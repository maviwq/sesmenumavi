local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local flying = false
local flySpeed = 50

local bv

function Fly()
    if flying then return end
    flying = true

    bv = Instance.new("BodyVelocity")
    bv.Velocity = Vector3.new(0,0,0)
    bv.MaxForce = Vector3.new(0, math.huge, 0) + Vector3.new(math.huge,0, math.huge)
    bv.Parent = humanoidRootPart

    local userInputService = game:GetService("UserInputService")
    local runService = game:GetService("RunService")

    local direction = Vector3.new()

    local function updateVelocity()
        direction = Vector3.new(0,0,0)
        if userInputService:IsKeyDown(Enum.KeyCode.W) then
            direction = direction + workspace.CurrentCamera.CFrame.LookVector
        end
        if userInputService:IsKeyDown(Enum.KeyCode.S) then
            direction = direction - workspace.CurrentCamera.CFrame.LookVector
        end
        if userInputService:IsKeyDown(Enum.KeyCode.A) then
            direction = direction - workspace.CurrentCamera.CFrame.RightVector
        end
        if userInputService:IsKeyDown(Enum.KeyCode.D) then
            direction = direction + workspace.CurrentCamera.CFrame.RightVector
        end
        direction = direction.Unit * flySpeed
        if direction.Magnitude == 0 then
            direction = Vector3.new(0,0,0)
        end
        bv.Velocity = Vector3.new(direction.X, 0, direction.Z) + Vector3.new(0, flySpeed/2, 0)
    end

    local conn
    conn = runService.Heartbeat:Connect(function()
        if flying then
            updateVelocity()
        else
            conn:Disconnect()
            if bv then
                bv:Destroy()
                bv = nil
            end
        end
    end)
end

function Unfly()
    flying = false
    if bv then
        bv:Destroy()
        bv = nil
    end
end

-- Örnek buton bağlama:
-- Fly() çağırılırsa uçmaya başlar,
-- Unfly() çağırılırsa uçma durur.
