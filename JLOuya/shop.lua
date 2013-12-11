local storyboard = require( "storyboard" )
local asciiGrid = require("ASCIIGrid")
local asciiBoard = require("ASCIIBoard")
local asciiBoardCell = require("ASCIIBoardCell")
local scene = storyboard.newScene()


function scene:redraw()
	self.board:clear(asciiBoardCell.createCell(0,0,0))

	local columns = self.gameData.constants.grid.columns
	local rows = self.gameData.constants.grid.rows
	local colors = self.gameData.resources.colors
	local charms = self.gameData.charms
	local profile = self.gameData.profile
	
	self.board:set(1,1,asciiBoardCell.createCell(201,colors.blue,colors.lightGray))
	self.board:set(1,rows,asciiBoardCell.createCell(200,colors.blue,colors.lightGray))
	self.board:set(columns,1,asciiBoardCell.createCell(187,colors.blue,colors.lightGray))
	self.board:set(columns,rows,asciiBoardCell.createCell(188,colors.blue,colors.lightGray))
	
	self.board:hLine(2,1,columns-2,asciiBoardCell.createCell(205,colors.blue,colors.lightGray))
	self.board:hLine(2,rows,columns-2,asciiBoardCell.createCell(205,colors.blue,colors.lightGray))
	
	self.board:vLine(1,2,rows-2,asciiBoardCell.createCell(186,colors.blue,colors.lightGray))
	self.board:vLine(columns,2,rows-2,asciiBoardCell.createCell(186,colors.blue,colors.lightGray))
	
	self.board:writeText(2,2,"Shop",asciiBoardCell.createCell(0,colors.white,colors.black))
	
	self.board:writeText(2,3,"Prices:",asciiBoardCell.createCell(0,colors.white,colors.black))
	for index,value in ipairs(self.menu) do
		if index==self.selectedItem then
			if profile.pennies>=self.prices[index] then
				self.board:set(2,25,charms.oButton)
				self.board:writeText(4,25,"Buy Item",asciiBoardCell.createCell(0,colors.white,colors.black))
				self.board:writeText(self.menuX,self.menuY+index-1,value,self.hiliteCell)
			else
				self.board:writeText(self.menuX,self.menuY+index-1,value,self.disabledHiliteCell)
			end
		else
			if profile.pennies>=self.prices[index] then
				self.board:writeText(self.menuX,self.menuY+index-1,value,self.normalCell)
			else
				self.board:writeText(self.menuX,self.menuY+index-1,value,self.disabledCell)
			end
		end
	end
	
	self.board:set(2,26,charms.aButton)
	self.board:writeText(4,26,"Go Back",asciiBoardCell.createCell(0,colors.white,colors.black))

	self.board:render(self.grid,self.gameData.resources.colors)
end

function scene:createScene( event )
    local group = self.view
	self.gameData = event.params
	local colors = self.gameData.resources.colors
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
	self.selectedItem=1
	self.prices={100,250,500,1000,10,50,100,250}
	self.menu={
		"Fish Bowl                   -  100"..string.char(155),
		"Small Fish Tank             -  250"..string.char(155),
		"Medium Fish Tank            -  500"..string.char(155),
		"Large Fish Tank             - 1000"..string.char(155),
		"Single Serving Fish Pellet  -   10"..string.char(155),
		"Week Supply of Fish Pellets -   50"..string.char(155),
		"One Tank Tablet             -  100"..string.char(155),
		"Three Tank Tablets          -  250"..string.char(155),
	}
	self.normalCell = asciiBoardCell.createCell(0,colors.white,colors.black)
	self.hiliteCell = asciiBoardCell.createCell(0,colors.black,colors.white)
	self.disabledCell = asciiBoardCell.createCell(0,colors.gray,colors.black)
	self.disabledHiliteCell = asciiBoardCell.createCell(0,colors.black,colors.gray)
	self.menuX=2
	self.menuY=4
end

function scene:onKeyDown(theKey)
	local soundManager = self.gameData.soundManager
	if theKey=="A" then
		soundManager.play("transition")
		storyboard.gotoScene("mainMenu","slideUp")
	elseif theKey=="down" then
		self.selectedItem=self.selectedItem+1
		if self.selectedItem>#self.menu then
			self.selectedItem=1
		end
		soundManager.play("menuChange")
		self:redraw()
	elseif theKey=="up" then
		self.selectedItem=self.selectedItem-1
		if self.selectedItem<1 then
			self.selectedItem=#self.menu
		end
		soundManager.play("menuChange")
		self:redraw()
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