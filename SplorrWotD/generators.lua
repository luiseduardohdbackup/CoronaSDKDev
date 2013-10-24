local theGenerators = {}
function theGenerators.newGenerator(theTable)
	local theGenerator = {}
	theGenerator.table = theTable
	theGenerator.total = 0
	for key,value in pairs(theTable) do
		theGenerator.total = theGenerator.total + value
	end
	return theGenerator
end
function theGenerators.generate(theSelf)
	local theValue = math.random(theSelf.total)
	for key,value in pairs(theSelf.table) do
		if value<=theValue then
			return key
		else
			theValue = theValue - value
		end
	end
end
return theGenerators