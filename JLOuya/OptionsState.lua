return {
	start=function()
		game.states.current = game.stateNames.options
		game.board:clear(0,game.board.colors.black,game.board.colors.black)
		
		game.board:set(1,1,201,game.board.colors.blue,game.board.colors.lightGray)
		game.board:set(1,game.board.gridRows,200,game.board.colors.blue,game.board.colors.lightGray)
		game.board:set(game.board.gridColumns,1,187,game.board.colors.blue,game.board.colors.lightGray)
		game.board:set(game.board.gridColumns,game.board.gridRows,188,game.board.colors.blue,game.board.colors.lightGray)
		
		game.board:hLine(2,1,game.board.gridColumns-2,205,game.board.colors.blue,game.board.colors.lightGray)
		game.board:hLine(2,game.board.gridRows,game.board.gridColumns-2,205,game.board.colors.blue,game.board.colors.lightGray)
		
		game.board:vLine(1,2,game.board.gridRows-2,186,game.board.colors.blue,game.board.colors.lightGray)
		game.board:vLine(game.board.gridColumns,2,game.board.gridRows-2,186,game.board.colors.blue,game.board.colors.lightGray)
		
		game.board:writeText(2,2,"Options",game.board.colors.lightCyan,game.board.colors.black)
		game.board:writeText(2,game.board.gridRows-1,"A",game.board.colors.gray,game.board.colors.red)
		game.board:writeText(4,game.board.gridRows-1,"Return to Main Menu",game.board.colors.lightGray,game.board.colors.black)
		
	end,
	finish=function(nextState)
		game.states[nextState].start()
	end,
	onKeyDown=function(theKey)
		if theKey=="A" then
			game.states.options.finish(game.stateNames.mainMenu)
		end
	end,
	onKeyUp=function(theKey)
	end
}