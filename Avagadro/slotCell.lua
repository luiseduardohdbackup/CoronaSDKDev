local slotCell={}
local tileSet = require "tileSet"
local cellDescriptors=require "cellDescriptors"
slotCell.newSlotCell=function(parent,theGameBoard,slot,x,y)
	local theSlotCell={}
	theSlotCell.group = display.newGroup()
	theSlotCell.group.x=x
	theSlotCell.group.y=y
	parent:insert(theSlotCell.group)
	theSlotCell.gameBoard=theGameBoard
	theSlotCell.slot=slot
	theSlotCell.foregroundSprite = tileSet.newForegroundSprite(theSlotCell.group,0,0)
	theSlotCell.cursorSprite = tileSet.newCursorSprite(theSlotCell.group,0,0)
	function theSlotCell:update()
		local gameBoard = self.gameBoard
		if gameBoard:getCurrentSlot()==self.slot then
			self.cursorSprite:setFrame(2)
		else
			self.cursorSprite:setFrame(1)
		end
		local value = gameBoard:getSlot(self.slot)
		if value==nil then
			value=0
		end
		
		local theFrame=cellDescriptors.getFrame(value)
		self.foregroundSprite:setFrame(theFrame)
	end
	return theSlotCell
end
return slotCell