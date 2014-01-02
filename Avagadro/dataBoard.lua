local dataBoard={}
dataBoard.newDataBoard=function(columns,rows,initialValue)
	local theBoard={}
	theBoard.columns=columns
	theBoard.rows=rows
	theBoard.cells={}
	for column=1,columns do
		theBoard.cells[column]={}
		for row=1,rows do
			theBoard.cells[column][row]=initialValue
		end
	end
	return theBoard
end
return dataBoard