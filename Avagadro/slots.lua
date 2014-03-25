local slots={}
local slotCell=require "slotCell"
local directions=require "directions"
slots.newSlots=function(parent,theGameBoard,x,y,direction,stride)
	local theSlots={}
	theSlots.group = display.newGroup()
	theSlots.group.x=x
	theSlots.group.y=y
	parent:insert(theSlots.group)
	theSlots.gameBoard=theGameBoard
	theSlots.slots={}
	for slot=1,theGameBoard:getMaximumSlots() do
		theSlots.slots[slot]=slotCell.newSlotCell(theSlots.group,theGameBoard,slot,directions.nextX(direction,0,0,slot*stride-stride),directions.nextY(direction,0,0,slot*stride-stride))
	end
	function theSlots:update()
		for slot=1,#self.slots do
			self.slots[slot]:update()
		end
	end
	return theSlots
end
return slots