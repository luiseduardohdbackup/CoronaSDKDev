return {
	start=function()
		game.states.current = game.stateNames.splash
		game.board:clear(0,game.board.colors.black,game.board.colors.black)
		
		game.board:set(1,1,201,game.board.colors.blue,game.board.colors.lightGray)
		game.board:set(1,game.board.gridRows,200,game.board.colors.blue,game.board.colors.lightGray)
		game.board:set(game.board.gridColumns,1,187,game.board.colors.blue,game.board.colors.lightGray)
		game.board:set(game.board.gridColumns,game.board.gridRows,188,game.board.colors.blue,game.board.colors.lightGray)
		
		game.board:hLine(2,1,game.board.gridColumns-2,205,game.board.colors.blue,game.board.colors.lightGray)
		game.board:hLine(2,game.board.gridRows,game.board.gridColumns-2,205,game.board.colors.blue,game.board.colors.lightGray)
		
		game.board:vLine(1,2,game.board.gridRows-2,186,game.board.colors.blue,game.board.colors.lightGray)
		game.board:vLine(game.board.gridColumns,2,game.board.gridRows-2,186,game.board.colors.blue,game.board.colors.lightGray)
		
		game.board:writeText(17,10,"A Production of",game.board.colors.lightGreen,game.board.colors.black)
		game.board:writeText(18,17,"PlayDeez Games",game.board.colors.lightGreen,game.board.colors.black)
		
		game.states.splash.timer = timer.performWithDelay(2000,function() 
			game.states.splash.finish(game.stateNames.mainMenu)
		end)
	end,
	onKeyDown=function(theKey)
		game.states.splash.finish(game.stateNames.mainMenu)
	end,
	onKeyUp=function(theKey)
	end,
	finish=function(nextState)
		if game.states.splash.timer~=nil then
			timer.cancel(game.states.splash.timer)
			game.states.splash.timer=nil
		end
		game.states[nextState].start()
	end
}
