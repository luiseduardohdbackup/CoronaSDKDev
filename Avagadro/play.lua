local storyboard = require( "storyboard" )
local board=require "board"
local scene = storyboard.newScene()

function scene:createScene( event )
    local group = self.view
	self.gameData = event.params
	display.newText({
		parent=group,
		text="Play",
		font=native.systemFont,
		fontSize=32,
		x=100,
		y=100
	})
	self.board=board.newBoard(group,self.gameData.dataBoard,0,0,108,108)
	self.board:update()
end

function scene:onKeyDown(theKey)
end

function scene:onKeyUp(theKey)
end

function scene:willEnterScene( event )
    local group = self.view
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