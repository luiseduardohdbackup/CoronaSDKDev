local boardCell={}
local tileSet=require "tileSet"
local cellDescriptors=require "cellDescriptors"
local json = require "json"
boardCell.newBoardCell=function(parent,theDataBoard,column,row,x,y)
	local theCell={}
	theCell.group = display.newGroup()
	parent:insert(theCell.group)
	theCell.group.x=x
	theCell.group.y=y
	
	theCell.foregroundSprite=tileSet.newForegroundSprite(theCell.group,0,0)
	
	theCell.dataBoard=theDataBoard
	theCell.column=column
	theCell.row=row
	theCell.update = function(self)
		local theValue=self.dataBoard.cells[self.column][self.row]
		local theFrame=cellDescriptors.getFrame(theValue)
		self.foregroundSprite:setFrame(theFrame)
	end
	return theCell
end

return boardCell