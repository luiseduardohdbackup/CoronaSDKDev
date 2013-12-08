local asciiCell = {}
asciiCell.createCell=function(parent,x,y,width,height,imageSheet)
	local cell = display.newGroup()
	cell.x = x
	cell.y = y
	cell.width=width
	cell.height=height
	cell.background = display.newRect(cell,0,0,width,height)
	cell.background:setFillColor({0,0,0})
	cell.foreground = display.newSprite(cell,imageSheet,{name="ascii",start=1,count=256})
	cell.foreground.x=width/2
	cell.foreground.y=height/2
	cell:insert(cell.foreground)
	cell.foreground:setFrame(2)
	parent:insert(cell)
	return cell
end
return asciiCell