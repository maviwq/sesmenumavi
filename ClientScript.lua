local ReplicatedStorage = game:GetService("ReplicatedStorage")
local playSoundEvent = ReplicatedStorage:WaitForChild("PlaySoundEvent")

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI oluşturma
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GlobalMusicGui"
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 140)
frame.Position = UDim2.new(0, 15, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = frame

local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "c00lteam"
titleLabel.Size = UDim2.new(1, 0, 0, 25)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.Parent = frame

local textBox = Instance.new("TextBox")
textBox.PlaceholderText = "Müzik kodunu gir..."
textBox.Size = UDim2.new(0, 230, 0, 35)
textBox.Position = UDim2.new(0, 10, 0, 45)
textBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.BorderSizePixel = 0
textBox.ClearTextOnFocus = false
textBox.Parent = frame

local playButton = Instance.new("TextButton")
playButton.Text = "▶️"
playButton.Size = UDim2.new(0, 60, 0, 35)
playButton.Position = UDim2.new(0, 250, 0, 45)
playButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
playButton.TextColor3 = Color3.fromRGB(255, 255, 255)
playButton.BorderSizePixel = 0
playButton.Parent = frame

local stopButton = Instance.new("TextButton")
stopButton.Text = "⏹ Tümünü Durdur"
stopButton.Size = UDim2.new(1, -20, 0, 40)
stopButton.Position = UDim2.new(0, 10, 0, 90)
stopButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stopButton.BorderSizePixel = 0
stopButton.Parent = frame

-- Tüm workspace'deki GlobalMusic seslerini tutar ve durdurur
local function stopAllSounds()
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Sound") and obj.Name == "GlobalMusic" then
            obj:Stop()
            obj:Destroy()
        end
    end
end

playButton.MouseButton1Click:Connect(function()
    local soundId = textBox.Text
    if soundId and soundId ~= "" then
        playSoundEvent:FireServer(soundId)
    end
end)

stopButton.MouseButton1Click:Connect(function()
    stopAllSounds()
end)
