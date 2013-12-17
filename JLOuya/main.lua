display.setDefault("background",85,85,85)
local asciiBoardCell = require("ASCIIBoardCell")

local gameData = {}
gameData.profileManager = require("profileManager")
gameData.profile = gameData.profileManager.loadProfile()
gameData.musicManager = require("musicManager")
gameData.musicManager.start()
gameData.musicManager.setVolume(gameData.profile.musicVolume)
gameData.soundManager = require("soundManager")
gameData.soundManager.setVolume(gameData.profile.soundVolume)
gameData.player={}
gameData.constants={}
gameData.constants.screen={
	width=1920,
	height=1080
}
gameData.constants.grid={
	columns=48,
	rows=27
}
gameData.constants.cell={
	width=32,
	height=32
}
gameData.constants.grid.width = gameData.constants.grid.columns * gameData.constants.cell.width
gameData.constants.grid.height = gameData.constants.grid.rows * gameData.constants.cell.height
gameData.constants.grid.x = (gameData.constants.screen.width-gameData.constants.grid.width)/2
gameData.constants.grid.y = (gameData.constants.screen.height-gameData.constants.grid.height)/2
gameData.constants.leftWalls = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}
gameData.constants.rightWalls = {48,47,46,45,44,43,42,41,40,39,38,37,36,35,34}
gameData.constants.tailLength = 5
gameData.speeds={
	500,
	400,
	300,
	200,
	100,
	90,
	80,
	70,
	60,
	50,
}
gameData.charms = {
	walls={
		asciiBoardCell.createCell(219,1,0),
		asciiBoardCell.createCell(219,2,0),
		asciiBoardCell.createCell(219,3,0),
		asciiBoardCell.createCell(219,4,0),
		asciiBoardCell.createCell(219,5,0),
		asciiBoardCell.createCell(219,6,0),
		asciiBoardCell.createCell(219,7,0),
		asciiBoardCell.createCell(219,8,0),
		asciiBoardCell.createCell(219,9,0),
		asciiBoardCell.createCell(219,10,0),
		asciiBoardCell.createCell(219,11,0),
		asciiBoardCell.createCell(219,12,0),
		asciiBoardCell.createCell(219,13,0),
		asciiBoardCell.createCell(219,14,0),
		asciiBoardCell.createCell(219,0,0),
	},
	block = asciiBoardCell.createCell(219,15,0),
	nextToBlock = asciiBoardCell.createCell(255,0,0),
	star = asciiBoardCell.createCell(42,6,0),
	dude = asciiBoardCell.createCell(2,15,0),
	life = asciiBoardCell.createCell(1,15,0),
	nothing = asciiBoardCell.createCell(0,0,0),
	invincibleDude = asciiBoardCell.createCell(2,11,0),
	warningDude = asciiBoardCell.createCell(2,12,0),
	shieldedDude = asciiBoardCell.createCell(1,1,0),
	heart=asciiBoardCell.createCell(3,4,0),
	diamond=asciiBoardCell.createCell(4,14,0),
	shield=asciiBoardCell.createCell(233,1,0),
	stopper=asciiBoardCell.createCell(234,3,0),
	bomb=asciiBoardCell.createCell(15,8,0),
	speedUp=asciiBoardCell.createCell(24,5,0),
	slowDown=asciiBoardCell.createCell(25,5,0),
	straighten=asciiBoardCell.createCell(18,5,0),
	widen=asciiBoardCell.createCell(29,1,0),
	fish=asciiBoardCell.createCell(224,13,0),
	oneQuarter=asciiBoardCell.createCell(172,2,0),
	oneHalf=asciiBoardCell.createCell(171,2,0),
	one=asciiBoardCell.createCell(49,2,0),
	two=asciiBoardCell.createCell(50,2,0),
	four=asciiBoardCell.createCell(52,2,0),
	zero=asciiBoardCell.createCell(48,2,0),
	jetlagJ=asciiBoardCell.createCell(74,8,0),
	jetlagE=asciiBoardCell.createCell(101,8,0),
	jetlagT=asciiBoardCell.createCell(116,8,0),
	jetlagL=asciiBoardCell.createCell(76,8,0),
	jetlagA=asciiBoardCell.createCell(97,8,0),
	jetlagG=asciiBoardCell.createCell(103,8,0),
	reverseKeys=asciiBoardCell.createCell(63,8,0),
	splat = asciiBoardCell.createCell(15,4,0),
	cent = asciiBoardCell.createCell(155,2,0),
	oButton = asciiBoardCell.createCell(string.byte("O"),2,10),
	uButton = asciiBoardCell.createCell(string.byte("U"),1,9),
	yButton = asciiBoardCell.createCell(string.byte("Y"),6,14),
	aButton = asciiBoardCell.createCell(string.byte("A"),4,12),
}

gameData.resources={
	imageSheet = graphics.newImageSheet("ascii.png",{width=40,height=40,numFrames=256}),
	colors=require("Colors")
}

local storyboard = require("storyboard")
storyboard.loadScene("splash",false,gameData)
storyboard.loadScene("mainMenu",false,gameData)
storyboard.loadScene("instructions",false,gameData)
storyboard.loadScene("options",false,gameData)
storyboard.loadScene("about",false,gameData)
storyboard.loadScene("shop",false,gameData)
storyboard.loadScene("feedTheFish",false,gameData)
storyboard.loadScene("play",false,gameData)
storyboard.loadScene("quit",false,gameData)
storyboard.gotoScene("splash","crossFade")

local lookUps = {}
lookUps.simulatorKeyboard ={
	down="down",
	up="up",
	left="left",
	right="right",
	enter="O",
	space="U",
	tab="Y",
	escape="A"
}
lookUps.ouyaKeyboard={
	down="down",
	up="up",
	left="left",
	right="right",
	buttonA="O",
	buttonB="A",
	buttonX="O",
	buttonY="Y",
	leftShoulderButton1="left",
	leftShoulderButton2="left",
	rightShoulderButton1="right",
	rightShoulderButton2="right",
	leftJoystickButton="left",
	rightJoystickButton="right"
}
function onKeyEvent(event)
	local currentScene = storyboard.getScene(storyboard.getCurrentSceneName())
	if event.device==nil then
		local theKey = lookUps.simulatorKeyboard[event.keyName]
		if theKey~=nil then
			if event.phase=="down" then
				currentScene:onKeyDown(theKey)
			elseif event.phase=="up" then
				currentScene:onKeyUp(theKey)
			end
		end
	else
		local theKey = lookUps.ouyaKeyboard[event.keyName]
		if theKey~=nil then
			if event.phase=="down" then
				currentScene:onKeyDown(theKey)
			elseif event.phase=="up" then
				currentScene:onKeyUp(theKey)
			end
		end
	end
end

function onAxisEvent(event)
	local currentScene = storyboard.getScene(storyboard.getCurrentSceneName())
end

Runtime:addEventListener( "key", onKeyEvent )

Runtime:addEventListener( "axis", onAxisEvent )