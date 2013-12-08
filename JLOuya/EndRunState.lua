return {
	start=function()
		game.states.current = game.stateNames.endRun
	end,
	finish=function(nextState)
		game.states[nextState].start()
	end,
	onKeyDown=function(theKey)
		if theKey=="O" then
			game.states.startRun.finish(game.stateNames.startRun)
		end
	end,
	onKeyUp=function(theKey)
	end
}
