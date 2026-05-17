hl.on("hyprland.start", function()
	hl.exec_cmd("wl-paste --watch cliphist store")
	hl.exec_cmd("hyprsunset")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")

	hl.exec_cmd("sh -c 'swaybg -i \"$(cat ~/.cache/wal/wal)\"'")
	hl.exec_cmd("mako ")
	hl.exec_cmd("waybar")

	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'catppuccin-mocha-blue-standard+default'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")

	hl.exec_cmd(
		"systemctl --user import-environment DISPLAY WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP"
	)

	hl.exec_cmd(
		"dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP=Hyprland GTK_USE_PORTAL=1"
	)
end)
