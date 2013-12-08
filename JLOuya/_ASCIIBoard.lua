local asciiBoard = {}

asciiBoard.gridColumns = 48
asciiBoard.gridRows = 27
asciiBoard.cellWidth = 32
asciiBoard.cellHeight = 32
asciiBoard.offsetX = 192
asciiBoard.offsetY = 108
asciiBoard.scoreRow=1
asciiBoard.fieldY=2
asciiBoard.fieldX=1
asciiBoard.fieldDeltaX=asciiBoard.fieldX-1
asciiBoard.fieldDeltaY=asciiBoard.fieldY-1
asciiBoard.fieldWidth=asciiBoard.gridColumns
asciiBoard.fieldHeight=asciiBoard.gridRows-3
asciiBoard.leftWalls={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}
asciiBoard.rightWalls={
	asciiBoard.gridColumns,
	asciiBoard.gridColumns-1,
	asciiBoard.gridColumns-2,
	asciiBoard.gridColumns-3,
	asciiBoard.gridColumns-4,
	asciiBoard.gridColumns-5,
	asciiBoard.gridColumns-6,
	asciiBoard.gridColumns-7,
	asciiBoard.gridColumns-8,
	asciiBoard.gridColumns-9,
	asciiBoard.gridColumns-10,
	asciiBoard.gridColumns-11,
	asciiBoard.gridColumns-12,
	asciiBoard.gridColumns-13,
	asciiBoard.gridColumns-14}
asciiBoard.imageSheet = graphics.newImageSheet("ascii.png",{width=40,height=40,numFrames=256});
asciiBoard.colors = {
black={0,0,0},
blue={0,0,170},
green={0,170,0},
cyan={0,170,170},
red={170,0,0},
magenta={170,0,170},
brown={170,85,0},
lightGray={170,170,170},
gray={85,85,85},
lightBlue={85,85,255},
lightGreen={85,255,85},
lightCyan={85,255,255},
lightRed={255,85,85},
lightMagenta={255,85,255},
yellow={255,255,85},
white={255,255,255}
}
asciiBoard.colors[1] = asciiBoard.colors.black
asciiBoard.colors[2] = asciiBoard.colors.blue
asciiBoard.colors[3] = asciiBoard.colors.green
asciiBoard.colors[4] = asciiBoard.colors.cyan
asciiBoard.colors[5] = asciiBoard.colors.red
asciiBoard.colors[6] = asciiBoard.colors.magenta
asciiBoard.colors[7] = asciiBoard.colors.brown
asciiBoard.colors[8] = asciiBoard.colors.lightGray
asciiBoard.colors[9] = asciiBoard.colors.gray
asciiBoard.colors[10] = asciiBoard.colors.lightBlue
asciiBoard.colors[11] = asciiBoard.colors.lightGreen
asciiBoard.colors[12] = asciiBoard.colors.lightCyan
asciiBoard.colors[13] = asciiBoard.colors.lightRed
asciiBoard.colors[14] = asciiBoard.colors.lightMagenta
asciiBoard.colors[15] = asciiBoard.colors.yellow
asciiBoard.colors[16] = asciiBoard.colors.white

asciiBoard.cells = {}
for column=1,asciiBoard.gridColumns do
	asciiBoard.cells[column]={}
	for row=1,asciiBoard.gridRows do
		local cell = {}
		asciiBoard.cells[column][row]=cell
		local x = asciiBoard.offsetX + asciiBoard.cellWidth * (column - 1)
		local y = asciiBoard.offsetY + asciiBoard.cellHeight * (row - 1)
		cell.background = display.newRect(x,y,asciiBoard.cellWidth,asciiBoard.cellHeight)
		cell.background:setFillColor(0,0,0)
		cell.foreground = display.newSprite(asciiBoard.imageSheet,{name="default",start=1,count=256});
		cell.foreground.x = x+asciiBoard.cellWidth/2
		cell.foreground.y = y+asciiBoard.cellHeight/2
		cell.foreground:setFrame(1)
		function cell:setBackgroundColor(theColor) 
			if theColor==nil then
				return
			end
			self.background.cachedFillColor = theColor
			self.background:setFillColor(theColor[1],theColor[2],theColor[3])
		end
		function cell:setForegroundColor(theColor)
			if theColor==nil then
				return
			end
			self.foreground.cachedFillColor = theColor
			self.foreground:setFillColor(theColor[1],theColor[2],theColor[3])
		end
		function cell:setCharacter(theCharacter)
			if theCharacter==nil then
				return
			end
			self.foreground.cachedFrame = theCharacter
			self.foreground:setFrame(theCharacter+1)
		end
		function cell:set(theCharacter,theForegroundColor,theBackgroundColor)
			self:setCharacter(theCharacter)
			self:setForegroundColor(theForegroundColor)
			self:setBackgroundColor(theBackgroundColor)
		end
	end
end

function asciiBoard:set(x,y,character,foregroundColor,backgroundColor)
	self.cells[x][y]:set(character,foregroundColor,backgroundColor)
end

function asciiBoard:setCharm(x,y,charm)
	self:set(x,y,charm.character,charm.foregroundColor,charm.backgroundColor)
end

function asciiBoard:hLine(x,y,length,character,foregroundColor,backgroundColor)
	for i=1,length do
		self.cells[x][y]:set(character,foregroundColor,backgroundColor)
		x=x+1
	end
end
function asciiBoard:hLineCharm(x,y,length,charm)
	self:hLine(x,y,length,charm.character,charm.foregroundColor,charm.backgroundColor)
end

function asciiBoard:vLine(x,y,length,character,foregroundColor,backgroundColor)
	for i=1,length do
		self.cells[x][y]:set(character,foregroundColor,backgroundColor)
		y=y+1
	end
end
function asciiBoard:vLineCharm(x,y,length,charm)
	self:vLine(x,y,length,charm.character,charm.foregroundColor,charm.backgroundColor)
end
function asciiBoard:fill(x,y,width,height,character,foregroundColor,backgroundColor)
	for i=1,width do
		self:vLine(x,y,height,character,foregroundColor,backgroundColor)
		x=x+1
	end
end
function asciiBoard:fillCharm(x,y,width,height,charm)
	self:fill(x,y,width,height,charm.character,charm.foregroundColor,charm.backgroundColor)
end

function asciiBoard:clear(character,foregroundColor,backgroundColor)
	self:fill(1,1,self.gridColumns,self.gridRows,character,foregroundColor,backgroundColor)
end

function asciiBoard:writeText(x,y,text,foregroundColor,backgroundColor)
	for i=1,string.len(text) do
		self.cells[x][y]:set(string.byte(text,i),foregroundColor,backgroundColor)
		x = x + 1
	end
end

function asciiBoard:scrollUp(x,y,width,height)
	for column=x,x+width-1 do
		for row=y,y+height-2 do
			self:set(column,row,self.cells[column][row+1].foreground.cachedFrame,self.cells[column][row+1].foreground.cachedFillColor,self.cells[column][row+1].background.cachedFillColor)
		end
	end
end

return asciiBoard