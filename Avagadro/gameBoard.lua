local gameBoard={}
local directions=require "directions"
local gameBoardCell=require "gameBoardCell"

gameBoard.newGameBoard=function(theDataBoard)
	local theBoard={}
	theBoard.columns=theDataBoard.columns
	theBoard.rows=theDataBoard.rows
	theBoard.cells={}
	for column=1,columns do
		theBoard.cells[column]={}
		for row=1,rows do
			theBoard.cells[column][row]=gameBoardCell.newGameBoardCell(theDataBoard,column,row)
		end
	end
	for column=1,columns do
		for row=1,rows do
			for direction=1,directions.count do
				local nextX=directions.nextX(direction,column,row)
				local nextY=directions.nextY(direction,column,row)
				if nextX>=1 and nextX<=columns and nextY>=1 and nextY<=rows then
					theBoard.cells[column][row]:setNeighbor(direction,theBoard.cells[nextX][nextY])
				end
			end
		end
	end
	return theBoard
end

return gameBoard