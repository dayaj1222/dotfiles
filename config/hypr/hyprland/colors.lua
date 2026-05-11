local function load_pywal_colors()
	local path = os.getenv("HOME") .. "/.cache/wal/colors.json"
	local file = io.open(path, "r")
	if not file then
		return nil
	end

	local content = file:read("*a")
	file:close()

	local colors = {}

	for i = 0, 15 do
		local key = "color" .. i
		local value = content:match('"' .. key .. '"%s*:%s*"(#%x%x%x%x%x%x)"')
		if value then
			colors[key] = value
		end
	end

	return colors
end

local c = load_pywal_colors()

if not c then
	c = {
		color0 = "#111128",
		color5 = "#BE558A",
		color8 = "#606076",
		color13 = "#BE558A",
	}
end

return c
