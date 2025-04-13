-- Radar Target Script (No Delay Version)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer
local mouse = lp:GetMouse()

-- GUI Setup
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "InstantRadarGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 150)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local inputLabel = Instance.new("TextLabel", frame)
inputLabel.Size = UDim2.new(1, -20, 0, 20)
inputLabel.Position = UDim2.new(0, 10, 0, 10)
inputLabel.Text = "Enter 3 letters of player name:"
inputLabel.TextColor3 = Color3.new(1,1,1)
inputLabel.BackgroundTransparency = 1
inputLabel.TextSize = 14

local inputBox = Instance.new("TextBox", frame)
inputBox.Size = UDim2.new(1, -20, 0, 30)
inputBox.Position = UDim2.new(0, 10, 0, 35)
inputBox.PlaceholderText = "e.g. 'abc'"
inputBox.Text = ""
inputBox.TextSize = 18
inputBox.TextColor3 = Color3.new(0, 0, 0)
inputBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

local selectRocketBtn = Instance.new("TextButton", frame)
selectRocketBtn.Size = UDim2.new(1, -20, 0, 30)
selectRocketBtn.Position = UDim2.new(0, 10, 0, 75)
selectRocketBtn.Text = "🎯 Select Rocket Block"
selectRocketBtn.BackgroundColor3 = Color3.fromRGB(80, 170, 255)
selectRocketBtn.TextColor3 = Color3.new(0, 0, 0)
selectRocketBtn.TextSize = 16

local statusLabel = Instance.new("TextLabel", frame)
statusLabel.Size = UDim2.new(1, -20, 0, 25)
statusLabel.Position = UDim2.new(0, 10, 0, 115)
statusLabel.Text = "Status: Waiting..."
statusLabel.TextColor3 = Color3.new(1,1,1)
statusLabel.TextSize = 14
statusLabel.BackgroundTransparency = 1

-- Vars
local selectedRocket = nil
local targetPlayer = nil

-- Rocket Selection
selectRocketBtn.MouseButton1Click:Connect(function()
	statusLabel.Text = "Click a rocket block..."
	local connection
	connection = mouse.Button1Down:Connect(function()
		local target = mouse.Target
		if target and target:IsDescendantOf(workspace) then
			selectedRocket = target
			statusLabel.Text = "✅ Rocket selected!"
			connection:Disconnect()
		else
			statusLabel.Text = "❌ Invalid block."
		end
	end)
end)

-- Target Player Search
inputBox.FocusLost:Connect(function()
	local input = inputBox.Text:lower()
	local found = false

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= lp and player.Name:lower():sub(1, #input) == input then
			targetPlayer = player
			statusLabel.Text = "✅ Target found: " .. player.Name
			found = true
			break
		end
	end

	if not found then
		targetPlayer = nil
		statusLabel.Text = "❌ Player not found"
	end
end)

-- Instant Aim Loop (no delay)
RunService.RenderStepped:Connect(function()
	if selectedRocket and targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local targetPos = targetPlayer.Character.HumanoidRootPart.Position
		local rocketPos = selectedRocket.Position
		selectedRocket.CFrame = CFrame.lookAt(rocketPos, targetPos)
	end
end)
