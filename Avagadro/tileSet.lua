local tileSet={}
tileSet.fileName="tileset.png"
tileSet.cellWidth=108
tileSet.cellheight=108
tileSet.border=4
tileSet.numFrames=32
tileSet.imageSheet=graphics.newImageSheet(tileSet.fileName,{width=tileSet.cellWidth,height=tileSet.cellheight,border=tileSet.border,numFrames=tileSet.numFrames})
tileSet.foregroundSequence={name="foreground",start=1,count=20}
tileSet.backgroundSequence={name="background",frames={20,21,22,23}}
tileSet.cursorSequence={name="cursor",frames={20,25}}
tileSet.newForegroundSprite=function(parent,x,y)
	local theSprite=display.newSprite(parent,tileSet.imageSheet,tileSet.foregroundSequence)
	theSprite.x=x
	theSprite.y=y
	return theSprite
end
tileSet.newBackgroundSprite=function(parent,x,y)
	local theSprite=display.newSprite(parent,tileSet.imageSheet,tileSet.backgroundSequence)
	theSprite.x=x
	theSprite.y=y
	return theSprite
end
tileSet.newCursorSprite=function(parent,x,y)
	local theSprite=display.newSprite(parent,tileSet.imageSheet,tileSet.cursorSequence)
	theSprite.x=x
	theSprite.y=y
	return theSprite
end
return tileSet