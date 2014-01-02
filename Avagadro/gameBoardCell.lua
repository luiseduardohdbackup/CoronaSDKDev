local gameBoardCell = {}
gameBoardCell.newGameBoardCell=function(theDataboard,column,row)
	local cell = {}
	cell.dataBoard=theDataBoard
	cell.column=column
	cell.row=row
	cell.neighbors={}
	function cell:getNeighbor(theDirection)
		return self.neighbors[theDirection]
	end
	function cell:setNeighbor(theDirection,theCell)
		self.neighbors[theDirection]=theCell
	end
	function cell:getValue()
		return self.dataBoard[self.column][self.row]
	end
	function cell:setValue(theValue)
		self.dataBoard[self.column][self.row]=theValue
	end
	return cell
end
return gameBoardCell