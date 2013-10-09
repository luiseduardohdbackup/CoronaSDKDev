--main.lua
require "sqlite3"
local ads = require("ads")

local db = sqlite3.open(system.pathForFile("JL2013.db",system.DocumentsDirectory))

function adListener(event)
	if event.isError then
	end
end

function handleSystem(event)
	if event.type=="applicationExit" then
		db:close()
	end
end

function setUpDatabase()
	db:exec([[CREATE TABLE IF NOT EXISTS AllTime (HighScore INT NOT NULL,HighLineScore INT NOT NULL,TotalScore INT NOT NULL,TotalLineScore INT NOT NULL,TotalGames INT NOT NULL)]])
	for a in db:nrows([[SELECT COUNT(*) as Count FROM AllTime]]) do
		if a.Count==0 then
			db:exec([[INSERT INTO AllTime (HighScore,HighLineScore,TotalScore,TotalLineScore,TotalGames) VALUES (0,0,0,0,0)]])
		elseif a.Count>1 then
			db:exec([[DELETE FROM AllTime]])
			db:exec([[INSERT INTO AllTime (HighScore,HighLineScore,TotalScore,TotalLineScore,TotalGames) VALUES (0,0,0,0,0)]])
		end
	end
end

setUpDatabase()

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
	sidebar = {
		width = 120
	},
	tail = {
		length=5
	}
}

function createBackground()
	local theBackground = display.newRect(0,0,constants.screen.width,constants.screen.height)
	theBackground:setFillColor(0,0,0)
	return theBackground
end
function createLeftWall()
	local theWall = display.newRect( 0,0,constants.cell.width,constants.screen.height )
	theWall:setFillColor(0,0,255)
	return theWall
end
function createLeftSideBar()
	local theSideBar = display.newRect(-constants.sidebar.width,0,constants.sidebar.width,constants.screen.height)
	theSideBar:setFillColor(128,128,128)
	return theSideBar
end
function createRightWall()
	local theWall = display.newRect( constants.screen.width - constants.cell.width,0,constants.cell.width,constants.screen.height )
	theWall:setFillColor(0,0,255)
	return theWall
end
function createRightSideBar()
	local theSideBar = display.newRect(constants.screen.width,0,constants.sidebar.width,constants.screen.height)
	theSideBar:setFillColor(128,128,128)
	return theSideBar
end
function createBlocks()
	local theBlocks = {}
	for theIndex = 0, constants.board.height-1 do
		theBlocks[theIndex] = display.newRect(0,constants.cell.height * theIndex,constants.cell.width,constants.cell.height)
	end
	return theBlocks
end
function createTail()
	local theTail = {}
	for theIndex=0,constants.tail.length-2 do
		theTail[theIndex]=display.newRect(constants.board.width/2 * constants.cell.width, constants.cell.height * theIndex, constants.cell.width, constants.cell.height)
		theTail[theIndex]:setFillColor(255,255,0)
	end
	theTail[constants.tail.length-1]=display.newRect(constants.board.width/2 * constants.cell.width,constants.cell.height * (constants.tail.length-1), constants.cell.width, constants.cell.height)
	theTail[constants.tail.length-1]:setFillColor(255,0,0)
	return theTail
end

local background = createBackground()
local blocks = createBlocks()
local leftWall = createLeftWall()
local rightWall = createRightWall()
createLeftSideBar()
createRightSideBar()
local tail = createTail()
local game = {
	state = "gameover",
	score = 0,
	highScore = 0,
	direction = 1,
	scoreDelta = 1,
	scoreAccumulator = 0,
	lines = 0
}

function loadHighScore()
	for theRow in db:nrows([[SELECT HighScore FROM AllTime LIMIT 1]]) do
		game.highScore = theRow.HighScore
	end
end

function updateDbScores()
	local theTotalScore
	local theTotalLineScore
	local theHighScore
	local theHighLineScore
	local theTotalGames
	for theRow in db:nrows([[SELECT * FROM AllTime LIMIT 1]]) do
		theTotalScore = game.score + theRow.TotalScore
		theTotalLineScore = math.floor(game.score / game.lines) + theRow.TotalLineScore
		theHighScore = math.max(theRow.HighScore,game.score)
		theHighLineScore = math.max(theRow.HighLineScore, math.floor(game.score / game.lines))
		theTotalGames = theRow.TotalGames + 1
	end
	db:exec([[UPDATE AllTime SET TotalScore=]]..theTotalScore..[[,TotalLineScore=]]..theTotalLineScore..[[,TotalGames=]]..theTotalGames..[[,HighScore=]]..theHighScore..[[,HighLineScore=]]..theHighLineScore)
end

loadHighScore()
local scoreText = display.newText( {
	text="0",
	x=176,
	y=16,
	width = 304,
	height = 32,
	font="8bitoperator JVE",
	fontSize=16,
	align="left"
} )
scoreText:setTextColor(0,255,0)
local highScoreText = display.newText({
	text="0",
	x=464,
	y=16,
	width = 304,
	height = 32,
	font="8bitoperator JVE",
	fontSize=16,
	align="right"
})
highScoreText:setTextColor(0,255,0)
local statusText = display.newText({
	text="Tap to Start",
	x = 320,
	y = 240,
	height = 96,
	font = "8bitoperator JVE",
	fontSize=48,
	align="center"
})
statusText:setTextColor(126,128,255)

function showScores()
	scoreText.text = game.score
	highScoreText.text = game.highScore
end
showScores()


function resetGame()
	for theIndex=0,constants.board.height-1 do
		blocks[theIndex].x = constants.cell.width/2
	end
	for theIndex=0,constants.tail.length-1 do
		tail[theIndex].x = constants.cell.width * (constants.board.width/2) + constants.cell.width/2
	end
	game.score = 0
	game.direction = 1
	game.scoreDelta = 1
	game.scoreAccumulator = 0
	game.lines = 0
	showScores()
end

function timeoutDeath()
	statusText.text="Tap to Start"
	game.state = "gameover"
end

function scrollGame()
	if game.state~="play" then
		return
	end
	game.lines = game.lines + 1
	game.scoreAccumulator = game.scoreAccumulator + game.scoreDelta
	game.scoreDelta = game.scoreDelta + 1
	if game.score > game.highScore then
		game.highScore = game.score
	end
	showScores()
	for theIndex=0,constants.board.height-2 do
		blocks[theIndex].x = blocks[theIndex+1].x
	end
	for theIndex=0,constants.tail.length-2 do
		tail[theIndex].x = tail[theIndex+1].x
	end
	blocks[constants.board.height-1].x = math.random(1,constants.board.width-2) * constants.cell.width + constants.cell.width/2
	tail[constants.tail.length-1].x = tail[constants.tail.length-1].x + game.direction * constants.cell.width
	if tail[constants.tail.length-1].x == blocks[constants.tail.length-1].x  or tail[constants.tail.length-1].x==leftWall.x or tail[constants.tail.length-1].x==rightWall.x then
		updateDbScores()
		statusText.text="Game Over"
		game.state = "death"
		timer.performWithDelay(1000,timeoutDeath)
	end
end

timer.performWithDelay(100,scrollGame,0)

function handleTap(event)
	if game.state=="gameover" then
		resetGame()
		statusText.text=""
		game.state="play"
	elseif game.state=="play" then
		if event.x<constants.screen.width/2 then
			if game.direction==1 then
				game.score = game.score + game.scoreAccumulator
				game.scoreAccumulator = 0
				game.scoreDelta = 1
			end
			game.direction = -1
		else
			if game.direction==-1 then
				game.score = game.score + game.scoreAccumulator
				game.scoreAccumulator = 0
				game.scoreDelta = 1
			end
			game.direction = 1
		end
	end
end

function handleKey(event)
	if event.keyName=="left" then
		if game.direction==1 then
			game.score = game.score + game.scoreAccumulator
			game.scoreAccumulator = 0
			game.scoreDelta = 1
		end
		game.direction=-1
	elseif event.keyName=="right" then
		if game.direction==-1 then
			game.score = game.score + game.scoreAccumulator
			game.scoreAccumulator = 0
			game.scoreDelta = 1
		end
		game.direction=1
	end
end

Runtime:addEventListener("tap",handleTap)
Runtime:addEventListener("key",handleKey)
Runtime:addEventListener("system",handleSystem)

ads.init("admob","ca-app-pub-6417425738244044/6541055152",adListener)
ads.show("banner",{ x = 0, y = 0})

