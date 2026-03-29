local HUDController = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LevelUtils = require(ReplicatedStorage.HUDSYSTEMS.Shared.LevelUtils)

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Remotes = ReplicatedStorage:WaitForChild("HUDSYSTEMS"):WaitForChild("Remotes")
local ProgressionUpdate = Remotes:WaitForChild("ProgressionUpdate")

local HUDFrame = nil

function HUDController.Init()
	HUDController.CreateHUD()
	ProgressionUpdate.OnClientEvent:Connect(HUDController.UpdateHUD)
end

function HUDController.CreateHUD()
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "HUD"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = PlayerGui
	
	HUDFrame = Instance.new("Frame")
	HUDFrame.Name = "PlayerHUD"
	HUDFrame.Size = UDim2.new(0, 300, 0, 100)
	HUDFrame.Position = UDim2.new(0, 20, 1, -120)
	HUDFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	HUDFrame.BackgroundTransparency = 0.5
	HUDFrame.BorderSizePixel = 0
	HUDFrame.Parent = ScreenGui
	
	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 8)
	UICorner.Parent = HUDFrame
	
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.fromRGB(255, 255, 255)
	UIStroke.Transparency = 0.8
	UIStroke.Parent = HUDFrame

	local UsernameLabel = Instance.new("TextLabel")
	UsernameLabel.Name = "Username"
	UsernameLabel.Size = UDim2.new(1, -20, 0, 25)
	UsernameLabel.Position = UDim2.new(0, 10, 0, 10)
	UsernameLabel.Text = Player.DisplayName
	UsernameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
	UsernameLabel.Font = Enum.Font.Roboto
	UsernameLabel.TextSize = 18
	UsernameLabel.BackgroundTransparency = 1
	UsernameLabel.Parent = HUDFrame

	local CoinsLabel = Instance.new("TextLabel")
	CoinsLabel.Name = "Coins"
	CoinsLabel.Size = UDim2.new(0.5, -15, 0, 20)
	CoinsLabel.Position = UDim2.new(0, 10, 0, 35)
	CoinsLabel.Text = "Coins: 0"
	CoinsLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
	CoinsLabel.TextXAlignment = Enum.TextXAlignment.Left
	CoinsLabel.Font = Enum.Font.Roboto
	CoinsLabel.TextSize = 16
	CoinsLabel.BackgroundTransparency = 1
	CoinsLabel.Parent = HUDFrame

	local LevelLabel = Instance.new("TextLabel")
	LevelLabel.Name = "Level"
	LevelLabel.Size = UDim2.new(0.5, -15, 0, 20)
	LevelLabel.Position = UDim2.new(0.5, 5, 0, 35)
	LevelLabel.Text = "Level: 1"
	LevelLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
	LevelLabel.TextXAlignment = Enum.TextXAlignment.Right
	LevelLabel.Font = Enum.Font.Roboto
	LevelLabel.TextSize = 16
	LevelLabel.BackgroundTransparency = 1
	LevelLabel.Parent = HUDFrame

	local XPBarBackground = Instance.new("Frame")
	XPBarBackground.Name = "XPBarBackground"
	XPBarBackground.Size = UDim2.new(1, -20, 0, 10)
	XPBarBackground.Position = UDim2.new(0, 10, 0, 65)
	XPBarBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	XPBarBackground.BorderSizePixel = 0
	XPBarBackground.Parent = HUDFrame

	local XPBarFill = Instance.new("Frame")
	XPBarFill.Name = "XPBarFill"
	XPBarFill.Size = UDim2.new(0, 0, 1, 0)
	XPBarFill.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
	XPBarFill.BorderSizePixel = 0
	XPBarFill.Parent = XPBarBackground

	local XPLabel = Instance.new("TextLabel")
	XPLabel.Name = "XPLabel"
	XPLabel.Size = UDim2.new(1, -20, 0, 15)
	XPLabel.Position = UDim2.new(0, 10, 0, 75)
	XPLabel.Text = "XP: 0 / 100"
	XPLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	XPLabel.TextSize = 12
	XPLabel.Font = Enum.Font.Roboto
	XPLabel.BackgroundTransparency = 1
	XPLabel.Parent = HUDFrame
end

function HUDController.UpdateHUD(data: {XP: number, Level: number, Coins: number})
	local level, xpInLevel, xpNeeded = LevelUtils.GetLevelProgress(data.XP)
	
	HUDFrame.Coins.Text = "Coins: " .. data.Coins
	HUDFrame.Level.Text = "Level: " .. level
	HUDFrame.XPLabel.Text = string.format("XP: %d / %d", math.floor(xpInLevel), math.floor(xpNeeded))
	
	local progress = math.clamp(xpInLevel / xpNeeded, 0, 1)
	HUDFrame.XPBarBackground.XPBarFill:TweenSize(UDim2.new(progress, 0, 1, 0), "Out", "Quad", 0.5, true)
end

return HUDController
