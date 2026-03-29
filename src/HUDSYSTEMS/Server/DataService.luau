local DataService = {}
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local MainDataStore = DataStoreService:GetDataStore("Vretx_Production_v1")
local PlayerData = {}

local DefaultData = {
	XP = 0,
	Level = 1,
	Coins = 0
}

local function DeepMerge(target, source)
	for key, value in pairs(source) do
		if type(value) == "table" and type(target[key]) == "table" then
			DeepMerge(target[key], value)
		else
			if target[key] == nil then
				target[key] = value
			end
		end
	end
	return target
end

function DataService.InitializePlayer(player: Player)
	local key = "Player_" .. player.UserId
	
	local success, result = pcall(function()
		return MainDataStore:GetAsync(key)
	end)
	
	if success then
		local data = result or table.clone(DefaultData)
		PlayerData[player.UserId] = DeepMerge(data, DefaultData)
		print("[DataService] Data loaded for " .. player.Name)
	else
		PlayerData[player.UserId] = table.clone(DefaultData)
		warn("[DataService] Failed to load for " .. player.Name .. ": " .. tostring(result))
	end
end

function DataService.SavePlayer(player: Player)
	local data = PlayerData[player.UserId]
	if not data then return end
	
	local key = "Player_" .. player.UserId
	
	local success, err = pcall(function()
		MainDataStore:SetAsync(key, data)
	end)
	
	if success then
		print("[DataService] Data saved for " .. player.Name)
	else
		warn("[DataService] Failed to save for " .. player.Name .. ": " .. tostring(err))
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
	DataService.SavePlayer(player)
	PlayerData[player.UserId] = nil
end

return DataService
