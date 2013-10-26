local theMonsters = {}
--local directions = require("directions")
local utilities = require("utilities")
local generators = require("generators")
local items = require("items")
function theMonsters.addToMonsterInventory(theMonster,theItem)
	if theMonster.inventory == nil then
		theMonster.inventory = {}
	end
	table.insert(theMonster.inventory,theItem)
end
function theMonsters.newMonster(theMonsterDescriptor,theItemTable)
	local theMonster = utilities.cloneTable(theMonsterDescriptor.instance)
	--finish statistics
	theMonster.hits = 0
	--add drop item
	if theMonsterDescriptor.dropGenerator ~= nil and theItemTable~=nil then
		theItemId = generators.generate(theMonsterDescriptor.dropGenerator)
		if theItemTable[theItemId]~=nil then
			theMonsters.addToMonsterInventory(theMonster, items.newMonsterItem(theItemTable[theItemId]))
		end
	end
	return theMonster
end
return theMonsters