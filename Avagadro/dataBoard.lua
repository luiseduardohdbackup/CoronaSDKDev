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
	theBoard.score=0
	theBoard.slots={}
	theBoard.slotCount=8
	theBoard.maximumSlots=8
	theBoard.currentSlot=1
	theBoard.currentColumn=1
	theBoard.currentRow=1
	theBoard.generator={
		helium=5,
		hydrogen=100,
		oxygen=50,
		nitrogen=25,
		carbon=10,
		mystery=0
	}
	theBoard.molecules=0
	theBoard.moleculeGoal=10
	return theBoard
end
return dataBoard