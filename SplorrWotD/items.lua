local theItems = {}
--local directions = require("directions")
local utilities = require("utilities")
local generators = require("generators")
function theItems.newMonsterItem(theItemDescriptor)
	local theItem = utilities.cloneTable(theItemDescriptor.instance)
	theItem.hidden = false
	return theItem
end
function theItems.newRoomItem(theItemDescriptor)
	local theItem = utilities.cloneTable(theItemDescriptor.instance)
	theItem.hidden = false -- generate based on descriptor
	return theItem
end
function theItems.newPlayerItem(theItemDescriptor)
	local theItem = utilities.cloneTable(theItemDescriptor.instance)
	theItem.hidden = false
	return theItem
end
return theItems