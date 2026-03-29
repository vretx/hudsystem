local DataService = {}
local Players = game:GetService("Players")

local PlayerData = {}

function DataService.InitializePlayer(player: Player)
	PlayerData[player.UserId] = {
		XP = 0,
		Level = 1,
		Coins = 0,
	}
end

function DataService.GetData(player: Player)
	return PlayerData[player.UserId]
end

function DataService.UpdateData(player: Player, key: string, value: any)
	if PlayerData[player.UserId] then
		PlayerData[player.UserId][key] = value
	end
end

function DataService.RemovePlayer(player: Player)
	PlayerData[player.UserId] = nil
end

return DataService
