local profileManager = {}
local json = require("json")
profileManager.loadProfile = function()
	local file = io.open(system.pathForFile("profile.json",system.DocumentsDirectory),"r")
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
				gamesPlayed=0,
				hallelujahs=0,
				musicVolume=0.5,
				soundVolume=0.5,
				fish={
					deathCount=0,
					bornOn=0,
					fedUntil=0,
					tankSize=0,
					dirt=0,
					dirtUpdated=0,
					pellets=0,
					tablets=0
				},
				bonuses={
					o=false,
					u=false,
					y=false,
					a=false,
					jetLag=false
				}
			}
	end
end
profileManager.saveProfile = function(profile)
	local file = io.open(system.pathForFile("profile.json",system.DocumentsDirectory),"w")
	file:write(json.encode(profile))
	io.close(file)
end
return profileManager