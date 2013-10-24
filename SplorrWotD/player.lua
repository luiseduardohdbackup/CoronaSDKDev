local thePlayer = {}
local directions = require("directions")
local utilities = require("utilities")
function thePlayer.newPlayer(theItemsTable)
	return {
		statistics = {
			experience = {
				level = 0,
				goal = 10,
				points = 0
			},
			body = 5,
			mind = 5,
			hits = 0,
			movement = 7
		},
		direction=math.random(directions.count),
		defaultLight = utilities.cloneTable(theItemsTable.match),
		defaultWeapon = utilities.cloneTable(theItemsTable.fist),
		baseArmor = utilities.cloneTable(theItemsTable.clothes),
		light = 1
	}
end
return thePlayer