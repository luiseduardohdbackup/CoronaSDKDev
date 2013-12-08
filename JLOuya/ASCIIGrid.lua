local asciiGrid = {}
local asciiCell = require("ASCIICell")
asciiGrid.createGrid=function(parent,x,y,columns,rows,cellWidth,cellHeight,imageSheet)
	local grid = display.newGroup()
	grid.x=x
	grid.y=y
	grid.width=columns*cellWidth
	grid.height=rows*cellHeight
	grid.cells={}
	for column=1,columns do
		grid.cells[column]={}
		for row=1,rows do
			grid.cells[column][row] = asciiCell.createCell(grid,column*cellWidth-cellWidth,row*cellHeight-cellHeight,cellWidth,cellHeight,imageSheet)
		end
	end
	parent:insert(grid)
	return grid
end
return asciiGrid