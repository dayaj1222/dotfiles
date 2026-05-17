return function(p)
	local mod = "SUPER"

	-- ─────────────────────────
	-- Basic Controls
	-- ─────────────────────────

	hl.bind(mod .. " + Return", hl.dsp.exec_cmd(p.term))
	hl.bind(mod .. " + SHIFT + Return", hl.dsp.exec_cmd("kitty --class floating"))
	hl.bind(mod .. " + B", hl.dsp.exec_cmd(p.browser))
	hl.bind(mod .. " + E", hl.dsp.exec_cmd(p.editor))
	hl.bind(mod .. " + N", hl.dsp.exec_cmd(p.fileManager))
	hl.bind(mod .. " + Q", hl.dsp.window.close())
	hl.bind(mod .. " + SHIFT + M", hl.dsp.exec_cmd(p.sysMonitor))
	hl.bind(mod .. " + M", hl.dsp.exec_cmd(p.music))

	-- Launcher
	hl.bind(mod .. " + Space", hl.dsp.exec_cmd(p.menu))

	-- Notifications
	hl.bind("CTRL + Space", hl.dsp.exec_cmd("makoctl mode -t do-not-disturb"))

	-- Reload / Exit
	hl.bind(mod .. " + R", hl.dsp.exec_cmd("hyprctl reload"))
	hl.bind(mod .. " + SHIFT + R", hl.dsp.exit())

	-- Floating / urgent
	hl.bind(mod .. " + S", hl.dsp.window.float({ action = "toggle" }))
	hl.bind(mod .. " + SHIFT + S", hl.dsp.focus({ urgent_or_last = true }))

	-- Power menu
	hl.bind(mod .. " + SHIFT + E", hl.dsp.exec_cmd("$HOME/.dotfiles/scripts/power-menu.sh"))

	-- Copilot terminal
	hl.bind(mod .. " + C", hl.dsp.exec_cmd("kitty --class copilot-kitty -e copilot --resume"))

	-- Waybar toggle
	hl.bind(mod .. " + ALT + W", hl.dsp.exec_cmd("$HOME/.dotfiles/scripts/waybar-toggle.sh"))

	-- Fullscreen
	hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))

	-- ─────────────────────────
	-- Focus Navigation
	-- ─────────────────────────

	hl.bind(mod .. " + H", hl.dsp.focus({ direction = "l" }))
	hl.bind(mod .. " + J", hl.dsp.focus({ direction = "d" }))
	hl.bind(mod .. " + K", hl.dsp.focus({ direction = "u" }))
	hl.bind(mod .. " + L", hl.dsp.focus({ direction = "r" }))

	hl.bind(mod .. " + left", hl.dsp.focus({ direction = "l" }))
	hl.bind(mod .. " + down", hl.dsp.focus({ direction = "d" }))
	hl.bind(mod .. " + up", hl.dsp.focus({ direction = "u" }))
	hl.bind(mod .. " + right", hl.dsp.focus({ direction = "r" }))

	-- ─────────────────────────
	-- Window Movement
	-- ─────────────────────────

	hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
	hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
	hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
	hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))

	hl.bind(mod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
	hl.bind(mod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))
	hl.bind(mod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
	hl.bind(mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))

	-- ─────────────────────────
	-- Window Resizing
	-- ─────────────────────────

	hl.bind(mod .. " + ALT + H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
	hl.bind(mod .. " + ALT + J", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
	hl.bind(mod .. " + ALT + K", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
	hl.bind(mod .. " + ALT + L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })

	-- Mouse
	hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
	hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

	-- ─────────────────────────
	-- Workspaces
	-- ─────────────────────────

	for i = 1, 10 do
		local key = i % 10
		hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
		hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
	end

	-- Scroll workspaces
	hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
	hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

	-- ─────────────────────────
	-- Scratchpad
	-- ─────────────────────────

	hl.bind(mod .. " + minus", hl.dsp.workspace.toggle_special("scratchpad"))
	hl.bind(mod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))

	-- ─────────────────────────
	-- Media & Hardware
	-- ─────────────────────────

	hl.bind(
		"XF86AudioRaiseVolume",
		hl.dsp.exec_cmd("$HOME/.dotfiles/scripts/volume-up.sh"),
		{ locked = true, repeating = true }
	)

	hl.bind(
		"XF86AudioLowerVolume",
		hl.dsp.exec_cmd("$HOME/.dotfiles/scripts/volume-down.sh"),
		{ locked = true, repeating = true }
	)

	hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

	hl.bind(
		"XF86MonBrightnessUp",
		hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
		{ locked = true, repeating = true }
	)

	hl.bind(
		"XF86MonBrightnessDown",
		hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
		{ locked = true, repeating = true }
	)

	hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl -p spotify play-pause"), { locked = true })

	hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl -p spotify next"), { locked = true })

	hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl -p spotify previous"), { locked = true })

	-- ─────────────────────────
	-- Do Not Disturb
	-- ─────────────────────────

	hl.bind(
		mod .. " + D",
		hl.dsp.exec_cmd(
			"sh -c \"notify-send ' Do Not Disturb' 'Turning on Do Not Disturb Mode' && sleep 2 && makoctl set-mode do-not-disturb\""
		)
	)

	hl.bind(
		mod .. " + SHIFT + D",
		hl.dsp.exec_cmd(
			"sh -c \"notify-send ' Do Not Disturb' 'Do Not Disturb Mode disabled' && makoctl set-mode default\""
		)
	)

	-- ─────────────────────────
	-- Screenshot & Utilities
	-- ─────────────────────────

	hl.bind("Print", hl.dsp.exec_cmd("$HOME/.dotfiles/scripts/screenshot.sh"))
	hl.bind(mod .. " + Print", hl.dsp.exec_cmd("$HOME/.dotfiles/scripts/screenshot.sh -f"))

	-- Clipboard
	hl.bind(
		mod .. " + V",
		hl.dsp.exec_cmd("sh -c \"cliphist list | fuzzel --dmenu --prompt 'Clipboard: ' | cliphist decode | wl-copy\"")
	)

	hl.bind(mod .. " + SHIFT + V", hl.dsp.exec_cmd("cliphist wipe"))

	-- Emoji picker
	hl.bind(mod .. " + period", hl.dsp.exec_cmd("$HOME/.dotfiles/scripts/emoji-picker.sh"))

	-- Wallpaper
	hl.bind(mod .. " + W", hl.dsp.exec_cmd("$HOME/.dotfiles/scripts/wallpaper.sh"))

	hl.bind(mod .. " + SHIFT + W", hl.dsp.exec_cmd("$HOME/.dotfiles/scripts/wallpaper.sh -r"))

	-- Color picker
	hl.bind(mod .. " + P", hl.dsp.exec_cmd("$HOME/.dotfiles/scripts/colorpicker.sh"))

	-- Caffeine
	hl.bind(mod .. " + SHIFT + C", hl.dsp.exec_cmd("$HOME/.dotfiles/scripts/caffeine-toggle.sh toggle"))
end
