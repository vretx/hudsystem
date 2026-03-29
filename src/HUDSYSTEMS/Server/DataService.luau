local DataService = {}
local Players = game:GetService("Players")

local DataStoreService = require(game:GetService("ServerScriptService"):WaitForChild("DataStore_Wrapper"):WaitForChild("Server"):WaitForChild("DataStoreService"))
local PlayerData = {}

function DataService.InitializePlayer(player: Player)
	local profile = DataStoreService.GetProfile(player)
	if profile then
		PlayerData[player.UserId] = profile
	else
		PlayerData[player.UserId] = {
			XP = 0,
			Level = 1,
			Coins = 0,
		}
	end
end

function DataService.GetData(player: Player)
	return PlayerData[player.UserId]
end

function DataService.UpdateData(player: Player, key: string, value: any)
	local data = PlayerData[player.UserId]
	if data then
		data[key] = value
	end
end

function DataService.RemovePlayer(player: Player)
	PlayerData[player.UserId] = nil
end

return DataService
