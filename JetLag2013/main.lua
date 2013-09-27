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
	},
	tail = {
		length=5
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
	return theBlocks
end
function createTail()
	local theTail = {}
	for theIndex=0,constants.tail.length-2 do
		theTail[theIndex]=display.newImage("tail.png")
		theTail[theIndex].x = constants.board.width/2 * constants.cell.width + constants.cell.width/2
		theTail[theIndex].y = constants.cell.height * theIndex + constants.cell.height/2
	end
	theTail[constants.tail.length-1]=display.newImage("head.png")
	theTail[constants.tail.length-1].x = constants.board.width/2 * constants.cell.width + constants.cell.width/2
	theTail[constants.tail.length-1].y = constants.cell.height * (constants.tail.length-1) + constants.cell.height/2
	return theTail
end

local background = createBackground()
local blocks = createBlocks()
local leftWall = createLeftWall()
local rightWall = createRightWall()
local tail = createTail()
local game = {
	state = "gameover",
	score = 0,
	highScore = 0,
	direction = 1
}

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

function showScores()
	scoreText.text = game.score
	highScoreText.text = game.highScore
end

function resetGame()
	for theIndex=0,constants.board.height-1 do
		blocks[theIndex].x = constants.cell.width/2
	end
	for theIndex=0,constants.tail.length-1 do
		tail[theIndex].x = constants.cell.width * (constants.board.width/2) + constants.cell.width/2
	end
	game.score = 0
	showScores()
end

function timeoutDeath()
	game.state = "gameover"
end

function scrollGame()
	if game.state~="play" then
		return
	end
	for theIndex=0,constants.board.height-2 do
		blocks[theIndex].x = blocks[theIndex+1].x
	end
	for theIndex=0,constants.tail.length-2 do
		tail[theIndex].x = tail[theIndex+1].x
	end
	blocks[constants.board.height-1].x = math.random(1,constants.board.width-2) * constants.cell.width + constants.cell.width/2
	tail[constants.tail.length-1].x = tail[constants.tail.length-1].x + game.direction * constants.cell.width
	if tail[constants.tail.length-1].x == blocks[constants.tail.length-1].x then
		game.state = "death"
		timer.performWithDelay(1000,timeoutDeath)
	end
end

timer.performWithDelay(100,scrollGame,0)

function handleTap(event)
	if game.state=="gameover" then
		resetGame()
		game.state="play"
	elseif game.state=="play" then
		if event.x<constants.screen.width/2 then
			game.direction = -1
		else
			game.direction = 1
		end
	end
end

Runtime:addEventListener("tap",handleTap)