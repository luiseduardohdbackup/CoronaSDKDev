local storyboard = require( "storyboard" )
local board=require "board"
local gameBoard=require "gameBoard"
local directions=require "directions"
local slots=require "slots"
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
	self.gameBoard=gameBoard.newGameBoard(self.gameData.dataBoard)
	self.gameBoard:updateHints()
	self.board=board.newBoard(group,self.gameBoard,54,54,108,108)
	self.board:update()
	self.slots=slots.newSlots(group,self.gameBoard,108*9,54,directions.south,108)
	self.slots:update()
	self.board:update()
end

function scene:onKeyDown(theKey)
	if theKey=="up" then
		self.gameBoard:moveCursor(directions.north)
		self.board:update()
	elseif theKey=="down" then
		self.gameBoard:moveCursor(directions.south)
		self.board:update()
	elseif theKey=="left" then
		self.gameBoard:moveCursor(directions.west)
		self.board:update()
	elseif theKey=="right" then
		self.gameBoard:moveCursor(directions.east)
		self.board:update()
	elseif theKey=="O" then
		self.gameBoard:placeAtom()
		self.slots:update()
		self.board:update()
	elseif theKey=="U" then
		self.gameBoard:rotateCurrentSlotCW()
		self.slots:update()
		self.board:update()
	elseif theKey=="Y" then
		self.gameBoard:nextSlot()
		self.slots:update()
		self.board:update()
	end
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