return {
	start=function()
		game.states.current = game.stateNames.play
		game.states.play.startTimer()
	end,
	startTimer = function()
		game.states.play.stopTimer()
		game.states.play.updateTimer=timer.performWithDelay(game.delays[game.player.speed],game.states.play.update,0)
	end,
	stopTimer = function()
		if game.states.play.updateTimer~=nil then
			timer.cancel(game.states.play.updateTimer)
			game.states.play.updateTimer=nil
		end
	end,
	update = function()
		game.board:setCharm(game.player.position+game.board.fieldDeltaX,game.player.tail+game.board.fieldDeltaY,game.charms.star)
		game.board:scrollUp(game.board.fieldX,game.board.fieldY,game.board.fieldWidth,game.board.fieldHeight)
		game.board:hLine(game.board.fieldX,game.board.fieldY+game.board.fieldHeight-1,game.board.fieldWidth,0,game.board.colors.black,game.board.colors.black)
		game.board:setCharm(game.board.leftWalls[game.player.level],game.board.fieldY+game.board.fieldHeight-1,game.charms.walls[game.player.level])
		game.board:setCharm(game.board.rightWalls[game.player.level],game.board.fieldY+game.board.fieldHeight-1,game.charms.walls[game.player.level])
		local blockPosition = math.random(game.board.leftWalls[game.player.level]+1,game.board.rightWalls[game.player.level]-1)
		game.board:setCharm(blockPosition,game.board.fieldY+game.board.fieldHeight-1,game.charms.block)
		
		
		
		game.board:setCharm(game.player.position+game.board.fieldDeltaX,game.player.tail+game.board.fieldDeltaY,game.charms.dude)
	end,
	finish=function(nextState)
		game.states[nextState].start()
	end,
	onKeyDown=function(theKey)
	end,
	onKeyUp=function(theKey)
	end
}
