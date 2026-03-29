local ProgressionConstants = require(script.Parent.ProgressionConstants)

local LevelUtils = {}

function LevelUtils.GetXPForLevel(level: number): number
	if level <= 1 then
		return 0
	end
	return math.floor(ProgressionConstants.BASE_XP * (level ^ ProgressionConstants.LEVEL_EXPONENT))
end

function LevelUtils.GetLevelFromXP(xp: number): number
	local level = 1
	while level < ProgressionConstants.MAX_LEVEL do
		local nextXP = LevelUtils.GetXPForLevel(level + 1)
		if xp < nextXP then
			break
		end
		level += 1
	end
	return level
end

function LevelUtils.GetLevelProgress(xp: number): (number, number, number)
	local currentLevel = LevelUtils.GetLevelFromXP(xp)
	local currentLevelXP = LevelUtils.GetXPForLevel(currentLevel)
	local nextLevelXP = LevelUtils.GetXPForLevel(currentLevel + 1)
	
	local xpInCurrentLevel = xp - currentLevelXP
	local xpRequiredForNextLevel = nextLevelXP - currentLevelXP
	
	return currentLevel, xpInCurrentLevel, xpRequiredForNextLevel
end

return LevelUtils
