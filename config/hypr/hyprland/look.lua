return function(c)
	hl.config({
		general = {
			gaps_in = 2,
			gaps_out = 6,
			border_size = 2,

			col = {
				active_border = { colors = { c.color5, c.color13 }, angle = 45 },
				inactive_border = c.color8,
			},

			resize_on_border = false,
			allow_tearing = false,
			layout = "dwindle",
		},

		decoration = {
			rounding = 4,
			rounding_power = 5,

			active_opacity = 1.0,
			inactive_opacity = 0.96,

			shadow = {
				enabled = false,
				range = 8,
				render_power = 3,
				color = c.color0,
			},

			blur = {
				enabled = true,
				size = 5,
				passes = 2,
				vibrancy = 0.17,
			},
		},

		animations = {
			enabled = true,
		},

		master = {
			new_status = "master",
		},

		misc = {
			force_default_wallpaper = 0,
			disable_hyprland_logo = true,
		},
	})
end
