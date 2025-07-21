local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Önce eski GUI varsa kaldır
local oldGui = PlayerGui:FindFirstChild("CustomGui")
if oldGui then oldGui:Destroy() end

-- ---------- Loading ekranı ----------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomGui"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(0, 300, 0, 150)
LoadingFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingFrame.Parent = ScreenGui
Instance.new("UICorner", LoadingFrame).CornerRadius = UDim.new(0, 20)

local LoadingTitle = Instance.new("TextLabel")
LoadingTitle.Parent = LoadingFrame
LoadingTitle.Size = UDim2.new(1, 0, 0, 40)
LoadingTitle.Position = UDim2.new(0, 0, 0, 10)
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Text = "c00lteam"
LoadingTitle.TextColor3 = Color3.new(1,1,1)
LoadingTitle.Font = Enum.Font.SourceSansBold
LoadingTitle.TextSize = 30

local LoadingText = Instance.new("TextLabel")
LoadingText.Parent = LoadingFrame
LoadingText.Size = UDim2.new(1, 0, 0, 25)
LoadingText.Position = UDim2.new(0, 0, 0, 60)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "Loading..."
LoadingText.TextColor3 = Color3.new(1,1,1)
LoadingText.Font = Enum.Font.SourceSans
LoadingText.TextSize = 20

local LoadingBarBack = Instance.new("Frame")
LoadingBarBack.Parent = LoadingFrame
LoadingBarBack.Size = UDim2.new(0.8, 0, 0, 20)
LoadingBarBack.Position = UDim2.new(0.1, 0, 0, 100)
LoadingBarBack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Instance.new("UICorner", LoadingBarBack).CornerRadius = UDim.new(0, 10)

local LoadingBar = Instance.new("Frame")
LoadingBar.Parent = LoadingBarBack
LoadingBar.Size = UDim2.new(0, 0, 1, 0)
LoadingBar.BackgroundColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", LoadingBar).CornerRadius = UDim.new(0, 10)

local loadProgress = 0
local function loadingAnim()
	while loadProgress < 1 do
		loadProgress += 0.01
		LoadingBar.Size = UDim2.new(loadProgress, 0, 1, 0)
		wait(0.03)
	end
end
loadingAnim()

-- ---------- Ana GUI ----------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 350)
MainFrame.Position = UDim2.new(0, 100, 0, 100)
MainFrame.AnchorPoint = Vector2.new(0,0)
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 20)
MainFrame.Visible = false

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1,0,0,50)
TitleBar.BackgroundTransparency = 1
TitleBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleBar
TitleLabel.Text = "c00lteam"
TitleLabel.TextColor3 = Color3.new(1,1,1)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 30
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 10, 0, 5)
TitleLabel.Size = UDim2.new(0, 150, 0, 40)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local BtnContainer = Instance.new("Frame")
BtnContainer.Parent = TitleBar
BtnContainer.Size = UDim2.new(0, 90, 1, 0)
BtnContainer.Position = UDim2.new(1, -95, 0, 0)
BtnContainer.BackgroundTransparency = 1

local function createCircleBtn(text, posX)
	local btn = Instance.new("TextButton")
	btn.Parent = BtnContainer
	btn.Text = text
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 28
	btn.TextColor3 = Color3.new(1,1,1)
	btn.BackgroundColor3 = Color3.new(0,0,0)
	btn.Size = UDim2.new(0, 40, 0, 40)
	btn.Position = UDim2.new(0, posX, 0, 5)
	btn.AutoButtonColor = false
	Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
	return btn
end

local MinimizeBtn = createCircleBtn("-", 0)
local CloseBtn = createCircleBtn("X", 50)

local SidePanel = Instance.new("Frame")
SidePanel.Parent = MainFrame
SidePanel.Size = UDim2.new(0, 120, 1, -60)
SidePanel.Position = UDim2.new(0, 10, 0, 60)
SidePanel.BackgroundColor3 = Color3.new(0,0,0)
Instance.new("UICorner", SidePanel).CornerRadius = UDim.new(0, 15)

local ContentArea = Instance.new("Frame")
ContentArea.Parent = MainFrame
ContentArea.Size = UDim2.new(1, -150, 1, -60)
ContentArea.Position = UDim2.new(0, 140, 0, 60)
ContentArea.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", ContentArea).CornerRadius = UDim.new(0, 15)

local function createSideBtn(text, y)
	local btn = Instance.new("TextButton")
	btn.Parent = SidePanel
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, y)
	btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	btn.Text = text
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 20
	btn.TextColor3 = Color3.new(1,1,1)
	btn.AutoButtonColor = false
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
	return btn
end

local GenelMenuBtn = createSideBtn("Genel Menü", 10)
local TrollMenuBtn = createSideBtn("Troll Menü", 60)
local SesMenuBtn = createSideBtn("Ses Menüsü", 110)

local function clearContent()
	for _,v in pairs(ContentArea:GetChildren()) do
		if not (v:IsA("UIListLayout") or v:IsA("UIPadding")) then
			v:Destroy()
		end
	end
end

-- ---------- Uçma Sistemi ----------
local flying = false
local BodyVelocity

local function startFly()
	if flying then return end
	flying = true

	Humanoid.PlatformStand = true  -- animasyonları kapat

	BodyVelocity = Instance.new("BodyVelocity")
	BodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
	BodyVelocity.Velocity = Vector3.new(0, 0, 0)
	BodyVelocity.Parent = HumanoidRootPart

	RunService:BindToRenderStep("FlyStep", Enum.RenderPriority.Character.Value, function()
		local camCFrame = workspace.CurrentCamera.CFrame
		local direction = Vector3.new()

		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			direction += camCFrame.LookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then
			direction -= camCFrame.LookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then
			direction -= camCFrame.RightVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then
			direction += camCFrame.RightVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			direction += Vector3.new(0, 1, 0)
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
			direction -= Vector3.new(0, 1, 0)
		end

		if direction.Magnitude > 0 then
			direction = direction.Unit * 50
		end

		BodyVelocity.Velocity = direction

		-- Karakteri kameranın yatay bakış yönüne çevir
		local lookVector = camCFrame.LookVector
		local newCFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + Vector3.new(lookVector.X, 0, lookVector.Z))
		HumanoidRootPart.CFrame = newCFrame
	end)
end

local function stopFly()
	if not flying then return end
	flying = false

	Humanoid.PlatformStand = false  -- animasyonları tekrar aç

	if BodyVelocity then
		BodyVelocity:Destroy()
		BodyVelocity = nil
	end
	RunService:UnbindFromRenderStep("FlyStep")
end

local function setupGenelMenu()
	clearContent()

	local flyToggleBtn = Instance.new("TextButton")
	flyToggleBtn.Parent = ContentArea
	flyToggleBtn.Size = UDim2.new(0, 150, 0, 50)
	flyToggleBtn.Position = UDim2.new(0, 20, 0, 20)
	flyToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	flyToggleBtn.Text = "Fly"
	flyToggleBtn.TextColor3 = Color3.new(1, 1, 1)
	flyToggleBtn.Font = Enum.Font.SourceSansBold
	flyToggleBtn.TextSize = 24
	Instance.new("UICorner", flyToggleBtn).CornerRadius = UDim.new(0, 10)

	flyToggleBtn.MouseButton1Click:Connect(function()
		if flying then
			stopFly()
			flyToggleBtn.Text = "Fly"
		else
			startFly()
			flyToggleBtn.Text = "Unfly"
		end
	end)
end

-- Menü geçişleri
GenelMenuBtn.MouseButton1Click:Connect(setupGenelMenu)

TrollMenuBtn.MouseButton1Click:Connect(function()
	clearContent()
	local lbl = Instance.new("TextLabel", ContentArea)
	lbl.Size = UDim2.new(1, -20, 1, -20)
	lbl.Position = UDim2.new(0, 10, 0, 10)
	lbl.BackgroundTransparency = 1
	lbl.TextColor3 = Color3.new(1, 1, 1)
	lbl.Font = Enum.Font.SourceSansBold
	lbl.TextSize = 24
	lbl.TextWrapped = true
	lbl.Text = "Troll menüsü buraya gelecek."
end)

SesMenuBtn.MouseButton1Click:Connect(function()
	clearContent()
	local lbl = Instance.new("TextLabel", ContentArea)
	lbl.Size = UDim2.new(1, -20, 1, -20)
	lbl.Position = UDim2.new(0, 10, 0, 10)
	lbl.BackgroundTransparency = 1
	lbl.TextColor3 = Color3.new(1, 1, 1)
	lbl.Font = Enum.Font.SourceSansBold
	lbl.TextSize = 24
	lbl.TextWrapped = true
	lbl.Text = "Ses menüsü buraya gelecek."
end)

-- Geri Aç Butonu (Menü Gizlendiğinde Gösterilir)
local RestoreBtn = Instance.new("TextButton")
RestoreBtn.Parent = ScreenGui
RestoreBtn.Size = UDim2.new(0, 100, 0, 40)
RestoreBtn.Position = UDim2.new(1, -110, 1, -50)
RestoreBtn.AnchorPoint = Vector2.new(0, 0)
RestoreBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
RestoreBtn.Text = "Menüyü Aç"
RestoreBtn.TextColor3 = Color3.new(1, 1, 1)
RestoreBtn.Font = Enum.Font.SourceSansBold
RestoreBtn.TextSize = 20
RestoreBtn.Visible = false
Instance.new("UICorner", RestoreBtn).CornerRadius = UDim.new(1, 0)

MinimizeBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
	RestoreBtn.Visible = true
end)

RestoreBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = true
	RestoreBtn.Visible = false
end)

-- Kapatma
CloseBtn.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

-- Sürükleme
local dragging, dragInput, dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

TitleBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

RunService.RenderStepped:Connect(function()
	if dragging and dragInput then
		local delta = dragInput.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- İlk açılışta loading sonra ana menüyü göster
wait(2)
LoadingFrame:Destroy()
MainFrame.Visible = true
setupGenelMenu()
