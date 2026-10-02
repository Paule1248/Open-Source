local script = game:GetService("Players").LocalPlayer.PlayerScripts.FishingClient
script.Disabled = true
local Event = game:GetService("ReplicatedStorage").Packages.Knit.Services.TeleportService.RE.GoTo
Event:FireServer(
    "TreasureDunes"
)
-- Script Path: game:GetService("Players").rasacata_alt.PlayerScripts.FishingClient
-- Took 0.62s to decompile.
-- Executor: Volt (1.3.15.1)
local ScreenGUI = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)

local Counter = Instance.new("TextLabel", ScreenGUI)
Counter.Size = UDim2.new(0.2, 0, 0.2,0)
Counter.Position = UDim2.new(0.5, 0, 0.5, 20)
Counter.BackgroundTransparency = 1
Counter.Text = "Test nega: 0"
Counter.TextSize = 50
Counter.TextColor3 = Color3.new(1, 1, 1)
Counter.ZIndex = math.huge

local v1

do
    local v2

    v1, v2 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("QuietLog")).For(warn, print)
end

local RunService, TweenService, UserInputService, SoundService, Debris, LocalPlayer, PlayerGui, FishingView, Fishing, FishingConfig, FishingWater, LoadingState, CameraPunch, PlayerSettings, ScreenFlash, FishingHud, FishingFX, FishingTooltip, v29, t1, PlayUI, FishingGui, Fishing2, Exit, CooldownBar, Name, ClickSpeedUp, t2, t3, t4, TweenGroup, uDim2, uDim2_2, uDim2_3, uDim2_4, t5, t6, FishingStreakColors, FishingTaps, clone, FishClick, Buy, StudsOffset, UIScale, u77, n1, u79, u80, u81, ShowBillboard, HideBillboard, HookBuyButton, u85, u86, n2, u88, n3, CATCH_TIME, n4, t8, u94, n5, ClearLoot, BuildLoot, PulseTile, UpdateBar, ClickSpeedUpSize, color3, color3_2, n8, u126, n9, u128, n10, t18, Heartbeat, CreateTimerRing, SetTimerRing, FadeTimerRing

do
    local Bar, BarSize, v47, UIGradientLOW, UIGradientHALF, UIGradientNORMAL

    do
        local Players = game:GetService("Players")
        local CollectionService, PlayerData, FishingLootInfo, v30

        do
            local Modules, FishingPose

            do
                local ReplicatedStorage = game:GetService("ReplicatedStorage")

                RunService = game:GetService("RunService")
                TweenService = game:GetService("TweenService")
                UserInputService = game:GetService("UserInputService")
                SoundService = game:GetService("SoundService")
                CollectionService = game:GetService("CollectionService")
                Debris = game:GetService("Debris")
                LocalPlayer = Players.LocalPlayer
                PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
                FishingView = PlayerGui:FindFirstChild("FishingView")

                if not FishingView then
                    FishingView = Instance.new("Folder")
                    FishingView.Name = "FishingView"
                    FishingView.Parent = PlayerGui
                end

                Fishing = ReplicatedStorage:WaitForChild("Fishing")
                FishingConfig = require(Fishing:WaitForChild("FishingConfig"))
                FishingWater = require(Fishing:WaitForChild("FishingWater"))
                Modules = ReplicatedStorage:WaitForChild("Modules")
                LoadingState = require(Modules:WaitForChild("LoadingState"))
                PlayerData = require(Modules:WaitForChild("PlayerData"))
                CameraPunch = require(Modules:WaitForChild("CameraPunch"))
                PlayerSettings = require(Modules:WaitForChild("PlayerSettings"))
                ScreenFlash = require(Modules:WaitForChild("ScreenFlash"))
                FishingHud = require(script:WaitForChild("FishingHud"))
                FishingFX = require(script:WaitForChild("FishingFX"))
                FishingPose = require(script:WaitForChild("FishingPose"))
                FishingTooltip = require(script:WaitForChild("FishingTooltip"))
                FishingLootInfo = require(script:WaitForChild("FishingLootInfo"))
                require(ReplicatedStorage.Packages.Knit).OnStart():await()
            end

            if require(Modules:WaitForChild("PlazaFeatures")).IsLockedHere() then
                return
            end

            local SafeGetService = require(Modules.SafeGetService)

            v29 = SafeGetService.Get("FishingService")
            v30 = SafeGetService.Get("EggHatchService")

            if not v29 then
                v1("[FishingClient] Brak FishingService - lowienie wylaczone.")

                return
            end

            FishingFX.Start()
            FishingPose.Start()
            task.spawn(FishingTooltip.Init)

            local function FindSound(p1) -- line: 89
                -- upvalues: SoundService (copy)
                local v177 = SoundService

                for _, v in ipairs(p1) do
                    v177 = v177 and v177:FindFirstChild(v)
                end

                return v177 and (not not v177:IsA("Sound") and v177) or nil
            end

            t1 = {
                Open = FindSound({
                    "Sounds",
                    "OpenGui"
                }),
                Click = FindSound({
                    "UI",
                    "NewClick"
                }),
                Hover = {
                    FindSound({
                        "UI",
                        "HoverVar1"
                    }),
                    FindSound({
                        "UI",
                        "HoverVar2"
                    }),
                    (FindSound({
                        "UI",
                        "HoverVar3"
                    }))
                },
                Tap = FindSound({
                    "Sounds",
                    "UpgradeinUI"
                }),
                TapSpawn = FindSound({
                    "Sounds",
                    "Pop"
                }),
                Miss = FindSound({
                    "OtherSound",
                    "NotiFail"
                }),
                Milestone = FindSound({
                    "Sounds",
                    "Bonus"
                }),
                Close = FindSound({
                    "OtherSound",
                    "UnEquip"
                })
            }
        end

        function PlayUI(p2, p3, p4) -- line: 108
            -- upvalues: SoundService (copy), Debris (copy)
            if typeof(p2) == "table" then
                p2 = p2[math.random(1, #p2)]
            end

            if not p2 then
                return
            end

            local clone2 = p2:Clone()

            if p3 then
                clone2.Volume = p3
            end

            clone2.PlaybackSpeed = p4 or 1
            clone2.Parent = SoundService
            clone2:Play()
            Debris:AddItem(clone2, 5)
        end

        require(script:WaitForChild("FishingSounds"))
        FishingGui = PlayerGui:WaitForChild("FishingGui")
        Fishing2 = FishingGui:WaitForChild("Fishing")

        local Pets = Fishing2:WaitForChild("Pets")
        local PetTemplate = Pets:WaitForChild("PetTemplate")
        local UIGridLayout = Pets:FindFirstChildOfClass("UIGridLayout")
        local Items = Fishing2:WaitForChild("Items")
        local ItemTempl = Items:WaitForChild("ItemTempl")

        Exit = Fishing2:WaitForChild("Exit")
        CooldownBar = Fishing2:WaitForChild("CooldownBar")
        Bar = CooldownBar:WaitForChild("Bar")
        Name = CooldownBar:WaitForChild("Name")
        ClickSpeedUp = Fishing2:WaitForChild("ClickSpeedUp")
        FishingGui.Enabled = true
        Fishing2.Visible = false
        PetTemplate.Visible = false
        ItemTempl.Visible = false
        ClickSpeedUp.Visible = false
        BarSize = Bar.Size
        v47 = math.max(0.1, 1 - 2 * Bar.Position.X.Scale)
        UIGradientLOW = Bar:FindFirstChild("UIGradientLOW")
        UIGradientHALF = Bar:FindFirstChild("UIGradientHALF")
        UIGradientNORMAL = Bar:FindFirstChild("UIGradientNORMAL")

        local v51 = UIGridLayout and UIGridLayout.CellSize

        t2 = {}
        t3 = {}
        t4 = {}

        for _, child in ipairs(Fishing2:GetChildren()) do
            if child:IsA("GuiObject") then
                if child == Pets or child.Name == "Info" or child.Name == "Tlo" then
                    t2[child] = child.Position
                elseif child == Items then
                    t3[child] = child.Position
                elseif child == Exit or child == CooldownBar then
                    t4[child] = child.Position
                end
            end
        end

        do
            local function SetGroup(p5, p6) -- line: 171
                for k, v in pairs(p5) do
                    k.Position = v + p6
                end
            end
        end

        function TweenGroup(p7, p8, p9) -- line: 177
            -- upvalues: TweenService (copy)
            for k, v in pairs(p7) do
                TweenService:Create(k, p9, {
                    Position = v + p8
                }):Play()
            end
        end

        uDim2 = UDim2.new()
        uDim2_2 = UDim2.fromScale(0, -0.3)
        uDim2_3 = UDim2.fromScale(-0.4, 0)
        uDim2_4 = UDim2.fromScale(0, 0.3)

        local t7, CenterAnchor, ApplyPetChance, BindDiscovered, ApplyItemChance

        do
            local colorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 190, 0)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 224)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 190, 0))
            })
            local colorSequence2 = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 55, 135)),
                ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 140, 0)),
                ColorSequenceKeypoint.new(0.66, Color3.fromRGB(255, 255, 150)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 55, 135))
            })
            local color3_3 = Color3.new(0, 0, 0)
            local color3_4 = Color3.new(1, 1, 1)

            t5 = {}
            t6 = {}
            FishingStreakColors = require(Fishing:WaitForChild("FishingStreakColors"))
            FishingTaps = require(Fishing:WaitForChild("FishingTaps"))
            clone = Fishing:WaitForChild("FishingPart"):Clone()
            clone.Name = "FishingPrompt"
            clone.Anchored = true
            clone.CanCollide = false
            clone.CanQuery = false
            clone.CanTouch = false
            clone.Transparency = 1
            FishClick = clone:WaitForChild("FishClick")
            Buy = FishClick:WaitForChild("Buy")

            do
                local FishClickSize = FishClick.Size

                StudsOffset = FishClick.StudsOffset
                FishClick.Enabled = false
                FishClick.Adornee = clone
                FishClick.Parent = FishingView
                clone.Parent = workspace.CurrentCamera
                UIScale = Instance.new("UIScale")
                UIScale.Parent = Buy
                u77 = false
                n1 = 0
                u79 = nil
                u80 = false
                u81 = false

                function ShowBillboard() -- line: 264
                    -- upvalues: u77 (ref), n1 (ref), u79 (ref), FishClick (ref), TweenService (copy), FishClickSize (copy)
                    if u77 then
                        return
                    end

                    u77 = true
                    n1 = os.clock()

                    if u79 then
                        u79:Cancel()
                    end

                    FishClick.Size = UDim2.new(0, 0, 0, 0)
                    FishClick.Enabled = true
                    u79 = TweenService:Create(FishClick, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Size = FishClickSize
                    })
                    u79:Play()
                end
                function HideBillboard() -- line: 275
                    -- upvalues: u77 (ref), u79 (ref), TweenService (copy), FishClick (ref)
                    if not u77 then
                        return
                    end

                    u77 = false

                    if u79 then
                        u79:Cancel()
                    end

                    u79 = TweenService:Create(FishClick, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        Size = UDim2.new(0, 0, 0, 0)
                    })
                    u79.Completed:Connect(function(p10) -- line: 280
                        -- upvalues: u77 (ref), FishClick (ref)
                        if p10 == Enum.PlaybackState.Completed and not u77 then
                            FishClick.Enabled = false
                        end
                    end)
                    u79:Play()
                end
                function HookBuyButton(p11) -- line: 288
                    -- upvalues: u80 (ref), PlayUI (copy), t1 (copy), u81 (ref)
                    p11.MouseEnter:Connect(function() -- line: 289
                        -- upvalues: u80 (ref), PlayUI (copy), t1 (copy)
                        u80 = true
                        PlayUI(t1.Hover, 0.4)
                    end)
                    p11.MouseLeave:Connect(function() -- line: 290
                        -- upvalues: u80 (ref), u81 (ref)
                        u80 = false
                        u81 = false
                    end)
                    p11.MouseButton1Down:Connect(function() -- line: 291
                        -- upvalues: u81 (ref)
                        u81 = true
                    end)
                    p11.MouseButton1Up:Connect(function() -- line: 292
                        -- upvalues: u81 (ref)
                        u81 = false
                    end)
                end

                HookBuyButton(Buy)
                u85 = false
                u86 = false
                n2 = 0
                u88 = nil
                n3 = 0
                CATCH_TIME = FishingConfig.CATCH_TIME
                n4 = 0
                t7 = {}
                t8 = {}
                u94 = nil
                n5 = 0

                local function GetCharacterParts() -- line: 309
                    -- upvalues: LocalPlayer (copy)
                    local Character = LocalPlayer.Character

                    return Character, Character and Character:FindFirstChild("HumanoidRootPart"), Character and Character:FindFirstChildOfClass("Humanoid")
                end
                local function Flat(p12) -- line: 316
                    return (Vector3.new(p12.X, 0, p12.Z))
                end
                local function ServerNow() -- line: 320
                    return workspace:GetServerTimeNow()
                end
                local function RandomRange(p13, p14) -- line: 324
                    return p13 + math.random() * (p14 - p13)
                end
            end

            local function GetScale(p15, p16) -- line: 328
                local v200 = p15:FindFirstChild(p16 or "FishingScale")

                if not v200 then
                    v200 = Instance.new("UIScale")
                    v200.Name = p16 or "FishingScale"
                    v200.Parent = p15
                end

                return v200
            end

            function CenterAnchor(p17) -- line: 343
                if not p17 or not p17:IsA("GuiObject") then
                    return
                end

                local p17AnchorPoint = p17.AnchorPoint

                if p17AnchorPoint.X == 0.5 and p17AnchorPoint.Y == 0.5 then
                    return
                end

                local p17Position = p17.Position
                local p17Size = p17.Size
                local v205 = 0.5 - p17AnchorPoint.X
                local v206 = 0.5 - p17AnchorPoint.Y

                p17.AnchorPoint = Vector2.new(0.5, 0.5)
                p17.Position = UDim2.new(p17Position.X.Scale + p17Size.X.Scale * v205, p17Position.X.Offset + p17Size.X.Offset * v205, p17Position.Y.Scale + p17Size.Y.Scale * v206, p17Position.Y.Offset + p17Size.Y.Offset * v206)
            end

            FishingGui:GetPropertyChangedSignal("Enabled"):Connect(function() -- line: 358
                -- upvalues: FishingGui (copy), u85 (ref), PlayerGui (copy)
                if FishingGui.Enabled or not u85 then
                    return
                end

                local UI = PlayerGui:FindFirstChild("UI")

                if not UI or not UI:IsA("ScreenGui") or UI.Enabled then
                    FishingGui.Enabled = true
                end
            end)

            local function FormatPercent(p18) -- line: 367
                if p18 >= 10 then
                    return string.format("%d%%", (math.floor(p18 + 0.5)))
                end

                local n6 = 2

                if p18 > 0 and p18 < 1 then
                    n6 = math.clamp(-math.floor((math.log10(p18))) + 1, 2, 6)
                end

                return (p18 >= 1 and string.format("%.1f", p18) or string.format("%." .. n6 .. "f", p18)):gsub("0+$", ""):gsub("%.$", "") .. "%"
            end
            local function GetAutoDeleteEntry(p19) -- line: 383
                -- upvalues: PlayerData (copy), LocalPlayer (copy)
                local v211 = PlayerData.Folder(LocalPlayer, "AutoDelete")
                local v212 = v211 and v211:FindFirstChild(p19)

                if v212 and v212:IsA("BoolValue") then
                    return v212
                end

                return nil
            end

            function ClearLoot() -- line: 390
                -- upvalues: t7 (copy), t8 (copy), t5 (copy), u94 (ref), FishingTooltip (copy), Pets (copy), Items (copy)
                for _, v in ipairs(t7) do
                    v:Disconnect()
                end

                table.clear(t7)
                table.clear(t8)
                table.clear(t5)
                u94 = nil
                FishingTooltip.Hide()

                for _, v in ipairs({
                    Pets,
                    Items
                }) do
                    for _, child in ipairs(v:GetChildren()) do
                        if child:GetAttribute("FishingLoot") then
                            child:Destroy()
                        end
                    end
                end
            end

            local function AddSweepGradient(p20, p21) -- line: 405
                -- upvalues: t5 (copy)
                local UIGradient = Instance.new("UIGradient")

                UIGradient.Name = "RareGradient"
                UIGradient.Color = p21
                UIGradient.Rotation = 45
                UIGradient.Parent = p20
                table.insert(t5, UIGradient)
            end

            function ApplyPetChance(p22, p23, p24, p25) -- line: 418
                -- upvalues: t5 (copy), colorSequence2 (copy), colorSequence (copy), FormatPercent (copy)
                if not p22 then
                    return
                end

                if p25 then
                    p22.Text = "???"

                    local colorSequence3 = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(128, 52, 232)),
                        ColorSequenceKeypoint.new(0.38, Color3.fromRGB(163, 92, 255)),
                        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(226, 200, 255)),
                        ColorSequenceKeypoint.new(0.62, Color3.fromRGB(163, 92, 255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 52, 232))
                    })
                    local UIGradient = Instance.new("UIGradient")

                    UIGradient.Name = "RareGradient"
                    UIGradient.Color = colorSequence3
                    UIGradient.Rotation = 45
                    UIGradient.Parent = p22
                    table.insert(t5, UIGradient)

                    return
                end

                if p24 == "Mythical" then
                    p22.Text = "???"

                    local v228 = colorSequence2
                    local UIGradient = Instance.new("UIGradient")

                    UIGradient.Name = "RareGradient"
                    UIGradient.Color = v228
                    UIGradient.Rotation = 45
                    UIGradient.Parent = p22
                    table.insert(t5, UIGradient)

                    return
                end

                if p23 < 0.001 then
                    p22.Text = "???"

                    local v230 = colorSequence
                    local UIGradient = Instance.new("UIGradient")

                    UIGradient.Name = "RareGradient"
                    UIGradient.Color = v230
                    UIGradient.Rotation = 45
                    UIGradient.Parent = p22
                    table.insert(t5, UIGradient)

                    return
                end

                p22.Text = FormatPercent(p23 * 100)

                if p24 == "Legendary" then
                    local v232 = colorSequence
                    local UIGradient = Instance.new("UIGradient")

                    UIGradient.Name = "RareGradient"
                    UIGradient.Color = v232
                    UIGradient.Rotation = 45
                    UIGradient.Parent = p22
                    table.insert(t5, UIGradient)
                end
            end

            local function IsPetDiscovered(p26) -- line: 456
                -- upvalues: PlayerData (copy), LocalPlayer (copy)
                local v235 = PlayerData.Folder(LocalPlayer, "IndexData")
                local v236 = v235 and v235:FindFirstChild(p26)

                return v236 ~= nil and (v236:IsA("BoolValue") and v236.Value == true)
            end

            function BindDiscovered(p27, p28, p29, p30) -- line: 464
                -- upvalues: PlayerData (copy), LocalPlayer (copy), color3_4 (copy), color3_3 (copy), t7 (copy)
                local NotOwn = p28:FindFirstChild("NotOwn")

                if not NotOwn then
                    NotOwn = Instance.new("ImageLabel")
                    NotOwn.Name = "NotOwn"
                    NotOwn.BackgroundTransparency = 1
                    NotOwn.Image = "rbxassetid://101993294561640"
                    NotOwn.AnchorPoint = Vector2.new(0.5, 0.5)
                    NotOwn.Position = UDim2.fromScale(0.52, 0.57)
                    NotOwn.Size = UDim2.fromScale(0.484, 0.535)
                    NotOwn.ScaleType = Enum.ScaleType.Fit
                    NotOwn.ZIndex = p29.ZIndex + 1
                    NotOwn.Parent = p28
                end

                local function Apply() -- line: 479
                    -- upvalues: p27 (copy), PlayerData (copy), LocalPlayer (copy), p29 (copy), color3_4 (copy), color3_3 (copy), NotOwn (ref), p30 (copy)
                    local v707 = p27
                    local v708 = PlayerData.Folder(LocalPlayer, "IndexData")
                    local v709 = v708 and v708:FindFirstChild(v707)
                    local v710 = v709 ~= nil and (v709:IsA("BoolValue") and v709.Value == true)

                    p29.ImageColor3 = v710 and color3_4 or color3_3
                    NotOwn.Visible = not v710

                    if p30 then
                        p30:SetAttribute("HoverHidden", not v710)
                    end
                end

                local v243 = PlayerData.Folder(LocalPlayer, "IndexData")
                local v244 = v243 and v243:FindFirstChild(p27)
                local v245 = v244 ~= nil and (v244:IsA("BoolValue") and v244.Value == true)

                p29.ImageColor3 = v245 and color3_4 or color3_3
                NotOwn.Visible = not v245

                if p30 then
                    p30:SetAttribute("HoverHidden", not v245)
                end

                local t9 = {}

                local function Hook(p31) -- line: 488
                    -- upvalues: t9 (copy), t7 (copy), Apply (copy)
                    if t9[p31] then
                        return
                    end

                    t9[p31] = true
                    table.insert(t7, p31.Changed:Connect(Apply))
                end

                local v248 = PlayerData.Folder(LocalPlayer, "IndexData")

                if v248 then
                    local p27_2 = v248:FindFirstChild(p27)

                    if p27_2 and p27_2:IsA("BoolValue") and not t9[p27_2] then
                        t9[p27_2] = true
                        table.insert(t7, p27_2.Changed:Connect(Apply))
                    end

                    table.insert(t7, v248.ChildAdded:Connect(function(child) -- line: 497
                        -- upvalues: p27 (copy), t9 (copy), t7 (copy), Apply (copy), PlayerData (copy), LocalPlayer (copy), p29 (copy), color3_4 (copy), color3_3 (copy), NotOwn (ref), p30 (copy)
                        if child.Name == p27 and child:IsA("BoolValue") then
                            if not t9[child] then
                                t9[child] = true
                                table.insert(t7, child.Changed:Connect(Apply))
                            end

                            local v713 = p27
                            local v714 = PlayerData.Folder(LocalPlayer, "IndexData")
                            local v715 = v714 and v714:FindFirstChild(v713)
                            local v716 = v715 ~= nil and (v715:IsA("BoolValue") and v715.Value == true)

                            p29.ImageColor3 = v716 and color3_4 or color3_3
                            NotOwn.Visible = not v716

                            if p30 then
                                p30:SetAttribute("HoverHidden", not v716)
                            end
                        end
                    end))
                end
            end
            function ApplyItemChance(p32, p33, p34) -- line: 509
                -- upvalues: colorSequence2 (copy), colorSequence (copy), t5 (copy), FormatPercent (copy)
                if not p32 then
                    return
                end

                local v253 = p34 == "Mythical"

                if p33 < 0.001 then
                    p32.Text = "???"

                    local v254 = v253 and colorSequence2 or colorSequence
                    local UIGradient = Instance.new("UIGradient")

                    UIGradient.Name = "RareGradient"
                    UIGradient.Color = v254
                    UIGradient.Rotation = 45
                    UIGradient.Parent = p32
                    table.insert(t5, UIGradient)

                    return
                end

                p32.Text = FormatPercent(p33 * 100)

                if v253 then
                    local v256 = colorSequence2
                    local UIGradient = Instance.new("UIGradient")

                    UIGradient.Name = "RareGradient"
                    UIGradient.Color = v256
                    UIGradient.Rotation = 45
                    UIGradient.Parent = p32
                    table.insert(t5, UIGradient)

                    return
                end

                if p33 < 0.005 then
                    local v258 = colorSequence
                    local UIGradient = Instance.new("UIGradient")

                    UIGradient.Name = "RareGradient"
                    UIGradient.Color = v258
                    UIGradient.Rotation = 45
                    UIGradient.Parent = p32
                    table.insert(t5, UIGradient)
                end
            end
        end

        local function BindAutoDelete(p35, p36) -- line: 527
            -- upvalues: TweenService (copy), t7 (copy), PlayerData (copy), LocalPlayer (copy)
            local u262 = nil

            local function Apply(p37) -- line: 530
                -- upvalues: u262 (ref), p36 (copy), TweenService (copy)
                local v718 = u262 ~= nil and u262.Value == true

                if v718 == p36.Visible and not p37 then
                    return
                end

                p36.Visible = v718

                if v718 and p37 then
                    local v719 = p36
                    local FishingScale = v719:FindFirstChild("FishingScale")

                    if not FishingScale then
                        FishingScale = Instance.new("UIScale")
                        FishingScale.Name = "FishingScale"
                        FishingScale.Parent = v719
                    end

                    FishingScale.Scale = 0
                    TweenService:Create(FishingScale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Scale = 1
                    }):Play()
                end
            end
            local function Hook(p38) -- line: 541
                -- upvalues: u262 (ref), Apply (copy), t7 (copy)
                if p38 == u262 then
                    return
                end

                u262 = p38
                Apply(true)
                table.insert(t7, p38.Changed:Connect(function() -- line: 545
                    -- upvalues: u262 (ref), p38 (copy), Apply (copy)
                    if u262 == p38 then
                        Apply(true)
                    end
                end))
            end

            p36.Visible = false

            local v265 = PlayerData.Folder(LocalPlayer, "AutoDelete")
            local v266 = v265 and v265:FindFirstChild(p35)
            local v267 = if not v266 or not v266:IsA("BoolValue") then nil else v266

            if v267 then
                u262 = v267
                Apply(false)
                table.insert(t7, v267.Changed:Connect(function() -- line: 555
                    -- upvalues: u262 (ref), v267 (copy), Apply (copy)
                    if u262 == v267 then
                        Apply(true)
                    end
                end))
            end

            local v268 = PlayerData.Folder(LocalPlayer, "AutoDelete")

            if v268 then
                table.insert(t7, v268.ChildAdded:Connect(function(child) -- line: 562
                    -- upvalues: p35 (copy), u262 (ref), Apply (copy), t7 (copy)
                    if child.Name == p35 and child:IsA("BoolValue") then
                        if child == u262 then
                            return
                        end

                        u262 = child
                        Apply(true)
                        table.insert(t7, child.Changed:Connect(function() -- line: 545
                            -- upvalues: u262 (ref), child (copy), Apply (copy)
                            if u262 == child then
                                Apply(true)
                            end
                        end))
                    end
                end))
            end
        end

        local tweenInfo = TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local tweenInfo2 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

        local function HookTileHover(p39, p40) -- line: 572
            -- upvalues: CenterAnchor (copy), TweenService (copy), t7 (copy), u94 (ref), PlayUI (copy), t1 (copy), tweenInfo (copy), tweenInfo2 (copy)
            CenterAnchor(p40)

            local HoverScale = p40:FindFirstChild("HoverScale")

            if not HoverScale then
                HoverScale = Instance.new("UIScale")
                HoverScale.Name = "HoverScale"
                HoverScale.Parent = p40
            end

            local v272 = HoverScale
            local tween = nil

            local function TweenTo(p41, p42) -- line: 576
                -- upvalues: tween (ref), TweenService (copy), v272 (copy)
                if tween then
                    tween:Cancel()
                end

                tween = TweenService:Create(v272, p42, {
                    Scale = p41
                })
                tween:Play()
            end

            table.insert(t7, p40.MouseEnter:Connect(function() -- line: 581
                -- upvalues: u94 (ref), p39 (copy), PlayUI (copy), t1 (copy), tweenInfo (copy), tween (ref), TweenService (copy), v272 (copy)
                u94 = p39
                PlayUI(t1.Hover, 0.35)

                local v725 = tweenInfo

                if tween then
                    tween:Cancel()
                end

                tween = TweenService:Create(v272, v725, {
                    Scale = 1.1
                })
                tween:Play()
            end))
            table.insert(t7, p40.MouseLeave:Connect(function() -- line: 586
                -- upvalues: u94 (ref), p39 (copy), tweenInfo2 (copy), tween (ref), TweenService (copy), v272 (copy)
                if u94 == p39 then
                    u94 = nil
                end

                local v726 = tweenInfo2

                if tween then
                    tween:Cancel()
                end

                tween = TweenService:Create(v272, v726, {
                    Scale = 1
                })
                tween:Play()
            end))

            return v272
        end
        local function PopIn(p43, p44) -- line: 593
            -- upvalues: CenterAnchor (copy), TweenService (copy)
            CenterAnchor(p43)

            local PopScale = p43:FindFirstChild("PopScale")

            if not PopScale then
                PopScale = Instance.new("UIScale")
                PopScale.Name = "PopScale"
                PopScale.Parent = p43
            end

            local v278 = PopScale

            v278.Scale = 0
            task.delay(p44, function() -- line: 597
                -- upvalues: p43 (copy), TweenService (copy), v278 (copy)
                if p43.Parent then
                    TweenService:Create(v278, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Scale = 1
                    }):Play()
                end
            end)
        end
        local function StripScripts(p45) -- line: 604
            for _, descendant in ipairs(p45:GetDescendants()) do
                if descendant:IsA("LuaSourceContainer") then
                    descendant:Destroy()
                end
            end
        end
        local function CreatePetTile(p46, p47, p48) -- line: 610
            -- upvalues: FishingLootInfo (copy), PetTemplate (copy), StripScripts (copy), CollectionService (copy), t8 (copy), BindDiscovered (copy), HookTileHover (copy), BindAutoDelete (copy), t7 (copy), PlayUI (copy), t1 (copy), TweenService (copy), u94 (ref), v30 (copy), ApplyPetChance (copy), Pets (copy), CenterAnchor (copy)
            local v285 = FishingLootInfo.Get(p46.Kind, p46.Name, p46.Rarity)
            local clone3 = PetTemplate:Clone()

            clone3.Name = p46.Name
            clone3:SetAttribute("FishingLoot", true)
            clone3.LayoutOrder = p47
            clone3.Visible = true
            StripScripts(clone3)
            clone3:SetAttribute("HoverPet", p46.Name)
            CollectionService:AddTag(clone3, "InventoryHover")

            local PetButton = clone3:FindFirstChild("PetButton")
            local t10 = {
                Tile = clone3,
                Button = PetButton,
                Entry = p46,
                Info = v285,
                Share = p48
            }

            t8[p46.Name] = t10

            if PetButton then
                if v285.Background ~= "" and (PetButton:IsA("ImageButton") or PetButton:IsA("ImageLabel")) then
                    PetButton.Image = v285.Background
                    PetButton.ImageTransparency = 0
                end

                local PetIcon = PetButton:FindFirstChild("PetIcon")

                if PetIcon then
                    PetIcon.Image = v285.Icon
                    BindDiscovered(p46.Name, PetButton, PetIcon, clone3)
                end

                local Rarity = PetButton:FindFirstChild("Rarity")

                if Rarity then
                    Rarity.Visible = false
                end

                local LockIcon = PetButton:FindFirstChild("LockIcon")

                if LockIcon then
                    LockIcon.Visible = false
                end

                local v292 = HookTileHover(t10, PetButton)
                local DeleteIcon = PetButton:FindFirstChild("DeleteIcon")

                if DeleteIcon then
                    if p46.Secret then
                        DeleteIcon.Visible = false
                    else
                        BindAutoDelete(p46.Name, DeleteIcon)
                    end
                end

                table.insert(t7, PetButton.Activated:Connect(function() -- line: 655
                    -- upvalues: PlayUI (copy), t1 (copy), v292 (copy), TweenService (copy), u94 (ref), t10 (copy), p46 (copy), v30 (copy)
                    PlayUI(t1.Click, 0.5)
                    v292.Scale = 0.85
                    TweenService:Create(v292, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Scale = u94 ~= t10 and 1 or 1.1
                    }):Play()

                    if not p46.Secret and (v30 and v30.Config) then
                        v30.Config:Fire("Delete", p46.Name)
                    end
                end))
            end

            local PetPower = clone3:FindFirstChild("PetPower")

            if PetPower then
                ApplyPetChance(PetPower, p48, v285.Rarity, p46.Secret == true)
            end

            clone3.Parent = Pets

            local v295 = 0.15 + p47 * 0.05

            CenterAnchor(clone3)

            local PopScale = clone3:FindFirstChild("PopScale")

            if not PopScale then
                PopScale = Instance.new("UIScale")
                PopScale.Name = "PopScale"
                PopScale.Parent = clone3
            end

            local v297 = PopScale

            v297.Scale = 0
            task.delay(v295, function() -- line: 597
                -- upvalues: clone3 (copy), TweenService (copy), v297 (copy)
                if clone3.Parent then
                    TweenService:Create(v297, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Scale = 1
                    }):Play()
                end
            end)
        end
        local function CreateItemTile(p49, p50, p51) -- line: 676
            -- upvalues: FishingLootInfo (copy), ItemTempl (copy), StripScripts (copy), t8 (copy), CollectionService (copy), HookTileHover (copy), ApplyItemChance (copy), Items (copy), CenterAnchor (copy), TweenService (copy)
            local v301 = FishingLootInfo.Get(p49.Kind, p49.Name, p49.Rarity)
            local clone4 = ItemTempl:Clone()

            clone4.Name = p49.Name
            clone4:SetAttribute("FishingLoot", true)
            clone4.LayoutOrder = p50
            clone4.Visible = true
            StripScripts(clone4)

            local Image = clone4:FindFirstChild("Image")
            local t11 = {
                Tile = clone4,
                Button = Image,
                Entry = p49,
                Info = v301,
                Share = p51
            }

            t8[p49.Name] = t11

            if Image then
                if Image:IsA("ImageLabel") or Image:IsA("ImageButton") then
                    Image.Image = v301.Icon
                end

                if p49.Kind == "Item" then
                    Image:SetAttribute("HoverItem", p49.Name)
                    CollectionService:AddTag(Image, "InventoryHover")
                elseif p49.Kind == "Currency" then
                    Image:SetAttribute("RewardHoverItem", p49.Name)
                    CollectionService:AddTag(Image, "RewardHover")
                end

                HookTileHover(t11, Image)
            end

            local PetPower = clone4:FindFirstChild("PetPower")

            if PetPower then
                ApplyItemChance(PetPower, p51, v301.Rarity)
            end

            clone4.Parent = Items

            local v306 = 0.25 + p50 * 0.05

            CenterAnchor(clone4)

            local PopScale = clone4:FindFirstChild("PopScale")

            if not PopScale then
                PopScale = Instance.new("UIScale")
                PopScale.Name = "PopScale"
                PopScale.Parent = clone4
            end

            local v308 = PopScale

            v308.Scale = 0
            task.delay(v306, function() -- line: 597
                -- upvalues: clone4 (copy), TweenService (copy), v308 (copy)
                if clone4.Parent then
                    TweenService:Create(v308, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Scale = 1
                    }):Play()
                end
            end)
        end

        function BuildLoot(p52) -- line: 715
            -- upvalues: ClearLoot (copy), Fishing (copy), Players (copy), FishingConfig (copy), FishingLootInfo (copy), UIGridLayout (copy), v51 (copy), CreatePetTile (copy), CreateItemTile (copy)
            ClearLoot()

            local t12 = {}

            pcall(function() -- line: 722
                -- upvalues: t12 (ref), Fishing (copy), Players (copy)
                t12 = require(Fishing:WaitForChild("FishingBoosts")).GetUnlocks(Players.LocalPlayer) or {}
            end)

            local t13 = {}
            local t14 = {}

            for _, v in ipairs(FishingConfig.GetLoot(p52)) do
                local v315 = FishingConfig.EntryWeight(v, t12)

                if v315 > 0 then
                    t13[v] = v315
                    table.insert(t14, v)
                end
            end

            local n7 = 0

            for _, v in ipairs(t14) do
                n7 += t13[v]
            end

            if n7 <= 0 then
                return
            end

            local t15 = {}
            local t16 = {}

            for _, v in ipairs(t14) do
                table.insert(v.Kind == "Pet" and t15 or t16, v)
            end

            table.sort(t15, function(p53, p54) -- line: 748
                -- upvalues: t13 (copy)
                local v729 = t13[p53]
                local v730 = t13[p54]

                if v729 ~= v730 then
                    return v730 < v729
                end

                return tostring(p53.Name) < tostring(p54.Name)
            end)
            table.sort(t16, function(p55, p56) -- line: 754
                -- upvalues: t13 (copy)
                local v733 = t13[p55]
                local v734 = t13[p56]

                if v733 ~= v734 then
                    return v733 < v734
                end

                return tostring(p55.Name) < tostring(p56.Name)
            end)

            local t17 = {}

            for _, v in ipairs(FishingConfig.SecretPets or {}) do
                if typeof(v) == "table" and v.Kind == "Pet" and FishingLootInfo.Get("Pet", v.Name).Icon ~= "" then
                    table.insert(t17, v)
                end
            end

            if UIGridLayout and v51 then
                local v326 = math.min(v51.X.Scale, 0.985 / math.max(1, #t15 + #t17))

                UIGridLayout.CellSize = UDim2.new(v326, v51.X.Offset, v51.Y.Scale, v51.Y.Offset)
            end

            for i, v in ipairs(t15) do
                CreatePetTile(v, i, t13[v] / n7)
            end

            for i, v in ipairs(t17) do
                CreatePetTile(v, #t15 + i, 0)
            end

            for i, v in ipairs(t16) do
                CreateItemTile(v, i, t13[v] / n7)
            end
        end
    end

    function PulseTile(p57) -- line: 786
        -- upvalues: t8 (copy), TweenService (copy), u94 (ref)
        local v334 = t8[p57]

        if not v334 or not v334.Button then
            return
        end

        local Button = v334.Button
        local HoverScale = Button:FindFirstChild("HoverScale")

        if not HoverScale then
            HoverScale = Instance.new("UIScale")
            HoverScale.Name = "HoverScale"
            HoverScale.Parent = Button
        end

        HoverScale.Scale = 1.4
        TweenService:Create(HoverScale, TweenInfo.new(0.45, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
            Scale = v334 ~= u94 and 1 or 1.1
        }):Play()
    end

    local function SetGradient(p58) -- line: 797
        -- upvalues: UIGradientLOW (copy), UIGradientHALF (copy), UIGradientNORMAL (copy)
        if UIGradientLOW then
            UIGradientLOW.Enabled = p58 < 0.34
        end

        if UIGradientHALF then
            UIGradientHALF.Enabled = p58 >= 0.34 and p58 < 0.67
        end

        if UIGradientNORMAL then
            UIGradientNORMAL.Enabled = p58 >= 0.67
        end
    end

    function UpdateBar(p59) -- line: 803
        -- upvalues: n3 (ref), CATCH_TIME (ref), n4 (ref), Bar (copy), v47 (copy), BarSize (copy), UIGradientLOW (copy), UIGradientHALF (copy), UIGradientNORMAL (copy), Name (copy)
        local v339 = math.max(0, n3 - workspace:GetServerTimeNow())
        local v340 = math.clamp(1 - v339 / math.max(0.1, CATCH_TIME), 0, 1)

        n4 += (v340 - n4) * math.min(1, p59 * 10)
        Bar.Size = UDim2.new(math.max(0.02, v47 * n4), 0, BarSize.Y.Scale, BarSize.Y.Offset)

        local v341 = n4

        if UIGradientLOW then
            UIGradientLOW.Enabled = v341 < 0.34
        end

        if UIGradientHALF then
            UIGradientHALF.Enabled = v341 >= 0.34 and v341 < 0.67
        end

        if UIGradientNORMAL then
            UIGradientNORMAL.Enabled = v341 >= 0.67
        end

        local v342 = string.format("%.1fs", v339)

        if v342 ~= Name.Text then
            Name.Text = v342
        end
    end

    ClickSpeedUpSize = ClickSpeedUp.Size
    color3 = Color3.new(1, 1, 1)
    color3_2 = Color3.fromRGB(255, 70, 70)
    n8 = 0
    u126 = nil
    n9 = 0
    u128 = false
    n10 = 0
    t18 = {
        Index = 1,
        Milestone = 0,
        PunchUntil = 50,
        Seq = FishingTaps.NewSequence(0)
    }

    local function CheckMilestone(p60) -- line: 839
        -- upvalues: FishingStreakColors (copy), t18 (copy), FishingFX (copy), LocalPlayer (copy)
        local MILESTONE_EVERY = FishingStreakColors.MILESTONE_EVERY
        local v345 = math.floor(p60 / MILESTONE_EVERY) * MILESTONE_EVERY

        if MILESTONE_EVERY <= v345 and v345 > t18.Milestone then
            t18.Milestone = v345
            pcall(FishingFX.ShowStreakEmote, LocalPlayer.Character, "Fire", v345)
        end
    end
    local function NoInput(p61) -- line: 851
        p61.Active = false
        p61.Interactable = false

        return p61
    end
    local function NewEffect(p62, p63, p64, p65) -- line: 857
        -- upvalues: Fishing2 (copy)
        local v351 = Instance.new(p62)

        v351.Active = false
        v351.Interactable = false
        v351.AnchorPoint = Vector2.new(0.5, 0.5)
        v351.Position = p63
        v351.Size = p64
        v351.BackgroundTransparency = 1
        v351.BorderSizePixel = 0
        v351.ZIndex = p65 or 30
        v351.Parent = Fishing2

        return v351
    end
    local function MakeRound(p66) -- line: 870
        local UICorner = Instance.new("UICorner")

        UICorner.CornerRadius = UDim.new(1, 0)
        UICorner.Parent = p66
    end
    local function MakeSquare(p67) -- line: 876
        Instance.new("UIAspectRatioConstraint").Parent = p67
    end
    local function EaseOutBack(p68, p69) -- line: 881
        local v357 = p69 or 1.7

        return 1 + (v357 + 1) * (p68 - 1) ^ 3 + v357 * (p68 - 1) ^ 2
    end

    function Heartbeat(p70, p71) -- line: 887
        local v360 = p70 * (72 + 108 * p71) / 60 % 1

        local function Pulse(p72) -- line: 890
            -- upvalues: v360 (copy)
            local v736 = (v360 - p72) / 0.065

            return (math.exp(-v736 * v736))
        end

        local v362 = (v360 - 0) / 0.065
        local v363 = math.exp(-v362 * v362)
        local v364 = (v360 - 1) / 0.065
        local v365 = v363 + math.exp(-v364 * v364)
        local v366 = (v360 - 0.22) / 0.065

        return v365 + 0.6 * math.exp(-v366 * v366)
    end

    local function BeatSpeed(p73) -- line: 897
        return (72 + 108 * p73) / 60 * 3.141592653589793 * 2
    end
    local function CreateArcLayer(p74, p75) -- line: 905
        local t19 = {}

        for _, v in ipairs({
            "Left",
            "Right"
        }) do
            local Frame = Instance.new("Frame")

            Frame.Active = false
            Frame.Interactable = false
            Frame.Name = v
            Frame.BackgroundTransparency = 1
            Frame.ClipsDescendants = true
            Frame.Size = UDim2.fromScale(0.5, 1)
            Frame.Position = UDim2.fromScale(v ~= "Left" and 0.5 or 0, 0)
            Frame.ZIndex = p75
            Frame.Parent = p74

            local Frame2 = Instance.new("Frame")

            Frame2.Active = false
            Frame2.Interactable = false
            Frame2.BackgroundTransparency = 1
            Frame2.ZIndex = p75

            local UICorner = Instance.new("UICorner")

            UICorner.CornerRadius = UDim.new(1, 0)
            UICorner.Parent = Frame2

            local UIStroke = Instance.new("UIStroke")

            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            UIStroke.Parent = Frame2

            local UIGradient = Instance.new("UIGradient")

            UIGradient.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(0.499, 0),
                NumberSequenceKeypoint.new(0.5, 1),
                NumberSequenceKeypoint.new(1, 1)
            })
            UIGradient.Parent = UIStroke
            Frame2.Parent = Frame
            t19[v] = {
                Ring = Frame2,
                Stroke = UIStroke,
                Gradient = UIGradient
            }
        end

        return t19
    end
    local function SetArcLayer(p76, p77, p78, p79, p80, p81, p82) -- line: 937
        local v385 = math.max(1, p78 - p79 / 2)
        local v386 = p77 / 2 - v385

        for _, v in ipairs({
            p76.Left,
            p76.Right
        }) do
            v.Ring.Size = UDim2.new(2, -2 * v386, 1, -2 * v386)
            v.Stroke.Thickness = p79
            v.Stroke.Color = p81
            v.Stroke.Transparency = p82
        end

        p76.Left.Ring.Position = UDim2.fromOffset(v386, v386)
        p76.Right.Ring.Position = UDim2.new(-1, v386, 0, v386)

        local v389 = math.clamp(p80, 0, 1)

        p76.Right.Gradient.Rotation = math.min(v389, 0.5) * 360
        p76.Left.Gradient.Rotation = math.max(0, v389 - 0.5) * 360 + 180
    end

    function CreateTimerRing(p83, p84) -- line: 953
        -- upvalues: ClickSpeedUpSize (copy), Fishing2 (copy), CreateArcLayer (copy)
        local uDim2_5 = UDim2.fromScale(ClickSpeedUpSize.X.Scale * 1.55, ClickSpeedUpSize.Y.Scale * 1.55)
        local Frame = Instance.new("Frame")

        Frame.Active = false
        Frame.Interactable = false
        Frame.AnchorPoint = Vector2.new(0.5, 0.5)
        Frame.Position = p83
        Frame.Size = uDim2_5
        Frame.BackgroundTransparency = 1
        Frame.BorderSizePixel = 0
        Frame.ZIndex = p84 or 30
        Frame.Parent = Fishing2
        Frame.Name = "TapTimer"
        Instance.new("UIAspectRatioConstraint").Parent = Frame

        local UIScale2 = Instance.new("UIScale")

        UIScale2.Parent = Frame

        local Frame3 = Instance.new("Frame")

        Frame3.Active = false
        Frame3.Interactable = false
        Frame3.Name = "Track"
        Frame3.AnchorPoint = Vector2.new(0.5, 0.5)
        Frame3.Position = UDim2.fromScale(0.5, 0.5)
        Frame3.BackgroundTransparency = 1
        Frame3.ZIndex = p84

        local UICorner = Instance.new("UICorner")

        UICorner.CornerRadius = UDim.new(1, 0)
        UICorner.Parent = Frame3

        local UIStroke = Instance.new("UIStroke")

        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        UIStroke.Parent = Frame3
        Frame3.Parent = Frame

        local v398 = CreateArcLayer(Frame, p84)
        local v399 = CreateArcLayer(Frame, p84 + 1)

        local function Cap(p85, p86) -- line: 975
            -- upvalues: Frame (copy)
            local Frame4 = Instance.new("Frame")

            Frame4.Active = false
            Frame4.Interactable = false
            Frame4.Name = p85
            Frame4.AnchorPoint = Vector2.new(0.5, 0.5)
            Frame4.BorderSizePixel = 0
            Frame4.ZIndex = p86

            local UICorner2 = Instance.new("UICorner")

            UICorner2.CornerRadius = UDim.new(1, 0)
            UICorner2.Parent = Frame4
            Frame4.Parent = Frame

            return Frame4
        end

        local t20 = {
            Holder = Frame,
            Scale = UIScale2,
            Track = Frame3,
            TrackStroke = UIStroke,
            Glow = v398,
            Main = v399
        }
        local v402 = p84 + 1
        local Frame5 = Instance.new("Frame")

        Frame5.Active = false
        Frame5.Interactable = false
        Frame5.Name = "HeadGlow"
        Frame5.AnchorPoint = Vector2.new(0.5, 0.5)
        Frame5.BorderSizePixel = 0
        Frame5.ZIndex = v402

        local UICorner3 = Instance.new("UICorner")

        UICorner3.CornerRadius = UDim.new(1, 0)
        UICorner3.Parent = Frame5
        Frame5.Parent = Frame
        t20.HeadGlow = Frame5

        local v405 = p84 + 2
        local Frame6 = Instance.new("Frame")

        Frame6.Active = false
        Frame6.Interactable = false
        Frame6.Name = "Tail"
        Frame6.AnchorPoint = Vector2.new(0.5, 0.5)
        Frame6.BorderSizePixel = 0
        Frame6.ZIndex = v405

        local UICorner4 = Instance.new("UICorner")

        UICorner4.CornerRadius = UDim.new(1, 0)
        UICorner4.Parent = Frame6
        Frame6.Parent = Frame
        t20.Tail = Frame6

        local v408 = p84 + 3
        local Frame7 = Instance.new("Frame")

        Frame7.Active = false
        Frame7.Interactable = false
        Frame7.Name = "Head"
        Frame7.AnchorPoint = Vector2.new(0.5, 0.5)
        Frame7.BorderSizePixel = 0
        Frame7.ZIndex = v408

        local UICorner5 = Instance.new("UICorner")

        UICorner5.CornerRadius = UDim.new(1, 0)
        UICorner5.Parent = Frame7
        Frame7.Parent = Frame
        t20.Head = Frame7

        return t20
    end
    function SetTimerRing(p87, p88, p89, p90, p91) -- line: 1000
        -- upvalues: SetArcLayer (copy)
        local AbsoluteSizeX = p87.Holder.AbsoluteSize.X

        if AbsoluteSizeX <= 0 then
            return
        end

        local v417 = p90 or 1
        local v418 = p91 or 0
        local v419 = math.max(3, AbsoluteSizeX * 0.045)
        local v420 = AbsoluteSizeX / 2 - v419 * 2.8 * 1.4 / 2 - 2
        local v421 = 2 * (v420 - v419 / 2)

        p87.Track.Size = UDim2.fromOffset(v421, v421)
        p87.TrackStroke.Thickness = v419
        p87.TrackStroke.Color = p89
        p87.TrackStroke.Transparency = 0.82 + 0.18 * v418
        SetArcLayer(p87.Glow, AbsoluteSizeX, v420, v419 * 2.8 * v417, p88, p89, 0.8 + 0.2 * v418)
        SetArcLayer(p87.Main, AbsoluteSizeX, v420, v419, p88, p89, v418)

        local v422 = v420 / AbsoluteSizeX
        local v423 = p88 > 0.005

        local function Place(p92, p93, p94, p95) -- line: 1019
            -- upvalues: v422 (copy), p89 (copy), v423 (copy)
            p92.Position = UDim2.fromScale(0.5 + math.sin(p93) * v422, 0.5 - math.cos(p93) * v422)
            p92.Size = UDim2.fromOffset(p94, p94)
            p92.BackgroundColor3 = p89
            p92.BackgroundTransparency = v423 and p95 or 1
        end

        local v425 = math.clamp(p88, 0, 1) * 3.141592653589793 * 2
        local Tail = p87.Tail

        Tail.Position = UDim2.fromScale(0.5 + 0 * v422, 0.5 - 1 * v422)
        Tail.Size = UDim2.fromOffset(v419, v419)
        Tail.BackgroundColor3 = p89
        Tail.BackgroundTransparency = v423 and v418 or 1

        local Head = p87.Head
        local v428 = v419 * 1.3

        Head.Position = UDim2.fromScale(0.5 + math.sin(v425) * v422, 0.5 - math.cos(v425) * v422)
        Head.Size = UDim2.fromOffset(v428, v428)
        Head.BackgroundColor3 = p89
        Head.BackgroundTransparency = v423 and v418 or 1

        local HeadGlow = p87.HeadGlow
        local v430 = v419 * 3.4 * v417
        local v431 = 0.62 + 0.38 * v418

        HeadGlow.Position = UDim2.fromScale(0.5 + math.sin(v425) * v422, 0.5 - math.cos(v425) * v422)
        HeadGlow.Size = UDim2.fromOffset(v430, v430)
        HeadGlow.BackgroundColor3 = p89
        HeadGlow.BackgroundTransparency = v423 and v431 or 1
    end
    function FadeTimerRing(p96, p97, p98, p99, p100) -- line: 1031
        -- upvalues: SetTimerRing (copy), TweenService (copy), Debris (copy)
        local NumberValue = Instance.new("NumberValue")

        NumberValue.Value = 0
        NumberValue.Changed:Connect(function(property) -- line: 1034
            -- upvalues: p96 (copy), SetTimerRing (copy), p97 (copy), p98 (copy)
            if p96.Holder.Parent then
                SetTimerRing(p96, p97, p98, 1, property)
            end
        end)

        local tweenInfo = TweenInfo.new(p99, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

        TweenService:Create(NumberValue, tweenInfo, {
            Value = 1
        }):Play()
        TweenService:Create(p96.Scale, tweenInfo, {
            Scale = p100
        }):Play()
        Debris:AddItem(p96.Holder, p99 + 0.05)
        Debris:AddItem(NumberValue, p99 + 0.05)
    end

    local function ReleaseStreakHold() -- line: 1045
        -- upvalues: n10 (ref), u128 (ref), ScreenFlash (copy)
        n10 += 1

        if u128 then
            u128 = false
            pcall(ScreenFlash.Release, 0.5)
        end
    end
end


local function SmallText(p104, p105, p106) -- line: 1140
    -- upvalues: Fishing2 (copy), TweenService (copy), Debris (copy)
    local uDim2_7 = UDim2.fromScale(0.12, 0.045)
    local TextLabel = Instance.new("TextLabel")

    TextLabel.Active = false
    TextLabel.Interactable = false
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    TextLabel.Position = p104
    TextLabel.Size = uDim2_7
    TextLabel.BackgroundTransparency = 1
    TextLabel.BorderSizePixel = 0
    TextLabel.ZIndex = 45
    TextLabel.Parent = Fishing2
    TextLabel.Font = Enum.Font.FredokaOne
    TextLabel.TextScaled = true
    TextLabel.Text = p105
    TextLabel.TextColor3 = p106

    local UIStroke = Instance.new("UIStroke")

    UIStroke.Thickness = 2.5
    UIStroke.Parent = TextLabel

    local UIScale4 = Instance.new("UIScale")

    UIScale4.Scale = 0.5
    UIScale4.Parent = TextLabel
    TweenService:Create(UIScale4, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play()

    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0.4)

    TweenService:Create(TextLabel, tweenInfo, {
        TextTransparency = 1,
        Position = p104 + UDim2.fromScale(0, 0.03)
    }):Play()
    TweenService:Create(UIStroke, tweenInfo, {
        Transparency = 1
    }):Play()
    Debris:AddItem(TextLabel, 1)
end

function t18.GraceLabel() -- line: 1234
    -- upvalues: t18 (copy), Name (copy), color3 (copy), CooldownBar (copy)
    local t18Label = t18.Label

    if t18Label and t18Label.Parent then
        return t18Label
    end

    local TextLabel = Instance.new("TextLabel")

    TextLabel.Active = false
    TextLabel.Interactable = false
    TextLabel.Name = "StreakPaused"
    TextLabel.AnchorPoint = Vector2.new(0.5, 1)
    TextLabel.Position = UDim2.fromScale(0.5, -0.75)
    TextLabel.Size = UDim2.fromScale(1.45, 1.75)
    TextLabel.BackgroundTransparency = 1
    TextLabel.FontFace = Name.FontFace
    TextLabel.TextScaled = true
    TextLabel.TextColor3 = color3
    TextLabel.ZIndex = 100
    TextLabel.Visible = false

    local UIStroke = Instance.new("UIStroke")

    UIStroke.Thickness = 2.5
    UIStroke.Color = Color3.fromRGB(35, 20, 15)
    UIStroke.Parent = TextLabel

    local UIGradient = Instance.new("UIGradient")

    UIGradient.Rotation = 90
    UIGradient.Parent = TextLabel
    Instance.new("UIScale").Parent = TextLabel
    TextLabel.Parent = CooldownBar
    t18.Label = TextLabel

    return TextLabel
end
function t18.EndGrace() -- line: 1262
    -- upvalues: t18 (copy)
    t18.GraceToken = (t18.GraceToken or 0) + 1
    t18.GraceUntil = nil

    local t18Label = t18.Label

    if t18Label and t18Label.Parent then
        t18Label.Visible = false
    end
end
function t18.LoseStreak() -- line: 1270
    -- upvalues: t18 (copy), n9 (ref), FishingStreakColors (copy), SmallText (copy), PlayUI (copy), t1 (copy), FishingFX (copy), LocalPlayer (copy), n10 (ref), u128 (ref), ScreenFlash (copy)
    t18.EndGrace()

    if n9 >= FishingStreakColors.LOST_EMOTE_FROM then
        SmallText(UDim2.fromScale(0.5, 0.77), "Streak lost", Color3.fromRGB(255, 95, 95))
        PlayUI(t1.Miss, 0.35)
        pcall(FishingFX.ShowStreakEmote, LocalPlayer.Character, "Cry", n9)
    end

    n9 = 0
    t18.Milestone = 0
    n10 += 1

    if u128 then
        u128 = false
        pcall(ScreenFlash.Release, 0.5)
    end
end
function t18.StartGrace(p111, p112, p113) -- line: 1285
    -- upvalues: t18 (copy), n10 (ref), u128 (ref), ScreenFlash (copy), SmallText (copy), PlayUI (copy), t1 (copy), u85 (ref)
    t18.GraceToken = (t18.GraceToken or 0) + 1

    local GraceToken = t18.GraceToken
    local elapsed = os.clock()

    t18.GraceUntil = elapsed + p111
    t18.GraceStart = elapsed
    n10 += 1

    if u128 then
        u128 = false
        pcall(ScreenFlash.Release, 0.5)
    end

    if not p113 then
        if p112 then
            SmallText(p112, "Streak paused!", Color3.fromRGB(255, 200, 80))
        end

        PlayUI(t1.Miss, 0.25, 1.15)
    end

    task.delay(p111, function() -- line: 1299
        -- upvalues: t18 (copy), GraceToken (copy), u85 (ref)
        if t18.GraceToken == GraceToken and (t18.GraceUntil and u85) then
            t18.LoseStreak()
        end
    end)
end
function t18.UpdateGrace(p114) -- line: 1307
    -- upvalues: t18 (copy), n9 (ref), FishingStreakColors (copy), FishingConfig (copy), color3_2 (copy), color3 (copy)
    if not t18.GraceUntil then
        return
    end

    if n9 < FishingStreakColors.LOST_EMOTE_FROM then
        local t18Label = t18.Label

        if t18Label and t18Label.Parent and t18Label.Visible then
            t18Label.Visible = false
        end

        return
    end

    local v510 = t18.GraceLabel()
    local v511 = math.max(0, t18.GraceUntil - p114)
    local v512 = math.min(math.ceil(v511), (math.ceil(tonumber(FishingConfig.STREAK_GRACE) or 30)))
    local v513 = string.format("Streak x%d paused - %ds", n9, v512)

    if v513 ~= v510.Text then
        v510.Text = v513
    end

    v510.Visible = true

    local v514 = v511 <= 5
    local v515 = FishingStreakColors.Color(n9, p114)

    if v514 then
        v515 = v515:Lerp(color3_2, math.abs((math.sin(p114 * 8))) * 0.5 + 0.5)
    end

    local UIGradient = v510:FindFirstChildOfClass("UIGradient")

    if UIGradient then
        UIGradient.Color = ColorSequence.new(color3, color3:Lerp(v515, 0.7))
    end

    local UIScale7 = v510:FindFirstChildOfClass("UIScale")

    if UIScale7 then
        local v518 = math.clamp((p114 - (t18.GraceStart or p114)) / 0.25, 0, 1)
        local v519 = 1.6 or 1.7

        UIScale7.Scale = (1 + (v519 + 1) * (v518 - 1) ^ 3 + v519 * (v518 - 1) ^ 2) * (1 + (not v514 and 0.03 or 0.06) * math.sin(p114 * (not v514 and 4 or 10)))
    end
end

local u149 = nil

local function DestroyTap(p115, p116) -- line: 1341
    -- upvalues: u126 (ref), FadeTimerRing (copy), Debris (copy)
    if p115.Dead then
        return
    end

    p115.Dead = true

    if p115 == u126 then
        u126 = nil
    end

    local Button = p115.Button
    local Icon = Button:FindFirstChild("Icon")

    if p116 then
        FadeTimerRing(p115.Ring, 1, p115.Color, 0, 0)

        p115.Scale.Scale = 1.35
        Button.ImageTransparency = 1

        if Icon then
            Icon.ImageTransparency = 1
        end
    else
        FadeTimerRing(p115.Ring, math.max(p115.Fill or 0, 0), p115.Color, 0, 0)

        p115.Scale.Scale = 0.5
        Button.ImageTransparency = 1

        if Icon then
            Icon.ImageTransparency = 1
        end
    end

    p115.Halo.BackgroundTransparency = 1

    Debris:AddItem(p115.Halo, 0)
    Debris:AddItem(Button, 0)
end

local function OnTapClicked(p117, p118) -- line: 1368
    if p117.Dead or (not u85 or p117.Gen ~= n8) then
        return
    end

    local p117Position = p117.Position
    local elapsed = os.clock()
    local v531, v532 = FishingTaps.ClickScale(p118, Fishing2)

    DestroyTap(p117, true)
    t18.Index = math.max(t18.Index, p117.Index + 1)

    local v533 = t18.GraceUntil ~= nil

    if v533 then
        t18.EndGrace()
    end

    n9 += 1

    local v534 = n9
    local v535 = FishingStreakColors.HeatOf(n9)
    local v536 = FishingStreakColors.IsRainbow(n9) and not FishingStreakColors.IsRainbow(n9 - 1)
    local v537 = n9 > 1 and FishingStreakColors.TierIndexOf(n9) > FishingStreakColors.TierIndexOf(n9 - 1)
    local v538 = n9 % FishingStreakColors.MILESTONE_EVERY == 0
    local v539 = v536 or v538

    local v545 = n9
    local MILESTONE_EVERY = FishingStreakColors.MILESTONE_EVERY
    local v547 = math.floor(v545 / MILESTONE_EVERY) * MILESTONE_EVERY

    local v548 = n8

    task.delay(0.05, function() -- line: 1424
        if v548 == n8 then
            u149(v548)
        end
    end)
    task.spawn(function()
        local ok, result = pcall(function() -- line: 1429
            return v29:SpeedUp(p117.Index, v531, v532)
        end)

        if not ok or (typeof(result) ~= "table" or not u85) then
            return
        end

        if typeof(result.EndsAt) == "number" and result.EndsAt == result.EndsAt then
            n3 = result.EndsAt
        end

        if typeof(result.Streak) == "number" and v548 == n8 then
            if result.Accepted == true and result.Streak <= 1 and v534 > 1 then
                n9 = math.max(1, result.Streak + (n9 - v534))
                t18.Milestone = math.floor(n9 / FishingStreakColors.MILESTONE_EVERY) * FishingStreakColors.MILESTONE_EVERY
            else
                n9 = math.max(n9, result.Streak)
            end
            Counter.Text = n9

            t18.Milestone = v757
            FishingFX.ShowStreakEmote(LocalPlayer.Character, "Fire", n9)
        end

        if typeof(result.TapIndex) == "number" and v548 == n8 and result.TapIndex > t18.Index then
            t18.Index = result.TapIndex
        end
    end)
end

function u149(p120)
    if not u85 or (p120 ~= n8 or u126) then
        return
    end

    local Index = t18.Index
    local uDim2_10 = UDim2.fromScale(t18.Seq:Get(Index))
    local elapsed = os.clock()
    local v556 = FishingStreakColors.HeatOf(n9)
    local uDim2_11 = UDim2.fromScale(ClickSpeedUpSize.X.Scale * 1.2, ClickSpeedUpSize.Y.Scale * 1.2)
    local Frame = Instance.new("Frame")

    Frame.Active = false
    Frame.Interactable = false
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.Position = uDim2_10
    Frame.Size = uDim2_11
    Frame.BackgroundTransparency = 1
    Frame.BorderSizePixel = 0
    Frame.ZIndex = 13
    Frame.Parent = Fishing2
    Frame.Name = "TapHalo"

    local UICorner = Instance.new("UICorner")

    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Frame
    Instance.new("UIAspectRatioConstraint").Parent = Frame

    local UIScale8 = Instance.new("UIScale")

    UIScale8.Parent = Frame

    local v561 = CreateTimerRing(uDim2_10, 14)
    local clone6 = ClickSpeedUp:Clone()

    clone6.Name = "ClickSpeedUpActive"
    clone6.Active = true
    clone6.Interactable = true

    for _, descendant in ipairs(clone6:GetDescendants()) do
        if descendant:IsA("GuiObject") then
            descendant.Active = false
            descendant.Interactable = false
        end
    end

    clone6.AnchorPoint = Vector2.new(0.5, 0.5)
    clone6.Position = uDim2_10
    clone6.Rotation = 0
    clone6.Visible = true
    clone6.ZIndex = 15
    clone6.ImageTransparency = 0

    local Icon = clone6:FindFirstChild("Icon")

    if Icon then
        Icon.ImageTransparency = 0
    end

    local UIScale9 = Instance.new("UIScale")

    UIScale9.Scale = 1
    UIScale9.Parent = clone6
    clone6.Parent = Fishing2

    local t22 = {
        Dead = false,
        Hovered = false,
        Ready = true,
        Fill = 1,
        Button = clone6,
        Scale = UIScale9,
        Ring = v561,
        Halo = Frame,
        HaloScale = UIScale8,
        Position = uDim2_10,
        Index = Index,
        Gen = p120,
        Born = elapsed,
        Color = FishingStreakColors.Color(n9, elapsed)
    }

    u126 = t22

    task.wait(0.75)
    t22.Hovered = true
    local input = {
        UserInputType = Enum.UserInputType.MouseButton1,
        UserInputState = Enum.UserInputState.Begin
    }

    OnTapClicked(t22, input)
end


local function OpenUI() -- line: 1606
    -- upvalues: n5 (ref), FishingGui (copy), Fishing2 (copy), t2 (copy), uDim2_2 (copy), t3 (copy), uDim2_3 (copy), t4 (copy), uDim2_4 (copy), TweenGroup (copy), uDim2 (copy), FishingHud (copy), PlayUI (copy), t1 (copy)
    n5 += 1

    local v592 = n5

    FishingGui.Enabled = true
    Fishing2.Visible = true

    local v593 = t2
    local v594 = uDim2_2

    for k, v in pairs(v593) do
        k.Position = v + v594
    end

    local v597 = t3
    local v598 = uDim2_3

    for k, v in pairs(v597) do
        k.Position = v + v598
    end

    local v601 = t4
    local v602 = uDim2_4

    for k, v in pairs(v601) do
        k.Position = v + v602
    end

    local tweenInfo = TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    TweenGroup(t2, uDim2, tweenInfo)
    TweenGroup(t4, uDim2, tweenInfo)

    local v606 = FishingHud.GetSlideOutRemaining()

    if v606 > 0 then
        task.delay(v606, function() -- line: 1621
            -- upvalues: v592 (copy), n5 (ref), TweenGroup (copy), t3 (copy), uDim2 (copy), tweenInfo (copy)
            if v592 == n5 then
                TweenGroup(t3, uDim2, tweenInfo)
            end
        end)
    else
        TweenGroup(t3, uDim2, tweenInfo)
    end

    PlayUI(t1.Open, 0.5)
end
local function CloseUI() -- line: 1630
    -- upvalues: n5 (ref), TweenGroup (copy), t2 (copy), uDim2_2 (copy), t3 (copy), uDim2_3 (copy), t4 (copy), uDim2_4 (copy), FishingTooltip (copy), Fishing2 (copy), ClearLoot (copy), uDim2 (copy)
    n5 += 1

    local v607 = n5
    local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

    TweenGroup(t2, uDim2_2, tweenInfo)
    TweenGroup(t3, uDim2_3, tweenInfo)
    TweenGroup(t4, uDim2_4, tweenInfo)
    FishingTooltip.Hide()
    task.delay(0.27, function() -- line: 1638
        -- upvalues: v607 (copy), n5 (ref), Fishing2 (copy), ClearLoot (copy), t2 (copy), uDim2 (copy), t3 (copy), t4 (copy)
        if v607 ~= n5 then
            return
        end

        Fishing2.Visible = false
        ClearLoot()

        local v759 = t2
        local v760 = uDim2

        for k, v in pairs(v759) do
            k.Position = v + v760
        end

        local v763 = t3
        local v764 = uDim2

        for k, v in pairs(v763) do
            k.Position = v + v764
        end

        local v767 = t4
        local v768 = uDim2

        for k, v in pairs(v767) do
            k.Position = v + v768
        end
    end)
end
local function CloseFishing() -- line: 1649
    -- upvalues: u85 (ref), n2 (ref), n8 (ref), u126 (ref), DestroyTap (copy), t18 (copy), n9 (ref), n10 (ref), u128 (ref), ScreenFlash (copy), CloseUI (copy), FishingHud (copy), PlayUI (copy), t1 (copy)
    if not u85 then
        return
    end

    u85 = false
    n2 = os.clock()
    n8 += 1

    if u126 then
        DestroyTap(u126, false)
    end

    u126 = nil
    t18.EndGrace()
    n9 = 0
    t18.Milestone = 0
    n10 += 1

    if u128 then
        u128 = false
        pcall(ScreenFlash.Release, 0.5)
    end

    CloseUI()
    FishingHud.SetActive(false, 0.25)
    PlayUI(t1.Close, 0.4)
end
local function OnStarted(p123, p124) -- line: 1660
    -- upvalues: u85 (ref), n3 (ref), FishingConfig (copy), CATCH_TIME (ref), n4 (ref), FishingHud (copy), BuildLoot (copy), CooldownBar (copy), OpenUI (copy), LocalPlayer (copy), n8 (ref), n9 (ref), t18 (copy), FishingStreakColors (copy), FishingTaps (copy), u149 (ref)
    u85 = true
    n3 = tonumber(p123.EndsAt) or workspace:GetServerTimeNow() + FishingConfig.CATCH_TIME
    CATCH_TIME = tonumber(p123.Duration) or FishingConfig.CATCH_TIME
    n4 = 0
    FishingHud.SetActive(true)
    BuildLoot(p123.World)
    CooldownBar.Visible = true
    OpenUI()

    local Character = LocalPlayer.Character
    local v612 = Character and Character:FindFirstChild("HumanoidRootPart")

    if Character then
        Character:FindFirstChildOfClass("Humanoid")
    end

    if not p124 and v612 and typeof(p123.CastPoint) == "Vector3" then
        local v613 = p123.CastPoint - v612.Position
        local vector3 = Vector3.new(v613.X, 0, v613.Z)

        if vector3.Magnitude > 0.1 then
            v612.CFrame = CFrame.lookAt(v612.Position, v612.Position + vector3)
        end
    end

    n8 += 1
    n9 = 0
    t18.Milestone = 0
    t18.EndGrace()

    local v615 = math.floor(tonumber(p123.Streak) or 0)
    local num = tonumber(p123.StreakPause)

    if v615 > 0 and num and num == num and num > 1.5 then
        n9 = v615
        t18.Milestone = math.floor(n9 / FishingStreakColors.MILESTONE_EVERY) * FishingStreakColors.MILESTONE_EVERY
        t18.StartGrace(num - 1, nil, true)
    end

    t18.Seq = FishingTaps.NewSequence(tonumber(p123.TapSeed) or 0)
    t18.Index = math.max(1, (math.floor(tonumber(p123.TapIndex) or 1)))

    local v617 = n8

    task.delay(FishingConfig.SPEEDUP_FIRST_DELAY, function() -- line: 1703
        -- upvalues: v617 (copy), n8 (ref), u149 (ref)
        if v617 == n8 then
            u149(v617)
        end
    end)
end
local function TryStart()
    if u85 or u86 then
        return
    end

    if not u77 or not u88 then
        return
    end

    if os.clock() - n1 < 0.25 then
        return
    end

    u86 = true
    UIScale.Scale = 0.85
    PlayUI(t1.Click, 0.5)
    HideBillboard()

    local ok, result = pcall(function() -- line: 1719
        -- upvalues: v29 (copy)
        return v29:StartFishing()
    end)

    u86 = false

    if ok and typeof(result) == "table" and result.Ok == true then
        OnStarted(result)

        return
    end

    n2 = os.clock()
end

Buy.Activated:Connect(TryStart)
UserInputService.InputBegan:Connect(function(input, gameProcessed) -- line: 1733
    -- upvalues: u77 (ref), u85 (ref), TryStart (copy)
    if gameProcessed then
        return
    end

    if (input.KeyCode == Enum.KeyCode.E or input.KeyCode == Enum.KeyCode.ButtonX) and u77 and not u85 then
        TryStart()
    end
end)
Exit.Activated:Connect(function() -- line: 1742
    -- upvalues: u85 (ref), PlayUI (copy), t1 (copy), n2 (ref), n8 (ref), u126 (ref), DestroyTap (copy), t18 (copy), n9 (ref), n10 (ref), u128 (ref), ScreenFlash (copy), CloseUI (copy), FishingHud (copy), v29 (copy)
    if not u85 then
        return
    end

    PlayUI(t1.Click, 0.5)

    if u85 then
        u85 = false
        n2 = os.clock()
        n8 += 1

        if u126 then
            DestroyTap(u126, false)
        end

        u126 = nil
        t18.EndGrace()
        n9 = 0
        t18.Milestone = 0
        n10 += 1

        if u128 then
            u128 = false
            pcall(ScreenFlash.Release, 0.5)
        end

        CloseUI()
        FishingHud.SetActive(false, 0.25)
        PlayUI(t1.Close, 0.4)
    end

    task.spawn(function() -- line: 1746
        -- upvalues: v29 (copy)
        pcall(function() -- line: 1747
            -- upvalues: v29 (copy)
            v29:StopFishing()
        end)
    end)
end)
v29.Stopped:Connect(function() -- line: 1751
    -- upvalues: u85 (ref), n2 (ref), n8 (ref), u126 (ref), DestroyTap (copy), t18 (copy), n9 (ref), n10 (ref), u128 (ref), ScreenFlash (copy), CloseUI (copy), FishingHud (copy), PlayUI (copy), t1 (copy)
    if not u85 then
        return
    end

    u85 = false
    n2 = os.clock()
    n8 += 1

    if u126 then
        DestroyTap(u126, false)
    end

    u126 = nil
    t18.EndGrace()
    n9 = 0
    t18.Milestone = 0
    n10 += 1

    if u128 then
        u128 = false
        pcall(ScreenFlash.Release, 0.5)
    end

    CloseUI()
    FishingHud.SetActive(false, 0.25)
    PlayUI(t1.Close, 0.4)
end)

local function OnServerSession(p125) -- line: 1760
    -- upvalues: u85 (ref), u86 (ref), u88 (ref), HideBillboard (copy), OnStarted (copy)
    if u85 or u86 then
        return
    end

    if typeof(p125) ~= "table" or p125.Ok ~= true then
        return
    end

    u88 = nil
    HideBillboard()
    OnStarted(p125, true)
end

if v29.Resumed then
    v29.Resumed:Connect(OnServerSession)
end

task.spawn(function() -- line: 1772
    -- upvalues: v29 (copy), u85 (ref), u86 (ref), u88 (ref), HideBillboard (copy), OnStarted (copy)
    if not v29.GetSession then
        return
    end

    local ok, result = pcall(function() -- line: 1774
        -- upvalues: v29 (copy)
        return v29:GetSession()
    end)

    if ok and not u85 then
        if u86 then
            return
        end

        if typeof(result) == "table" then
            if result.Ok ~= true then
                return
            end

            u88 = nil
            HideBillboard()
            OnStarted(result, true)
        end
    end
end)

local function IsGoldenCatch(p126) -- line: 1792
    return typeof(p126) == "table" and (p126.Kind == "Pet" and (typeof(p126.Name) == "string" and string.sub(p126.Name, 1, 7) == "Golden "))
end
local function GoldenCatchFX() -- line: 1797
    -- upvalues: LocalPlayer (copy), Debris (copy), PlayUI (copy), t1 (copy)
    local Character = LocalPlayer.Character
    local v627 = Character and Character:FindFirstChild("HumanoidRootPart")

    if Character then
        Character:FindFirstChildOfClass("Humanoid")
    end

    if not v627 then
        return
    end

    local Attachment = Instance.new("Attachment")

    Attachment.Name = "GoldenCatchFX"
    Attachment.Position = Vector3.new(0, 1, 0)
    Attachment.Parent = v627

    local function burst(p127, p128) -- line: 1805
        -- upvalues: Attachment (copy)
        local ParticleEmitter = Instance.new("ParticleEmitter")

        ParticleEmitter.Enabled = false
        ParticleEmitter.LightInfluence = 0
        ParticleEmitter.LightEmission = 1
        ParticleEmitter.SpreadAngle = Vector2.new(180, 180)

        for k, v in pairs(p127) do
            ParticleEmitter[k] = v
        end

        ParticleEmitter.Parent = Attachment
        ParticleEmitter:Emit(p128)
    end

    local new = NumberSequence.new
    local new2 = NumberSequenceKeypoint.new

    burst({
        Texture = "rbxassetid://76001960071878",
        Brightness = 2.5,
        Drag = 4,
        Acceleration = Vector3.new(0, 5, 0),
        Color = ColorSequence.new(Color3.fromRGB(223, 192, 113)),
        Size = new({
            new2(0, 0.9),
            new2(0.6, 0.6),
            new2(1, 0)
        }),
        Transparency = new({
            new2(0, 0),
            new2(0.8, 0.2),
            new2(1, 1)
        }),
        Lifetime = NumberRange.new(0.8, 1.4),
        Speed = NumberRange.new(9, 18),
        Rotation = NumberRange.new(-360, 360),
        RotSpeed = NumberRange.new(-360, 360)
    }, 45)
    burst({
        Texture = "rbxasset://textures/particles/forcefield_glow_main.dds",
        Brightness = 2,
        Color = ColorSequence.new(Color3.fromRGB(255, 225, 120)),
        Size = new({
            new2(0, 1),
            new2(0.3, 7),
            new2(1, 9)
        }),
        Transparency = new({
            new2(0, 0.3),
            new2(1, 1)
        }),
        Lifetime = NumberRange.new(0.6, 0.6),
        Speed = NumberRange.new(0, 0)
    }, 2)
    Debris:AddItem(Attachment, 2)
    PlayUI(t1.Milestone, 0.5, 1.15)
end

v29.Caught:Connect(function(p129, p130, p131) -- line: 1846
    -- upvalues: u85 (ref), n3 (ref), CATCH_TIME (ref), PulseTile (copy), t8 (copy)
    if not u85 then
        return
    end

    if typeof(p130) == "number" and p130 == p130 then
        n3 = p130
    end

    if typeof(p131) == "number" and p131 > 0 then
        CATCH_TIME = p131
    end

    if typeof(p129) == "table" and typeof(p129.Name) == "string" then
        local v635 = string.match(p129.Name, "^[^|]+") or p129.Name

        if typeof(p129) == "table" and (p129.Kind == "Pet" and (typeof(p129.Name) == "string" and string.sub(p129.Name, 1, 7) == "Golden ")) then
            PulseTile(t8[v635] and v635 or string.sub(v635, 8))

            if not p129.Deleted then
                return
            end
        else
            PulseTile(v635)
        end
    end
end)

local t23 = {}

local function ShowPetNotification(p132) -- line: 1879
    -- upvalues: PlayerGui (copy)
    local UI = PlayerGui:FindFirstChild("UI")
    local v638 = UI and UI:FindFirstChild("Base")
    local v639 = v638 and v638:FindFirstChild("Side")
    local v640 = v639 and v639:FindFirstChild("ItemsNotifications")
    local v641 = v640 and v640:FindFirstChild("ShowPet")

    if not v641 or not v641:IsA("BindableEvent") then
        return
    end

    v641:Fire(p132, 1, string.match(p132, "^(Golden) ") or (string.match(p132, "^(Diamond) ") or nil))
end

v29.Caught:Connect(function(p133) -- line: 1890
    -- upvalues: t23 (copy), FishingConfig (copy), ShowPetNotification (copy)
    if typeof(p133) ~= "table" or (p133.Kind ~= "Pet" or p133.Deleted) then
        return
    end

    if typeof(p133.Name) ~= "string" or p133.Name == "" then
        return
    end

    local t24 = {
        Name = p133.Name
    }

    table.insert(t23, t24)

    local n12 = 3

    if FishingConfig.IsSecretPet and FishingConfig.IsSecretPet(p133.Name) then
        n12 += (tonumber(FishingConfig.SECRET_CATCH_HOLD) or 0) + 2
    end

    task.delay(n12, function() -- line: 1901
        -- upvalues: t23 (copy), t24 (copy), ShowPetNotification (copy)
        local v776 = table.find(t23, t24)

        if v776 then
            table.remove(t23, v776)
            ShowPetNotification(t24.Name)
        end
    end)
end)

local n13 = 0

local function LootShare(p134) -- line: 1922
    -- upvalues: t8 (copy)
    local v646 = string.match(p134, "^[^|]+") or p134
    local v647 = t8[v646] or (string.sub(v646, 1, 7) ~= "Golden " or t8[string.sub(v646, 8)])

    return v647 and tonumber(v647.Share) or nil, v647 and (not not v647.Entry and v647.Entry.Kind) or nil
end
local function PlayRareBonus(p135, p136) -- line: 1931
    -- upvalues: LootShare (copy), n13 (ref), PlayUI (copy), t1 (copy)
    if typeof(p135) ~= "string" then
        return
    end

    local v650 = false

    if p136 == "Pet" and string.sub(p135, 1, 7) == "Golden " then
        v650 = true
    else
        local v651 = LootShare(p135)

        if v651 then
            v650 = p136 == "Pet" and v651 <= 0.05 or p136 == "Item" and v651 < 0.005
        end
    end

    if not v650 then
        return
    end

    local elapsed = os.clock()

    if elapsed - n13 < 1.5 then
        return
    end

    n13 = elapsed
    PlayUI(t1.Milestone, 0.5, 1.05 + math.random() * 0.12)
end

function FishingFX.OnPetCollected(p137) -- line: 1949
    -- upvalues: t23 (copy), ShowPetNotification (copy), PlayRareBonus (copy)
    for i, v in ipairs(t23) do
        if p137 == v.Name then
            table.remove(t23, i)
            ShowPetNotification(p137)
            PlayRareBonus(p137, "Pet")

            return
        end
    end
end

local t25 = {}

local function ShowItemNotification(p138, p139) -- line: 1970
    -- upvalues: PlayerGui (copy)
    local UI = PlayerGui:FindFirstChild("UI")
    local v659 = UI and UI:FindFirstChild("Base")
    local v660 = v659 and v659:FindFirstChild("Side")
    local v661 = v660 and v660:FindFirstChild("ItemsNotifications")
    local v662 = v661 and v661:FindFirstChild("ShowItem")

    if not v662 or not v662:IsA("BindableEvent") then
        return
    end

    v662:Fire(p138, p139)
end

v29.Caught:Connect(function(p140) -- line: 1980
    -- upvalues: t25 (copy), ShowItemNotification (copy)
    if typeof(p140) ~= "table" or p140.Kind ~= "Item" then
        return
    end

    if typeof(p140.Name) ~= "string" or p140.Name == "" then
        return
    end

    local t26 = {
        Name = p140.Name,
        Amount = math.max(1, (math.floor(tonumber(p140.Amount) or 1)))
    }

    table.insert(t25, t26)
    task.delay(3, function() -- line: 1985
        -- upvalues: t25 (copy), t26 (copy), ShowItemNotification (copy)
        local v777 = table.find(t25, t26)

        if v777 then
            table.remove(t25, v777)
            ShowItemNotification(t26.Name, t26.Amount)
        end
    end)
end)

function FishingFX.OnItemCollected(p141) -- line: 1994
    -- upvalues: t25 (copy), ShowItemNotification (copy), LootShare (copy), n13 (ref), PlayUI (copy), t1 (copy)
    for i, v in ipairs(t25) do
        if p141 == v.Name then
            table.remove(t25, i)
            ShowItemNotification(v.Name, v.Amount)

            local vName = v.Name

            if typeof(vName) ~= "string" then
                return
            end

            local v669 = false
            local v670 = LootShare(vName)

            if v670 then
                v669 = v670 < 0.005
            end

            if not v669 then
                return
            end

            local elapsed = os.clock()

            if elapsed - n13 < 1.5 then
                return
            end

            n13 = elapsed
            PlayUI(t1.Milestone, 0.5, 1.05 + math.random() * 0.12)

            return
        end
    end
end

local u170 = nil

local function GetCurrencyPopupEvent() -- line: 2018
    -- upvalues: u170 (ref), LocalPlayer (copy)
    if u170 and u170.Parent then
        return u170
    end

    local PlayerScripts = LocalPlayer:FindFirstChildOfClass("PlayerScripts")
    local v673 = PlayerScripts and PlayerScripts:FindFirstChild("LocalCurrencyPopup")

    if v673 and v673:IsA("BindableEvent") then
        u170 = v673

        return v673
    end

    return nil
end

function FishingFX.OnCurrencyCollected(p142, p143) -- line: 2029
    -- upvalues: u170 (ref), LocalPlayer (copy)
    local v676

    if u170 and u170.Parent then
        v676 = u170
    else
        local PlayerScripts = LocalPlayer:FindFirstChildOfClass("PlayerScripts")

        v676 = PlayerScripts and PlayerScripts:FindFirstChild("LocalCurrencyPopup")

        if v676 and v676:IsA("BindableEvent") then
            u170 = v676
        else
            v676 = nil
        end
    end

    if v676 then
        v676:Fire(p142, p143)
    end
end

if v29.CurrencyCaught then
    v29.CurrencyCaught:Connect(function(p144, p145, p146, p147) -- line: 2037
        local ok, result = pcall(FishingFX.OwnCurrency, p144, p145, p146, p147)

        if not ok then
            v1("[FishingClient] orby waluty: " .. tostring(result))
        end
    end)
end

local function PromptAllowed() -- line: 2046
    -- upvalues: u85 (ref), u86 (ref), n2 (ref), LoadingState (copy), PlayerGui (copy)
    if u85 or u86 then
        return false
    end

    if os.clock() - n2 < 0.6 then
        return false
    end

    if LoadingState.IsLoading() then
        return false
    end

    local UI = PlayerGui:FindFirstChild("UI")

    if UI and UI:IsA("ScreenGui") and not UI.Enabled then
        return false
    end

    return true
end
local function EnsureBillboardParent() -- line: 2055
    -- upvalues: FishingView (ref), PlayerGui (copy), FishClick (ref), Fishing (copy), clone (copy), Buy (ref), UIScale (ref), TryStart (copy), HookBuyButton (copy), u77 (ref)
    if FishingView.Parent ~= PlayerGui then
        local FishingView2 = PlayerGui:FindFirstChild("FishingView")

        if FishingView2 then
            FishingView = FishingView2
        else
            FishingView = Instance.new("Folder")
            FishingView.Name = "FishingView"
            FishingView.Parent = PlayerGui
        end
    end

    if FishClick.Parent ~= FishingView and not pcall(function() -- line: 2068
        -- upvalues: FishClick (ref), FishingView (ref)
        FishClick.Parent = FishingView
    end) then
        FishClick = Fishing.FishingPart.FishClick:Clone()
        FishClick.Enabled = false
        FishClick.Adornee = clone
        FishClick.Parent = FishingView
        Buy = FishClick:WaitForChild("Buy")
        UIScale = Instance.new("UIScale")
        UIScale.Parent = Buy
        Buy.Activated:Connect(TryStart)
        HookBuyButton(Buy)
        u77 = false
    end
end
local function RefreshPrompt() -- line: 2085
    -- upvalues: EnsureBillboardParent (copy), LocalPlayer (copy), PromptAllowed (copy), u88 (ref), HideBillboard (copy), FishingWater (copy), u77 (ref), clone (copy), ShowBillboard (copy)
    EnsureBillboardParent()

    local Character = LocalPlayer.Character
    local v687 = Character and Character:FindFirstChild("HumanoidRootPart")
    local v688 = Character and Character:FindFirstChildOfClass("Humanoid")

    if not PromptAllowed() or (not v687 or not v688 or v688.Health <= 0) then
        u88 = nil
        HideBillboard()

        return
    end

    local v689 = FishingWater.FindSpot(v687.Position, v687.CFrame.LookVector, FishingWater.BuildExclude())

    if v689 then
        local v690 = u77

        u88 = v689

        if not v690 then
            clone.Position = v687.Position + v689.Dir * 2
        end

        ShowBillboard()

        return
    end

    u88 = nil
    HideBillboard()
end

local n14 = 0

RunService.Heartbeat:Connect(function(dt) -- line: 2110
    -- upvalues: n14 (ref), RefreshPrompt (copy), v1 (copy), FishingTooltip (copy)
    n14 += dt

    if n14 >= 0.15 then
        n14 = 0

        local ok, result = pcall(RefreshPrompt)

        if not ok then
            v1("[FishingClient] " .. tostring(result))
        end
    end

    FishingTooltip.Hide()
end)
RunService.RenderStepped:Connect(function(dt) -- line: 2123
    -- upvalues: u77 (ref), u88 (ref), LocalPlayer (copy), clone (copy), FishClick (ref), StudsOffset (copy), u81 (ref), u80 (ref), UIScale (ref), u85 (ref), UpdateBar (copy), AnimateTap (copy), t18 (copy), t5 (copy), t6 (copy), FishingStreakColors (copy)
    local elapsed = os.clock()

    if u77 then
        if u88 then
            local Character = LocalPlayer.Character
            local v697 = Character and Character:FindFirstChild("HumanoidRootPart")

            if Character then
                Character:FindFirstChildOfClass("Humanoid")
            end

            if v697 then
                local v698 = v697.Position + u88.Dir * 2

                clone.Position = clone.Position:Lerp(v698, (math.clamp(dt * 12, 0, 1)))
            end
        end

        FishClick.StudsOffset = StudsOffset + Vector3.new(0, math.sin(elapsed * 2.4) * 0.3, 0)

        local v699 = if not u81 then if not u80 then math.sin(elapsed * 5) * 0.045 + 1 else 1.08 else 0.92
        local v700 = UIScale

        v700.Scale = v700.Scale + (v699 - UIScale.Scale) * math.min(1, dt * 14)
    end

    if u85 then
        UpdateBar(dt)
        t18.UpdateGrace(elapsed)
    end

    if #t5 > 0 then
        local v701 = elapsed * 0.8 % 2.5 - 1.25

        for _, v in ipairs(t5) do
            v.Offset = Vector2.new(v701, 0)
        end
    end

    for i = #t6, 1, -1 do
        local v705 = t6[i]

        if v705.Parent then
            v705.Color = FishingStreakColors.RainbowSequence(elapsed * 0.6)
        else
            table.remove(t6, i)
        end
    end
end)
    
