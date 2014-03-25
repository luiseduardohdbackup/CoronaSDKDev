local generator={}
function generator.generate(data)
	local tally=0
	for k,v in pairs(data) do
		tally=tally+v
	end
	local value=math.random(tally)
	for k,v in pairs(data) do
		if value>v then
			value=value-v
		else
			return k
		end
	end
end
return generator