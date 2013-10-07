--main.lua
display.setDefault("background",255,255,255)
local gameData = {}
gameData.bounds = {
	left=display.contentCenterX-display.viewableContentWidth/2,
	top=display.contentCenterY-display.viewableContentHeight/2,
	right=display.contentCenterX+display.viewableContentWidth/2,
	bottom=display.contentCenterY+display.viewableContentHeight/2
}
gameData.cell = {width=68,height=68}
function gameData.cell.newCell()
	local theCell = {}
	theCell.inside = false
	theCell.powered = false
	theCell.lit = false
	theCell.locked = false
	theCell.neighbors = {nil,nil,nil,nil}
	theCell.connected = {false,false,false,false}
	function theCell:clear()
		self.inside = false
		self.powered = false
		self.lit = false
		self.locked = false
		self.connected = {false,false,false,false}
	end
	function theCell:light()
		local opposites={3,4,1,2}
		if self.lit then
			return
		end
		self.lit = true
		for direction=1,#self.neighbors do
			if self.neighbors[direction]~=nil and self.connected[direction] and self.neighbors[direction].connected[opposites[direction]] then
				self.neighbors[direction]:light()
			end
		end
	end
	function theCell:rotateCW()
		local temp = theCell.connected[4]
		table.remove(theCell.connected,4)
		table.insert(theCell.connected,1,temp)
	end
	function theCell:unlight()
		local opposites={3,4,1,2}
		if not self.lit then
			return
		end
		self.lit = false
		for direction=1,#self.neighbors do
			if self.neighbors[direction]~=nil and self.connected[direction] and self.neighbors[direction].connected[opposites[direction]] then
				self.neighbors[direction]:unlight()
			end
		end
	end
	function theCell:getFrame()
		local theFrame = 1
		if self.connected[1] then
			theFrame = theFrame + 1
		end
		if self.connected[2] then
			theFrame = theFrame + 2
		end
		if self.connected[3] then
			theFrame = theFrame + 4
		end
		if self.connected[4] then
			theFrame = theFrame + 8
		end
		return theFrame
	end
	function theCell:setFrame(frame)
		self.connected[4] = frame>8
		if frame>8 then
			frame = frame-8
		end
		self.connected[3] = frame>4
		if frame>4 then
			frame = frame -4
		end
		self.connected[2] = frame>2
		if frame>2 then
			frame = frame - 2
		end
		self.connected[1] = frame>1
	end
	function theCell:getSequenceName()
		if self.powered then
			if self:getFrame()~=self.originalFrame then
				return "white"
			else
				return "yellow"
			end
		elseif self.lit then
			if self:getFrame()~=self.originalFrame then
				return "cyan"
			else
				return "green"
			end
		else
			if self:getFrame()~=self.originalFrame then
				return "magenta"
			else
				return "red"
			end
		end
	end
	return theCell
end
gameData.board = {
	columns=math.floor((gameData.bounds.right-gameData.bounds.left)/gameData.cell.width),
	rows=math.floor((gameData.bounds.bottom-gameData.bounds.top)/gameData.cell.height)
}
gameData.board.x = gameData.bounds.left + ((gameData.bounds.right-gameData.bounds.left) - gameData.board.columns * gameData.cell.width)/2
gameData.board.y = gameData.bounds.top + ((gameData.bounds.bottom-gameData.bounds.top) - gameData.board.rows * gameData.cell.height)/2
function gameData.board.newBoard(cell,columns,rows)
	local theBoard = {}
	local theColumns = {}
	theBoard.columns = theColumns
	while #theColumns<columns do
		local theColumn = {}
		while #theColumn<rows do
			local theCell = cell.newCell()
			table.insert(theColumn,theCell)
		end
		table.insert(theColumns,theColumn)
	end
	local deltas = {{x=0,y=-1,opposite=3},{x=1,y=0,opposite=4},{x=0,y=1,opposite=1},{x=-1,y=0,opposite=2}}
	for column=1,#theColumns do
		local theColumn = theColumns[column]
		for row=1,#theColumn do
			for direction=1,#deltas do
				local nextColumn = column + deltas[direction].x
				local nextRow = row + deltas[direction].y
				if nextColumn>=1 and nextColumn<=#theColumns and nextRow>=1 and nextRow<=#theColumn then
					theColumns[column][row].neighbors[direction]=theColumns[nextColumn][nextRow]
					theColumns[nextColumn][nextRow].neighbors[deltas[direction].opposite]=theColumns[column][row]
				end
			end
		end
	end
	function theBoard:clear()
		for column=1,#self.columns do
			for row=1,#self.columns[column] do
				self.columns[column][row]:clear()
			end
		end
	end
	function theBoard:isSolved()
		for column=1,#self.columns do
			for row=1,#self.columns[column] do
				if not self.columns[column][row].lit then
					return false
				end
			end
		end
		return true
	end
	function theBoard:light()
		self.poweredCell:light()
	end
	function theBoard:unlight()
		self.poweredCell:unlight()
	end
	function theBoard:generate()
		local opposites={3,4,1,2}
		self:clear()
		local cell = self.columns[math.random(#self.columns)][math.random(#self.columns[1])]
		self.poweredCell = cell
		cell.inside = true
		cell.powered = true
		local frontier = {}
		for direction=1,#cell.neighbors do
			if cell.neighbors[direction] ~= nil then
				table.insert(frontier,cell.neighbors[direction])
			end
		end
		while #frontier>0 do
			local index=math.random(#frontier)
			cell = frontier[index]
			table.remove(frontier,index)
			local directions={}
			for direction=1,#cell.neighbors do
				if cell.neighbors[direction]~=nil and cell.neighbors[direction].inside then
					table.insert(directions,direction)
				end
			end
			local direction = directions[math.random(#directions)]
			cell.inside = true
			cell.connected[direction]=true
			cell.neighbors[direction].connected[opposites[direction]]=true
			for direction=1,#cell.neighbors do
				if cell.neighbors[direction] ~= nil and not cell.neighbors[direction].inside and table.indexOf(frontier,cell.neighbors[direction])==nil then
					table.insert(frontier,cell.neighbors[direction])
				end
			end
		end
	end
	function theBoard:scramble()
		for column=1,#self.columns do
			for row=1,#self.columns[column] do
				local cell = self.columns[column][row]
				local frames = {}
				local currentFrame = cell:getFrame()
				for direction=1,#cell.connected do
					cell.rotateCW()
					local frame = cell:getFrame()
					if frame~=currentFrame and table.indexOf(frames,frame)==nil then
						table.insert(frames,frame)
					end
				end
				if #frames==1 then
					cell:setFrame(frames[1])
				elseif #frames>1 then
					cell:setFrame(frames[math.random(#frames)])
				end
				if cell:getFrame()==1 or cell:getFrame()==16 then
					cell.originalFrame = 17 - cell:getFrame()
				else
					cell.originalFrame = cell:getFrame()
				end
			end
		end
	end
	return theBoard
end
gameData.pipeImageSheet = graphics.newImageSheet("pipes.png",{width=64,height=64,numFrames=96})
gameData.pipeSequences = {{name="red",frames={1,2,3,4,13,14,15,16,25,26,27,28,37,38,39,40}},
	{name="green",frames={5,6,7,8,17,18,19,20,29,30,31,32,41,42,43,44}},
	{name="yellow",frames={9,10,11,12,21,22,23,24,33,34,35,36,45,46,47,48}},
	{name="magenta",frames={49,50,51,52,61,62,63,64,73,74,75,76,85,86,87,88}},
	{name="cyan",frames={53,54,55,56,65,66,67,68,77,78,79,80,89,90,91,92}},
	{name="white",frames={57,58,59,60,69,70,71,72,81,82,83,84,93,94,95,96}}}
local storyboard = require("storyboard")
storyboard.loadScene("splash",false,gameData)
storyboard.loadScene("mainMenu",false,gameData)
storyboard.loadScene("about",false,gameData)
storyboard.loadScene("help",false,gameData)
storyboard.loadScene("play",false,gameData)
storyboard.gotoScene("splash","crossFade")
