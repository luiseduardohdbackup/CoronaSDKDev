return {
	start=function()
		game.states.current = game.stateNames.startRun
		game.player.bombs=3
		game.player.position = math.floor(game.board.gridColumns/2)
		game.player.shields=0
		game.player.direction=0
		game.player.invincibility=0
		
		game.board:fill(game.board.fieldX,game.board.fieldY,game.board.fieldWidth,game.board.fieldHeight,0,game.board.colors.black,game.board.colors.black)
		game.board:vLineCharm(game.board.leftWalls[game.player.level],game.board.fieldY,game.board.fieldHeight,game.charms.walls[game.player.level])
		game.board:vLineCharm(game.board.rightWalls[game.player.level],game.board.fieldY,game.board.fieldHeight,game.charms.walls[game.player.level])
		game.board:vLineCharm(game.player.position+game.board.fieldDeltaX,game.board.fieldY,game.player.tail-1,game.charms.star)
		game.board:setCharm(game.player.position+game.board.fieldDeltaX,game.player.tail+game.board.fieldDeltaY,game.charms.dude)
		game.board:hLine(1,1,game.board.gridColumns,0,game.board.colors.black,game.board.colors.brown)
		
		game.board:fill(game.board.fieldX,game.board.fieldHeight+game.board.fieldY,game.board.fieldWidth,2,0,game.board.colors.black,game.board.colors.gray)
		
		--score
		local temp = tostring(game.player.score)
		game.board:writeText(game.board.gridColumns+1-string.len(temp),game.board.scoreRow,temp,nil,nil)
		
		game.board:set(1,1,1,nil,nil)
		game.board:writeText(2,1,"x",nil,nil)
		game.board:set(3,1,48+math.floor(game.player.lives/10),nil,nil)
		game.board:set(4,1,48+game.player.lives%10,nil,nil)

		game.board:set(6,1,15,nil,nil)
		game.board:writeText(7,1,"x",nil,nil)
		game.board:set(8,1,48+math.floor(game.player.bombs/10),nil,nil)
		game.board:set(9,1,48+game.player.bombs%10,nil,nil)
		
	end,
	finish=function(nextState)
		game.states[nextState].start()
	end,
	onKeyDown=function(theKey)
		if theKey=="O" then
			game.states.startRun.finish(game.stateNames.play)
		end
	end,
	onKeyUp=function(theKey)
	end
}
