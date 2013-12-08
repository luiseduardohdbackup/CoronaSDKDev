local storyboard = require( "storyboard" )
local asciiGrid = require("ASCIIGrid")
local asciiBoard = require("ASCIIBoard")
local asciiBoardCell = require("ASCIIBoardCell")
local scene = storyboard.newScene()

function scene:redrawHeader()
	local player = self.gameData.player
	local columns = self.gameData.constants.grid.columns
	self.headerCell:setCharacter(0)
	self.header:clear(self.headerCell)
	
	self.headerCell:setCharacter(1)
	self.header:set(1,1,self.headerCell)
	self.headerCell:setCharacter(string.byte("x"))
	self.header:set(2,1,self.headerCell)
	self.headerCell:setCharacter(string.byte("0")+math.floor(player.lives/10))
	self.header:set(3,1,self.headerCell)
	self.headerCell:setCharacter(string.byte("0")+player.lives%10)
	self.header:set(4,1,self.headerCell)
	
	self.headerCell:setCharacter(15)
	self.header:set(6,1,self.headerCell)
	self.headerCell:setCharacter(string.byte("x"))
	self.header:set(7,1,self.headerCell)
	self.headerCell:setCharacter(string.byte("0")+math.floor(player.bombs/10))
	self.header:set(8,1,self.headerCell)
	self.headerCell:setCharacter(string.byte("0")+player.bombs%10)
	self.header:set(9,1,self.headerCell)
	
	local temp = tostring(player.score)
	self.header:writeText(columns-string.len(temp),1,temp,self.headerCell)
	
	self.header:render(self.grid,self.gameData.resources.colors)
end

function scene:redrawFooter()
	self.footerCell:setCharacter(0)
	self.footer:clear(self.footerCell)
	self.footer:render(self.grid,self.gameData.resources.colors)
end

function scene:startGame()
	local player = self.gameData.player
	player.level=1
	player.lives=1
	player.score=0
	self:startRun()
end

function scene:startRun()
	local player = self.gameData.player
	local columns = self.field.columns
	local rows=self.field.rows
	local constants = self.gameData.constants
	local charms = self.gameData.charms
	player.state="startRun"
	player.bombs=3
	player.shields=0
	player.position=math.floor(self.gameData.constants.grid.columns/2)
	player.direction=0
	self.fieldCell:setCharacter(0)
	self.field:clear(self.fieldCell)
	self.field:vLine(constants.leftWalls[player.level],1,self.field.rows,charms.walls[player.level])
	self.field:vLine(constants.rightWalls[player.level],1,self.field.rows,charms.walls[player.level])
	self.field:vLine(player.position,1,constants.tailLength,charms.star)
	self.field:set(player.position,constants.tailLength+1,charms.dude)
	self.field:render(self.grid,self.gameData.resources.colors)
	self:redrawHeader()
	self:redrawFooter()
end

function scene:timer(event)
	local player = self.gameData.player
	local constants = self.gameData.constants
	local charms = self.gameData.charms
	self.field:set(player.position,constants.tailLength+1,charms.star)
	self.field:scrollUp(1,1,self.field.columns,self.field.rows)
	self.fieldCell:setCharacter(0)
	self.field:hLine(1,self.field.rows,self.field.columns,self.fieldCell)
	self.field:set(constants.leftWalls[player.level],self.field.rows,charms.walls[player.level])
	self.field:set(constants.rightWalls[player.level],self.field.rows,charms.walls[player.level])
	local blockPosition = math.random(constants.leftWalls[player.level]+1,constants.rightWalls[player.level]-1)
	self.field:set(blockPosition,self.field.rows,charms.block)
	
	player.position=player.position+player.direction
	
	self.field:set(player.position,constants.tailLength+1,charms.dude)
	self.field:render(self.grid,self.gameData.resources.colors)
end


function scene:beginPlay()
	local player = self.gameData.player
	player.state="play"
	self.updateTimer = timer.performWithDelay(100,self,0)
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
	self.header = asciiBoard.createBoard(1,1,self.gameData.constants.grid.columns,1)
	self.field = asciiBoard.createBoard(1,2,self.gameData.constants.grid.columns,self.gameData.constants.grid.rows-3)
	self.footer = asciiBoard.createBoard(1,self.gameData.constants.grid.rows-1,self.gameData.constants.grid.columns,2)

	local colors = self.gameData.resources.colors

	
	self.headerCell = asciiBoardCell.createCell(0,colors.black,colors.brown)
	self.fieldCell = asciiBoardCell.createCell(0,colors.black,colors.black)
	self.footerCell = asciiBoardCell.createCell(0,colors.black,colors.gray)
	
	self.header:clear(self.headerCell)
	self.field:clear(self.fieldCell)
	self.footer:clear(self.footerCell)

	self.header:render(self.grid,self.gameData.resources.colors)
	self.field:render(self.grid,self.gameData.resources.colors)
	self.footer:render(self.grid,self.gameData.resources.colors)
end

function scene:onKeyDown(theKey)
	local player = self.gameData.player
	if player.state=="startRun" then
		if theKey=="O" then
			self:beginPlay()
		end
	elseif player.state=="play" then
		if theKey=="left" then
			player.direction=-1
		elseif theKey=="right" then
			player.direction=1
		end
	end
end

function scene:onKeyUp(theKey)
end

function scene:willEnterScene( event )
    local group = self.view
	if self.gameData.player.state==nil then
		self:startGame()
	end
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