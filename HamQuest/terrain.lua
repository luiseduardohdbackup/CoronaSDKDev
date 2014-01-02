local terrain={}

terrain.imageSheet = graphics.newImageSheet("images/terrain/terrain.png",{width=32,height=32,border=4,numFrames=20})
terrain.descriptors={
	floor={sprite=1,name="Floor",passable=true},
	solid={sprite=2,name="Solid",passable=false},
	northWall={sprite=5,name="North Wall",passable=false},
	eastWall={sprite=6,name="East Wall",passable=false},
	southWall={sprite=7,name="South Wall",passable=false},
	westWall={sprite=8,name="West Wall",passable=false},
	northDoor={sprite=9,name="North Door",passable=true},
	eastDoor={sprite=10,name="East Door",passable=true},
	southDoor={sprite=11,name="South Door",passable=true},
	westDoor={sprite=12,name="West Door",passable=true},
	northEastInsideCorner={sprite=13,name="Northeast Inside Corner",passable=false},
	southEastInsideCorner={sprite=14,name="Southeast Inside Corner",passable=false},
	southWestInsideCorner={sprite=15,name="Southwest Inside Corner",passable=false},
	northWestInsideCorner={sprite=16,name="Northwest Inside Corner",passable=false},
	northEastOutsideCorner={sprite=17,name="Northeast Outside Corner",passable=false},
	southEastOutsideCorner={sprite=18,name="Southeast Outside Corner",passable=false},
	southWestOutsideCorner={sprite=19,name="Southwest Outside Corner",passable=false},
	northWestOutsideCorner={sprite=20,name="Northwest Outside Corner",passable=false},
}
terrain.default="solid"

return terrain