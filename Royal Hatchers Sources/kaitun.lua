local Default_Config = {
    ["FarmMode"] = "Event",
    ["TeleportMethod"] = "Tween",
    ["Webhook"] = "",
    ["WebhookID"] = "",
    ["Merchant"] = true,
}

local function mergeConfig(default, user)
    if type(default) ~= "table" then return user end
    user = user or {}
    for k, v in pairs(default) do
        if type(v) == "table" then
            user[k] = mergeConfig(v, user[k])
        elseif user[k] == nil then
            user[k] = v
        end
    end
    return user
end

local Config = (getgenv and getgenv().Config) or _G.Config or {}
Config = mergeConfig(Default_Config, Config)

-- ==================== UILIB SETUP ====================

local success, content = pcall(game.HttpGet, game, "https://raw.githubusercontent.com/Paule1248/Open-Source/refs/heads/main/Utils/Lib%20New")
local UILib

if success then
    writefile("Hasty-Utils/UILib.lua", content)
    UILib = loadstring(content)()
    print("[Hasty] UILib updated from GitHub")
elseif isfile("Hasty-Utils/UILib.lua") then
    UILib = loadstring(readfile("Hasty-Utils/UILib.lua"))()
    print("[Hasty] UILib loaded from Cache")
else
    game.Players.LocalPlayer:Kick("Fatal Error: UILib not found and no internet.")
    return
end

local success2, content2 = pcall(game.HttpGet, game, "https://raw.githubusercontent.com/Paule1248/Open-Source/refs/heads/main/Utils/Utils")
local Utils

if success2 then
    writefile("Hasty-Utils/Utils.lua", content2)
    Utils = loadstring(content2)()
    print("[Hasty] Utils updated from GitHub")
elseif isfile("Hasty-Utils/Utils.lua") then
    Utils = loadstring(readfile("Hasty-Utils/Utils.lua"))()
    print("[Hasty] Utils loaded from Cache")
else
    game.Players.LocalPlayer:Kick("Fatal Error: Utils not found and no internet.")
    return
end

-- ==================== UI ERSTELLEN ====================

local UI = UILib:CreateWindow("Royal Hatchers (.gg/8ywgJqucQK)")

local StartTime        = os.time()
local StartEggsHatched = game:GetService("Players").LocalPlayer.leaderstats.Eggs.Value

-- Stats
local SessionEggsStat = UI:AddStat("Session Eggs", "0")
local UptimeLabel     = UI:AddStat("Uptime",        "00:00:00")
local StatusLabel     = UI:AddStat("Status",        "Idle")
UI:AddSeperator()
local GemStat         = UI:AddStat("Gems",          "0")
local HatchSpeedStat  = UI:AddStat("Hatch Speed",   "--")

-- ==================== CORE SERVICES ====================

local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser       = game:GetService("VirtualUser")
local Lighting          = game:GetService("Lighting")
local SoundService      = game:GetService("SoundService")
local RunService        = game:GetService("RunService")
local TweenService      = game:GetService("TweenService")

local Libraries    = ReplicatedStorage:WaitForChild("Libraries")
local MerchantData = require(Libraries:WaitForChild("MerchantData"))
local ItemData     = require(Libraries:WaitForChild("ItemData"))
local EggData      = require(Libraries:WaitForChild("EggData"))
local PetData      = require(ReplicatedStorage.Libraries.PetData)

local player          = Players.LocalPlayer
local eggsFolder      = workspace:FindFirstChild("_").Eggs
eggsFolder.Parent     = player
local UpgradesFolder  = workspace:FindFirstChild("_").Upgrades
UpgradesFolder.Parent = player
local Islands = require(player.PlayerScripts.Modules.Islands)

local MERCHANT_POS   = Vector3.new(1011, 100, 549)
local EventMerchant  = Vector3.new(-935, 31, -158)
local BestIslandData = {"MysticalForest", CFrame.new(307, 459, 1510)}

local IndexedPets  = {}
local BestEggIndex = {}
local BannedEggs   = {"Valentines Egg","Exclusive Pets","100K Egg","Release Egg","Lovely Egg","500K Egg","Season 1 Egg"}

local LastHatchTime = tick()

local Click          = ReplicatedStorage.Remotes.Functions.Click
local UpdateIndex    = ReplicatedStorage.Remotes.Events.UpdateIndex
local ClaimAllSeason = ReplicatedStorage.Remotes.Functions.ClaimAllSeason
local RestartPass    = ReplicatedStorage.Remotes.Functions.RestartPass

-- SafePart
local SafePart = Instance.new("Part", workspace)
SafePart.Size = Vector3.new(100,1,100)
SafePart.Anchored = true
SafePart.CanCollide = true
SafePart.Name = "SafePart"
local decal = Instance.new("Decal")
decal.Texture = "rbxassetid://94472596251951"
decal.Face = Enum.NormalId.Top
decal.Parent = SafePart

Lighting.Brightness = 0
Lighting.GlobalShadows = false
Lighting.FogEnd = math.huge
Lighting.ClockTime = 0
Lighting.Ambient = Color3.new(1,1,1)
Lighting.OutdoorAmbient = Color3.new(1,1,1)
Lighting.ShadowSoftness = 0
SoundService.RespectFilteringEnabled = true
SoundService:SetListener(Enum.ListenerType.Camera)
SoundService.AmbientReverb = Enum.ReverbType.NoReverb
settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
pcall(function()
    RunService:UnbindFromRenderStep("Humanoid")
    RunService:UnbindFromRenderStep("Animation")
end)

local areaNames = {"Spawn","Autumn","Frost","Jungle","New Areas","New New Areas","Other","Union","Icosphere.001","Cylinder.003","Maps"}
for _, name in ipairs(areaNames) do
    local area = workspace:FindFirstChild(name)
    if area and area:IsA("Model") then area:Destroy() end
end
for _, child in ipairs(workspace:GetChildren()) do
    if child:IsA("Model") and not table.find(areaNames, child.Name) then child:Destroy() end
end
local objectNames = {"BountyBoards","Debris","EggDecor","ItemDropsDebris","Leaderboards","Pets","Walkups","Portals"}
local underscoreFolder = workspace:FindFirstChild("_")
if underscoreFolder then
    for _, name in ipairs(objectNames) do
        local obj = underscoreFolder:FindFirstChild(name)
        if obj then obj:Destroy() end
    end
end

local function GetEggFromPet(petName)
    for eggName, data in pairs(EggData) do
        for petInEgg in pairs(data.Chances) do
            if petInEgg == petName then return eggName end
        end
    end
    return "Unknown"
end

local function HasIsland(Name)
    local islands = debug.getupvalue(Islands.updatePortal, 1)
    for islandName, unlocked in pairs(islands) do
        if unlocked == true and islandName == Name then return true end
    end
    return false
end

local function TableCount(tbl)
    local count = 0
    for _ in pairs(tbl) do count += 1 end
    return count
end

local function getHRP()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end

local function rotateRandomly()
    local hrp = getHRP()
    hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(math.random(0, 360)), 0)
end

local function teleport(target)
    task.wait(0.1)
    local hrp = getHRP()
    if not hrp then return end
    local targetPos = typeof(target) == "CFrame" and target.Position or target
    local distance  = (targetPos - hrp.Position).Magnitude
    if distance < 10 then return end
    SafePart.Position = hrp.Position - Vector3.new(0,3,0)
    if Config.TeleportMethod == "Tween" then
        local tweenInfo = TweenInfo.new(distance / 20, Enum.EasingStyle.Linear)
        local t1 = TweenService:Create(hrp,       tweenInfo, {CFrame = CFrame.new(targetPos)})
        local t2 = TweenService:Create(SafePart,  tweenInfo, {CFrame = CFrame.new(targetPos - Vector3.new(0,3,0))})
        t1:Play(); t2:Play()
        t1.Completed:Wait()
        rotateRandomly()
    end
end

local clickEvents = {"MouseButton1Click","MouseButton2Click","Activated","MouseButton1Down"}

-- ==================== CURRENCY HELPERS ====================

local function getPlayerCurrency(currencyName)
    local ls = player:FindFirstChild("leaderstats")
    if not ls then return 0 end
    local stat = ls:FindFirstChild(currencyName)
    return stat and stat.Value or 0
end

local function getItemCost(itemFrame)
    local currencyAttr = "Gems"

    local priceLabel = itemFrame:FindFirstChild("Buy").Frame.TextLabel


    if priceLabel then
        if priceLabel:IsA("TextLabel") then
            local text = priceLabel.Text or ""
            local numStr = text:gsub("[^%d,]", ""):gsub(",", "")
            local price = tonumber(numStr)
            local currency = "Gems"
            if text:lower():find("coin") then currency = "Coins" end
            if price then
                return { price = price, currency = currency }
            end
        end
    end

    local costAttr = itemFrame:GetAttribute("Cost")
    if costAttr and type(costAttr) == "number" then
        return { price = costAttr, currency = currencyAttr }
    end

    return nil
end

local function canAfford(itemFrame)
    local cost = getItemCost(itemFrame)
    if not cost then return false, "Preis nicht lesbar" end
    local balance = getPlayerCurrency(cost.currency)
    if balance < cost.price then
        return false, string.format("Zu wenig %s (%d/%d)", cost.currency, balance, cost.price)
    end
    return true
end

local function buyFromMerchant()
    if not Config["Merchant"] then return end
    for merchantID, data in pairs(MerchantData) do
        if data.IslandRequired and not HasIsland(data.IslandRequired) then
            continue
        end

        local gui = player.PlayerGui.GUI:FindFirstChild(data.FrameDisplayName or "")

        if gui and gui:FindFirstChild("InventoryScroll") then
            
            local hasStock = true
            local tpCalled = false
            
            while hasStock do
                hasStock = false
                local items = gui.InventoryScroll:GetChildren()


                for _, itemFrame in pairs(items) do
                    if itemFrame:IsA("Frame") then
                        local stock = itemFrame:GetAttribute("Stock") or 0
                        
                        if stock > 0 and canAfford(itemFrame) then
                            hasStock = true
                            break
                        end
                    end
                end


                if hasStock then
                    if not tpCalled then
                        if merchantID == "1MMerchant" then
                            pcall(function()
                                ReplicatedStorage.Remotes.Functions.TeleportIsland:InvokeServer("1MEvent", "TelportTo")
                            end)
                        else
                            pcall(function()
                                ReplicatedStorage.Remotes.Functions.TeleportIsland:InvokeServer("Forest", "TelportTo")
                            end)
                        end 
                        local hrp = getHRP()
                        SafePart.Position = hrp.Position - Vector3.new(0,3,0)
                        task.wait(0.5)
                        tpCalled = true
                    end

                    if merchantID == "1MMerchant" then
                        teleport(EventMerchant)
                        task.wait()
                    else
                        teleport(MERCHANT_POS)
                        task.wait()
                    end

                    for _, itemFrame in pairs(gui.InventoryScroll:GetChildren()) do
                        if itemFrame:IsA("Frame") then
                            local stock = itemFrame:GetAttribute("Stock") or 0

                            if stock > 0 then
                                local buyBtn = itemFrame:FindFirstChild("Buy")
                                if buyBtn then
                                    for i = 1, stock do

                                        for _, eventName in pairs(clickEvents) do
                                            local event = buyBtn:FindFirstChild(eventName) or buyBtn[eventName]
                                            if event then

                                                for _, conn in pairs(getconnections(event)) do
                                                    conn:Fire()
                                                    task.wait()
                                                end
                                            end
                                        end
                                        task.wait()
                                    end
                                end
                            end
                        end
                    end
                end
            end
            
            if tpCalled then
                pcall(function()
                    ReplicatedStorage.Remotes.Functions.TeleportIsland:InvokeServer("Forest", "TeleportBack")
                end)
                task.wait(0.5)
            end
        end
    end

    return
end

local function GetNearestEggModelByName(eggName)
    local hrp = getHRP()
    if not hrp then return nil end
    local nearestEgg, nearestPrimary
    local shortestDistance = math.huge
    for _, egg in ipairs(eggsFolder:GetChildren()) do
        if egg:IsA("Model") and egg.Name == eggName then
            local primaryPart = egg.PrimaryPart or egg:FindFirstChildWhichIsA("BasePart")
            if primaryPart then
                local distance = (primaryPart.Position - hrp.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestEgg       = egg
                    nearestPrimary   = primaryPart
                end
            end
        end
    end
    return nearestEgg, nearestPrimary
end

local function getNearestMysticalEgg()
    local nearestEgg, shortestDistance = nil, math.huge
    for _, egg in pairs(eggsFolder:GetChildren()) do
        if egg.Name == "Mystical Egg" and egg:IsA("Model") then
            local pp = egg.PrimaryPart or egg:FindFirstChildWhichIsA("BasePart")
            if pp then
                local d = (pp.Position - getHRP().Position).Magnitude
                if d < shortestDistance and d < 40 then shortestDistance = d; nearestEgg = egg end
            end
        end
    end
    if not nearestEgg then
        for _, egg in pairs(eggsFolder:GetChildren()) do
            if egg:IsA("Model") then
                local pp = egg.PrimaryPart or egg:FindFirstChildWhichIsA("BasePart")
                if pp then
                    local d = (pp.Position - getHRP().Position).Magnitude
                    if d < shortestDistance and d < 40 then shortestDistance = d; nearestEgg = egg end
                end
            end
        end
    end
    return nearestEgg
end

-- ==================== WEBHOOK ====================

local function SendMessageWithEmbedAndPing(embed)
    local data = {
        ["content"] = "<@" .. Config.WebhookID .. ">",
        ["embeds"] = {{
            ["title"]       = embed.title,
            ["description"] = embed.description,
            ["color"]       = embed.color,
            ["fields"]      = embed.fields,
            ["footer"]      = {["text"] = embed.footer.text},
        }},
    }
    pcall(function()
        request({
            Url     = Config.Webhook,
            Method  = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body    = game:GetService("HttpService"):JSONEncode(data),
        })
    end)
end

local function HatchEgg(Model)
    if not Model then return end
    task.spawn(function()
        local success = ReplicatedStorage.Remotes.Functions.BuyEgg:InvokeServer(Model, 100)
        if success then
            local Eggs, Pets = success[1], success[2]
            for _, pet in ipairs(Pets) do
                local petName = pet[1]
                local petType = pet[2]
                local petInfo = PetData[petName]
                if petInfo and (petInfo.Rarity == "Secret" or petInfo.Rarity == "Royal") and Config.Webhook ~= "" then
                    local embed = {
                        title       = (petInfo.Rarity == "Royal" and "🔥 ROYAL PET HATCHED!" or "💎 SECRET PET HATCHED!"),
                        description = "You just hatched a **" .. petName .. "** (" .. petType .. ")",
                        color       = petInfo.Rarity == "Royal" and 16776960 or 16711935,
                        fields      = {
                            {name = "👤 Player",        value = player.Name, inline = true},
                            {name = "📦 Hatch Session", value = tostring(player.leaderstats.Eggs.Value - StartEggsHatched) .. " hatched", inline = true},
                        },
                        footer    = {text = "Royal Hatchers (https://discord.gg/8ywgJqucQK)"},
                        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
                    }
                    SendMessageWithEmbedAndPing(embed)
                end
            end
            task.spawn(function()
                local timeDiff = tick() - LastHatchTime
                HatchSpeedStat:Update(string.format("%.2f", timeDiff) .. "s")
            end)
            LastHatchTime = tick()
        end
    end)
end

-- ==================== INDEX UPDATE ====================

UpdateIndex.OnClientEvent:Connect(function(data)
    local found = false
    IndexedPets = {}
    for type, pets in pairs(data) do
        for _, petName in ipairs(pets) do
            IndexedPets[type .. " " .. petName] = true
        end
    end
    local unknownCount = {}
    for petName, pdata in pairs(PetData) do
        if (not IndexedPets["Normal " .. petName] or not IndexedPets["Shiny " .. petName])
            and pdata.Rarity ~= "Royal" and pdata.Rarity ~= "Secret" then
            local egg = GetEggFromPet(petName)
            if egg ~= "Unknown" and not table.find(BannedEggs, egg) then
                unknownCount[egg] = (unknownCount[egg] or 0) + 1
            end
        end
    end
    local maxCount = 0
    for _, count in pairs(unknownCount) do if count > maxCount then maxCount = count end end
    for egg, count in pairs(unknownCount) do
        if count == maxCount then BestEggIndex = egg; found = true end
    end
    if not found then BestEggIndex = "Mystical Egg" end
end)

-- ==================== ANTI-AFK ====================

task.spawn(function()
    local GC = getconnections or get_signal_cons
    if GC then
        for _, v in pairs(GC(player.Idled)) do
            if v.Disable then v:Disable() elseif v.Disconnect then v:Disconnect() end
        end
    end
    player.Idled:Connect(function() VirtualUser:CaptureController(); VirtualUser:ClickButton2(Vector2.new()) end)
    while task.wait(120) do VirtualUser:CaptureController(); VirtualUser:ClickButton2(Vector2.new()) end
end)


task.spawn(function()
    while true do
        local elapsed    = os.time() - StartTime
        local eggsHatched = player.leaderstats.Eggs.Value - StartEggsHatched
        UptimeLabel:Update(Utils:FormatTime(elapsed))
        SessionEggsStat:Update(Utils:FormatNumber(eggsHatched))
        GemStat:Update(Utils:FormatNumber(player.leaderstats.Gems.Value))
        Click:InvokeServer(nil)
        task.wait()
    end
end)

task.spawn(function()
    while task.wait() do
        task.spawn(function() Click:InvokeServer(nil) end)
        task.wait()
        ClaimAllSeason:InvokeServer()
        RestartPass:InvokeServer()
    end
end)


task.spawn(function()
    while true do
        task.wait()

        if Config.FarmMode == "Best" then
            buyFromMerchant()
            if (getHRP().Position - BestIslandData[2].Position).Magnitude >= 35 then
                pcall(function() ReplicatedStorage.Remotes.Functions.TeleportIsland:InvokeServer(BestIslandData[1], "TelportTo") end)
                local hrp = getHRP()
                SafePart.Position = hrp.Position - Vector3.new(0,3,0)
                task.wait(0.5)
                teleport(CFrame.new(307, 430, 1510) * CFrame.new(math.random(-5,5), math.random(-5,5), math.random(-5,5)))
                task.wait(0.5)
            end
            HatchEgg(getNearestMysticalEgg())

        elseif Config.FarmMode == "Index" then
            teleport(Vector3.new(-26, -24, 122))
            repeat
                teleport(Vector3.new(-26, -24, 122))
                task.wait(0.2)
                local nearestEgg = GetNearestEggModelByName("Common Egg")
                if nearestEgg then ReplicatedStorage.Remotes.Functions.BuyEgg:InvokeServer(nearestEgg, 100) end
            until TableCount(IndexedPets) > 0
            buyFromMerchant()
            task.wait()
            local nearestEgg, primaryPart = GetNearestEggModelByName(BestEggIndex)
            if nearestEgg then
                teleport(primaryPart.Position)
                ReplicatedStorage.Remotes.Functions.BuyEgg:InvokeServer(nearestEgg, 100)
            end

        elseif Config.FarmMode == "Event" then
            local function teleportToEvent()
                pcall(function() ReplicatedStorage.Remotes.Functions.TeleportIsland:InvokeServer("1MEvent", "TelportTo") end)
            end

            local position = Vector3.new(-873.42, 37.18, -135.11)
            local hrp = getHRP()
            if not hrp then task.wait(); continue end

            buyFromMerchant()

            if (hrp.Position - position).Magnitude > 20 then
                teleportToEvent()
                task.wait(0.2)
                hrp = getHRP()
                if hrp then SafePart.Position = hrp.Position - Vector3.new(0,3,0) end
                task.wait(0.2)
            end

            local randomLook = Vector3.new(math.random(-100,100)/100, 0, math.random(-100,100)/100).Unit
            teleport(CFrame.new(position, position + randomLook))

            local egg = GetNearestEggModelByName("1M Egg")
            if egg then HatchEgg(egg) end
        end
    end
end)
