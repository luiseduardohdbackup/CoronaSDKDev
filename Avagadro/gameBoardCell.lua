local gameBoardCell = {}
local cellDescriptors=require "cellDescriptors"
local directions=require "directions"
gameBoardCell.newGameBoardCell=function(theDataBoard,column,row)
	local cell = {}
	cell.dataBoard=theDataBoard
	cell.column=column
	cell.row=row
	cell.neighbors={}
	cell.hint=4
	function cell:updateHint()
		if self:getValue()~=0 then
			self.hint=1
			return
		end
		local currentSlotValue = self.dataBoard.slots[self.dataBoard.currentSlot]
		if self:checkValue(currentSlotValue) then
			self.hint=4
			return
		end
		local rotations = cellDescriptors.getRotations(currentSlotValue)
		for k,value in pairs(rotations) do
			if self:checkValue(value) then
				self.hint=3
				return
			end
		end
		self.hint=2
	end
	function cell:checkValue(value)
		if cellDescriptors.getIgnoreLinks(value) then
			return true
		else
			local links = cellDescriptors.getLinks(value)
			for direction=1,directions.count do
				local neighbor = self:getNeighbor(direction)
				if links[direction] then
					if neighbor==nil then
						return false
					else
						local neighborValue=neighbor:getValue()
						if not cellDescriptors.getIgnoreLinks(neighborValue) then
							local neighborLinks=cellDescriptors.getLinks(neighborValue)
							if not neighborLinks[directions.opposites[direction]] then
								return false
							end
						end
					end
				elseif neighbor~=nil then
					local neighborValue=neighbor:getValue()
					if not cellDescriptors.getIgnoreLinks(neighborValue) then
						local neighborLinks=cellDescriptors.getLinks(neighborValue)
						if neighborLinks[directions.opposites[direction]] then
							return false
						end
					end
				end
			end
		end
		return true
	end
	function cell:getHint()
		return self.hint
	end
	function cell:getNeighbor(theDirection)
		return self.neighbors[theDirection]
	end
	function cell:setNeighbor(theDirection,theCell)
		self.neighbors[theDirection]=theCell
	end
	function cell:getValue()
		return self.dataBoard.cells[self.column][self.row]
	end
	function cell:setValue(theValue)
		self.dataBoard.cells[self.column][self.row]=theValue
	end
	function cell:checkMolecule(fromColumn,fromRow)
		local links = cellDescriptors.getLinks(self:getValue())
		for direction=1,directions.count do
			if links[direction] then
				local neighbor=self:getNeighbor(direction)
				if neighbor==nil then
					return false
				elseif cellDescriptors.isEmpty(neighbor:getValue()) then
					return false
				else
					if neighbor.column~=fromColumn or neighbor.row~=fromRow then
						if not neighbor:checkMolecule(self.column,self.row) then
							return false
						end
					end
				end
			end
		end
		return true
	end
	function cell:hasCursor()
		return cell.dataBoard.currentColumn==self.column and cell.dataBoard.currentRow==self.row
	end
	function cell:setCursor()
		cell.dataBoard.currentColumn=self.column
		cell.dataBoard.currentRow=self.row
	end
	return cell
end
return gameBoardCell