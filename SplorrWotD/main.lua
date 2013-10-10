--main.lua
display.setDefault("background",0,0,0)
local gameData = {}
gameData.bounds = {
	left = 0,
	right = 640,
	top = 0,
	bottom = 360
}
local storyboard = require("storyboard")
storyboard.loadScene("splash",false,gameData)
storyboard.loadScene("mainMenu",false,gameData)
storyboard.gotoScene("splash","crossFade")
