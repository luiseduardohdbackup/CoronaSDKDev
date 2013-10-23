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
	whole = {
			[0]=generators.newGenerator({[0]=1}),
			[1]=generators.newGenerator({[1]=1}),
			[2]=generators.newGenerator({[2]=1}),
			[3]=generators.newGenerator({[3]=1}),
			[4]=generators.newGenerator({[4]=1}),
			[5]=generators.newGenerator({[5]=1})
		},
	oneSixth = {
			[1]=generators.newGenerator({[0]=5,[1]=1}),
			[2]=generators.newGenerator({[0]=25,[1]=10,[2]=1}),
			[3]=generators.newGenerator({[0]=125,[1]=75,[2]=15,[3]=1}),
			[4]=generators.newGenerator({[0]=625,[1]=500,[2]=150,[3]=20,[4]=1}),
			[5]=generators.newGenerator({[0]=3125,[1]=3125,[2]=1250,[3]=250,[4]=25,[5]=1})
		},
	oneThird = {
			[1]=generators.newGenerator({[0]=2,[1]=1}),
			[2]=generators.newGenerator({[0]=4,[1]=4,[2]=1}),
			[3]=generators.newGenerator({[0]=8,[1]=12,[2]=6,[3]=1}),
			[4]=generators.newGenerator({[0]=16,[1]=32,[2]=24,[3]=8,[4]=1}),
			[5]=generators.newGenerator({[0]=32,[1]=80,[2]=80,[3]=40,[4]=10,[5]=1})
		},
	oneHalf = {
			[1]=generators.newGenerator({[0]=1,[1]=1}),
			[2]=generators.newGenerator({[0]=1,[1]=2,[2]=1}),
			[3]=generators.newGenerator({[0]=1,[1]=3,[2]=3,[3]=1}),
			[4]=generators.newGenerator({[0]=1,[1]=4,[2]=6,[3]=4,[4]=1}),
			[5]=generators.newGenerator({[0]=1,[1]=5,[2]=10,[3]=10,[4]=5,[5]=1})
		},
	twoThirds = {
			[1]=generators.newGenerator({[1]=2,[0]=1}),
			[2]=generators.newGenerator({[2]=4,[1]=4,[0]=1}),
			[3]=generators.newGenerator({[3]=8,[2]=12,[1]=6,[0]=1}),
			[4]=generators.newGenerator({[4]=16,[3]=32,[2]=24,[1]=8,[0]=1}),
			[5]=generators.newGenerator({[5]=32,[4]=80,[3]=80,[2]=40,[1]=10,[0]=1})
		},
	fiveSixths = {
			[1]=generators.newGenerator({[1]=5,[0]=1}),
			[2]=generators.newGenerator({[2]=25,[1]=10,[0]=1}),
			[3]=generators.newGenerator({[3]=125,[2]=75,[1]=15,[0]=1}),
			[4]=generators.newGenerator({[4]=625,[3]=500,[2]=150,[1]=20,[0]=1}),
			[5]=generators.newGenerator({[5]=3125,[4]=3125,[3]=1250,[2]=250,[1]=25,[0]=1})
		}
}
gameData.monsters = {
	minotaur = {
		movement = 5,
		body = 5,
		mind = 2,
		attack = gameData.generators.oneThird[2],
		defend = gameData.generators.oneSixth[5]
	},
	rat = {
		movement = 10,
		body = 1,
		mind = 1,
		attack = gameData.generators.whole[1],
		defend = gameData.generators.whole[1]
	},
	spider = {
		movement = 10,
		body = 1,
		mind = 1,
		attack = gameData.generators.fiveSixths[1],
		defend = gameData.generators.whole[0]
	},
	bat = {
		movement = 10,
		body = 1,
		mind = 1,
		attack = gameData.generators.oneThird[1],
		defend = gameData.generators.whole[0]
	}
}
local storyboard = require("storyboard")
storyboard.loadScene("splash",false,gameData)
storyboard.loadScene("mainMenu",false,gameData)
storyboard.loadScene("options",false,gameData)
storyboard.loadScene("play",false,gameData)
storyboard.loadScene("map",false,gameData)
storyboard.gotoScene("splash","crossFade")
