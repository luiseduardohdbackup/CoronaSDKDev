local board={}
local boardCell=require "boardCell"
board.newBoard=function(parent,theGameBoard,x,y,cellWidth,cellHeight)
	local theBoard={}
	theBoard.group = display.newGroup()
	theBoard.group.x=x
	theBoard.group.y=y
	parent:insert(theBoard.group)
	theBoard.gameBoard=theGameBoard
	theBoard.columns=theGameBoard.columns
	function theBoard:getColumns()
		return self.columns
	end
	theBoard.rows=theGameBoard.rows
	function theBoard:getRows()
		return self.rows
	end
	theBoard.cells={}
	function theBoard:getCell(column,row)
		if column>=1 and column<=self:getColumns() and row>=1 and row<=self:getRows() then
			return self.cells[column][row]
		else
			return nil
		end
	end
	for column=1,theBoard.columns do
		theBoard.cells[column]={}
		for row=1,theBoard.rows do
			theBoard.cells[column][row]=boardCell.newBoardCell(theBoard.group,theGameBoard,column,row,column*cellWidth-cellWidth,row*cellHeight-cellHeight)
		end
	end
	function theBoard:update()
		for column=1,self.columns do
			for row=1,self.rows do
				self.cells[column][row]:update()
			end
		end
	end
	return theBoard
end

return board