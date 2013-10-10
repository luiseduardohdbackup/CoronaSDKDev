local theDb = {}
require "sqlite3"

theDb.db = sqlite3.open(system.pathForFile("JL2013.db",system.DocumentsDirectory))

function theDb:system(event)
	if event.type=="applicationExit" then
		self.db:close()
	end
end

theDb.db:exec([[CREATE TABLE IF NOT EXISTS AllTime (HighScore INT NOT NULL,HighLineScore INT NOT NULL,TotalScore INT NOT NULL,TotalLineScore INT NOT NULL,TotalGames INT NOT NULL)]])
for a in theDb.db:nrows([[SELECT COUNT(*) as Count FROM AllTime]]) do
	if a.Count==0 then
		theDb.db:exec([[INSERT INTO AllTime (HighScore,HighLineScore,TotalScore,TotalLineScore,TotalGames) VALUES (0,0,0,0,0)]])
	elseif a.Count>1 then
		theDb.db:exec([[DELETE FROM AllTime]])
		theDb.db:exec([[INSERT INTO AllTime (HighScore,HighLineScore,TotalScore,TotalLineScore,TotalGames) VALUES (0,0,0,0,0)]])
	end
end

function theDb:getAllTimeHighScore()
	for theRow in self.db:nrows([[SELECT HighScore FROM AllTime LIMIT 1]]) do
		return theRow.HighScore
	end
end

function theDb:recordScore(theScore,theLines)
	local theTotalScore
	local theTotalLineScore
	local theHighScore
	local theHighLineScore
	local theTotalGames
	for theRow in self.db:nrows([[SELECT * FROM AllTime LIMIT 1]]) do
		theTotalScore = theScore + theRow.TotalScore
		theTotalLineScore = math.floor(theScore / theLines) + theRow.TotalLineScore
		theHighScore = math.max(theRow.HighScore,theScore)
		theHighLineScore = math.max(theRow.HighLineScore, math.floor(theScore / theLines))
		theTotalGames = theRow.TotalGames + 1
	end
	self.db:exec([[UPDATE AllTime SET TotalScore=]]..theTotalScore..[[,TotalLineScore=]]..theTotalLineScore..[[,TotalGames=]]..theTotalGames..[[,HighScore=]]..theHighScore..[[,HighLineScore=]]..theHighLineScore)
end

Runtime:addEventListener("system",theDb)

return theDb