hl.config({
	input = {
		kb_layout = "us",
		follow_mouse = 1,
		sensitivity = 0,
		accel_profile = "adaptive",

		touchpad = {
			natural_scroll = true,
			tap_to_click = true,
			disable_while_typing = true,
			drag_lock = false,
			scroll_factor = 1.0,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
