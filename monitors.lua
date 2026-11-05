-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })

-- BEGIN OMARCHY QEMU PROFILE
-- QEMU publishes the live window's size and host refresh rate through Virtio
-- GPU EDID. Quattro's preceding automatic monitor rule stays authoritative;
-- keep normal guest cursor visibility. The matching host runtime can display
-- guest-defined sprites independently from desktop frames.
local function omarchy_kernel_option_enabled(expected_option)
  if type(io) ~= "table" or type(io.open) ~= "function" then
    return false
  end

  local opened, cmdline_file = pcall(io.open, "/proc/cmdline", "r")
  if not opened or not cmdline_file then
    return false
  end

  local read_ok, cmdline = pcall(cmdline_file.read, cmdline_file, "*a")
  pcall(cmdline_file.close, cmdline_file)
  if not read_ok or type(cmdline) ~= "string" then
    return false
  end

  for option in cmdline:gmatch("%S+") do
    if option == expected_option then
      return true
    end
  end
  return false
end

-- Hyprland re-reads this file on every reload, and each theme switch runs
-- one. Keep the mode display sync last applied from the window's EDID;
-- falling back to "preferred" changes the mode, which blanks the window and
-- can restore an older window size.
local function omarchy_synced_display_mode()
  if type(os) ~= "table" or type(os.getenv) ~= "function" or type(io) ~= "table" or type(io.open) ~= "function" then
    return nil
  end
  local runtime_dir = os.getenv("XDG_RUNTIME_DIR")
  if type(runtime_dir) ~= "string" or runtime_dir == "" then
    return nil
  end

  local opened, mode_file = pcall(io.open, runtime_dir .. "/try-omarchy/display-mode", "r")
  if not opened or not mode_file then
    return nil
  end
  local mode_ok, mode = pcall(mode_file.read, mode_file, "*l")
  local scale_ok, scale = pcall(mode_file.read, mode_file, "*l")
  pcall(mode_file.close, mode_file)
  if not mode_ok or not scale_ok or type(mode) ~= "string" or type(scale) ~= "string" then
    return nil
  end
  if not mode:match("^modeline [%d ]+ [+-]hsync [+-]vsync$") or not scale:match("^%d+%.?%d*$") then
    return nil
  end
  return mode, scale
end

-- Hyprland needs the scaled size to land on whole pixels, and the synced mode
-- follows the window size. Pick the closest clean scale the way display sync
-- does, so a scale set here does not raise Hyprland's invalid scale warning.
local function omarchy_clean_scale(mode, requested)
  if type(math) ~= "table" or type(math.floor) ~= "function" then
    return nil
  end
  local numbers = {}
  for number in mode:gmatch("%d+") do
    numbers[#numbers + 1] = tonumber(number)
  end
  local width, height = numbers[2], numbers[6]
  if not width or not height then
    return nil
  end
  local target = math.floor(requested * 120 + 0.5)
  local best
  for candidate = 30, 960 do
    if (width * 120) % candidate == 0 and (height * 120) % candidate == 0 then
      local distance = math.abs(candidate - target)
      if not best or distance < math.abs(best - target) or (distance == math.abs(best - target) and candidate > best) then
        best = candidate
      end
    end
  end
  if not best then
    return nil
  end
  local scale = string.format("%.6f", best / 120):gsub("0+$", ""):gsub("%.$", "")
  return scale
end

if omarchy_kernel_option_enabled("omarchy.qemu=1") then
  -- Virgl cursor GPU buffers arrive inverted; use a small CPU cursor buffer.
  hl.config({ cursor = { invisible = false, use_cpu_buffer = 1 } })
  local synced_mode, synced_scale = omarchy_synced_display_mode()
  if synced_mode then
    -- A number the user set in this file is explicit intent and outranks
    -- the scale guessed from the EDID; "auto" keeps the guessed scale.
    local user_scale = tonumber(omarchy_monitor_scale)
    if user_scale and user_scale > 0 then
      synced_scale = omarchy_clean_scale(synced_mode, user_scale) or synced_scale
    end
    hl.monitor({ output = "", mode = synced_mode, scale = synced_scale })
  end
  o.exec_on_start("/usr/local/bin/omarchy-native-display-sync")
end

-- On CPU rendering (llvmpipe) every animation frame is CPU time the desktop
-- feels. Start with animations off; looknfeel.lua loads after this file, so
-- an explicit choice there still wins.
if omarchy_kernel_option_enabled("tryomarchy.render=cpu") then
  hl.config({ animations = { enabled = false } })
end
-- END OMARCHY QEMU PROFILE
