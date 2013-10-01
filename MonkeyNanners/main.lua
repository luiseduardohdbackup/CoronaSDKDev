local constants = {
	screen = {
		width = 640,
		height = 480
	},
	sidebar = {
		width = 120
	}
}

local monkey
local banana

function createMonkey()
	local theMonkey = display.newImage("Icon-mdpi.png")
	theMonkey.x = constants.screen.width/2
	theMonkey.y = constants.screen.height/2
	return theMonkey
end
function createBanana()
	local theBanana = display.newImage("banana.png")
	return theBanana
end
function moveBanana(event)
	banana.x = event.x
	banana.y = event.y
end
function moveMonkey()
	local deltaX = banana.x-monkey.x
	local deltaY = banana.y-monkey.y
	local distance = math.sqrt(math.pow(deltaX,2)+math.pow(deltaY,2))
	if distance > 1 then
		deltaX = deltaX/distance
		deltaY = deltaY/distance
	end
	monkey.x = monkey.x + deltaX
	monkey.y = monkey.y + deltaY
end

display.setDefault("background",128,255,255)
monkey = createMonkey()
banana = createBanana()

timer.performWithDelay(50,moveMonkey,0)
Runtime:addEventListener("touch",moveBanana)

