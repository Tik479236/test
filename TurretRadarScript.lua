--// Настройки
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")

--// UI
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "CustomMenuUI"
gui.ResetOnSpawn = false

--// Размытие на весь экран
local blur = Instance.new("BlurEffect")
blur.Enabled = false
blur.Size = 0
blur.Parent = Lighting

local function toggleBlur(enable)
	if enable then
		blur.Enabled = true
		TweenService:Create(blur, TweenInfo.new(0.3), { Size = 20 }):Play()
	else
		local blurOut = TweenService:Create(blur, TweenInfo.new(0.25), { Size = 0 })
		blurOut:Play()
		blurOut.Completed:Connect(function()
			blur.Enabled = false
		end)
	end
end

--// Кнопка открытия
local openBtn = Instance.new("ImageButton", gui)
openBtn.Size = UDim2.new(0, 60, 0, 60)
openBtn.Position = UDim2.new(0, 20, 0, 160)
openBtn.Image = "rbxthumb://type=Asset&id=132917237197645&w=420&h=420"
openBtn.BackgroundTransparency = 1
openBtn.Name = "OpenImage"
openBtn.ZIndex = 10
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)

--// Главное меню
local menu = Instance.new("Frame", gui)
menu.Size = UDim2.new(0, 400, 0, 300)
menu.Position = UDim2.new(0.5, -200, 0.5, -150)
menu.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
menu.Visible = false
menu.Active = true
menu.Draggable = true
menu.ZIndex = 20
Instance.new("UICorner", menu).CornerRadius = UDim.new(0.05, 0)

-- Чёрная рамка
local border = Instance.new("UIStroke", menu)
border.Thickness = 2
border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
border.LineJoinMode = Enum.LineJoinMode.Round
border.Color = Color3.fromRGB(0, 0, 0)

--// Кнопка "X"
local closeBtn = Instance.new("TextButton", menu)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true
closeBtn.ZIndex = 21
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

--// Scroll
local scroll = Instance.new("ScrollingFrame", menu)
scroll.Size = UDim2.new(1, -20, 1, -50)
scroll.Position = UDim2.new(0, 10, 0, 40)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 8
scroll.BackgroundTransparency = 1
scroll.ZIndex = 20
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ClipsDescendants = true

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 10)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
layout.SortOrder = Enum.SortOrder.LayoutOrder

--// Создание кнопок
local function createButton(text, url)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 360, 0, 50)
	btn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.GothamBold
	btn.TextScaled = true
	btn.Text = text
	btn.Parent = scroll
	btn.ZIndex = 21
	Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {
			BackgroundColor3 = Color3.fromRGB(75, 75, 75)
		}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {
			BackgroundColor3 = Color3.fromRGB(55, 55, 55)
		}):Play()
	end)

	btn.MouseButton1Click:Connect(function()
		loadstring(game:HttpGet(url))()
	end)
end

-- Добавляем кнопки
createButton("Counter Blox", "https://raw.githubusercontent.com/uedan228/Happy-Hub/main/Counter%20Blox%3A%20Source%202")
createButton("Purple Auto Build", "https://raw.githubusercontent.com/catblox1346/StensUIReMake/refs/heads/main/Script/BoatBuilderHub")
createButton("Script with Cats", "https://raw.githubusercontent.com/TheRealAsu/BABFT/refs/heads/main/Jan25_Source.lua")
createButton("Ragdoll", "https://raw.githubusercontent.com/H20CalibreYT/SystemBroken/main/script")
createButton("Universal", "https://sirius.menu/script")
createButton("Invisible", "https://pastebin.com/raw/3Rnd9rHf")

-- Третья с конца — Турель
createButton("Turret", "https://raw.githubusercontent.com/Tik479236/test/refs/heads/main/TurretRadarScript.lua")

-- Вторая с конца — Auto Build
createButton("Auto Build", "https://raw.githubusercontent.com/novakoolhub/Scripts/main/Scripts/NovBoatR1")

-- Последняя — Пароль
local password = Instance.new("TextButton", scroll)
password.Size = UDim2.new(0, 360, 0, 40)
password.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
password.TextColor3 = Color3.new(1, 1, 1)
password.Font = Enum.Font.GothamBold
password.TextScaled = true
password.Text = "Password: N-314159"
password.ZIndex = 21
Instance.new("UICorner", password).CornerRadius = UDim.new(1, 0)

password.MouseButton1Click:Connect(function()
	setclipboard("N-314159")
	password.Text = "Copied!"
	task.wait(1)
	password.Text = "Password: N-314159"
end)

-- Анимация открытия
openBtn.MouseButton1Click:Connect(function()
	menu.Position = UDim2.new(0, openBtn.AbsolutePosition.X, 0, openBtn.AbsolutePosition.Y)
	menu.Size = UDim2.new(0, 0, 0, 0)
	menu.Visible = true
	openBtn.Visible = false
	toggleBlur(true)

	TweenService:Create(menu, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = UDim2.new(0, 400, 0, 300),
		Position = UDim2.new(0.5, -200, 0.5, -150)
	}):Play()
end)

-- Анимация закрытия
closeBtn.MouseButton1Click:Connect(function()
	local tweenOut = TweenService:Create(menu, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Size = UDim2.new(0, 0, 0, 0),
		Position = UDim2.new(0, openBtn.AbsolutePosition.X, 0, openBtn.AbsolutePosition.Y)
	})
	tweenOut:Play()
	tweenOut.Completed:Wait()
	menu.Visible = false
	openBtn.Visible = true
	toggleBlur(false)
end)
