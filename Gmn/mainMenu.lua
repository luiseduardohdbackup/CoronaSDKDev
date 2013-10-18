local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

function adListener(event)
	if event.isError then
	end
end
local ads = require("ads")
ads.init("admob","ca-app-pub-6417425738244044/6541055152",adListener)


function scene:createScene( event )
        local group = self.view
	self.gameData = event.params
	display.newRect(group,0,0,640,480):setFillColor(0,0,0)

		display.newText({
		parent = group,
		text="JetLag 2013",
		x=display.contentCenterX,
		y=display.contentCenterY,
		width=640,
		font="8bitoperator JVE",
		fontSize=128,
		align="center"
	}):setTextColor(0,255,0)

	
	self.playButton = display.newImage(group,"longbutton.png")
	self.playButton.x = self.gameData.bounds.left + self.playButton.width
	self.playButton.y = self.gameData.bounds.bottom - self.playButton.height * 2
	self.playButton:addEventListener("tap",self)
	display.newText({
		parent = group,
		text="Play",
		x=self.playButton.x,
		y=self.playButton.y,
		font="8bitoperator JVE",
		fontSize=48,
		align="center"
	}):setTextColor(255,255,255)

	self.statsButton = display.newImage(group,"longbutton.png")
	self.statsButton.x = self.gameData.bounds.right - self.statsButton.width
	self.statsButton.y = self.gameData.bounds.bottom - self.statsButton.height * 2
	self.statsButton:addEventListener("tap",self)
	display.newText({
		parent = group,
		text="Stats",
		x=self.statsButton.x,
		y=self.statsButton.y,
		font="8bitoperator JVE",
		fontSize=48,
		align="center"
	}):setTextColor(255,255,255)

	self.helpButton = display.newImage(group,"longbutton.png")
	self.helpButton.x = self.gameData.bounds.left + self.helpButton.width
	self.helpButton.y = self.gameData.bounds.top + self.helpButton.height * 2
	self.helpButton:addEventListener("tap",self)
	display.newText({
		parent = group,
		text="Help",
		x=self.helpButton.x,
		y=self.helpButton.y,
		font="8bitoperator JVE",
		fontSize=48,
		align="center"
	}):setTextColor(255,255,255)

	self.aboutButton = display.newImage(group,"longbutton.png")
	self.aboutButton.x = self.gameData.bounds.right - self.aboutButton.width
	self.aboutButton.y = self.gameData.bounds.top + self.aboutButton.height * 2
	self.aboutButton:addEventListener("tap",self)
	display.newText({
		parent = group,
		text="About",
		x=self.aboutButton.x,
		y=self.aboutButton.y,
		font="8bitoperator JVE",
		fontSize=48,
		align="center"
	}):setTextColor(255,255,255)
end

function scene:tap(event)
	if event.target==self.playButton then
		ads.hide()
		storyboard.gotoScene("play","crossFade")
	elseif event.target==self.helpButton then
		ads.hide()
		storyboard.gotoScene("help","slideRight")
	elseif event.target==self.statsButton then
		ads.hide()
		storyboard.gotoScene("stats","slideUp")
	elseif event.target==self.aboutButton then
		ads.hide()
		storyboard.gotoScene("about","slideLeft")
	end
end

-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
        local group = self.view
		ads.show("banner",{ x = 0, y = 0})

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