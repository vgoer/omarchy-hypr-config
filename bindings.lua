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

o.bind("SUPER + SHIFT + T", "btop", {
    launch = "kitty --class btop-float btop"
})

o.rebind("SUPER + W", "Toggle floating/tiling", hl.dsp.window.float({
    action = "toggle"
}))


o.bind("SUPER + C", "Close window", hl.dsp.window.close())
