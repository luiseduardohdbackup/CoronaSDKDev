--main.lua
display.setDefault("background",0,0,0)
local gameData = {}
local maze = require("maze")
gameData.bounds = {
	left = 0,
	top = 0,
	right = 640,
	bottom = 360
}
gameData.maze = maze.newMaze(16,8)
local storyboard = require("storyboard")
storyboard.loadScene("splash",false,gameData)
storyboard.loadScene("mainMenu",false,gameData)
storyboard.loadScene("options",false,gameData)
storyboard.loadScene("play",false,gameData)
storyboard.gotoScene("splash","crossFade")
