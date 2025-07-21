local ReplicatedStorage = game:GetService("ReplicatedStorage")

local playSoundEvent = ReplicatedStorage:FindFirstChild("PlaySoundEvent")
if not playSoundEvent then
    playSoundEvent = Instance.new("RemoteEvent")
    playSoundEvent.Name = "PlaySoundEvent"
    playSoundEvent.Parent = ReplicatedStorage
end

playSoundEvent.OnServerEvent:Connect(function(player, soundId)
    if not soundId or soundId == "" then
        return -- boşsa hiçbir şey yapma
    end

    -- Yeni ses objesi yarat
    local sound = Instance.new("Sound")
    sound.Name = "GlobalMusic"
    sound.SoundId = "rbxassetid://" .. soundId
    sound.Volume = 1
    sound.Looped = false -- ardarda çalabilmesi için loop yok
    sound.Parent = workspace
    sound:Play()

    -- Ses bitince yok et
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end)
