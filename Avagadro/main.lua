local dataBoard=require "dataBoard"
local gameBoard=require "gameBoard"
local directions=require "directions"
local storyboard = require "storyboard" 
display.setDefault("background",1,1,1)
local gameData = {}
gameData.dataBoard=dataBoard.newDataBoard(8,8,0)

storyboard.loadScene("splash",false,gameData)
storyboard.loadScene("mainMenu",false,gameData)
storyboard.loadScene("play",false,gameData)
storyboard.gotoScene("play")

local lookUps = {}
lookUps.simulatorKeyboard ={
	down="down",
	up="up",
	left="left",
	right="right",
	space="O",
	tab="U",
	enter="Y",
	escape="A",
}
lookUps.ouyaKeyboard={
	down="down",
	up="up",
	left="left",
	right="right",
	buttonA="O",
	buttonB="A",
	buttonX="U",
	buttonY="Y",
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