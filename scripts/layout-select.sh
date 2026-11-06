#!/bin/bash
# Pick a Hyprland layout from the Omarchy menu and persist the choice.
#
# The chosen layout is written to $XDG_STATE_HOME/hypr/layout, which
# bindings.lua reads at load time. A reload then reapplies the layout and the
# bindings that depend on it (hy3's arrow bindings vs. Omarchy's defaults).

set -euo pipefail

state_home="${XDG_STATE_HOME:-$HOME/.local/state}"
state_file="$state_home/hypr/layout"

layouts=(dwindle scrolling master monocle hy3 lua:grid)
labels=(Dwindle Scrolling Master Monocle hy3 Grid)

current="$(hyprctl getoption -j general:layout 2>/dev/null | jq -r '.str // empty' || true)"
if [[ -z $current && -r $state_file ]]; then
  current="$(<"$state_file")"
fi

options=()
for i in "${!layouts[@]}"; do
  if [[ ${layouts[i]} == "$current" ]]; then
    options+=("●"$'\t'"${labels[i]}")
  else
    options+=("○"$'\t'"${labels[i]}")
  fi
done

choice="$(omarchy-menu-select "Layout" "${options[@]}")" || exit 0
choice="${choice%%$'\t'*}" # strip a trailing subtext, if any

case "$choice" in
  Dwindle) layout=dwindle ;;
  Scrolling) layout=scrolling ;;
  Master) layout=master ;;
  Monocle) layout=monocle ;;
  hy3) layout=hy3 ;;
  Grid) layout=lua:grid ;;
  *) exit 0 ;;
esac

mkdir -p "$(dirname "$state_file")"
printf '%s\n' "$layout" >"$state_file"

# Re-read the config so the layout and its layout-dependent bindings apply.
hyprctl reload >/dev/null
