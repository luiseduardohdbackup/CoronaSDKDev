local musicManager = {}
audio.reserveChannels(1)
musicManager.streams={
	audio.loadStream("music/Big_Bang_Boom_-_06_-_Micro_Invasion_-_Big_Bang_Boom_-_Healing.mp3"),
	audio.loadStream("music/Bitluzherbip_-_05_-_Micro_Invasion_-_Bitluzherbip_-_Undergorund_Ex-School.mp3"),
	audio.loadStream("music/Chip_For_Breakfast_-_03_-_Micro_Invasion_-_Chip_For_Breakfast_-_Friday_13th_Kliwon.mp3"),
	audio.loadStream("music/Crazy_Games_-_02_-_Micro_Invasion_-_Crazy_Games_-_Wake_Up.mp3"),
	audio.loadStream("music/Go_Gadget_-_04_-_Micro_Invasion_-_Go_Gadget_-_Password.mp3"),
	audio.loadStream("music/Majemuk_-_09_-_Micro_Invsaion_-_Majemuk_-_Story_Behind_the_Name.mp3"),
	audio.loadStream("music/Mendhoan_-_01_-_Micro_Invasion_-_Mendhoan_-_Intro.mp3"),
	audio.loadStream("music/Son_Of_A_Bit_-_08_-_Micro_Invasion_-_Son_Of_a_Bit_-_Chased_By_A_Running_Chupacabra.mp3"),
	audio.loadStream("music/You_Kill_My_Brother_-_07_-_Micro_Invasion_-_You_Kill_My_Brother_-_Go_Go_Go.mp3"),
}
musicManager.start = function(event)
	audio.play(musicManager.streams[math.random(#musicManager.streams)],{channel=1,onComplete=musicManager.start})
end
musicManager.setVolume = function(theVolume)
	audio.setVolume(theVolume,{channel=1})
end
return musicManager