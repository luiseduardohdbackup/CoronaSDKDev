local soundManager = {}
soundManager.sounds={
	menuChange=audio.loadSound("sounds/menuchange.wav"),
	transition=audio.loadSound("sounds/transition.wav"),
	death=audio.loadSound("sounds/death.wav"),
	gameover=audio.loadSound("sounds/gameover.wav"),
	heart=audio.loadSound("sounds/heart.wav"),
	cent=audio.loadSound("sounds/cent.wav"),
	bombExplode=audio.loadSound("sounds/bombexplode.wav"),
	diamond=audio.loadSound("sounds/diamond.wav"),
	extraLife=audio.loadSound("sounds/extralife.wav"),
	lastBomb=audio.loadSound("sounds/lastbomb.wav"),
	newBomb=audio.loadSound("sounds/newbomb.wav"),
	newShield=audio.loadSound("sounds/newshield.wav"),
	noMoreBombs=audio.loadSound("sounds/nomorebombs.wav"),
	shieldUse=audio.loadSound("sounds/shielduse.wav"),
	blockEat=audio.loadSound("sounds/blockeat.wav"),
	maxStat=audio.loadSound("sounds/maxstat.wav"),
	reverseKeys=audio.loadSound("sounds/reversekeys.wav"),
	slowDown=audio.loadSound("sounds/slowdown.wav"),
	speedUp=audio.loadSound("sounds/speedup.wav"),
	stopper=audio.loadSound("sounds/stopper.wav"),
	widen=audio.loadSound("sounds/widen.wav"),
	straighten=audio.loadSound("sounds/straighten.wav"),
	hallelujah=audio.loadSound("sounds/hallelujah.wav"),
--	=audio.loadSound("sounds/.wav"),
--	=audio.loadSound("sounds/.wav"),
--	=audio.loadSound("sounds/.wav"),
}
soundManager.play = function(name)
	audio.play(soundManager.sounds[name])
end
soundManager.setVolume = function(volume)
	for channel=audio.reservedChannels+1,audio.totalChannels do
		audio.setVolume(volume,{channel=channel})
	end
end
return soundManager