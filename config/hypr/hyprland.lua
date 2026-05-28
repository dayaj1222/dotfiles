local c = require("hyprland.colors")
require("hyprland.monitors")

local programs = require("hyprland.programs")

require("hyprland.env")
require("hyprland.look")(c)
require("hyprland.animations")

require("hyprland.input")
require("hyprland.autostart")

require("hyprland.keybinds")(programs)
require("hyprland.windowrules")

-- For Noctalia Color templates
require("noctalia")
