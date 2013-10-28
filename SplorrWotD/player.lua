local directions = require("directions")
local utilities = require("utilities")
local generators = require("generators")
local json = require("json")
local items = require("items")
local thePlayer = {}
function thePlayer.newPlayer(theItemsTable)
	local theResult = {
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
		equipped = {
		},
		inventory={
		},
		direction=math.random(directions.count),
		defaultLight = items.newPlayerItem(theItemsTable.match),
		defaultWeapon = items.newPlayerItem(theItemsTable.fist),
		baseArmor = items.newPlayerItem(theItemsTable.clothes),
		light = 1
	}
	return theResult
end
function thePlayer.rollAttack(theCurrentPlayer)
	local theTotal = nil
	for _,item in pairs(theCurrentPlayer.equipped) do
		if item.itemType=="weapon" then
			if theTotal==nil then
				theTotal = generators.generate(item.attack)
			else
				theTotal = theTotal + generators.generate(item.attack)
			end
		end
	end
	if theTotal==nil then
		theTotal = generators.generate(theCurrentPlayer.defaultWeapon.attack)
	end
	return theTotal
end
function thePlayer.rollDefend(theCurrentPlayer)
	local theTotal = generators.generate(theCurrentPlayer.baseArmor.defend)
	for _,item in pairs(theCurrentPlayer.equipped) do
		if item.itemType=="armor" then
			theTotal = theTotal + generators.generate(item.defend)
		end
	end
	return theTotal
end
return thePlayer