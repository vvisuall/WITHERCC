local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Visual Hub | Snow Plow Simulator",
   Icon = 17091459839,
   LoadingTitle = "Visual Hub",
   LoadingSubtitle = "By vvhrrs",
   Theme = "Amethyst"
})

-- Valores
local WalkSpeedText = 16
_G.AutoSnow = false
_G.AutoRebirth = false

-- Funções
local function AutoSnow()
	while _G.AutoSnow == true do
		 for i = 1, 8 do
		 	local nevinha = "workspace.HitParts.Snow" .. i
		 	game:GetService("ReplicatedStorage").Events.e8eGb8RgRXFcug8q:FireServer(nevinha, "Snow8", "MagicWand")
		 end
	wait(0.0001)
	end
end
local function SetWalkSpeed()
	game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = WalkSpeedText
end
local function AutoRebirth()
	while _G.AutoRebirth == true do
		game:GetService("ReplicatedStorage").RebirthEvent:FireServer()
		wait(1)
	end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Auto Farm")
local Toggle =  Menu:CreateToggle({
   Name = "Auto Snow",
   CurrentValue = false,
   Callback = function(Value)
   	_G.AutoSnow = Value
   	AutoSnow()
   end,
})
local Toggle =  Menu:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Callback = function(Value)
   	_G.AutoRebirth = Value
   	AutoRebirth()
   end,
})
local Button = Menu:CreateButton({
   Name = "Inf Gems",
   Callback = function()
   	game:GetService("ReplicatedStorage").ServerEvents.treasureChestCollection:FireServer(999999999999999)
    end,
})
local Section = Menu:CreateSection("Movement")
local Input = Menu:CreateInput({
   Name = "WalkSpeed",
   CurrentValue = "",
   PlaceholderText = "Default WalkSpeed = 16",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	WalkSpeedText = Text
   end,
})
local Button = Menu:CreateButton({
   Name = "Set WalkSpeed",
   Callback = function()
   	SetWalkSpeed()
    end,
})

-- Credits.
local Credits = Window:CreateTab("Credits", "info")
local Section = Credits:CreateSection("Discord Server")
local Label = Credits:CreateLabel("discord.gg/U8FhFdvGcf")
local Button = Credits:CreateButton({
   Name = "Copy Server Link",
   Callback = function()
   	setclipboard("discord.gg/U8FhFdvGcf")
   	toclipboard("discord.gg/U8FhFdvGcf")
    end,
})
