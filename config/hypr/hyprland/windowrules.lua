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
	center = true,
	border_size = 3,
})

-- Thunar
hl.window_rule({
	name = "Thunar",
	match = { class = "thunar" },
	float = true,
	size = "1000 700",
	center = true,
	border_size = 2,
})

-- MPV
hl.window_rule({
	name = "mpv",
	match = { class = "mpv" },
	float = true,
	size = "1000 700",
	border_size = 2,
	center = true,
})

-- Swappy
hl.window_rule({
	name = "swappy-float",
	match = { class = "swappy" },
	float = true,
	border_size = 2,
	center = true,
})

-- feh
hl.window_rule({
	name = "feh-float",
	match = { class = "feh" },
	float = true,
	border_size = 2,
	center = true,
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
	border_size = 2,
	center = true,
})

-- Generic floating class
hl.window_rule({
	name = "floating-class",
	match = { class = "floating" },
	float = true,
	size = "1000 700",
	border_size = 2,
	center = true,
})

-- Copilot panel
hl.window_rule({
	name = "Hermes",
	match = { class = "hermes" },
	float = true,
	size = "500 990",
	move = { 1400, 70 },
})

-- nmtui
hl.window_rule({
	name = "nmtui-float",
	match = { title = "nmtui" },
	float = true,
	workspace = "99",
	center = true,
})

-- MComix
hl.window_rule({
	name = "MComix",
	match = { class = "MComix" },
	float = true,
	size = "1200 800",
	border_size = 2,
	center = true,
})

-- Transmission
hl.window_rule({
	name = "transmission-float",
	match = { class = ".*transmission.*" },
	float = true,
	size = "800 600",
	border_size = 2,
	center = true,
})

-- nwg-look
hl.window_rule({
	name = "nwg-look",
	match = { class = "nwg-look" },
	float = true,
	size = "800 600",
	center = true,
})

-- Kvantum manager
hl.window_rule({
	name = "Kvantummanager",
	match = { class = "kvantummanager" },
	float = true,
	size = "800 600",
	center = true,
})

-- xdg-desktop-portal-gtk
hl.window_rule({
	name = "xdg-desktop-portal-gtk",
	match = { class = "xdg-desktop-portal-gtk" },
	float = true,
	size = "1000 600",
	center = true,
})

-- Noctalia
hl.layer_rule({
	name = "noctalia",
	match = {
		namespace = "^noctalia-(bar-.+|notification|dock|panel)$",
	},
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})
