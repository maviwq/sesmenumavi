-- Roblox GUI ve basit fly/unfly sistemi

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Varsayılan ayarlar
local isFly = false
local flySpeed = 50
local flyDirection = Vector3.new(0,0,0)
local bodyVelocity

-- Yüklenme ekranı
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "c00lteamGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0,300,0,150)
loadingFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
loadingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
loadingFrame.BorderSizePixel = 0
loadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
loadingFrame.Parent = ScreenGui
loadingFrame.ClipsDescendants = true
loadingFrame.BackgroundTransparency = 0

local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "c00lteam"
titleLabel.Size = UDim2.new(1,0,0,40)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.new(1,1,1)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 30
titleLabel.Parent = loadingFrame

local loadingLabel = Instance.new("TextLabel")
loadingLabel.Text = "Loading..."
loadingLabel.Size = UDim2.new(1,0,0,30)
loadingLabel.Position = UDim2.new(0,0,0,50)
loadingLabel.BackgroundTransparency = 1
loadingLabel.TextColor3 = Color3.new(1,1,1)
loadingLabel.Font = Enum.Font.Gotham
loadingLabel.TextSize = 20
loadingLabel.Parent = loadingFrame

local loadingBarBg = Instance.new("Frame")
loadingBarBg.Size = UDim2.new(0.8,0,0,20)
loadingBarBg.Position = UDim2.new(0.1,0,0,100)
loadingBarBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
loadingBarBg.BorderSizePixel = 0
loadingBarBg.Parent = loadingFrame

local loadingBarFill = Instance.new("Frame")
loadingBarFill.Size = UDim2.new(0,0,1,0)
loadingBarFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
loadingBarFill.BorderSizePixel = 0
loadingBarFill.Parent = loadingBarBg

-- Loading animasyonu
spawn(function()
    for i = 0, 1, 0.01 do
        loadingBarFill.Size = UDim2.new(i, 0, 1, 0)
        wait(0.02)
    end
    wait(0.3)
    loadingFrame:Destroy()
    createMainGui()
end)

function createMainGui()
    -- Ana panel
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 300)
    mainFrame.Position = UDim2.new(0, 20, 0.3, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    mainFrame.BorderSizePixel = 0
    mainFrame.AnchorPoint = Vector2.new(0, 0)
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = ScreenGui
    mainFrame.Name = "MainFrame"
    mainFrame.Active = true
    mainFrame.Draggable = true

    -- Üst bar (c00lteam + küçültme & kapatma)
    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 30)
    topBar.BackgroundTransparency = 0.5
    topBar.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
    topBar.Parent = mainFrame
    topBar.Name = "TopBar"

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.6, 0, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.Text = "c00lteam"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.TextColor3 = Color3.new(1,1,1)
    title.BackgroundTransparency = 1
    title.Parent = topBar

    -- Kapatma & küçültme butonları (sağda)
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 30, 1, 0)
    closeButton.Position = UDim2.new(1, -30, 0, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.new(1,1,1)
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 20
    closeButton.Parent = topBar

    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, 30, 1, 0)
    minimizeButton.Position = UDim2.new(1, -60, 0, 0)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    minimizeButton.Text = "-"
    minimizeButton.TextColor3 = Color3.new(1,1,1)
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.TextSize = 20
    minimizeButton.Parent = topBar

    -- Sol panel (butonlar)
    local sidePanel = Instance.new("Frame")
    sidePanel.Size = UDim2.new(0, 100, 1, -30)
    sidePanel.Position = UDim2.new(0, 0, 0, 30)
    sidePanel.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    sidePanel.Parent = mainFrame
    sidePanel.Name = "SidePanel"

    -- Butonlar (Troll Menü, Ses Menüsü, Genel Menü)
    local buttons = {}

    local function createButton(text, posY)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -20, 0, 40)
        btn.Position = UDim2.new(0, 10, 0, posY)
        btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 16
        btn.Text = text
        btn.Parent = sidePanel
        return btn
    end

    buttons.troll = createButton("Troll Menü", 10)
    buttons.ses = createButton("Ses Menüsü", 60)
    buttons.genel = createButton("Genel Menü", 110)

    -- Sağ panel (içerik)
    local contentPanel = Instance.new("Frame")
    contentPanel.Size = UDim2.new(1, -100, 1, -30)
    contentPanel.Position = UDim2.new(0, 100, 0, 30)
    contentPanel.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    contentPanel.Parent = mainFrame
    contentPanel.Name = "ContentPanel"

    -- Genel Menü içeriği
    local function createGenelMenu()
        contentPanel:ClearAllChildren()

        local flyButton = Instance.new("TextButton")
        flyButton.Size = UDim2.new(0, 100, 0, 40)
        flyButton.Position = UDim2.new(0, 20, 0, 20)
        flyButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        flyButton.TextColor3 = Color3.new(1,1,1)
        flyButton.Font = Enum.Font.GothamBold
        flyButton.TextSize = 16
        flyButton.Text = "Fly"
        flyButton.Parent = contentPanel

        local unFlyButton = Instance.new("TextButton")
        unFlyButton.Size = UDim2.new(0, 100, 0, 40)
        unFlyButton.Position = UDim2.new(0, 140, 0, 20)
        unFlyButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        unFlyButton.TextColor3 = Color3.new(1,1,1)
        unFlyButton.Font = Enum.Font.GothamBold
        unFlyButton.TextSize = 16
        unFlyButton.Text = "UnFly"
        unFlyButton.Parent = contentPanel

        -- Fly/unfly fonksiyonları
        flyButton.MouseButton1Click:Connect(function()
            if isFly then return end
            isFly = true
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = Vector3.new(0,0,0)
                bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                bodyVelocity.Parent = character.HumanoidRootPart
            end
            -- Uçuşu güncelle
            RunService:BindToRenderStep("Fly", Enum.RenderPriority.Camera.Value + 1, function()
                if not isFly or not bodyVelocity or not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    RunService:UnbindFromRenderStep("Fly")
                    if bodyVelocity then
                        bodyVelocity:Destroy()
                        bodyVelocity = nil
                    end
                    return
                end

                local hrp = LocalPlayer.Character.HumanoidRootPart
                local cam = workspace.CurrentCamera
                local moveDir = Vector3.new(0,0,0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0,1,0) end
                if moveDir.Magnitude > 0 then
                    moveDir = moveDir.Unit * flySpeed
                    bodyVelocity.Velocity = moveDir
                else
                    bodyVelocity.Velocity = Vector3.new(0,0,0)
                end
            end)
        end)

        unFlyButton.MouseButton1Click:Connect(function()
            isFly = false
            if bodyVelocity then
                bodyVelocity:Destroy()
                bodyVelocity = nil
            end
            RunService:UnbindFromRenderStep("Fly")
        end)
    end

    -- Troll Menü içeriği örnek (şimdilik boş)
    local function createTrollMenu()
        contentPanel:ClearAllChildren()
        local label = Instance.new("TextLabel")
        label.Text = "Troll Menü İçeriği Burada"
        label.Size = UDim2.new(1, 0, 1, 0)
        label.TextColor3 = Color3.new(1,1,1)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.GothamBold
        label.TextSize = 18
        label.Parent = contentPanel
    end

    -- Ses Menüsü içeriği örnek (şimdilik boş)
    local function createSesMenu()
        contentPanel:ClearAllChildren()
        local label = Instance.new("TextLabel")
        label.Text = "Ses Menüsü İçeriği Burada"
        label.Size = UDim2.new(1, 0, 1, 0)
        label.TextColor3 = Color3.new(1,1,1)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.GothamBold
        label.TextSize = 18
        label.Parent = contentPanel
    end

    -- Butonlara tıklama ile içerik değiştirme
    buttons.genel.MouseButton1Click:Connect(createGenelMenu)
    buttons.troll.MouseButton1Click:Connect(createTrollMenu)
    buttons.ses.MouseButton1Click:Connect(createSesMenu)

    -- Başlangıçta genel menüyü aç
    createGenelMenu()

    -- Küçültme işlevi
    local minimized = false
    minimizeButton.MouseButton1Click:Connect(function()
        if minimized then
            -- Geri büyüt
            mainFrame.Size = UDim2.new(0, 400, 0, 300)
            sidePanel.Visible = true
            contentPanel.Visible = true
            minimized = false
        else
            -- Küçült: Yan panel ve içerik gizleniyor, ama kapatma/küçültme kalıyor
            mainFrame.Size = UDim2.new(0, 100, 0, 300)
            sidePanel.Visible = false
            contentPanel.Visible = false
            minimized = true
        end
    end)

    -- Kapatma işlevi
    closeButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
end
