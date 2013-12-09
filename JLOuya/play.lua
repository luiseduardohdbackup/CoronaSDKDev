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
	self.headerCell:setCharacter(string.byte("0")+(player.lives%10))
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
	self.header:writeText(columns-string.len(temp)+1,1,temp,self.headerCell)
	
	self.header:render(self.grid,self.gameData.resources.colors)
end

function scene:redrawFooter()
	local player = self.gameData.player
	local colors = self.gameData.resources.colors
	self.footerCell:setCharacter(0)
	self.footer:clear(self.footerCell)
	self.footer:set(self.footer.columns,self.footer.rows,asciiBoardCell.createCell(155,colors.green,colors.gray))
	local temp = tostring(player.pennies)
	self.footer:writeText(self.footer.columns-string.len(temp),self.footer.rows,temp,asciiBoardCell.createCell(0,colors.green,colors.gray))
	self.footer:render(self.grid,self.gameData.resources.colors)
end

function scene:startGame()
	local player = self.gameData.player
	player.level=1
	player.lives=3
	player.score=0
	player.pennies=0
	self:startRun()
end

function scene:startRun()
	local colors = self.gameData.resources.colors
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
	player.reverseKeys=0
	self.fieldCell:setCharacter(0)
	self.field:clear(self.fieldCell)
	self.field:vLine(constants.leftWalls[player.level],1,self.field.rows,charms.walls[player.level])
	self.field:vLine(constants.rightWalls[player.level],1,self.field.rows,charms.walls[player.level])
	self.field:vLine(player.position,1,constants.tailLength,charms.star)
	self.field:set(player.position,constants.tailLength+1,charms.dude)
	self.field:set(19,12,charms.oButton)
	self.field:writeText(20,12," Start Run",asciiBoardCell.createCell(0,colors.lightGray,colors.black))
	self.field:set(19,14,charms.aButton)
	self.field:writeText(20,14," Main Menu",asciiBoardCell.createCell(0,colors.lightGray,colors.black))
	self.field:render(self.grid,self.gameData.resources.colors)
	self:redrawHeader()
	self:redrawFooter()
end

function scene:endGame()
	local soundManager = self.gameData.soundManager
	local player = self.gameData.player
	local profile = self.gameData.profile
	local colors = self.gameData.resources.colors
	local charms = self.gameData.charms
	soundManager.play("gameover")
	player.state="endGame"
	self.field:writeText(20,10,"GAME OVER!",asciiBoardCell.createCell(0,colors.lightCyan,colors.black))
	self.field:set(19,12,charms.oButton)
	self.field:writeText(20,12," Play Again",asciiBoardCell.createCell(0,colors.lightGray,colors.black))
	self.field:set(19,14,charms.aButton)
	self.field:writeText(20,14," Main Menu",asciiBoardCell.createCell(0,colors.lightGray,colors.black))
	local bonusLine = 16
	if player.pennies>0 then
		profile.pennies = profile.pennies+player.pennies
		local temp="You have added "..tostring(player.pennies)..string.char(155).." to your account!"
		self.field:writeText(25-math.floor(string.len(temp)/2),bonusLine,temp,asciiBoardCell.createCell(0,colors.lightRed,colors.black))
		bonusLine = bonusLine+1
	end
	if player.pennies==25 and not profile.bonuses.o then
		profile.bonuses.o=true
		self.field:writeText(14,bonusLine,"'Shave and a Haircut' Bonus Unlocked",asciiBoardCell.createCell(0,colors.lightGreen,colors.black))
		bonusLine = bonusLine+1
	end
	local oldAverage = 0
	if profile.gamesPlayed>0 then
		oldAverage=math.floor(profile.totalScore/profile.gamesPlayed)
	end
	profile.totalScore=profile.totalScore+player.score
	profile.gamesPlayed=profile.gamesPlayed+1
	if player.score>profile.highScore then
		profile.highScore=player.score
		self.field:writeText(17,bonusLine,"NEW HIGH SCORE!",asciiBoardCell.createCell(0,colors.lightBlue,colors.black))
		bonusLine = bonusLine+1
	elseif oldAverage>0 then
		local newAverage = math.floor(profile.totalScore/profile.gamesPlayed)
		if newAverage>oldAverage then
			self.field:writeText(17,bonusLine,"Average Increased!",asciiBoardCell.createCell(0,colors.lightBlue,colors.black))
		elseif newAverage<oldAverage then
			self.field:writeText(17,bonusLine,"Average Decreased!",asciiBoardCell.createCell(0,colors.lightBlue,colors.black))
		end
	end
	if player.score<=75 and not profile.bonuses.a then
		profile.bonuses.a=true
		self.field:writeText(14,bonusLine,"Lemming Bonus Unlocked",asciiBoardCell.createCell(0,colors.lightRed,colors.black))
		bonusLine = bonusLine+1
	end
	self.gameData.profileManager.saveProfile(profile)
end

function scene:endRun()
	local soundManager = self.gameData.soundManager
	local player = self.gameData.player
	local colors = self.gameData.resources.colors
	local charms = self.gameData.charms
	timer.cancel(self.updateTimer)
	self.updateTimer=nil
	player.lives = player.lives-1
	if player.lives==0 then
		self:endGame()
	else
		soundManager.play("death")
		player.state="endRun"
		self.field:writeText(11,10,"**SPLAT!!** That had to hurt!",asciiBoardCell.createCell(0,colors.lightMagenta,colors.black))
		self.field:set(19,12,charms.oButton)
		self.field:writeText(20,12," Continue",asciiBoardCell.createCell(0,colors.lightGray,colors.black))
		self.field:set(19,14,charms.aButton)
		self.field:writeText(20,14," Main Menu",asciiBoardCell.createCell(0,colors.lightGray,colors.black))
	end
end

function scene:timer(event)
	local soundManager = self.gameData.soundManager
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
	if blockPosition>constants.leftWalls[player.level]+1 then
		self.field:set(blockPosition-1,self.field.rows,charms.nextToBlock)
	end
	if blockPosition<constants.rightWalls[player.level]-1 then
		self.field:set(blockPosition+1,self.field.rows,charms.nextToBlock)
	end
	player.position=player.position+player.direction
	local theCell=self.field.cells[player.position][constants.tailLength+1]
	local dudeCharm = charms.dude
	if theCell.character==219 then
		charms.splat:setBackground(theCell.foreground)
		dudeCharm=charms.splat
		self:endRun()
	elseif theCell.character==255 or theCell.character==155 then
		soundManager.play("cent")
		player.pennies=player.pennies+1
	else
		player.score=player.score+player.level
	end
	self.field:set(player.position,constants.tailLength+1,dudeCharm)
	self.field:render(self.grid,self.gameData.resources.colors)
	self:redrawHeader()
	self:redrawFooter()
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
	local soundManager = self.gameData.soundManager
	local player = self.gameData.player
	local charms = self.gameData.charms
	if player.state=="startRun" then
		if theKey=="O" then
			self.fieldCell:setCharacter(0)
			self.field:fill(19,12,11,3,self.fieldCell)
			self:beginPlay()
		elseif theKey=="A" then
			soundManager.play("transition")
			storyboard.gotoScene("mainMenu","zoomOutInRotate")
		end
	elseif player.state=="endRun" then
		if theKey=="O" then
			self:startRun()
		elseif theKey=="A" then
			soundManager.play("transition")
			storyboard.gotoScene("mainMenu","zoomOutInRotate")
		end
	elseif player.state=="endGame" then
		if theKey=="O" then
			self:startGame()
		elseif theKey=="A" then
			soundManager.play("transition")
			storyboard.gotoScene("mainMenu","zoomOutInRotate")
		end
	elseif player.state=="play" then
		if theKey=="left" then
			player.direction=-1
		elseif theKey=="right" then
			player.direction=1
		elseif theKey=="O" then
			if player.bombs>0 then
				player.bombs=player.bombs-1
				self.fieldCell:setCharacter(0)
				for x=1,self.field.columns do
					for y=1,self.field.rows do
						if self.field.cells[x][y].character==219 and self.field.cells[x][y].foreground==15 then
							self.field:set(x,y,charms.cent)
						elseif self.field.cells[x][y].character==255 and self.field.cells[x][y].foreground==0 then
							self.field:set(x,y,self.fieldCell)
						end
					end
				end
			end
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