local boardCell={}
local tileSet=require "tileSet"
local cellDescriptors=require "cellDescriptors"
local json = require "json"
boardCell.newBoardCell=function(parent,theGameBoard,column,row,x,y)
	local theCell={}
	theCell.group = display.newGroup()
	parent:insert(theCell.group)
	theCell.group.x=x
	theCell.group.y=y
	
	theCell.backgroundSprite=tileSet.newBackgroundSprite(theCell.group,0,0)
	theCell.foregroundSprite=tileSet.newForegroundSprite(theCell.group,0,0)
	theCell.cursorSprite=tileSet.newCursorSprite(theCell.group,0,0)
	
	theCell.gameBoard=theGameBoard
	theCell.column=column
	theCell.row=row
	function theCell:update()
		local theGameCell = self.gameBoard:getCell(self.column,self.row)
		local theValue=theGameCell:getValue()
		
		self.backgroundSprite:setFrame(self.gameBoard:getCell(self.column,self.row):getHint())
		
		if theGameCell:hasCursor() then
			self.cursorSprite:setFrame(2)
		else
			self.cursorSprite:setFrame(1)
		end
		
		local theFrame=cellDescriptors.getFrame(theValue)
		self.foregroundSprite:setFrame(theFrame)
	end
	return theCell
end

return boardCell