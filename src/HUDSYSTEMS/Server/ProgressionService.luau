local ProgressionService = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local DataService = require(script.Parent.DataService)
local LevelUtils = require(ReplicatedStorage:WaitForChild("HUDSYSTEMS"):WaitForChild("Shared"):WaitForChild("LevelUtils"))

local HUDSYSTEMS_Folder = ReplicatedStorage:WaitForChild("HUDSYSTEMS")
local Remotes = HUDSYSTEMS_Folder:WaitForChild("Remotes")

local ProgressionUpdate = Remotes:FindFirstChild("ProgressionUpdate")
if not ProgressionUpdate then
	ProgressionUpdate = Instance.new("RemoteEvent")
	ProgressionUpdate.Name = "ProgressionUpdate"
	ProgressionUpdate.Parent = Remotes
end

function ProgressionService.AddXP(player: Player, amount: number)
	local data = DataService.GetData(player)
	if not data then return end
	
	local newXP = math.max(0, data.XP + amount)
	local newLevel = LevelUtils.GetLevelFromXP(newXP)
	
	DataService.UpdateData(player, "XP", newXP)
	DataService.UpdateData(player, "Level", newLevel)
	
	ProgressionUpdate:FireClient(player, DataService.GetData(player))
end

function ProgressionService.AddCoins(player: Player, amount: number)
	local data = DataService.GetData(player)
	if not data then return end
	
	local newCoins = math.max(0, data.Coins + amount)
	DataService.UpdateData(player, "Coins", newCoins)
	
	ProgressionUpdate:FireClient(player, DataService.GetData(player))
end

function ProgressionService.Replicate(player: Player)
	local data = DataService.GetData(player)
	if data then
		ProgressionUpdate:FireClient(player, data)
	end
end

return ProgressionService
