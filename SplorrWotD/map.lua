local storyboard = require("storyboard")
local scene = storyboard.newScene()
local directions = require("directions")

-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view
	self.gameData = event.params
	self.mapSheet = graphics.newImageSheet("Map/Rooms.png",{width=40,height=40,numFrames=16})
	local maze = self.gameData.maze
	self.roomSprites = {}
	for column = 1 , maze.size.columns do
		table.insert(self.roomSprites,{})
		for row = 1 , maze.size.rows do
			table.insert(self.roomSprites[column],display.newSprite(group,self.mapSheet,{
				name = "room",
				start = 1,
				count = 16
			}))
			self.roomSprites[column][row].x = 40 * column - 20
			self.roomSprites[column][row].y = 40 * row - 20
			self.roomSprites[column][row]:setSequence("room")
			self.roomSprites[column][row]:setFrame(16)
		end
	end
	self.testButton = display.newImage(group,"EmptyButton.png")
	self.testButton.x = 220
	self.testButton.y = 340
	self.testButton:addEventListener("tap",self)
end

function scene:renderMap()
	local maze = self.gameData.maze
	for column = 1 , maze.size.columns do
		for row = 1 , maze.size.rows do
			local cell = maze.columns[column][row]
			local sprite = self.roomSprites[column][row]
			if cell.visitCount~=nil then
				local frame = 1
				if cell.connections[1]==1 then
					frame = frame + 1
				end
				if cell.connections[2]==1 then
					frame = frame + 2
				end
				if cell.connections[3]==1 then
					frame = frame + 4
				end
				if cell.connections[4]==1 then
					frame = frame + 8
				end
				sprite:setFrame(frame)
				sprite.isVisible = true
			else
				sprite.isVisible = false
			end
		end
	end
end

function scene:tap(event)
	storyboard.gotoScene("play")
end

-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
    local group = self.view
	self:renderMap()
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