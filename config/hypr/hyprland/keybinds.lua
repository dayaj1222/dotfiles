return function(p)
	local mod = "SUPER"
	local ipc = "noctalia msg "

	-- ─────────────────────────
	-- Basic Controls & Launchers
	-- ─────────────────────────

	hl.bind(mod .. " + Return", hl.dsp.exec_cmd(p.term))
	hl.bind(mod .. " + SHIFT + Return", hl.dsp.exec_cmd("kitty --class floating"))
	hl.bind(mod .. " + B", hl.dsp.exec_cmd(p.browser))
	hl.bind(mod .. " + E", hl.dsp.exec_cmd(p.editor))
	hl.bind(mod .. " + N", hl.dsp.exec_cmd(p.fileManager))
	hl.bind(mod .. " + Q", hl.dsp.window.close())
	hl.bind(mod .. " + SHIFT + M", hl.dsp.exec_cmd(p.sysMonitor))
	hl.bind(mod .. " + M", hl.dsp.exec_cmd(p.music))

	-- Panels & Menus
	hl.bind(mod .. " + Space", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
	hl.bind(mod .. " + S", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
	hl.bind(mod .. " + SHIFT + E", hl.dsp.exec_cmd(ipc .. "panel-toggle session"))
	hl.bind(mod .. " + V", hl.dsp.exec_cmd(ipc .. "panel-toggle clipboard"))
	hl.bind(mod .. " + period", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher /emo"))
	hl.bind(mod .. " + W", hl.dsp.exec_cmd(ipc .. "panel-toggle wallpaper"))
	hl.bind(mod .. " + SHIFT + W", hl.dsp.exec_cmd(ipc .. "wallpaper-random"))

	-- Custom Development Executions
	hl.bind(mod .. " + C", hl.dsp.exec_cmd("kitty --class hermes -e hermes"))

	-- ─────────────────────────
	-- Notifications & System States
	-- ─────────────────────────

	hl.bind("CTRL + Space", hl.dsp.exec_cmd(ipc .. "notification-clear-active"))
	hl.bind(mod .. " + D", hl.dsp.exec_cmd(ipc .. "notification-dnd-toggle"))
	hl.bind(mod .. " + ALT + C", hl.dsp.exec_cmd(ipc .. "caffeine-toggle"))
	hl.bind(mod .. " + ALT + B", hl.dsp.exec_cmd(ipc .. "bar-toggle"))

	-- Reload / Session Exit
	hl.bind(mod .. " + R", hl.dsp.exec_cmd("hyprctl reload"))
	hl.bind(mod .. " + SHIFT + R", hl.dsp.exit())

	-- ─────────────────────────
	-- Window Architecture & Layouts
	-- ─────────────────────────

	hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
	hl.bind(mod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))

	-- Focus Navigation (Vim & Arrow Mapping)
	hl.bind(mod .. " + H", hl.dsp.focus({ direction = "l" }))
	hl.bind(mod .. " + J", hl.dsp.focus({ direction = "d" }))
	hl.bind(mod .. " + K", hl.dsp.focus({ direction = "u" }))
	hl.bind(mod .. " + L", hl.dsp.focus({ direction = "r" }))

	hl.bind(mod .. " + left", hl.dsp.focus({ direction = "l" }))
	hl.bind(mod .. " + down", hl.dsp.focus({ direction = "d" }))
	hl.bind(mod .. " + up", hl.dsp.focus({ direction = "u" }))
	hl.bind(mod .. " + right", hl.dsp.focus({ direction = "r" }))

	-- Window Movement (Tiling Shift)
	hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
	hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
	hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
	hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))

	hl.bind(mod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
	hl.bind(mod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))
	hl.bind(mod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
	hl.bind(mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))

	-- Window Resizing
	hl.bind(mod .. " + ALT + H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
	hl.bind(mod .. " + ALT + J", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
	hl.bind(mod .. " + ALT + K", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
	hl.bind(mod .. " + ALT + L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })

	-- Pointer Controls
	hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
	hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

	-- ─────────────────────────
	-- Workspaces & Virtual Desktops
	-- ─────────────────────────

	for i = 1, 10 do
		local key = i % 10
		hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
		hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
	end

	-- Scratchpads
	hl.bind(mod .. " + minus", hl.dsp.workspace.toggle_special("scratchpad"))
	hl.bind(mod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))

	-- ─────────────────────────
	-- Hardware Actions & Multimedia Hooks
	-- ─────────────────────────

	hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"))
	hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"))
	hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"))
	hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"))
	hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"))

	-- MPRIS Native Audio Pipeline
	hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(ipc .. "media toggle"), { locked = true })
	hl.bind("XF86AudioNext", hl.dsp.exec_cmd(ipc .. "media next"), { locked = true })
	hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(ipc .. "media previous"), { locked = true })

	-- ─────────────────────────
	-- External Utility Fallbacks
	-- ─────────────────────────

	hl.bind("Print", hl.dsp.exec_cmd("$HOME/.dotfiles/scripts/screenshot.sh"))
	hl.bind(mod .. " + Print", hl.dsp.exec_cmd("$HOME/.dotfiles/scripts/screenshot.sh -f"))
	hl.bind(mod .. " + P", hl.dsp.exec_cmd("$HOME/.dotfiles/scripts/colorpicker.sh"))
end
