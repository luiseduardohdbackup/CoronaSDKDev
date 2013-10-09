local constants = {
	screen = {
		width = 640,
		height = 360
	}
}

local happySpeed = 10
local happySpeedMultiplier = 1.05
local sadSpeed = 5
local minimum = 5
local banana
local sadmonkeys={}
local happymonkeys={}



function createBackground()
	local theBackground = display.newImage("background.png")
	return theBackground
end
function createBanana()
	local theBanana = display.newImage("banana.png")
	theBanana.x = display.contentCenterX
	theBanana.y = display.contentCenterY
	return theBanana
end
function moveBanana(event)
	banana.x = event.x
	banana.y = event.y
end
function spawnHappyMonkey(x,y)
	local theHappyMonkey = display.newImage("happymonkey.png")
	table.insert(happymonkeys,theHappyMonkey)
	theHappyMonkey.x = x
	theHappyMonkey.y = y
	local theRadians = math.random() * math.pi * 2
	theHappyMonkey.deltaY = happySpeed * math.sin(theRadians)
	theHappyMonkey.deltaX = happySpeed * math.cos(theRadians)
end
function spawnSadMonkey()
	local theSadMonkey = display.newImage("sadmonkey.png")
	table.insert(sadmonkeys,theSadMonkey)
	local theSide = math.random(4)
	if theSide==1 then
		theSadMonkey.y = display.contentCenterY-display.viewableContentHeight/2
		theSadMonkey.x = display.contentCenterX-display.viewableContentWidth/2 + math.random() * display.viewableContentWidth
	elseif theSide==2 then
		theSadMonkey.y = display.contentCenterY+display.viewableContentHeight/2
		theSadMonkey.x = display.contentCenterX-display.viewableContentWidth/2 + math.random() * display.viewableContentWidth
	elseif theSide==3 then
		theSadMonkey.x = display.contentCenterX-display.viewableContentWidth/2
		theSadMonkey.y = display.contentCenterY-display.viewableContentHeight/2 + math.random() * display.viewableContentHeight
	else
		theSadMonkey.x = display.contentCenterX+display.viewableContentWidth/2
		theSadMonkey.y = display.contentCenterY-display.viewableContentHeight/2 + math.random() * display.viewableContentHeight
	end
	local angle = math.random() * math.pi
	theSadMonkey.deltaX = math.cos(angle) * sadSpeed
	theSadMonkey.deltaY = math.sin(angle) * sadSpeed
end
function moveMonkeys()
	local indices
	indices = {}
	local top = display.contentCenterY - display.viewableContentHeight/2
	local bottom = display.contentCenterY + display.viewableContentHeight/2
	local left = display.contentCenterX - display.viewableContentWidth/2
	local right = display.contentCenterX + display.viewableContentWidth/2
	for index,monkey in pairs(happymonkeys) do
		monkey.x = monkey.x + monkey.deltaX
		monkey.y = monkey.y + monkey.deltaY
		monkey.deltaX = monkey.deltaX * happySpeedMultiplier
		monkey.deltaY = monkey.deltaY * happySpeedMultiplier
		if monkey.x < left or monkey.x > right or monkey.y < top or monkey.y>bottom then
			monkey:removeSelf()
			table.insert(indices,1,index)
		end
	end
	for index,value in pairs(indices) do
		table.remove(happymonkeys,value)
	end
	indices = {}
	for index,monkey in pairs(sadmonkeys) do
		local deltaX = banana.x-monkey.x
		local deltaY = banana.y-monkey.y
		local distance = math.sqrt(math.pow(deltaX,2)+math.pow(deltaY,2))
		if distance<32 then
			spawnHappyMonkey(monkey.x,monkey.y)
			monkey:removeSelf()
			table.insert(indices,1,index)
		end
		monkey.x = monkey.x + monkey.deltaX
		monkey.y = monkey.y + monkey.deltaY
		if monkey.x < left then
			monkey.x = monkey.x + right - left
		elseif monkey.x>right then
			monkey.x = monkey.x - right + left
		end
		if monkey.y<top then
			monkey.y = monkey.y + bottom - top
		elseif monkey.y>bottom then
			monkey.y = monkey.y - bottom + top
		end
	end
	for index,value in pairs(indices) do
		table.remove(sadmonkeys,value)
	end
	while #sadmonkeys<minimum do
		spawnSadMonkey()
	end
end

createBackground()
banana = createBanana()

timer.performWithDelay(50,moveMonkeys,0)
timer.performWithDelay(2000,spawnSadMonkey,0)
Runtime:addEventListener("touch",moveBanana)

