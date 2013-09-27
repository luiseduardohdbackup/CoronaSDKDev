--main.lua

local constants = {
	cell = {
		width=16,
		height=16
	},
	board = {
		width = 40,
		height = 30
	},
	screen = {
		width = 640,
		height = 480
	}
}

function createBackground()
	return display.newImage( "background.png" )
end
function createLeftWall()
	local theWall = display.newImage( "wall.png" )
	theWall.x = constants.cell.width/2
end
function createRightWall()
	local theWall = display.newImage( "wall.png" )
	theWall.x = (constants.board.width-1) * constants.cell.width + constants.cell.width/2
	return theWall
end
function createBlocks()
	local theBlocks = {}
	for theIndex = 0, constants.board.height-1 do
		theBlocks[theIndex] = display.newImage("block.png")
		theBlocks[theIndex].x = constants.cell.width/2
		theBlocks[theIndex].y = constants.cell.height * theIndex + constants.cell.height/2
	end
end

local background = createBackground()
local blocks = createBlocks()
local leftWall = createLeftWall()
local rightWall = createRightWall()

local scoreText = display.newText( {
	text="0",
	x=176,
	y=16,
	width = 304,
	height = 16,
	font=native.systemFont,
	fontSize=16,
	align="left"
} )
scoreText:setTextColor(0,255,0);
local highScoreText = display.newText({
	text="0",
	x=464,
	y=16,
	width = 304,
	height = 16,
	font=native.systemFont,
	fontSize=16,
	align="right"
})
highScoreText:setTextColor(0,255,0);
