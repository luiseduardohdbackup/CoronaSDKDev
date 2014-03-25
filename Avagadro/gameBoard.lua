local gameBoard={}
local directions=require "directions"
local gameBoardCell=require "gameBoardCell"
local generator=require "generator"
local cellDescriptors=require "cellDescriptors"

gameBoard.newGameBoard=function(theDataBoard)
	local theBoard={}
	theBoard.dataBoard=theDataBoard
	theBoard.columns=theDataBoard.columns
	function theBoard:getColumns()
		return self.columns
	end
	theBoard.rows=theDataBoard.rows
	function theBoard:getRows()
		return self.rows
	end
	theBoard.cells={}
	for column=1,theBoard.columns do
		theBoard.cells[column]={}
		for row=1,theBoard.rows do
			theBoard.cells[column][row]=gameBoardCell.newGameBoardCell(theDataBoard,column,row)
		end
	end
	function theBoard:getCell(column,row)
		if column>=1 and column<=self:getColumns() and row>=1 and row<=self:getRows() then
			return self.cells[column][row]
		else
			return nil
		end
	end
	for column=1,theBoard.columns do
		for row=1,theBoard.rows do
			for direction=1,directions.count do
				local nextX=directions.nextX(direction,column,row)
				local nextY=directions.nextY(direction,column,row)
				if nextX>=1 and nextX<=theBoard.columns and nextY>=1 and nextY<=theBoard.rows then
					theBoard:getCell(column,row):setNeighbor(direction,theBoard:getCell(nextX,nextY))
				end
			end
		end
	end
	function theBoard:fillSlots()
		local dataBoard=self.dataBoard
		for slot=1,dataBoard.slotCount do
			if dataBoard.slots[slot]==nil then
				local atom=generator.generate(dataBoard.generator)
				dataBoard.slots[slot]=cellDescriptors.generateAtom(atom)
			end
		end
		self:updateHints()
	end
	function theBoard:placeAtom()
		local cell = self:getCell(self.dataBoard.currentColumn,self.dataBoard.currentRow)
		if cell:getHint()==4 then
			local slotValue = self:getSlot(self:getCurrentSlot())
			self:setSlot(self:getCurrentSlot(),nil)
			cell:setValue(slotValue)
			cell:checkMolecule()
			self:fillSlots()
		end
	end
	function theBoard:updateHints()
		for column=1,self.columns do
			for row=1,self.rows do
				self:getCell(column,row):updateHint()
			end
		end
	end
	function theBoard:getMaximumSlots()
		return self.dataBoard.maximumSlots
	end
	function theBoard:getCurrentSlot()
		return self.dataBoard.currentSlot
	end
	function theBoard:nextSlot()
		local slot=self.dataBoard.currentSlot+1
		if slot>self.dataBoard.slotCount then
			slot=1
		end
		self.dataBoard.currentSlot=slot
		self:updateHints()
	end
	function theBoard:getSlot(slot)
		return self.dataBoard.slots[slot]
	end
	function theBoard:setSlot(slot,value)
		self.dataBoard.slots[slot]=value
	end
	function theBoard:rotateSlotCW(slot)
		self.dataBoard.slots[slot]=cellDescriptors.getCW(self.dataBoard.slots[slot])
		self:updateHints()
	end
	function theBoard:rotateSlotCCW(slot)
		self.dataBoard.slots[slot]=cellDescriptors.getCCW(self.dataBoard.slots[slot])
		self:updateHints()
	end
	function theBoard:rotateCurrentSlotCW()
		self:rotateSlotCW(self:getCurrentSlot())
	end
	function theBoard:rotateCurrentSlotCCW()
		self:rotateSlotCCW(self:getCurrentSlot())
	end
	function theBoard:moveCursor(direction)
		local column=self.dataBoard.currentColumn
		local row=self.dataBoard.currentRow
		local nextColumn=directions.nextX(direction,column,row)
		local nextRow=directions.nextY(direction,column,row)
		if nextColumn>self.dataBoard.columns then
			nextColumn=1
		end
		if nextRow>self.dataBoard.rows then
			nextRow=1
		end
		if nextColumn<1 then
			nextColumn=self.dataBoard.columns
		end
		if nextRow<1 then
			nextRow=self.dataBoard.rows
		end
		self.dataBoard.currentColumn=nextColumn
		self.dataBoard.currentRow=nextRow
	end
	theBoard:fillSlots()
	return theBoard
end

return gameBoard