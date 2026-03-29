local CommandService = {}
local Players = game:GetService("Players")
local ProgressionService = require(script.Parent.ProgressionService)

function CommandService.Init()
	Players.PlayerAdded:Connect(function(player)
		player.Chatted:Connect(function(message)
			CommandService.HandleChat(player, message)
		end)
	end)
end

function CommandService.HandleChat(player: Player, message: string)
	local args = string.split(message, " ")
	local command = args[1]
	
	if command == "/coins" then
		local amount = tonumber(args[2])
		if amount then
			ProgressionService.AddCoins(player, amount)
		end
	elseif command == "/xp" then
		local amount = tonumber(args[2])
		if amount then
			ProgressionService.AddXP(player, amount)
		end
	end
end

return CommandService
