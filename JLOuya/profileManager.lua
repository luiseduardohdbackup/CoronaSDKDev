local profileManager = {}
local json = require("json")
profileManager.loadProfile = function()
	local file = io.open(system.pathForFile(system.DocumentsDirectory,"profile.json"),"r")
	if file~=nil then
		local contents = file:read("*a")
		local result = json.decode(contents)
		io.close(file)
		return result
	else
	return {
			pennies=0,
			highScore=0,
			totalScore=0,
			gamesPlayed=0
		}
	end
end
profileManager.saveProfile = function(profile)
	local file = io.open(system.pathForFile(system.DocumentsDirectory,"profile.json"),"w")
	file:write(json.encode(profile))
	io.close(file)
end
return profileManager