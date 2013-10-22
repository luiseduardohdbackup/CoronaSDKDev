--main.lua
display.setDefault("background",0,0,0)
local gameData = {}
local maze = require("maze")
local generators = require("generators")
gameData.bounds = {
	left = 0,
	top = 0,
	right = 640,
	bottom = 360
}
gameData.maze = maze.newMaze(16,8)
gameData.generators = {
	w = generators.newGenerator({[0]=2,[1]=1}),
	ww = generators.newGenerator({[0]=2,[1]=1}),
	r = generators.newGenerator({[0]=1,[1]=1}),
	b = generators.newGenerator({[0]=1,[1]=2})
}
gameData.monsters = {
	spider = {
		health = 1
	},
	bat = {
		health = 1
	}
}
local storyboard = require("storyboard")
storyboard.loadScene("splash",false,gameData)
storyboard.loadScene("mainMenu",false,gameData)
storyboard.loadScene("options",false,gameData)
storyboard.loadScene("play",false,gameData)
storyboard.loadScene("map",false,gameData)
storyboard.gotoScene("splash","crossFade")
