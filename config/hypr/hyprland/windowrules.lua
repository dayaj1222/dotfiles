local center = "(monitor_w-window_w)/2 (monitor_h-window_h)/2"

-- Suppress maximize requests
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Fix XWayland dragging
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- Spotify
hl.window_rule({
	name = "spotify-float",
	match = { class = "Spotify" },
	float = true,
	size = "1050 650",
	move = "15  15",
	border_size = 3,
})

-- Thunar
hl.window_rule({
	name = "Thunar",
	match = { class = "thunar" },
	float = true,
	size = "1000 700",
	move = center,
	border_size = 2,
})

-- MPV
hl.window_rule({
	name = "mpv",
	match = { class = "mpv" },
	float = true,
	size = "1000 700",
	move = center,
	border_size = 2,
})

-- Swappy
hl.window_rule({
	name = "swappy-float",
	match = { class = "swappy" },
	float = true,
	move = center,
	border_size = 2,
})

-- feh
hl.window_rule({
	name = "feh-float",
	match = { class = "feh" },
	float = true,
	move = center,
	border_size = 2,
})

-- Veracrypt
hl.window_rule({
	name = "veracrypt-float",
	match = { class = "veracrypt" },
	float = true,
	border_size = 3,
})

-- Python GUI
hl.window_rule({
	name = "python3-float",
	match = { class = "python3" },
	float = true,
	border_size = 3,
})

-- Pavucontrol
hl.window_rule({
	name = "Pavucontrol",
	match = { class = "org.pulseaudio.pavucontrol" },
	float = true,
	size = "800 600",
	move = center,
	border_size = 2,
})

-- Generic floating class
hl.window_rule({
	name = "floating-class",
	match = { class = "floating" },
	float = true,
	size = "1000 700",
	move = center,
	border_size = 2,
})

-- Copilot panel
hl.window_rule({
	name = "copilot-kitty-panel",
	match = { class = "copilot-kitty" },
	float = true,
	size = "500 990",
	move = "1402  70",
})

-- nmtui
hl.window_rule({
	name = "nmtui-float",
	match = { title = "nmtui" },
	float = true,
	move = center,
	workspace = "99",
})

-- MComix
hl.window_rule({
	name = "MComix",
	match = { class = "MComix" },
	float = true,
	size = "1200 800",
	move = center,
	border_size = 2,
})

-- Transmission
hl.window_rule({
	name = "transmission-float",
	match = { class = ".*transmission.*" },
	float = true,
	size = "800 600",
	move = center,
	border_size = 2,
})

-- nwg-look
hl.window_rule({
	name = "nwg-look",
	match = { class = "nwg-look" },
	float = true,
	size = "800 600",
	move = center,
})

-- Kvantum manager
hl.window_rule({
	name = "Kvantummanager",
	match = { class = "kvantummanager" },
	float = true,
	size = "800 600",
	move = center,
})

-- xdg-desktop-portal-gtk
hl.window_rule({
	name = "xdg-desktop-portal-gtk",
	match = { class = "xdg-desktop-portal-gtk" },
	float = true,
	size = "600 600",
	move = center,
})
