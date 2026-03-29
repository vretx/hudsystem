local Players = game:GetService("Players")
local DataService = require(script.DataService)
local ProgressionService = require(script.ProgressionService)
local CommandService = require(script.CommandService)

Players.PlayerAdded:Connect(function(player)
	DataService.InitializePlayer(player)
	ProgressionService.Replicate(player)
end)

Players.PlayerRemoving:Connect(function(player)
	DataService.RemovePlayer(player)
end)

CommandService.Init()
