--main.lua
display.setDefault("background",128,128,128)
local gameData = {}
gameData.bounds = {
	left = 0,
	right = 640,
	top = 0,
	bottom = 480
}
local storyboard = require("storyboard")
storyboard.loadScene("splash",false,gameData)
storyboard.loadScene("mainMenu",false,gameData)
storyboard.gotoScene("splash","crossFade")
