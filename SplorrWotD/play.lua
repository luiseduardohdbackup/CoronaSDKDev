local storyboard = require("storyboard")
local scene = storyboard.newScene()
local directions = require("directions")

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
	
	self.spider = display.newImage(group,"Spider.png")
	self.spider.x = 320
	self.spider.y = 240
	self.spider.isVisible = false
	
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
		for theImage=0,3 do
			self.step[theImage].isVisible=false
		end
	end
end

function scene:tap(event)
	if event.target == self.moveForwardButton then
		local thePlayer = self.gameData.maze.player
		local theRoom = self.gameData.maze.columns[thePlayer.position.column][thePlayer.position.row]
		self.step[self.doorLightTable[thePlayer.light][theRoom.connections[thePlayer.direction]]].isVisible=true	
		self.stepTimer = timer.performWithDelay(500,self)
		if theRoom.connections[thePlayer.direction]~=0 then
			thePlayer.position.column = thePlayer.position.column + directions.deltas[thePlayer.direction].x
			thePlayer.position.row = thePlayer.position.row + directions.deltas[thePlayer.direction].y
			self:renderCurrentRoom()
		else
			self.hitRect.alpha=1
			transition.to(self.hitRect,{alpha=0})
		end
	elseif event.target == self.turnLeftButton then
		if self.turnLeftTimer == nil then
			self.turnBackground.isVisible = true
			self.turnForeground.x = 0
			self.turnForeground.isVisible = true
			self.turnLeftTimer = timer.performWithDelay(25,self,0)
			self.gameData.maze.player.direction = directions.lefts[self.gameData.maze.player.direction]
			self:renderCurrentRoom()
		end
	elseif event.target == self.turnRightButton then
		if self.turnRightTimer == nil then
			self.turnBackground.isVisible = true
			self.turnForeground.x = 640
			self.turnForeground.isVisible = true
			self.turnRightTimer = timer.performWithDelay(25,self,0)
			self.gameData.maze.player.direction = directions.rights[self.gameData.maze.player.direction]
			self:renderCurrentRoom()
		end
	elseif event.target == self.turnAroundButton then
		if self.turnAroundTimer == nil then
			self.turnBackground.isVisible = true
			self.turnForeground.x = 640
			self.turnForeground.isVisible = true
			self.turnAroundTimer = timer.performWithDelay(25,self,0)
			self.gameData.maze.player.direction = directions.opposites[self.gameData.maze.player.direction]
			self:renderCurrentRoom()
		end
	elseif event.target == self.lightButton then
		self.gameData.maze.player.light = self.gameData.maze.player.light + 1
		if self.gameData.maze.player.light>4 then
			self.gameData.maze.player.light = 1
		end
		self:renderCurrentRoom()
	end
end

-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
    local group = self.view
	self:renderCurrentRoom()

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
        local group = self.view
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view
end


-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
        local group = self.view
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
        local group = self.view
end


-- Called if/when overlay scene is displayed via storyboard.showOverlay()
function scene:overlayBegan( event )
        local group = self.view
        local overlay_name = event.sceneName  -- name of the overlay scene
end


-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
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