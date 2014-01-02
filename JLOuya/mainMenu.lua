local storyboard = require( "storyboard" )
local asciiGrid = require("ASCIIGrid")
local asciiBoard = require("ASCIIBoard")
local asciiBoardCell = require("ASCIIBoardCell")
local scene = storyboard.newScene()

function scene:renderMenu()
	for index=1,#self.menuItems do
		local cell = self.menuItemNormalCell
		if index==self.currentMenuItem then
			cell = self.menuItemHiliteCell
		end
		self.board:writeText(self.menuX,self.menuY+index-1,self.menuItems[index],cell)
	end
	self.board:render(self.grid,self.gameData.resources.colors)
end

function scene:redraw()
	local columns = self.gameData.constants.grid.columns
	local rows = self.gameData.constants.grid.rows
	local colors = self.gameData.resources.colors
	local profile = self.gameData.profile

	self.board:clear(asciiBoardCell.createCell(0,0,0))

	self.board:set(1,1,asciiBoardCell.createCell(201,colors.blue,colors.lightGray))
	self.board:set(1,rows,asciiBoardCell.createCell(200,colors.blue,colors.lightGray))
	self.board:set(columns,1,asciiBoardCell.createCell(187,colors.blue,colors.lightGray))
	self.board:set(columns,rows,asciiBoardCell.createCell(188,colors.blue,colors.lightGray))
	
	self.board:hLine(2,1,columns-2,asciiBoardCell.createCell(205,colors.blue,colors.lightGray))
	self.board:hLine(2,rows,columns-2,asciiBoardCell.createCell(205,colors.blue,colors.lightGray))
	
	self.board:vLine(1,2,rows-2,asciiBoardCell.createCell(186,colors.blue,colors.lightGray))
	self.board:vLine(columns,2,rows-2,asciiBoardCell.createCell(186,colors.blue,colors.lightGray))

	self.board:set(columns-1,rows-1,asciiBoardCell.createCell(155,colors.green,colors.black))
	local temp = tostring(self.gameData.profile.pennies)
	self.board:writeText(columns-1-string.len(temp),rows-1,temp,asciiBoardCell.createCell(0,colors.green,colors.black))
	
	self.board:writeText(20,2,"High:"..tostring(profile.highScore),asciiBoardCell.createCell(0,colors.green,colors.black))
	self.board:writeText(19,3,"Games:"..tostring(profile.gamesPlayed),asciiBoardCell.createCell(0,colors.green,colors.black))
	local averageScore = 0
	if profile.gamesPlayed>0 then
		averageScore=math.floor(profile.totalScore/profile.gamesPlayed)
	end
	self.board:writeText(17,4,"Average:"..averageScore,asciiBoardCell.createCell(0,colors.green,colors.black))
	
	self:renderMenu()
end

function scene:createScene( event )
    local group = self.view
	self.gameData = event.params
	self.grid = asciiGrid.createGrid(
		group,
		self.gameData.constants.grid.x,
		self.gameData.constants.grid.y,
		self.gameData.constants.grid.columns,
		self.gameData.constants.grid.rows,
		self.gameData.constants.cell.width,
		self.gameData.constants.cell.height,
		self.gameData.resources.imageSheet)
	self.board = asciiBoard.createBoard(1,1,self.gameData.constants.grid.columns,self.gameData.constants.grid.rows)

	local columns = self.gameData.constants.grid.columns
	local rows = self.gameData.constants.grid.rows
	local colors = self.gameData.resources.colors
	

	self.menuItemNormalCell = asciiBoardCell.createCell(0,colors.lightGray,colors.black)
	self.menuItemHiliteCell = asciiBoardCell.createCell(0,colors.black,colors.lightGray)
	self.menuX=16
	self.menuY=12
	self.currentMenuItem=1
	self.menuItems={
		"   Play  Game   ",
		"  Instructions  ",
		"    Options     ",
		"     About      ",
		--"      Shop      ",
		--"    Feed Fish   ",
		"      Quit      "
	}
	self.nextScenes={
		"play",
		"instructions",
		"options",
		"about",
		--"shop",
		--"feedTheFish",
		"quit"
	}
	self.transitions={
		"zoomOutInRotate",
		"slideLeft",
		"slideRight",
		"slideUp",
		--"slideDown",
		--"flip",
		"crossFade"
	}

end

function scene:onKeyDown(theKey)
	local soundManager = self.gameData.soundManager
	--local colors = self.gameData.resources.colors
	--self.board:writeText(2,2,"                                ",asciiBoardCell.createCell(0,colors.lightCyan,colors.black))
	--self.board:writeText(2,2,theKey,asciiBoardCell.createCell(0,colors.lightCyan,colors.black))
	--self.board:render(self.grid,self.gameData.resources.colors)
	if theKey=="down" then
		soundManager.play("menuChange")
		self.currentMenuItem=self.currentMenuItem+1
		if self.currentMenuItem>#self.menuItems then
			self.currentMenuItem=1
		end
		self:renderMenu()
	elseif theKey=="up" then
		soundManager.play("menuChange")
		self.currentMenuItem=self.currentMenuItem-1
		if self.currentMenuItem<1 then
			self.currentMenuItem=#self.menuItems
		end
		self:renderMenu()
	elseif theKey=="O" then
		soundManager.play("transition")
		storyboard:gotoScene(self.nextScenes[self.currentMenuItem],self.transitions[self.currentMenuItem]);
	end
end

function scene:onKeyUp(theKey)
end

function scene:willEnterScene( event )
    local group = self.view
	self:redraw()
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