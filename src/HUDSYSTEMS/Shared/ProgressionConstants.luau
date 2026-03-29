local ProgressionConstants = {
	BASE_XP = 100,
	LEVEL_EXPONENT = 2.5,
	MAX_LEVEL = 500,
}

export type ProgressionData = {
	XP: number,
	Level: number,
	Coins: number,
}

return ProgressionConstants
