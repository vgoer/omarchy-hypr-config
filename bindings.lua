-- ╭─────────────────────────────────────────────────────────────────────────╮
-- │  Omacale keybindings — paste into ~/.config/hypr/bindings.lua           │
-- │  Each action is an IPC call into the running Omarchy shell:             │
-- │  omarchy-shell omacale <launcher|dashboard|session|settings|close>      │
-- │  Keys below are unbound in a stock Omarchy install. Check yours with:   │
-- │  omarchy menu keybindings --print                                       │
-- ╰─────────────────────────────────────────────────────────────────────────╯

-- ── Helpers ─────────────────────────────────────────────────────────────────
-- o.rebind is provided by Omarchy (default/hypr/helpers.lua); restated here so
-- this file is self-contained when pasted. Same arguments as o.bind.

function o.rebind(keys, description, dispatcher, options)
  hl.unbind(keys)
  o.bind(keys, description, dispatcher, options)
end

-- ── Drawers ─────────────────────────────────────────────────────────────────

o.bind("SUPER + A", "Omacale launcher", "omarchy-shell omacale launcher")
o.bind("SUPER + D", "Omacale dashboard", "omarchy-shell omacale dashboard")
o.bind("SUPER + N", "Omacale notifications sidebar", "omarchy-shell omacale sidebar")
o.bind("SUPER + U", "Omacale quick toggles", "omarchy-shell omacale utilities")
o.bind("SUPER + SHIFT + ESCAPE", "Omacale session menu", "omarchy-shell omacale session")
o.bind("SUPER + SHIFT + I", "Omacale settings", "omarchy-shell omacale settings")

-- ── Dashboard tabs ──────────────────────────────────────────────────────────

o.bind("SUPER + ALT + D", "Omacale media", "omarchy-shell omacale dashboardTab media")
o.bind("SUPER + ALT + P", "Omacale performance", "omarchy-shell omacale dashboardTab performance")

-- ── Keyboard ────────────────────────────────────────────────────────────────
-- Omarchy's own SUPER + CTRL + A/B/W/P and 1..9 already open Omacale's popouts
-- (1..9 count the third-party widgets in the plugin pill). This one is the
-- bar focus mode: the bar takes the keyboard and a cursor walks its items --
-- j/k or arrows move, Enter/Space act, Menu or Shift+F10 opens a tray item's
-- menu, 1..9 switch workspace, Escape leaves. code:19 is the 0 key, which
-- Omarchy's code:10..18 loop leaves free.

o.bind("SUPER + CTRL + code:19", "Omacale bar focus", "omarchy-shell omacale barFocus")




-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")


-- my add
-- Essential application bindings.
o.rebind("SUPER + RETURN", "Terminal",{
  omarchy = "terminal"
})

o.rebind("SUPER + SHIFT + RETURN", "Floating Terminal", {
    launch = "kitty --class kitty"
})

o.rebind("SUPER + W", "Toggle floating/tiling", hl.dsp.window.float({
    action = "toggle"
}))

o.bind("SUPER + G", "Browser", { omarchy = "browser" })
o.bind("SUPER + E", "File manager", { omarchy = "nautilus" })
o.bind("SUPER + ALT + SHIFT + F", "File manager (cwd)", { omarchy = "nautilus-cwd" })
o.bind("SUPER + SHIFT + B", "Browser", { omarchy = "browser" })
o.bind("SUPER + SHIFT + ALT + B", "Browser (private)", { omarchy = "browser --private" })
o.bind("SUPER + SHIFT + N", "Editor", { omarchy = "editor" })

if o.preinstalled_bindings_enabled() then
  -- Bindings for preinstalled Omarchy applications, TUIs, and web apps.
  o.bind("SUPER + ALT + RETURN", "Tmux", { omarchy = "terminal-tmux" })
  o.bind("SUPER + CTRL + RETURN", "Herdr", { omarchy = "terminal-herdr" })
  o.bind("SUPER + SHIFT + M", "Music", { omarchy = "spotify" })
  o.bind("SUPER + SHIFT + ALT + M", "Music TUI", { tui = "cliamp", focus = true })
  o.bind("SUPER + SHIFT + D", "Docker", { tui = "omarchy-launch-docker-tui" })
  o.bind("SUPER + SHIFT + G", "Signal", { omarchy = "signal" })
  o.bind("SUPER + SHIFT + O", "Obsidian", { launch = "obsidian", focus = "^obsidian$" })
  o.bind("SUPER + SHIFT + W", "Omawrite", { launch = "omawrite" })
  o.bind("SUPER + SHIFT + SLASH", "Passwords", { omarchy = "1password" })

  o.bind("SUPER + SHIFT + A", "ChatGPT", { webapp = "https://chatgpt.com" })
  o.bind("SUPER + SHIFT + ALT + A", "Grok", { webapp = "https://grok.com" })
  o.bind("SUPER + SHIFT + C", "Calendar", { webapp = "https://app.hey.com/calendar/weeks/" })
  o.bind("SUPER + SHIFT + E", "Email", { webapp = "https://app.hey.com" })
  o.bind("SUPER + SHIFT + ALT + E", "New email", { webapp = "https://app.hey.com/messages/new?display=standalone&new_window=true" })
  o.bind("SUPER + SHIFT + Y", "YouTube", { webapp = "https://youtube.com/" })
  o.bind("SUPER + SHIFT + ALT + G", "WhatsApp", { webapp = "https://web.whatsapp.com/", focus = true })
  o.bind( "SUPER + SHIFT + CTRL + G", "Google Messages", { webapp = "https://messages.google.com/web/conversations", focus = true })
  o.bind("SUPER + SHIFT + P", "Google Photos", { webapp = "https://photos.google.com/", focus = true })
  o.bind("SUPER + SHIFT + S", "Google Maps", { webapp = "https://maps.google.com/", focus = true })
  o.bind("SUPER + SHIFT + X", "X", { webapp = "https://x.com/" })
  o.bind("SUPER + SHIFT + ALT + X", "X Post", { webapp = "https://x.com/compose/post" })
end


o.bind("SUPER + C", "Close window", hl.dsp.window.close())
