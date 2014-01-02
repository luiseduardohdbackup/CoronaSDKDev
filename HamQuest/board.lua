local board={}

board.newBoard=function(columns,rows)
	local theBoard={}
	theBoard.columns=columns
	theBoard.rows=rows
	theBoard.cells={}
	while #theBoard.cells<theBoard.columns do
		theBoard.cells[#theBoard.cells+1]={}
		while #theBoard.cells[#theBoard.cells]<theBoard.rows do
			theBoard.cells[#theBoard.cells][#theBoard.cells[#theBoard.cells]+1]={}
		end
	end
	return theBoard
end

return board