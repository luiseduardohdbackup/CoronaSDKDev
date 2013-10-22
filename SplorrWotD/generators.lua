local theGenerators = {}
function theGenerators.newGenerator(theTable)
	local theGenerator = {}
	theGenerator.table = theTable
	theGenerator.total = 0
	for key,value in pairs(theTable) do
		theGenerator.total = theGenerator.total + value
	end
	function theGenerator:generate()
		local theValue = math.random(self.total)
		for key,value in pairs(self.table) do
			if value<=theValue then
				return key
			else
				theValue = theValue - value
			end
		end
	end
	return theGenerator
end
return theGenerators