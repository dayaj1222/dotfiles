hl.on("hyprland.start", function()
	hl.exec_cmd("noctalia")
	hl.exec_cmd("wl-paste --watch cliphist store")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")

	hl.exec_cmd("sh -c 'swaybg -i \"$(cat ~/.cache/wal/wal)\"'")
	hl.exec_cmd("mako ")
	hl.exec_cmd("waybar")
end)
