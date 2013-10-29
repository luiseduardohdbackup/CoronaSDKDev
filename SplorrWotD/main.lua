--main.lua
display.setDefault("background",0,0,0)
local gameData = {}
local maze = require("maze")
local generators = require("generators")
local utilities = require("utilities")
local directions = require("directions")
local player = require("player")
local monsters = require("monsters")
local items = require("items")
gameData.bounds = {
	left = 0,
	top = 0,
	right = 640,
	bottom = 360
}
gameData.generators = {
	whole = {
			[0]=generators.newGenerator({[0]=1}),
			[1]=generators.newGenerator({[1]=1}),
			[2]=generators.newGenerator({[2]=1}),
			[3]=generators.newGenerator({[3]=1}),
			[4]=generators.newGenerator({[4]=1}),
			[5]=generators.newGenerator({[5]=1}),
			[6]=generators.newGenerator({[6]=1}),
			[7]=generators.newGenerator({[7]=1}),
			[8]=generators.newGenerator({[8]=1}),
			[9]=generators.newGenerator({[9]=1}),
			[10]=generators.newGenerator({[10]=1}),
			[11]=generators.newGenerator({[11]=1}),
			[12]=generators.newGenerator({[12]=1}),
			[13]=generators.newGenerator({[13]=1}),
			[16]=generators.newGenerator({[16]=1})
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
		instance = {
			name = "Minotaur",
			groupName="minotaur",
			movement = 5,
			body = 5,
			mind = 2,
			attack = utilities.cloneTable(gameData.generators.oneThird[2]),
			defend = utilities.cloneTable(gameData.generators.oneSixth[5]),
			experience = 5
		},
		doorCounts = {1},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(1)),
		dropGenerator = generators.newGenerator({battleAxe=1})
	},
	rat = {
		instance = {
			name = "Rat",
			groupName="rat",
			movement = 10,
			body = 1,
			mind = 1,
			attack = utilities.cloneTable(generators.newConstantGenerator(1)),
			defend = utilities.cloneTable(generators.newConstantGenerator(1)),
			experience = 1
		},
		doorCounts = {2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(16)),
		dropGenerator = generators.newGenerator({ratTail=1})
	},
	spider = {
		instance = {
			name = "Spider",
			groupName="spider",
			movement = 10,
			body = 1,
			mind = 1,
			attack = utilities.cloneTable(gameData.generators.fiveSixths[1]),
			defend = utilities.cloneTable(generators.newConstantGenerator(0)),
			experience = 1
		},
		doorCounts = {2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(16)),
		dropGenerator = generators.newGenerator({spiderEye=1})
	},
	bat = {
		instance = {
			name = "Bat",
			groupName="bat",
			movement = 10,
			body = 1,
			mind = 1,
			attack = utilities.cloneTable(gameData.generators.oneThird[1]),
			defend = utilities.cloneTable(generators.newConstantGenerator(0)),
			experience = 1
		},
		doorCounts = {2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(16)),
		dropGenerator = generators.newGenerator({batWing=1})
	},
	chaosWarrior = {
		instance = {
			name = "Chaos Warrior",
			groupName="chaosWarrior",
			movement = 7,
			body = 3,
			mind = 3,
			attack = utilities.cloneTable(gameData.generators.oneThird[4]),
			defend = utilities.cloneTable(gameData.generators.oneSixth[4])),
			experience = 1
		},
		doorCounts = {2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(16)),
		dropGenerator = generators.newGenerator({batWing=1})
	},
	gargoyle = {
		instance = {
			name = "Gargoyle",
			groupName="gargoyle",
			movement = 6,
			body = 3,
			mind = 4,
			attack = utilities.cloneTable(gameData.generators.oneThird[4]),
			defend = utilities.cloneTable(gameData.generators.oneSixth[5])),
			experience = 1
		},
		doorCounts = {2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(16)),
		dropGenerator = generators.newGenerator({batWing=1})
	},
	mummy = {
		instance = {
			name = "Mummy",
			groupName="mummy",
			movement = 4,
			body = 2,
			mind = 0,
			attack = utilities.cloneTable(gameData.generators.oneThird[3]),
			defend = utilities.cloneTable(gameData.generators.oneSixth[4])),
			experience = 1
		},
		doorCounts = {2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(16)),
		dropGenerator = generators.newGenerator({batWing=1})
	},
	skeleton = {
		instance = {
			name = "Skeleton",
			groupName="skeleton",
			movement = 6,
			body = 1,
			mind = 0,
			attack = utilities.cloneTable(gameData.generators.oneThird[2]),
			defend = utilities.cloneTable(gameData.generators.oneSixth[2])),
			experience = 1
		},
		doorCounts = {2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(16)),
		dropGenerator = generators.newGenerator({batWing=1})
	},
	fimir = {
		instance = {
			name = "Fimir",
			groupName="fimir",
			movement = 6,
			body = 2,
			mind = 3,
			attack = utilities.cloneTable(gameData.generators.oneThird[3]),
			defend = utilities.cloneTable(gameData.generators.oneSixth[3])),
			experience = 1
		},
		doorCounts = {2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(16)),
		dropGenerator = generators.newGenerator({batWing=1})
	},
	goblin = {
		instance = {
			name = "Goblin",
			groupName="goblin",
			movement = 10,
			body = 1,
			mind = 1,
			attack = utilities.cloneTable(gameData.generators.oneThird[2]),
			defend = utilities.cloneTable(gameData.generators.oneSixth[1])),
			experience = 1
		},
		doorCounts = {2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(16)),
		dropGenerator = generators.newGenerator({batWing=1})
	},
	orc = {
		instance = {
			name = "Orc",
			groupName="orc",
			movement = 8,
			body = 1,
			mind = 2,
			attack = utilities.cloneTable(gameData.generators.oneThird[3]),
			defend = utilities.cloneTable(gameData.generators.oneSixth[2])),
			experience = 1
		},
		doorCounts = {2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(16)),
		dropGenerator = generators.newGenerator({batWing=1})
	},
	zombie = {
		instance = {
			name = "Zombie",
			groupName="zombie",
			movement = 5,
			body = 1,
			mind = 0,
			attack = utilities.cloneTable(gameData.generators.oneThird[2]),
			defend = utilities.cloneTable(gameData.generators.oneSixth[3])),
			experience = 1
		},
		doorCounts = {2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(16)),
		dropGenerator = generators.newGenerator({batWing=1})
	}
}
gameData.items = {
	match = {
		instance = {
			name="Match",
			itemType = "light",
			lightLevel = 1,
			equipSlots = {"light"}
		},
		doorCounts = {},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(0)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(1))
	},
	torch = {
		instance = {
			name="Torch",
			itemType = "light",
			lightLevel = 2,
			equipSlots = {"light"}
		},
		doorCounts = {1,2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(4)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(0))
	},
	lantern = {
		instance = {
			name="Lantern",
			itemType = "light",
			lightLevel = 3,
			equipSlots = {"light"}
		},
		doorCounts = {1,2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(2)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(0))
	},
	magicLantern = {
		instance = {
			name="Magic Lantern",
			itemType = "light",
			lightLevel = 4,
			equipSlots = {"light"}
		},
		doorCounts = {1,2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(1)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(0))
	},
	fist = {
		instance = {
			name = "Fist",
			itemType = "weapon",
			equipSlots = {"on-hand"},
			attack = utilities.cloneTable(gameData.generators.oneSixth[1])
		},
		doorCounts = {},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(0)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(0))
	},
	dagger = {
		instance = {
			name = "Dagger",
			itemType = "weapon",
			equipSlots = {"on-hand"},
			attack = utilities.cloneTable(gameData.generators.oneHalf[1])
		},
		doorCounts = {1,2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(8)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(0))
	},
	shortSword = {
		instance = {
			name = "Short Sword",
			itemType = "weapon",
			equipSlots = {"on-hand"},
			attack = utilities.cloneTable(gameData.generators.oneHalf[2])
		},
		doorCounts = {1,2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(4)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(0))
	},
	longSword = {
		instance = {
			name = "Long Sword",
			itemType = "weapon",
			equipSlots = {"on-hand"},
			attack = utilities.cloneTable(gameData.generators.oneHalf[3])
		},
		doorCounts = {1,2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(2)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(0))
	},
	twoHandedSword = {
		instance = {
			name = "Two-handed Sword",
			itemType = "weapon",
			equipSlots = {"on-hand","off-hand"},
			attack = utilities.cloneTable(gameData.generators.oneHalf[4])
		},
		doorCounts = {1,2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(1)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(0))
	},
	battleAxe = {
		instance = {
			name = "Battle Axe",
			itemType = "weapon",
			equipSlots = {"on-hand","off-hand"},
			attack = utilities.cloneTable(gameData.generators.oneHalf[5])
		},
		doorCounts = {},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(0)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(0))
	},
	clothes = {
		instance = {
			name = "Clothes",
			itemType = "armor",
			equipSlots = {},
			defend = utilities.cloneTable(gameData.generators.oneThird[2])
		},
		doorCounts = {},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(0)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(0))
	},
	helmet = {
		instance = {
			name = "Helmet",
			itemType = "armor",
			equipSlots = {"head"},
			defend = utilities.cloneTable(gameData.generators.oneThird[1])
		},
		doorCounts = {1,2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(4)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(0))
	},
	shield = {
		instance = {
			name = "Shield",
			itemType = "armor",
			equipSlots = {"off-hand"},
			defend = utilities.cloneTable(gameData.generators.oneThird[1])
		},
		doorCounts = {1,2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(4)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(0))
	},
	chainMail = {
		instance = {
			name = "Chain Mail",
			itemType = "armor",
			equipSlots = {"torso"},
			defend = utilities.cloneTable(gameData.generators.oneThird[1])
		},
		doorCounts = {1,2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(4)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(0))
	},
	plateMail = {
		instance = {
			name = "Plate Mail",
			itemType = "armor",
			equipSlots = {"torso"},
			defend = utilities.cloneTable(gameData.generators.oneThird[2])
		},
		doorCounts = {1,2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(2)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(0))
	},
	boots = {
		instance = {
			name = "Boots",
			itemType = "armor",
			equipSlots = {"feet"},
			defend = utilities.cloneTable(gameData.generators.whole[0])
		},
		doorCounts = {1,2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(1)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(0))
	},
	ladderPiece = {
		instance = {
			name = "Ladder Piece",
			itemType = "quest"
		},
		doorCounts = {1},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(13)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(0))
	},
	ham = {
		instance = {
			name = "Lovely Ham",
			itemType = "healing"
		},
		doorCounts = {1,2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(32)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(10))
	},
	potion = {
		instance = {
			name = "Potion",
			itemType = "healing"
		},
		doorCounts = {1,2,3,4},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(16)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(3))
	},
	ratTail = {
		instance = {
			name = "Rat Tail",
			itemType = "trophy"
		},
		doorCounts = {},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(0)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(0))
	},
	spiderEye = {
		instance = {
			name = "Spider Eye",
			itemType = "trophy"
		},
		doorCounts = {},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(0)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(0))
	},
	batWing = {
		instance = {
			name = "Bat Wing",
			itemType = "trophy"
		},
		doorCounts = {},
		countGenerator = utilities.cloneTable(generators.newConstantGenerator(0)),
		inventoryGenerator = utilities.cloneTable(generators.newConstantGenerator(0))
	}
}
gameData.player = player.newPlayer(gameData.items)
gameData.maze = maze.newMaze(16,8,{monsters=gameData.monsters,items = gameData.items, player = gameData.player})

local storyboard = require("storyboard")
storyboard.loadScene("splash",false,gameData)
storyboard.loadScene("mainMenu",false,gameData)
storyboard.loadScene("options",false,gameData)
storyboard.loadScene("play",false,gameData)
storyboard.loadScene("map",false,gameData)
storyboard.gotoScene("splash","crossFade")
