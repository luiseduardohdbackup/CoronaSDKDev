local theUtilities = {}
function theUtilities.cloneTable(theTable)
	local theNewTable = {}
	for k,v in pairs(theTable) do
		local theType = type(v)
		if theType=="number" or theType=="string" or theType=="boolean" then
			theNewTable[k]=v
		elseif theType=="table" then
			theNewTable[k]=theUtilities.cloneTable(v)
		end
	end
	return theNewTable
end
return theUtilities