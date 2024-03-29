local storyboard = require( "storyboard" )
local asciiGrid = require("ASCIIGrid")
local asciiBoard = require("ASCIIBoard")
local asciiBoardCell = require("ASCIIBoardCell")
local scene = storyboard.newScene()

function scene:redraw()
	local profile = self.gameData.profile
	self.board:clear(asciiBoardCell.createCell(0,0,0))

	local columns = self.gameData.constants.grid.columns
	local rows = self.gameData.constants.grid.rows
	local colors = self.gameData.resources.colors
	
	self.board:set(1,1,asciiBoardCell.createCell(201,colors.blue,colors.lightGray))
	self.board:set(1,rows,asciiBoardCell.createCell(200,colors.blue,colors.lightGray))
	self.board:set(columns,1,asciiBoardCell.createCell(187,colors.blue,colors.lightGray))
	self.board:set(columns,rows,asciiBoardCell.createCell(188,colors.blue,colors.lightGray))
	
	self.board:hLine(2,1,columns-2,asciiBoardCell.createCell(205,colors.blue,colors.lightGray))
	self.board:hLine(2,rows,columns-2,asciiBoardCell.createCell(205,colors.blue,colors.lightGray))
	
	self.board:vLine(1,2,rows-2,asciiBoardCell.createCell(186,colors.blue,colors.lightGray))
	self.board:vLine(columns,2,rows-2,asciiBoardCell.createCell(186,colors.blue,colors.lightGray))
	
	self.board:writeText(2,23,"D-pad Up/Down: select setting",asciiBoardCell.createCell(0,colors.lightGray,colors.black))
	self.board:writeText(2,24,"D-pad Right/Left: change setting",asciiBoardCell.createCell(0,colors.lightGray,colors.black))
	
	self.board:writeText(2,2,"Options",asciiBoardCell.createCell(0,colors.white,colors.black))
	self.board:writeText(2,26,"A",asciiBoardCell.createCell(0,colors.red,colors.lightRed))
	self.board:writeText(4,26,"Go Back",asciiBoardCell.createCell(0,colors.white,colors.black))

	for index,value in ipairs(self.menuItems) do
		if index==self.selectedItem then
			self.board:writeText(self.menuX,self.menuY+index-1,value,self.hiliteCell)
		else
			self.board:writeText(self.menuX,self.menuY+index-1,value,self.normalCell)
		end
	end
	
	self.board:hLine(25,4,10,asciiBoardCell.createCell(0,0,8))
	self.board:hLine(25,5,10,asciiBoardCell.createCell(0,0,8))
	self.board:hLine(25,4,math.floor(10*profile.musicVolume),asciiBoardCell.createCell(0,0,2))
	self.board:hLine(25,5,math.floor(10*profile.soundVolume),asciiBoardCell.createCell(0,0,2))

	self.board:render(self.grid,self.gameData.resources.colors)
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
	
	local colors = self.gameData.resources.colors
	self.menuX=12
	self.menuY=4
	self.menuItems={
		"Music Volume",
		"Sound Volume",
	}
	self.selectedItem=1
	self.normalCell = asciiBoardCell.createCell(0,colors.white,colors.black)
	self.hiliteCell = asciiBoardCell.createCell(0,colors.black,colors.white)

end

function scene:decrementValue()
	local soundManager = self.gameData.soundManager
	local musicManager = self.gameData.musicManager
	local profile = self.gameData.profile
	if self.selectedItem==1 then
		profile.musicVolume=profile.musicVolume-0.1
		if profile.musicVolume<0 then 
			profile.musicVolume=0
		else
			soundManager.play("menuChange")
		end
		musicManager.setVolume(profile.musicVolume)
		self.gameData.profileManager.saveProfile(profile)
	elseif self.selectedItem==2 then
		profile.soundVolume=profile.soundVolume-0.1
		if profile.soundVolume<0 then 
			profile.soundVolume=0
		else
			soundManager.play("menuChange")
		end
		soundManager.setVolume(profile.soundVolume)
		self.gameData.profileManager.saveProfile(profile)
	end
	self:redraw()
end

function scene:incrementValue()
	local soundManager = self.gameData.soundManager
	local musicManager = self.gameData.musicManager
	local profile = self.gameData.profile
	if self.selectedItem==1 then
		profile.musicVolume=profile.musicVolume+0.1
		if profile.musicVolume>1 then 
			profile.musicVolume=1
		else
			soundManager.play("menuChange")
		end
		musicManager.setVolume(profile.musicVolume)
		self.gameData.profileManager.saveProfile(profile)
	elseif self.selectedItem==2 then
		profile.soundVolume=profile.soundVolume+0.1
		if profile.soundVolume>1 then 
			profile.soundVolume=1
		else
			soundManager.play("menuChange")
		end
		soundManager.setVolume(profile.soundVolume)
		self.gameData.profileManager.saveProfile(profile)
	end
	self:redraw()
end

function scene:nextMenuItem()
	local soundManager = self.gameData.soundManager
	soundManager.play("menuChange")
	self.selectedItem=self.selectedItem+1
	if self.selectedItem>#self.menuItems then
		self.selectedItem=1
	end
	self:redraw()
end

function scene:previousMenuItem()
	local soundManager = self.gameData.soundManager
	soundManager.play("menuChange")
	self.selectedItem=self.selectedItem-1
	if self.selectedItem<1 then
		self.selectedItem=#self.menuItems
	end
	self:redraw()
end

function scene:onKeyDown(theKey)
	local soundManager = self.gameData.soundManager
	local musicManager = self.gameData.musicManager
	local profile = self.gameData.profile
	if theKey=="A" then
		storyboard.gotoScene("mainMenu","slideLeft")
	elseif theKey=="left" then
		self:decrementValue()
	elseif theKey=="right" then
		self:incrementValue()
	elseif theKey=="up" then
		self:nextMenuItem()
	elseif theKey=="down" then
		self:previousMenuItem()
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