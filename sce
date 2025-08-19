--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "AutoCollectAndAutoSell"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 120)
frame.Position = UDim2.new(0, 20, 0, 300)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = false
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1, 30, 1, 30)
shadow.Position = UDim2.new(0, -15, 0, -15)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.6
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.ZIndex = -1
shadow.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 50)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = "Auto Collect + Sell"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = frame

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(1, -40, 0, 40)
toggle.Position = UDim2.new(0, 20, 1, -50)
toggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
toggle.Text = "OFF"
toggle.TextColor3 = Color3.fromRGB(255, 0, 0)
toggle.TextScaled = true
toggle.Font = Enum.Font.GothamBold
toggle.AutoButtonColor = false
toggle.Parent = frame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggle

local toggled = false

toggle.MouseButton1Click:Connect(function()
	toggled = not toggled
	toggle.Text = toggled and "ON" or "OFF"
	toggle.TextColor3 = toggled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
	toggle.BackgroundColor3 = toggled and Color3.fromRGB(30, 130, 30) or Color3.fromRGB(80, 80, 80)
end)

local dragging, dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

frame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

task.spawn(function()
	while true do
		if toggled then
			local FunctionsFolder = ReplicatedStorage:WaitForChild("Communication"):WaitForChild("Functions")
			for _, remote in pairs(FunctionsFolder:GetChildren()) do
				if remote:IsA("RemoteFunction") then
					pcall(function()
						remote:InvokeServer()
					end)
				end
			end
		end
		task.wait(5)
	end
end)
