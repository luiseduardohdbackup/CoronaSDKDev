local map={}
local terrain = require "terrain"

map.newMap=function(columns,rows)
	local theMap = {}
	theMap.columns=columns
	theMap.rows=rows
	theMap.cells={}
	for column=1,columns do
		theMap[column]={}
		for row=1,rows do
			theMap[column][row]={
				terrain=terrain.default
			}
		end
	end
end

return map