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
	theCell.powered = false
	theCell.lit = false
	theCell.locked = false
	theCell.neighbors = {nil,nil,nil,nil}
	theCell.connected = {false,false,false,false}
	function theCell:clear()
		self.powered = false
		self.lit = false
		self.locked = false
		self.connected = {false,false,false,false}
	end
	function theCell:light()
		if self.lit then
			return
		end
	end
	function theCell:unlight()
		if not self.lit then
			return
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
	function theCell:getSequenceName()
		if self.powered then
			if self.locked then
				return "white"
			else
				return "yellow"
			end
		elseif self.lit then
			if self.locked then
				return "cyan"
			else
				return "green"
			end
		else
			if self.locked then
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
function gameData.board.newBoard(cell,columns,rows)
	local theBoard = {}
	while #theBoard<width do
		local theColumn = {}
		while #theColumn<rows do
			local theCell = cell.newCell()
			table.insert(theColumn,theCell)
		end
		table.insert(theBoard,theColumn)
	end
	local deltas = {{x=0,y=-1,opposite=3},{x=1,y=0,opposite=4},{x=0,y=1,opposite=1},{x=-1,y=0,opposite=2}}
	for column=1,#theBoard do
		local theColumn = theBoard[column]
		for row=1,#theColumn do
			for direction=1,#deltas do
				local nextColumn = column + deltas[direction].x
				local nextRow = row + deltas[direction].y
				if nextColumn>=1 and nextColumn<=#theBoard and nextRow>=1 and nextRow<=#theColumn then
					theBoard[
				end
			end
		end
	end
	return theBoard
end
gameData.board.x = display.contentCenterX - gameData.cell.width * gameData.board.columns/2 + gameData.cell.width/2
gameData.board.y = display.contentCenterY - gameData.cell.height * gameData.board.rows/2 + gameData.cell.height/2
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
