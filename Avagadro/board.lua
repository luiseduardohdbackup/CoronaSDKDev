local board={}
local boardCell=require "boardCell"
board.newBoard=function(parent,theDataBoard,x,y,cellWidth,cellHeight)
	local theBoard={}
	theBoard.group = display.newGroup()
	theBoard.group.x=x
	theBoard.group.y=y
	parent:insert(theBoard.group)
	
	theBoard.columns=theDataBoard.columns
	theBoard.rows=theDataBoard.rows
	theBoard.cells={}
	for column=1,theBoard.columns do
		theBoard.cells[column]={}
		for row=1,theBoard.rows do
			theBoard.cells[column][row]=boardCell.newBoardCell(theBoard.group,theDataBoard,column,row,column*cellWidth,row*cellHeight)
		end
	end
	theBoard.update = function(self)
		for column=1,self.columns do
			for row=1,self.rows do
				self.cells[column][row]:update()
			end
		end
	end
	return theBoard
end

return board