hl.curve("snappy", { type = "bezier", points = { { 0.2, 0.9 }, { 0.3, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 6, bezier = "default" })

hl.animation({ leaf = "border", enabled = true, speed = 2, bezier = "snappy" })

hl.animation({ leaf = "windows", enabled = true, speed = 2, bezier = "snappy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2, bezier = "snappy", style = "popin 85%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.5, bezier = "quick", style = "popin 85%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 2, bezier = "snappy" })

hl.animation({ leaf = "fade", enabled = true, speed = 1.5, bezier = "quick" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.5, bezier = "quick" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1, bezier = "quick" })

hl.animation({ leaf = "layers", enabled = true, speed = 2, bezier = "snappy" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 2, bezier = "snappy", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "quick", style = "fade" })

hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "snappy", style = "slide 80%" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 2, bezier = "snappy", style = "slide 80%" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.5, bezier = "quick", style = "slide 80%" })
