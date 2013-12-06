display.setDefault("background",85,85,85)
game = {}
game.board =  require("ASCIIBoard")
game.stateNames = {
	splash="splash",
	mainMenu="mainMenu",
	startGame = "startGame",
	startRun = "startRun",
	play="play",
	endRun="endRun",
	gameOver="gameOver",
	instructions = "instructions",
	options = "options"
}
game.states={}
-------------------------------------------------------------------------------------------------------------------------------------
game.states.splash=require("SplashState")
-------------------------------------------------------------------------------------------------------------------------------------
game.states.mainMenu=require("MainMenuState")
-------------------------------------------------------------------------------------------------------------------------------------
game.states.instructions=require("InstructionsState")
-------------------------------------------------------------------------------------------------------------------------------------
game.states.options=require("OptionsState")
-------------------------------------------------------------------------------------------------------------------------------------
game.states.startGame=require("StartGameState")
-------------------------------------------------------------------------------------------------------------------------------------
game.states.startRun=require("StartRunState")
-------------------------------------------------------------------------------------------------------------------------------------
game.states.play=require("PlayState")
-------------------------------------------------------------------------------------------------------------------------------------
game.delays = {	
	1000,
	500,
	333,
	250,
	200,
	167,
	143,
	125,
	111,
	90,
	83,
	76,
	71,
	67,
	63,
	59,
	56,
	53,
	50
}
game.charms = {
	walls={
		{character=219,foregroundColor=game.board.colors.blue,backgroundColor=game.board.colors.black},
		{character=219,foregroundColor=game.board.colors.green,backgroundColor=game.board.colors.black},
		{character=219,foregroundColor=game.board.colors.cyan,backgroundColor=game.board.colors.black},
		{character=219,foregroundColor=game.board.colors.red,backgroundColor=game.board.colors.black},
		{character=219,foregroundColor=game.board.colors.magenta,backgroundColor=game.board.colors.black},
		{character=219,foregroundColor=game.board.colors.brown,backgroundColor=game.board.colors.black},
		{character=219,foregroundColor=game.board.colors.lightGray,backgroundColor=game.board.colors.black},
		{character=219,foregroundColor=game.board.colors.gray,backgroundColor=game.board.colors.black},
		{character=219,foregroundColor=game.board.colors.lightBlue,backgroundColor=game.board.colors.black},
		{character=219,foregroundColor=game.board.colors.lightGreen,backgroundColor=game.board.colors.black},
		{character=219,foregroundColor=game.board.colors.lightCyan,backgroundColor=game.board.colors.black},
		{character=219,foregroundColor=game.board.colors.lightRed,backgroundColor=game.board.colors.black},
		{character=219,foregroundColor=game.board.colors.lightMagenta,backgroundColor=game.board.colors.black},
		{character=219,foregroundColor=game.board.colors.yellow,backgroundColor=game.board.colors.black},
		{character=219,foregroundColor=game.board.colors.black,backgroundColor=game.board.colors.black}
	},
	block={character=219,foregroundColor=game.board.colors.white,backgroundColor=game.board.colors.black},
	dude={character=2,foregroundColor=game.board.colors.white,backgroundColor=game.board.colors.black},
	invincibleDude={character=2,foregroundColor=game.board.colors.lightCyan,backgroundColor=game.board.colors.black},
	warningDude={character=2,foregroundColor=game.board.colors.lightRed,backgroundColor=game.board.colors.black},
	shieldDude={character=1,foregroundColor=game.board.colors.lightBlue,backgroundColor=game.board.colors.black},
	life={character=1,foregroundColor=game.board.colors.white,backgroundColor=game.board.colors.black},
	heart={character=3,foregroundColor=game.board.colors.red,backgroundColor=game.board.colors.black},
	stopper={character=4,foregroundColor=game.board.colors.red,backgroundColor=game.board.colors.black},
	bomb={character=15,foregroundColor=game.board.colors.gray,backgroundColor=game.board.colors.black},
	question={character=63,foregroundColor=game.board.colors.gray,backgroundColor=game.board.colors.black},
	straighten={character=18,foregroundColor=game.board.colors.green,backgroundColor=game.board.colors.black},
	left={character=26,foregroundColor=game.board.colors.green,backgroundColor=game.board.colors.black},
	right={character=27,foregroundColor=game.board.colors.green,backgroundColor=game.board.colors.black},
	up={character=24,foregroundColor=game.board.colors.green,backgroundColor=game.board.colors.black},
	down={character=25,foregroundColor=game.board.colors.green,backgroundColor=game.board.colors.black},
	star={character=42,foregroundColor=game.board.colors.brown,backgroundColor=game.board.colors.black}
}
-------------------------------------------------------------------------------------------------------------------------------------
game.lookUps = {}
game.lookUps.simulatorKeyboard ={
	down="down",
	up="up",
	left="left",
	right="right",
	space="O",
	tab="U",
	enter="Y",
	escape="A"
}
game.onKeyEvent = function(event)
	if event.device==nil then
			local theKey = game.lookUps.simulatorKeyboard[event.keyName]
			if theKey~=nil then
				if event.phase=="down" then
					game.states[game.states.current].onKeyDown(theKey)
				elseif event.phase=="up" then
					game.states[game.states.current].onKeyUp(theKey)
				end
			end
	else
	end
end

game.onAxisEvent = function(event)
end

Runtime:addEventListener( "key", game.onKeyEvent )

Runtime:addEventListener( "axis", game.onAxisEvent )

game.states.splash.start()