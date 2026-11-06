-- Extra autostart processes.
-- o.launch_on_start("my-service")

-- Load hy3 after Hyprland starts
o.exec_on_start("hyprpm reload -n && hyprctl reload")
