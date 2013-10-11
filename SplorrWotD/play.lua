local storyboard = require("storyboard")
local scene = storyboard.newScene()
local directions = require("directions")

function scene:renderCurrentRoom()
	local thePlayer = self.gameData.maze.player
	local theRoom = self.gameData.maze.columns[thePlayer.position.column][thePlayer.position.row]
	self.roomDoorAhead.isVisible = theRoom.connections[thePlayer.direction]
	self.roomDoorLeft.isVisible = theRoom.connections[directions.lefts[thePlayer.direction]]
	self.roomDoorRight.isVisible = theRoom.connections[directions.rights[thePlayer.direction]]
	self.roomDoorUp.isVisible = thePlayer.position.column == self.gameData.maze.exit.column and thePlayer.position.row == self.gameData.maze.exit.row
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view
	self.gameData = event.params
	
	self.roomWalls = display.newImage(group,"RoomWalls.png")
	self.roomWalls.x = 320
	self.roomWalls.y = 160
	
	self.roomDoorAhead = display.newImage(group,"RoomDoorAhead.png")
	self.roomDoorAhead.x = 320
	self.roomDoorAhead.y = 160
	self.roomDoorAhead.isVisible = false

	self.roomDoorLeft = display.newImage(group,"RoomDoorLeft.png")
	self.roomDoorLeft.x = 80
	self.roomDoorLeft.y = 160
	self.roomDoorLeft.isVisible = false

	self.roomDoorRight = display.newImage(group,"RoomDoorRight.png")
	self.roomDoorRight.x = 560
	self.roomDoorRight.y = 160
	self.roomDoorRight.isVisible = false

	self.roomDoorUp = display.newImage(group,"RoomDoorUp.png")
	self.roomDoorUp.x = 320
	self.roomDoorUp.y = 40
	self.roomDoorUp.isVisible = false
	
	self.spider = display.newImage(group,"Spider.png")
	self.spider.x = 320
	self.spider.y = 240
	self.spider.isVisible = false
	
	self.torchLight = display.newImage(group,"TorchLight.png")
	self.torchLight.x = 320
	self.torchLight.y = 160
	
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

	
end

function scene:tap(event)
	if event.target == self.moveForwardButton then
		local thePlayer = self.gameData.maze.player
		local theRoom = self.gameData.maze.columns[thePlayer.position.column][thePlayer.position.row]
		if theRoom.connections[thePlayer.direction] then
			thePlayer.position.column = thePlayer.position.column + directions.deltas[thePlayer.direction].x
			thePlayer.position.row = thePlayer.position.row + directions.deltas[thePlayer.direction].y
			self:renderCurrentRoom()
		end
	elseif event.target == self.turnLeftButton then
		self.gameData.maze.player.direction = directions.lefts[self.gameData.maze.player.direction]
		self:renderCurrentRoom()
	elseif event.target == self.turnRightButton then
		self.gameData.maze.player.direction = directions.rights[self.gameData.maze.player.direction]
		self:renderCurrentRoom()
	elseif event.target == self.turnAroundButton then
		self.gameData.maze.player.direction = directions.opposites[self.gameData.maze.player.direction]
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