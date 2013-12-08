local asciiBoard = {}
local asciiBoardCell = require("ASCIIBoardCell")
asciiBoard.createBoard = function(x,y,columns,rows)
	local board = {}
	board.x=x
	board.y=y
	board.columns=columns
	board.rows=rows
	board.cells={}
	for column=1,columns do
		board.cells[column]={}
		for row=1,rows do
			board.cells[column][row]=asciiBoardCell.createCell(0,0,0)
		end
	end
	function board:setDirty(dirty)
		for column = 1,self.columns do
			for row=1,self.rows do
				self.cells[column][row]:setDirty(dirty)
			end
		end
	end
	function board:invalidate()
		self:setDirty(true)
	end
	function board:validate()
		self:setDirty(false)
	end
	function board:render(grid,colors)
		for column = 1,self.columns do
			for row=1,self.rows do
				local boardCell = self.cells[column][row]
				if boardCell.dirty then
					local gridX = column+self.x-1
					local gridY = row+self.y-1
					local gridCell = grid.cells[gridX][gridY]
					gridCell.foreground:setFrame(boardCell.character+1)
					gridCell.foreground:setFillColor(colors[boardCell.foreground][1],colors[boardCell.foreground][2],colors[boardCell.foreground][3])
					gridCell.background:setFillColor(colors[boardCell.background][1],colors[boardCell.background][2],colors[boardCell.background][3])
					boardCell:setDirty(false)
				end
			end
		end
	end
	function board:set(x,y,cell)
		self.cells[x][y]:set(cell)
	end
	function board:hLine(x,y,length,cell)
		for column=x,x+length-1 do
			self:set(column,y,cell)
		end
	end
	function board:vLine(x,y,length,cell)
		for row=y,y+length-1 do
			self:set(x,row,cell)
		end
	end
	function board:fill(x,y,width,height,cell)
		for column=x,x+width-1 do
			self:vLine(column,y,height,cell)
		end
	end
	function board:clear(cell)
		self:fill(1,1,self.columns,self.rows,cell)
	end
	function board:writeText(x,y,text,cell)
		for index=1,string.len(text) do
			cell.character=string.byte(text,index)
			board:set(x,y,cell)
			x=x+1
		end
	end
	function board:scrollUp(x,y,width,height)
		for column=x,x+width-1 do
			for row=y,y+height-2 do
				self:set(column,row,self.cells[column][row+1])
			end
		end
	end
	return board
end
return asciiBoard