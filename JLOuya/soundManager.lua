local soundManager = {}
soundManager.sounds={
	menuChange=audio.loadSound("sounds/menuchange.wav"),
	transition=audio.loadSound("sounds/transition.wav"),
	death=audio.loadSound("sounds/death.wav"),
	gameover=audio.loadSound("sounds/gameover.wav"),
	heart=audio.loadSound("sounds/heart.wav"),
	cent=audio.loadSound("sounds/cent.wav"),
}
soundManager.play = function(name)
	audio.play(soundManager.sounds[name])
end
return soundManager