local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

----------------------------------------------------------------------------------
-- 
--      NOTE:
--      
--      Code outside of listener functions (below) will only be executed once,
--      unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------


-- local forward references should go here --


---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
        local group = self.view
	self.gameData = event.params
	display.newImage(group,"background.png")

	local titleImage = display.newImage(group,"title.png")
	titleImage.x = display.contentCenterX
	titleImage.y = display.contentCenterY

	self.playButton = display.newImage(group,"longbutton.png")
	self.playButton.x = display.contentCenterX
	self.playButton.y = self.gameData.bounds.bottom - self.playButton.height
	self.playButton:addEventListener("tap",self)
	display.newText({
		parent = group,
		text="Play",
		x=self.playButton.x,
		y=self.playButton.y,
		font=native.systemFont,
		fontSize=48,
		align="center"
	}):setTextColor(255,255,255)

	--self.helpButton = display.newImage(group,"longbutton.png")
	--self.helpButton.x = self.gameData.bounds.left + self.helpButton.width
	--self.helpButton.y = self.gameData.bounds.bottom - self.helpButton.height
	--self.helpButton:addEventListener("tap",self)
	--display.newText({
		--parent = group,
		--text="Help",
		--x=self.helpButton.x,
		--y=self.helpButton.y,
		--font=native.systemFont,
		--fontSize=48,
		--align="center"
	--}):setTextColor(255,255,255)

	--self.aboutButton = display.newImage(group,"longbutton.png")
	--self.aboutButton.x = self.gameData.bounds.right - self.aboutButton.width
	--self.aboutButton.y = self.gameData.bounds.bottom - self.aboutButton.height
	--self.aboutButton:addEventListener("tap",self)
	--display.newText({
		--parent = group,
		--text="About",
		--x=self.aboutButton.x,
		--y=self.aboutButton.y,
		--font=native.systemFont,
		--fontSize=48,
		--align="center"
	--}):setTextColor(255,255,255)
end

function scene:tap(event)
	if event.target==self.playButton then
		storyboard.gotoScene("play","crossFade")
	elseif event.target==self.helpButton then
		storyboard.gotoScene("help","slideRight")
	elseif event.target==self.aboutButton then
		storyboard.gotoScene("about","slideLeft")
	end
end

-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      This event requires build 2012.782 or later.

        -----------------------------------------------------------------------------

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)

        -----------------------------------------------------------------------------

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)

        -----------------------------------------------------------------------------

end


-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      This event requires build 2012.782 or later.

        -----------------------------------------------------------------------------

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. remove listeners, widgets, save state, etc.)

        -----------------------------------------------------------------------------

end


-- Called if/when overlay scene is displayed via storyboard.showOverlay()
function scene:overlayBegan( event )
        local group = self.view
        local overlay_name = event.sceneName  -- name of the overlay scene

        -----------------------------------------------------------------------------

        --      This event requires build 2012.797 or later.

        -----------------------------------------------------------------------------

end


-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
        local group = self.view
        local overlay_name = event.sceneName  -- name of the overlay scene

        -----------------------------------------------------------------------------

        --      This event requires build 2012.797 or later.

        -----------------------------------------------------------------------------

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