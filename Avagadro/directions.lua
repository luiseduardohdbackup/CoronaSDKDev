local directions = {}
directions.count = 4
directions.north=1
directions.east=2
directions.south=3
directions.west=4
directions.deltas = {{x=0,y=-1},{x=1,y=0},{x=0,y=1},{x=-1,y=0}}
directions.flags = {1,2,4,8}
directions.opposites = {3,4,1,2}
directions.rights = {2,3,4,1}
directions.lefts = {4,1,2,3}
directions.nextX = function(direction,x,y,stride)
	if stride==nil then
		stride=1
	end
	return x + directions.deltas[direction].x * stride
end
directions.nextY = function(direction,x,y,stride)
	if stride==nil then
		stride=1
	end
	return y + directions.deltas[direction].y * stride
end
return directions