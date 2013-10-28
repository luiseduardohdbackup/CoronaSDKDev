local storyboard = require("storyboard")
local scene = storyboard.newScene()
local directions = require("directions")
local player = require("player")

function scene:renderCurrentRoom()
	local thePlayer = self.gameData.maze.player
	local theRoom = self.gameData.maze.columns[thePlayer.position.column][thePlayer.position.row]
	local door = self.doorLightTable[thePlayer.light][theRoom.connections[thePlayer.direction]]
	for theDoor = 1, 3 do
		self.doorAhead[theDoor].isVisible = (door==theDoor)
	end
	door = self.doorLightTable[thePlayer.light][theRoom.connections[directions.lefts[thePlayer.direction]]]
	for theDoor = 1, 3 do
		self.doorLeft[theDoor].isVisible = (door==theDoor)
	end
	door = self.doorLightTable[thePlayer.light][theRoom.connections[directions.rights[thePlayer.direction]]]
	for theDoor = 1, 3 do
		self.doorRight[theDoor].isVisible = (door==theDoor)
	end
	self.doorUp.isVisible = thePlayer.position.column == self.gameData.maze.exit.column and thePlayer.position.row == self.gameData.maze.exit.row
	for theKey,theValue in pairs(self.monsters) do
		if theRoom.monster==nil or theRoom.monster.groupName~=theKey then
			theValue.dodge.isVisible = false
			theValue.normal.isVisible = false
			theValue.hit.isVisible = false
			theValue.lunge.isVisible = false
		else
			theValue.dodge.isVisible = self.dodgeTimer ~= nil
			theValue.normal.isVisible = self.dodgeTimer==nil and self.lungeTimer==nil
			theValue.hit.isVisible = self.dodgeTimer==nil and self.lungeTimer==nil and self.hitTimer~=nil
			theValue.lunge.isVisible = self.lungeTimer~=nil
		end
	end
	for light=1,4 do
		if light==thePlayer.light then
			if not self.light[light].isVisible then
				self.light[light].isVisible = true
			end
		else
			if self.light[light].isVisible then
				self.light[light].isVisible = false
			end
		end
	end
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view
	self.gameData = event.params
	
	self.roomWalls = display.newImage(group,"RoomWalls.png")
	self.roomWalls.x = 320
	self.roomWalls.y = 160
	
	self.doorLightTable = {
		{[0]=0,1,0},
		{[0]=0,1,0},
		{[0]=0,1,2},
		{[0]=0,1,3}
	}
	
	self.doorAhead = {}
	self.doorAhead[1] = display.newImage(group,"Doors/ahead/Door.png")
	self.doorAhead[1].x = 320
	self.doorAhead[1].y = 160
	self.doorAhead[1].isVisible = false
	
	self.doorAhead[2] = display.newImage(group,"Doors/ahead/SecretSemi.png")
	self.doorAhead[2].x = 320
	self.doorAhead[2].y = 160
	self.doorAhead[2].isVisible = false
	
	self.doorAhead[3] = display.newImage(group,"Doors/ahead/SecretFull.png")
	self.doorAhead[3].x = 320
	self.doorAhead[3].y = 160
	self.doorAhead[3].isVisible = false
	
	self.doorLeft = {}
	self.doorLeft[1] = display.newImage(group,"Doors/left/Door.png")
	self.doorLeft[1].x = 80
	self.doorLeft[1].y = 160
	self.doorLeft[1].isVisible = false
	
	self.doorLeft[2] = display.newImage(group,"Doors/left/SecretSemi.png")
	self.doorLeft[2].x = 80
	self.doorLeft[2].y = 160
	self.doorLeft[2].isVisible = false
	
	self.doorLeft[3] = display.newImage(group,"Doors/left/SecretFull.png")
	self.doorLeft[3].x = 80
	self.doorLeft[3].y = 160
	self.doorLeft[3].isVisible = false
	
	self.doorRight = {}
	self.doorRight[1] = display.newImage(group,"Doors/right/Door.png")
	self.doorRight[1].x = 560
	self.doorRight[1].y = 160
	self.doorRight[1].isVisible = false
	
	self.doorRight[2] = display.newImage(group,"Doors/right/SecretSemi.png")
	self.doorRight[2].x = 560
	self.doorRight[2].y = 160
	self.doorRight[2].isVisible = false
	
	self.doorRight[3] = display.newImage(group,"Doors/right/SecretFull.png")
	self.doorRight[3].x = 560
	self.doorRight[3].y = 160
	self.doorRight[3].isVisible = false
	
	self.doorUp = display.newImage(group,"Doors/up/Door.png")
	self.doorUp.x = 320
	self.doorUp.y = 40
	self.doorUp.isVisible = false
	
	self.monsters = {}
	self.monsters.bat = {}
	self.monsters.bat.dodge = display.newImage(group,"Monsters/Bat/Dodge.png")
	self.monsters.bat.dodge.x = 320
	self.monsters.bat.dodge.y = 160
	self.monsters.bat.dodge.isVisible = false
	
	self.monsters.bat.normal = display.newImage(group,"Monsters/Bat/Normal.png")
	self.monsters.bat.normal.x = 320
	self.monsters.bat.normal.y = 160
	self.monsters.bat.normal.isVisible = false
	
	self.monsters.bat.hit = display.newImage(group,"Monsters/Bat/Hit.png")
	self.monsters.bat.hit.x = 320
	self.monsters.bat.hit.y = 160
	self.monsters.bat.hit.isVisible = false
	
	self.monsters.bat.lunge = display.newImage(group,"Monsters/Bat/Lunge.png")
	self.monsters.bat.lunge.x = 320
	self.monsters.bat.lunge.y = 160
	self.monsters.bat.lunge.isVisible = false
	
	self.monsters.minotaur = {}
	self.monsters.minotaur.dodge = display.newImage(group,"Monsters/Minotaur/Dodge.png")
	self.monsters.minotaur.dodge.x = 320
	self.monsters.minotaur.dodge.y = 160
	self.monsters.minotaur.dodge.isVisible = false
	
	self.monsters.minotaur.normal = display.newImage(group,"Monsters/Minotaur/Normal.png")
	self.monsters.minotaur.normal.x = 320
	self.monsters.minotaur.normal.y = 160
	self.monsters.minotaur.normal.isVisible = false
	
	self.monsters.minotaur.hit = display.newImage(group,"Monsters/Minotaur/Hit.png")
	self.monsters.minotaur.hit.x = 320
	self.monsters.minotaur.hit.y = 160
	self.monsters.minotaur.hit.isVisible = false
	
	self.monsters.minotaur.lunge = display.newImage(group,"Monsters/Minotaur/Lunge.png")
	self.monsters.minotaur.lunge.x = 320
	self.monsters.minotaur.lunge.y = 160
	self.monsters.minotaur.lunge.isVisible = false
	
	self.monsters.rat = {}
	self.monsters.rat.dodge = display.newImage(group,"Monsters/Rat/Dodge.png")
	self.monsters.rat.dodge.x = 320
	self.monsters.rat.dodge.y = 160
	self.monsters.rat.dodge.isVisible = false
	
	self.monsters.rat.normal = display.newImage(group,"Monsters/Rat/Normal.png")
	self.monsters.rat.normal.x = 320
	self.monsters.rat.normal.y = 160
	self.monsters.rat.normal.isVisible = false
	
	self.monsters.rat.hit = display.newImage(group,"Monsters/Rat/Hit.png")
	self.monsters.rat.hit.x = 320
	self.monsters.rat.hit.y = 160
	self.monsters.rat.hit.isVisible = false
	
	self.monsters.rat.lunge = display.newImage(group,"Monsters/Rat/Lunge.png")
	self.monsters.rat.lunge.x = 320
	self.monsters.rat.lunge.y = 160
	self.monsters.rat.lunge.isVisible = false
	
	self.monsters.spider = {}
	self.monsters.spider.dodge = display.newImage(group,"Monsters/Spider/Dodge.png")
	self.monsters.spider.dodge.x = 320
	self.monsters.spider.dodge.y = 160
	self.monsters.spider.dodge.isVisible = false
	
	self.monsters.spider.normal = display.newImage(group,"Monsters/Spider/Normal.png")
	self.monsters.spider.normal.x = 320
	self.monsters.spider.normal.y = 160
	self.monsters.spider.normal.isVisible = false
	
	self.monsters.spider.hit = display.newImage(group,"Monsters/Spider/Hit.png")
	self.monsters.spider.hit.x = 320
	self.monsters.spider.hit.y = 160
	self.monsters.spider.hit.isVisible = false
	
	self.monsters.spider.lunge = display.newImage(group,"Monsters/Spider/Lunge.png")
	self.monsters.spider.lunge.x = 320
	self.monsters.spider.lunge.y = 160
	self.monsters.spider.lunge.isVisible = false
	
	self.turnBackground = display.newImage(group,"TurnBackground.png")
	self.turnBackground.x = 320
	self.turnBackground.y = 160
	self.turnBackground.isVisible = false
	
	self.turnForeground = display.newImage(group,"TurnForeground.png")
	self.turnForeground.x = 320
	self.turnForeground.y = 160
	self.turnForeground.isVisible = false
	
	self.step = {}
	
	self.step[0] = display.newImage(group,"Doors/step/Wall.png")
	self.step[0].x = 320
	self.step[0].y = 160
	self.step[0].isVisible = false
	
	self.step[1] = display.newImage(group,"Doors/step/Door.png")
	self.step[1].x = 320
	self.step[1].y = 160
	self.step[1].isVisible = false
	
	self.step[2] = display.newImage(group,"Doors/step/SecretSemi.png")
	self.step[2].x = 320
	self.step[2].y = 160
	self.step[2].isVisible = false
	
	self.step[3] = display.newImage(group,"Doors/step/SecretFull.png")
	self.step[3].x = 320
	self.step[3].y = 160
	self.step[3].isVisible = false

	self.light = {}
	
	self.light[1] = display.newImage(group,"Lights/Match.png")
	self.light[1].x = 320
	self.light[1].y = 160
	self.light[1].isVisible=false
	
	self.light[2] = display.newImage(group,"Lights/Torch.png")
	self.light[2].x = 320
	self.light[2].y = 160
	self.light[2].isVisible=false
	
	self.light[3] = display.newImage(group,"Lights/Lantern.png")
	self.light[3].x = 320
	self.light[3].y = 160
	self.light[3].isVisible=false
	
	self.light[4] = display.newImage(group,"Lights/MagicLantern.png")
	self.light[4].x = 320
	self.light[4].y = 160
	self.light[4].isVisible=false
	
	self.hitRect = display.newRect(group,0,0,640,320)
	self.hitRect:setFillColor(128,0,0)
	self.hitRect.alpha = 0
	
	self.moveForwardButton = display.newImage(group,"MoveForward.png")
	self.moveForwardButton.x = 300
	self.moveForwardButton.y = 340
	self.moveForwardButton:addEventListener("tap",self)

	self.turnLeftButton = display.newImage(group,"TurnLeft.png")
	self.turnLeftButton.x = 260
	self.turnLeftButton.y = 340
	self.turnLeftButton:addEventListener("tap",self)

	self.turnRightButton = display.newImage(group,"TurnRight.png")
	self.turnRightButton.x = 380
	self.turnRightButton.y = 340
	self.turnRightButton:addEventListener("tap",self)

	self.turnAroundButton = display.newImage(group,"TurnAround.png")
	self.turnAroundButton.x = 340
	self.turnAroundButton.y = 340
	self.turnAroundButton:addEventListener("tap",self)

	self.lightButton = display.newImage(group,"LightLevel.png")
	self.lightButton.x = 420
	self.lightButton.y = 340
	self.lightButton:addEventListener("tap",self)

	self.testButton = display.newImage(group,"EmptyButton.png")
	self.testButton.x = 220
	self.testButton.y = 340
	self.testButton:addEventListener("tap",self)

	self.attackButton = display.newImage(group,"EmptyButton.png")
	self.attackButton.x = 180
	self.attackButton.y = 340
	self.attackButton:addEventListener("tap",self)

end

function scene:timer(event)
	if event.source==self.turnLeftTimer then
		self.turnForeground.x = self.turnForeground.x + 40
		if self.turnForeground.x > 640 then
			self.turnForeground.isVisible = false
			self.turnBackground.isVisible = false
			timer.cancel(self.turnLeftTimer)
			self.turnLeftTimer = nil
		end
	elseif event.source==self.turnRightTimer then
		self.turnForeground.x = self.turnForeground.x - 40
		if self.turnForeground.x < 0 then
			self.turnForeground.isVisible = false
			self.turnBackground.isVisible = false
			timer.cancel(self.turnRightTimer)
			self.turnRightTimer = nil
		end
	elseif event.source==self.turnAroundTimer then
		self.turnForeground.x = self.turnForeground.x - 40
		if self.turnForeground.x < 0 then
			timer.cancel(self.turnAroundTimer)
			self.turnAroundTimer = nil
			self.turnForeground.x = 640
			self.turnRightTimer = timer.performWithDelay(25,self,0)
		end
	elseif event.source == self.stepTimer then
		self.stepTimer = nil
		for _,v in pairs(self.step) do
			v.isVisible=false
		end
	elseif event.source == self.dodgeTimer then
		self.dodgeTimer=nil
		self:renderCurrentRoom()
	elseif event.source == self.hitTimer then
		self.hitTimer=nil
		self:renderCurrentRoom()
	end
end

function scene:hasActiveTimer()
	return self.stepTimer~=nil
		or self.turnAroundTimer~=nil
		or self.turnRightTimer~=nil
		or self.turnLeftTimer~=nil
		or self.dodgeTimer~=nil
		or self.lungeTimer~=nil
		or self.hitTimer~=nil
end

function scene:moveForward()
	if not self:hasActiveTimer() then
		local thePlayer = self.gameData.maze.player
		local theRoom = self.gameData.maze.columns[thePlayer.position.column][thePlayer.position.row]
		self.step[self.doorLightTable[thePlayer.light][theRoom.connections[thePlayer.direction]]].isVisible=true	
		self.stepTimer = timer.performWithDelay(500,self)
		if theRoom.connections[thePlayer.direction]~=0 then
			thePlayer.position.column = thePlayer.position.column + directions.deltas[thePlayer.direction].x
			thePlayer.position.row = thePlayer.position.row + directions.deltas[thePlayer.direction].y
			local theNextRoom = self.gameData.maze.columns[thePlayer.position.column][thePlayer.position.row]
			if theNextRoom.visitCount==nil then
				theNextRoom.visitCount = 1
			else
				theNextRoom.visitCount = theNextRoom.visitCount + 1
			end
			self:renderCurrentRoom()
		else
			self.hitRect.alpha=1
			transition.to(self.hitRect,{alpha=0})
		end
	end
end

function scene:turnLeft()
	if not self:hasActiveTimer() then
		self.turnBackground.isVisible = true
		self.turnForeground.x = 0
		self.turnForeground.isVisible = true
		self.turnLeftTimer = timer.performWithDelay(25,self,0)
		self.gameData.maze.player.direction = directions.lefts[self.gameData.maze.player.direction]
		self:renderCurrentRoom()
	end
end

function scene:turnRight()
	if not self:hasActiveTimer() then
		self.turnBackground.isVisible = true
		self.turnForeground.x = 640
		self.turnForeground.isVisible = true
		self.turnRightTimer = timer.performWithDelay(25,self,0)
		self.gameData.maze.player.direction = directions.rights[self.gameData.maze.player.direction]
		self:renderCurrentRoom()
	end
end

function scene:turnAround()
	if not self:hasActiveTimer() then
		self.turnBackground.isVisible = true
		self.turnForeground.x = 640
		self.turnForeground.isVisible = true
		self.turnAroundTimer = timer.performWithDelay(25,self,0)
		self.gameData.maze.player.direction = directions.opposites[self.gameData.maze.player.direction]
		self:renderCurrentRoom()
	end
end

function scene:attackMonster()
	local thePlayer = self.gameData.maze.player
	local theRoom = self.gameData.maze.columns[thePlayer.position.column][thePlayer.position.row]
	local theMonster = theRoom.monster
	if theMonster~=nil and not self:hasActiveTimer() then
		local theRoll = player.rollAttack(thePlayer)
		if theRoll>0 then
			self.monsters[theMonster.groupName].hit.alpha=1
			transition.to(self.monsters[theMonster.groupName].hit,{alpha=0})
			self.hitTimer = timer.performWithDelay(500,self)
			self:renderCurrentRoom()
		else
			self.dodgeTimer = timer.performWithDelay(500,self)
			self:renderCurrentRoom()
		end
	end
end

function scene:tap(event)
	if event.target == self.moveForwardButton then
		self:moveForward()
	elseif event.target == self.turnLeftButton then
		self:turnLeft()
	elseif event.target == self.turnRightButton then
		self:turnRight()
	elseif event.target == self.turnAroundButton then
		self:turnAround()
	elseif event.target == self.attackButton then
		self:attackMonster()
	elseif event.target == self.lightButton then
		self.gameData.maze.player.light = self.gameData.maze.player.light + 1
		if self.gameData.maze.player.light>4 then
			self.gameData.maze.player.light = 1
		end
		self:renderCurrentRoom()
	elseif event.target == self.testButton then
		storyboard.gotoScene("map")
	end
end

function scene:willEnterScene( event )
    local group = self.view
	self:renderCurrentRoom()
end

function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view
end

function scene:didExitScene( event )
    local group = self.view
end

function scene:destroyScene( event )
    local group = self.view
end

function scene:overlayBegan( event )
	local group = self.view
	local overlay_name = event.sceneName  -- name of the overlay scene
end

function scene:overlayEnded( event )
	local group = self.view
	local overlay_name = event.sceneName  -- name of the overlay scene
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "willEnterScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "didExitScene" event is dispatched after scene has finished transitioning out
scene:addEventListener( "didExitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-- "overlayBegan" event is dispatched when an overlay scene is shown
scene:addEventListener( "overlayBegan", scene )

-- "overlayEnded" event is dispatched when an overlay scene is hidden/removed
scene:addEventListener( "overlayEnded", scene )

---------------------------------------------------------------------------------

return scene