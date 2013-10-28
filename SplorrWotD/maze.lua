local theMaze = {}
local directions = require("directions")
local generators = require("generators")
local monsters = require("monsters")
local items = require("items")
theMaze.newMaze = function(theColumns,theRows,theOptions)
	local theResult = {}
	theResult.version = 1
	theResult.player = theOptions.player
	theResult.size = {
		columns = theColumns,
		rows = theRows
	}
	theResult.columns = {}
	while #theResult.columns<theColumns do
		local theColumn = {}
		table.insert(theResult.columns,theColumn)
		while #theColumn<theRows do
			local theCell = {}
			table.insert(theColumn,theCell)
			theCell.column = #theResult.columns
			theCell.row = #theColumn
			theCell.neighbors = {}
			theCell.inside = false
			theCell.connections = {}
			theCell.connectionCount = 0
			while #theCell.connections < directions.count do
				table.insert(theCell.connections,0)
			end
		end
	end
	for theColumn = 1, theColumns do
		for theRow = 1, theRows do
			for theDirection = 1,#directions.deltas do
				local theNextColumn = theColumn + directions.deltas[theDirection].x
				local theNextRow = theRow + directions.deltas[theDirection].y
				if theNextColumn>=1 and theNextColumn<=theColumns and theNextRow>=1 and theNextRow<=theRows then
					theResult.columns[theColumn][theRow].neighbors[theDirection]=theResult.columns[theNextColumn][theNextRow]
				end
			end
		end
	end
	local cell = theResult.columns[math.random(theColumns)][math.random(theRows)]
	cell.inside = true
	local frontier = {}
	for direction=1,#cell.neighbors do
		if cell.neighbors[direction] ~= nil then
			table.insert(frontier,cell.neighbors[direction])
		end
	end
	while #frontier>0 do
		local index=math.random(#frontier)
		cell = frontier[index]
		table.remove(frontier,index)
		local possibleDirections={}
		for direction=1,directions.count do
			if cell.neighbors[direction]~=nil and cell.neighbors[direction].inside then
				table.insert(possibleDirections,direction)
			end
		end
		local direction = possibleDirections[math.random(#possibleDirections)]
		cell.inside = true
		cell.connections[direction]=1
		cell.connectionCount = cell.connectionCount + 1
		cell.neighbors[direction].connections[directions.opposites[direction]]=1
		cell.neighbors[direction].connectionCount = cell.neighbors[direction].connectionCount + 1
		for direction=1,#cell.neighbors do
			if cell.neighbors[direction] ~= nil and not cell.neighbors[direction].inside and table.indexOf(frontier,cell.neighbors[direction])==nil then
				table.insert(frontier,cell.neighbors[direction])
			end
		end
	end
	--create hidden doors
	for theColumn = 1, theColumns do
		for theRow = 1, theRows do
			local theCell = theResult.columns[theColumn][theRow]
			for theDirection = 1, directions.count do
				if theCell.connections[theDirection]>0 then
					if theCell.connectionCount==1 or theCell.neighbors[theDirection].connectionCount==1 then
						theCell.connections[theDirection]=2
					end
				end
			end
		end
	end
	--populate items
	if theOptions.items~=nil then
		local theItems = theOptions.items
		for theKey,theValue in pairs(theItems) do
			local theCount = generators.generate(theValue.countGenerator)
			while theCount>0 do
				local theColumn = math.random(theColumns)
				local theRow = math.random(theRows)
				local theCell = theResult.columns[theColumn][theRow]
				if table.indexOf(theValue.doorCounts,theCell.connectionCount)~=nil then
					if theCell.items==nil then
						theCell.items = {}
					end
					table.insert(theCell.items,items.newRoomItem(theValue))
					theCount = theCount - 1
				end
			end
		end
	end
	--populate monsters
	if theOptions.monsters~=nil then
		local theMonsters = theOptions.monsters
		for theKey,theValue in pairs(theMonsters) do
			local theCount = generators.generate(theValue.countGenerator)
			while theCount>0 do
				local theColumn = math.random(theColumns)
				local theRow = math.random(theRows)
				local theCell = theResult.columns[theColumn][theRow]
				if theCell.monster==nil then
					if table.indexOf(theValue.doorCounts,theCell.connectionCount)~=nil then
						theCell.monster = monsters.newMonster(theValue,theOptions.items)
						theCount = theCount - 1
					end
				end
			end
		end
	end
	--set the player position
	local done = false
	while not done do
		local theColumn = math.random(theColumns)
		local theRow = math.random(theRows)
		if theResult.columns[theColumn][theRow].connectionCount~=1 and theResult.columns[theColumn][theRow].monster==nil then
			done = true
			theResult.exit = {column=theColumn,row=theRow}
			theResult.player.position = {column=theColumn,row=theRow}
			theResult.columns[theColumn][theRow].visitCount = 1
		end
	end
	--clean up extra data
	for theColumn = 1, theColumns do
		for theRow = 1, theRows do
			theResult.columns[theColumn][theRow].neighbors = nil
			theResult.columns[theColumn][theRow].inside = nil
			theResult.columns[theColumn][theRow].connectionCount = nil
		end
	end
	return theResult
end


return theMaze