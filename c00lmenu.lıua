local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
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
local loadingCorner = Instance.new("UICorner", LoadingFrame)
loadingCorner.CornerRadius = UDim.new(0, 20)

local LoadingTitle = Instance.new("TextLabel")
LoadingTitle.Parent = LoadingFrame
LoadingTitle.Size = UDim2.new(1, 0, 0, 40)
LoadingTitle.Position = UDim2.new(0, 0, 0, 10)
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Text = "c00lteam"
LoadingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingTitle.Font = Enum.Font.SourceSansBold
LoadingTitle.TextSize = 30

local LoadingText = Instance.new("TextLabel")
LoadingText.Parent = LoadingFrame
LoadingText.Size = UDim2.new(1, 0, 0, 25)
LoadingText.Position = UDim2.new(0, 0, 0, 60)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "Loading..."
LoadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingText.Font = Enum.Font.SourceSans
LoadingText.TextSize = 20

local LoadingBarBack = Instance.new("Frame")
LoadingBarBack.Parent = LoadingFrame
LoadingBarBack.Size = UDim2.new(0.8, 0, 0, 20)
LoadingBarBack.Position = UDim2.new(0.1, 0, 0, 100)
LoadingBarBack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
local loadingBarBackCorner = Instance.new("UICorner", LoadingBarBack)
loadingBarBackCorner.CornerRadius = UDim.new(0, 10)

local LoadingBar = Instance.new("Frame")
LoadingBar.Parent = LoadingBarBack
LoadingBar.Size = UDim2.new(0, 0, 1, 0)
LoadingBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
local loadingBarCorner = Instance.new("UICorner", LoadingBar)
loadingBarCorner.CornerRadius = UDim.new(0, 10)

-- Yüklenme animasyonu
local loadProgress = 0
local loadSpeed = 0.01

local function loadingAnim()
    while loadProgress < 1 do
        loadProgress = loadProgress + loadSpeed
        LoadingBar.Size = UDim2.new(loadProgress, 0, 1, 0)
        wait(0.03)
    end
end

loadingAnim()

-- ---------- Ana GUI ----------

-- Ana çerçeve
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 350)
MainFrame.Position = UDim2.new(0, 100, 0, 100)
MainFrame.AnchorPoint = Vector2.new(0,0)
MainFrame.Parent = ScreenGui
local UICornerMain = Instance.new("UICorner", MainFrame)
UICornerMain.CornerRadius = UDim.new(0, 20)
MainFrame.Visible = false -- loading biter bitmez gösterilecek

-- Başlık çubuğu (sürükleme alanı)
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1,0,0,50)
TitleBar.BackgroundTransparency = 1
TitleBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleBar
TitleLabel.Text = "c00lteam"
TitleLabel.TextColor3 = Color3.fromRGB(255,255,255)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 30
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 10, 0, 5)
TitleLabel.Size = UDim2.new(0, 150, 0, 40)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Kapat ve küçült butonları container
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
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(1, 0)
    return btn
end

local MinimizeBtn = createCircleBtn("-", 0)
local CloseBtn = createCircleBtn("X", 50)

-- Yan panel (butonlar)
local SidePanel = Instance.new("Frame")
SidePanel.Parent = MainFrame
SidePanel.Size = UDim2.new(0, 120, 1, -60)
SidePanel.Position = UDim2.new(0, 10, 0, 60)
SidePanel.BackgroundColor3 = Color3.fromRGB(0,0,0)
local UICornerSide = Instance.new("UICorner", SidePanel)
UICornerSide.CornerRadius = UDim.new(0, 15)

-- İçerik alanı (menülerin içeriği buraya gelecek)
local ContentArea = Instance.new("Frame")
ContentArea.Parent = MainFrame
ContentArea.Size = UDim2.new(1, -150, 1, -60)
ContentArea.Position = UDim2.new(0, 140, 0, 60)
ContentArea.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
local UICornerContent = Instance.new("UICorner", ContentArea)
UICornerContent.CornerRadius = UDim.new(0, 15)

local ContentLabel = Instance.new("TextLabel")
ContentLabel.Parent = ContentArea
ContentLabel.Size = UDim2.new(1, -20, 1, -20)
ContentLabel.Position = UDim2.new(0, 10, 0, 10)
ContentLabel.BackgroundTransparency = 1
ContentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ContentLabel.Font = Enum.Font.SourceSansBold
ContentLabel.TextSize = 24
ContentLabel.TextWrapped = true
ContentLabel.Text = "c00lteam'e hoşgeldiniz!"

-- Yan panel butonları fonksiyonu
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
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 10)
    return btn
end

local GenelMenuBtn = createSideBtn("Genel Menü", 10)
local TrollMenuBtn = createSideBtn("Troll Menü", 60)
local SesMenuBtn = createSideBtn("Ses Menüsü", 110)

-- Menü switch fonksiyonu
local function clearContent()
    for _,v in pairs(ContentArea:GetChildren()) do
        if not (v:IsA("UIListLayout") or v:IsA("UIPadding")) then
            v:Destroy()
        end
    end
end

-- Uçma sistemi değişkenleri
local flying = false
local BodyVelocity

local function startFly()
    if flying then return end
    flying = true
    
    BodyVelocity = Instance.new("BodyVelocity")
    BodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    BodyVelocity.Velocity = Vector3.new(0, 0, 0)
    BodyVelocity.Parent = HumanoidRootPart
    
    RunService:BindToRenderStep("FlyStep", Enum.RenderPriority.Character.Value, function()
        local camCFrame = workspace.CurrentCamera.CFrame
        local direction = Vector3.new()
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            direction = direction + camCFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            direction = direction - camCFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            direction = direction - camCFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            direction = direction + camCFrame.RightVector
        end
        
        if direction.Magnitude > 0 then
            direction = direction.Unit * 50 -- uçma hızı
        end
        
        BodyVelocity.Velocity = Vector3.new(direction.X, 0, direction.Z)
    end)
end

local function stopFly()
    if not flying then return end
    flying = false
    if BodyVelocity then
        BodyVelocity:Destroy()
        BodyVelocity = nil
    end
    RunService:UnbindFromRenderStep("FlyStep")
end

-- Genel Menü içeriği
local function setupGenelMenu()
    clearContent()
    
    local flyBtn = Instance.new("TextButton")
    flyBtn.Parent = ContentArea
    flyBtn.Size = UDim2.new(0, 150, 0, 50)
    flyBtn.Position = UDim2.new(0, 20, 0, 20)
    flyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    flyBtn.Text = "Fly"
    flyBtn.TextColor3 = Color3.new(1,1,1)
    flyBtn.Font = Enum.Font.SourceSansBold
    flyBtn.TextSize = 24
    local flyCorner = Instance.new("UICorner", flyBtn)
    flyCorner.CornerRadius = UDim.new(0, 10)
    
    local unflyBtn = Instance.new("TextButton")
    unflyBtn.Parent = ContentArea
    unflyBtn.Size = UDim2.new(0, 150, 0, 50)
    unflyBtn.Position = UDim2.new(0, 20, 0, 90)
    unflyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    unflyBtn.Text = "Unfly"
    unflyBtn.TextColor3 = Color3.new(1,1,1)
    unflyBtn.Font = Enum.Font.SourceSansBold
    unflyBtn.TextSize = 24
    local unflyCorner = Instance.new("UICorner", unflyBtn)
    unflyCorner.CornerRadius = UDim.new(0, 10)
    
    flyBtn.MouseButton1Click:Connect(function()
        startFly()
    end)
    unflyBtn.MouseButton1Click:Connect(function()
        stopFly()
    end)
end

-- Başlangıçta Genel Menü yüklensin
setupGenelMenu()

-- Butonlarla menü değişimi (şimdilik sadece Genel Menü işliyor)
GenelMenuBtn.MouseButton1Click:Connect(function()
    setupGenelMenu()
end)

TrollMenuBtn.MouseButton1Click:Connect(function()
    clearContent()
    local lbl = Instance.new("TextLabel")
    lbl.Parent = ContentArea
    lbl.Size = UDim2.new(1, -20, 1, -20)
    lbl.Position = UDim2.new(0, 10, 0, 10)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextSize = 24
    lbl.TextWrapped = true
    lbl.Text = "Troll menüsü buraya gelecek."
end)

SesMenuBtn.MouseButton1Click:Connect(function()
    clearContent()
    local lbl = Instance.new("TextLabel")
    lbl.Parent = ContentArea
    lbl.Size = UDim2.new(1, -20, 1, -20)
    lbl.Position = UDim2.new(0, 10, 0, 10)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextSize = 24
    lbl.TextWrapped = true
    lbl.Text = "Ses menüsü buraya gelecek."
end)

-- Kapatma butonu
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Küçültme butonu
MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Sürükleme fonksiyonu
local dragging = false
local dragInput
local dragStart
local startPos

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

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Loading bitince mainframe'i gösterip loading ekranını kaldır
LoadingFrame:Destroy()
MainFrame.Visible = true
