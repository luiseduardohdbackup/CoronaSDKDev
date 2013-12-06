return {
	start=function()
		game.states.current = game.stateNames.mainMenu
		game.board:clear(0,game.board.colors.black,game.board.colors.black)
		
		game.board:set(1,1,201,game.board.colors.blue,game.board.colors.lightGray)
		game.board:set(1,game.board.gridRows,200,game.board.colors.blue,game.board.colors.lightGray)
		game.board:set(game.board.gridColumns,1,187,game.board.colors.blue,game.board.colors.lightGray)
		game.board:set(game.board.gridColumns,game.board.gridRows,188,game.board.colors.blue,game.board.colors.lightGray)
		
		game.board:hLine(2,1,game.board.gridColumns-2,205,game.board.colors.blue,game.board.colors.lightGray)
		game.board:hLine(2,game.board.gridRows,game.board.gridColumns-2,205,game.board.colors.blue,game.board.colors.lightGray)
		
		game.board:vLine(1,2,game.board.gridRows-2,186,game.board.colors.blue,game.board.colors.lightGray)
		game.board:vLine(game.board.gridColumns,2,game.board.gridRows-2,186,game.board.colors.blue,game.board.colors.lightGray)
		
		game.board:writeText(2,2,"JetLag",game.board.colors.lightCyan,game.board.colors.black)
		game.board:writeText(2,3,"O",game.board.colors.gray,game.board.colors.green)
		game.board:writeText(2,4,"U",game.board.colors.gray,game.board.colors.blue)
		game.board:writeText(2,5,"Y",game.board.colors.gray,game.board.colors.yellow)
		game.board:writeText(4,3,"Start Game",game.board.colors.lightGray,game.board.colors.black)
		game.board:writeText(4,4,"Instructions",game.board.colors.lightGray,game.board.colors.black)
		game.board:writeText(4,5,"Options",game.board.colors.lightGray,game.board.colors.black)
		
	end,
	finish=function(nextState)
		game.states[nextState].start()
	end,
	onKeyDown=function(theKey)
		if theKey=="O" then
			game.states.mainMenu.finish(game.stateNames.startGame)
		elseif theKey=="U" then
			game.states.mainMenu.finish(game.stateNames.instructions)
		elseif theKey=="Y" then
			game.states.mainMenu.finish(game.stateNames.options)
		end
	end,
	onKeyUp=function(theKey)
	end
}
