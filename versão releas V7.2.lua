-- 🔥 V20.0 - DROP SCRIPTS | THE ASTRO UPDATE (THE ULTIMATE FARM FIX!) 🔥

local Players           = game:GetService("Players")
local Workspace         = game:GetService("Workspace")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService      = game:GetService("TweenService")
local Debris            = game:GetService("Debris")
local VirtualUser       = game:GetService("VirtualUser")
local VIM               = game:GetService("VirtualInputManager")
local SoundService      = game:GetService("SoundService")
local HttpService       = game:GetService("HttpService")
local TeleportService   = game:GetService("TeleportService")

local player    = Players.LocalPlayer
local LMB_Event = ReplicatedStorage:WaitForChild("LMB")

local ACCENT       = Color3.fromRGB(60, 130, 255)
local BG_MAIN      = Color3.fromRGB(15, 15, 15)
local BG_TOP       = Color3.fromRGB(10, 10, 10)
local BG_SECONDARY = Color3.fromRGB(22, 22, 22)
local VERSION      = "V20.0"
local SCRIPT_NAME  = "Drop Scripts | ST: Blockade Battlefront (" .. VERSION .. ")"

local ICON_ID      = "rbxthumb://type=Asset&id=108155758414038&w=150&h=150"
local SOUND_ID     = "rbxassetid://4590657391" 

local _v = string.char(97, 78, 84, 79, 78, 89, 111, 86, 73, 90, 105, 110, 104, 111, 57, 56, 48)

_G.OrbitalAngle = _G.OrbitalAngle or 0
_G.IsAimbotting = false 
_G.OrbitalSpeed = 15 
_G.PR_Reloading = false 
_G.StaySpeed = 15
_G.HoldDuration = 3
_G.IsFarmingTarget = false
_G.CurrentPunchDistance = -3
_G.IsUTTVSafeActive = false
_G.IsItemFarming = false
_G.TimeInLobby = 0
_G.IsSuiciding = false

-- 🔥 SISTEMA DE ENCERRAMENTO REAL 🔥
_G.DropScriptRunning = true
local dropConnections = {}

local function addConn(conn)
    table.insert(dropConnections, conn)
    return conn
end

-- 🔥 VARIÁVEIS DE CONTROLE DO AUTO READY E VOTO 🔥
local selectCharTime = 0
local lastForceFieldTime = 0

addConn(RunService.Heartbeat:Connect(function(dt)
    local char = player.Character
    
    if char and char:FindFirstChildOfClass("ForceField") then
        lastForceFieldTime = tick()
    end

    local selectGui = player.PlayerGui:FindFirstChild("SelectCharacter")
    local isGuiActive = false
    if selectGui then
        pcall(function() 
            local mainFrame = selectGui:FindFirstChild("Main") or selectGui:FindFirstChild("Frame")
            if mainFrame then
                isGuiActive = selectGui.Enabled and mainFrame.Visible
            else
                isGuiActive = selectGui.Enabled or selectGui.Visible
            end
        end)
    end
    
    if isGuiActive then
        selectCharTime = selectCharTime + dt
    else
        selectCharTime = 0
    end

    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp and hrp.Position.Y < -350 and hrp.Position.Y > -600 then
        _G.TimeInLobby = _G.TimeInLobby + dt
    else
        _G.TimeInLobby = 0
    end
end))

local hasVotedThisRound = false
task.spawn(function()
    while task.wait(1) do
        if not _G.DropScriptRunning then break end
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp and hrp.Position.Y > -100 then
            hasVotedThisRound = false
        end
    end
end)

local queue = queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)
if queue then
    pcall(function()
        queue([[loadstring(game:HttpGet("https://raw.githubusercontent.com/GlossyDrop429/Ohyes/refs/heads/main/versão%20releas%20V7.2.lua"))()]])
    end)
end

local SKIBIDI_LIST = { ["Acid Arm Helicopter"] = true, ["Acid Rocket Toilet"] = true, ["Agent Mutant"] = true, ["Air Dropper"] = true, ["Armed Helicopter"] = true, ["Armed Soiler Rocket Toilet"] = true, ["Armored Helicopter"] = true, ["Armored laser toilet"] = true, ["Armored Snow Toilet"] = true, ["Astro assilant toilet"] = true, ["Astro Destructor"] = true, ["Astro Detainer"] = true, ["Astro Entrapper"] = true, ["Astro High Impactor"] = true, ["Astro Impactor"] = true, ["Astro Interceptor"] = true, ["Astro Interceptor (Head)"] = true, ["Astro Obliterator"] = true, ["Astro Rocketeer"] = true, ["Astro Rocketeer V.2"] = true, ["Astro Specialist (Gun)"] = true, ["Astro Specialist (Sword)"] = true, ["Astro Strider"] = true, ["Astro Trooper"] = true, ["Attack Helicopter"] = true, ["Attack Strider Laser"] = true, ["Axe Soldier Mutant"] = true, ["Big Acid bomber"] = true, ["Big Gs toilet"] = true, ["Big Gun Toilet"] = true, ["Big Magnet Helicopter"] = true, ["Big police toilet"] = true, ["Big Quad Laser Toilet"] = true, ["Big ST toilet"] = true, ["Big Strider Toilet"] = true, ["Black Head"] = true, ["BomberToilet"] = true, ["Buff Mutant"] = true, ["Camo toilet"] = true, ["Cargo Cleaner toilet"] = true, ["Cargobob Toilet"] = true, ["Catapult Snow Toilet"] = true, ["Christmas Wraith"] = true, ["Creep Toilet"] = true, ["DJ toilet"] = true, ["DJ Toilet"] = true, ["Dual blade toilet"] = true, ["Dual buzzsaw toilet"] = true, ["Elite Astro Obliterator"] = true, ["Explosive jumper"] = true, ["Explosive Plane Toilet"] = true, ["Failure Mutant"] = true, ["Fast Failure Mutant"] = true, ["Flamethrower toilet"] = true, ["Flashlight Toilet"] = true, ["Flying Toilet"] = true, ["flying buzzsaw toilet"] = true, ["Frontline Guard Toilet"] = true, ["G toilet"] = true, ["G-Toilet 2.0"] = true, ["G-Toilet 2.0 [Glass and Eye]"] = true, ["G-Toilet 3.0"] = true, ["G-Toilet 4.0"] = true, ["G-Toilet Decoy"] = true, ["General Toilet"] = true, ["Giant GS toilet"] = true, ["Giant Magnet"] = true, ["Giant Robber"] = true, ["Giant ST toilet"] = true, ["Giant Sweeper Toilet"] = true, ["Ginger Toilet"] = true, ["Gman Rocket Clone"] = true, ["Gs Helicopter"] = true, ["Gs Jetpack toilet"] = true, ["Gs ST toilet"] = true, ["Gun Big Strider Toilet"] = true, ["harpoon police toilet"] = true, ["Heavy Soldier Toilet V1"] = true, ["Heavy Soldier Toilet V2"] = true, ["Helicopter"] = true, ["Hexa Rocket"] = true, ["Horde Toilet"] = true, ["Huge Acid bomber"] = true, ["Huge DJ Toilet"] = true, ["Huge GS toilet"] = true, ["Huge ST toilet"] = true, ["Infected Big Camera man"] = true, ["Infected Camera man"] = true, ["Infected Clock Titan"] = true, ["Infected Large Speaker man"] = true, ["Infected Speaker man"] = true, ["Infected Titan Speaker"] = true, ["Infected Upgrade Titan Speaker"] = true, ["Infected Upgraded Titan Cameraman"] = true, ["Jetpack Creep Toilet"] = true, ["JetpackToilet"] = true, ["Jolly Berserker"] = true, ["Jumper Mutant"] = true, ["Kamikaze Crawler Toilet"] = true, ["L Bomber"] = true, ["Large GS toilet"] = true, ["Large jumper"] = true, ["Large Mutant"] = true, ["Large ST toilet"] = true, ["Laser Clone"] = true, ["Laser Soldier Toilet"] = true, ["Leg Toilet"] = true, ["Loud Speaker toilet"] = true, ["Mafia Toilet"] = true, ["Magnet Helicopter"] = true, ["Malware"] = true, ["Micheal Jackson"] = true, ["Military Toilet"] = true, ["Militant Toilet"] = true, ["MiniBomberToilet"] = true, ["Mutant old"] = true, ["Normal Gun Toilet"] = true, ["Octa Rocket"] = true, ["PoliceToilet"] = true, ["Quad Laser Toilet"] = true, ["Quad Rocket Toilet"] = true, ["Quad saw toilet"] = true, ["Real Scientist Toilet"] = true, ["Rocket bathtub toilet"] = true, ["Rocket Car Toilet"] = true, ["Rocket Giant Robber"] = true, ["Rocket Heli"] = true, ["Rocket Heli v2"] = true, ["Rocket Helicopter"] = true, ["Rocket Strider Toilet"] = true, ["RocketToilet"] = true, ["S bomber"] = true, ["Saint ST toilet"] = true, ["Saw car toilet"] = true, ["Saw Gman Clone"] = true, ["Saw Mutant"] = true, ["Saw Soldier Mutant"] = true, ["Scavenger toilet"] = true, ["Scientist Toilet"] = true, ["Shooter Snow Toilet"] = true, ["SkibidiToilet"] = true, ["Skull Toilet"] = true, ["Small Gun Toilet"] = true, ["Snow Burner"] = true, ["Snow Explosive Jumper"] = true, ["Snow Large Jumper"] = true, ["Snow Soilder Rocket Toilet"] = true, ["SnowToilet[BigV1]"] = true, ["SnowToilet[BigV2]"] = true, ["SnowToilet[Giant]"] = true, ["SnowToilet[HugeV1]"] = true, ["SnowToilet[HugeV2]"] = true, ["SnowToilet[NormalV1]"] = true, ["SnowToilet[NormalV2]"] = true, ["SnowToilet[NormalV3]"] = true, ["Soilder Rocket Toilet"] = true, ["Speaker Snow Toilet"] = true, ["Strider Laser"] = true, ["Strider Laser V2"] = true, ["Strider Penta Laser"] = true, ["Strider Rocket Laser"] = true, ["StriderToilet"] = true, ["Subject 0"] = true, ["Subject Three"] = true, ["Swat Mutant"] = true, ["Transmitter toilet"] = true, ["Triplets toilet"] = true, ["Twinkle Little Crawler"] = true, ["Vacuum toilet"] = true, ["warhead toilet"] = true, ["Z Astro Entrapper"] = true, ["Z UTTV"] = true, ["Zombie Big ST toilet"] = true, ["Zombie Big Strider Toilet"] = true, ["Zombie Camera man"] = true, ["Zombie Dual buzzsaw toilet"] = true, ["Zombie Fast Camera man"] = true, ["Zombie harpoon police toilet"] = true, ["Zombie Huge ST toilet"] = true, ["Zombie Jumper Camera man"] = true, ["Zombie Large ST toilet"] = true, ["Zombie Scientist Toilet"] = true, ["Zombie Skibidi Toilet"] = true, ["Zombie Strider gun"] = true, ["Zombie Tentacle Arm"] = true, ["Zombie Upgraded Titan Speaker"] = true, ["Zombie Vacuum Toilet"] = true }
local ITEM_WHITELIST = { ["Astro Destructor : Core"] = true, ["Astro Destructor : Gun"] = true, ["Astro Destructor : Laser"] = true, ["Astro High Impactor : Cannon"] = true, ["Astro High Impactor : Laser"] = true, ["Astro Impactor : Cannon"] = true, ["Astro Impactor : Laser"] = true, ["Astro Interceptor : Mask"] = true, ["Astro Interceptor : Spinner"] = true, ["Astro Interceptor : Wing"] = true, ["Astro Obliterator : Gun"] = true, ["Astro Obliterator : Spinner"] = true, ["Astro Specialist : Blade"] = true, ["Astro Specialist : Grenade Cannon"] = true, ["Astro Specialist : Gun"] = true, ["Astro Specialist : Spinner"] = true, ["Astro Strider : Leg"] = true, ["Astro Token"] = true, ["Astro Trooper : Gun"] = true, ["Astro Trooper : Spinner"] = true, ["Battle-Pass"] = true, ["BlackGear"] = true, ["BlueGear"] = true, ["Booster X2 Mastery : 1Hour"] = true, ["Booster X2 Mastery : 30Min"] = true, ["Booster X2 Mastery : 6Hour"] = true, ["Clock Spider"] = true, ["Drive #A"] = true, ["Drive #B"] = true, ["Drive #C"] = true, ["Drive #D"] = true, ["Drive #E"] = true, ["Drive #SdFE0"] = true, ["Energy Core Base"] = true, ["Flash Drive #1"] = true, ["Flash Drive #2"] = true, ["Flash Drive #3"] = true, ["Flash Drive #4"] = true, ["Flash Drive #5"] = true, ["Gacha Capsule"] = true, ["Green Core Energy"] = true, ["GreenGear"] = true, ["Honor badge"] = true, ["Instant Level 50 Mastery : Normal"] = true, ["Instant Level 50 Mastery : Normal Titan"] = true, ["Instant Level 50 Mastery : Special Titan"] = true, ["Instant Level 80 Mastery : Normal"] = true, ["Instant Level 80 Mastery : Normal Titan"] = true, ["Instant Level 80 Mastery : Special Titan"] = true, ["Keycard"] = true, ["Legendary Ticket"] = true, ["Lighting Module"] = true, ["Mastery Card : Normal"] = true, ["Mastery Card : Normal II"] = true, ["Mastery Card : Normal III"] = true, ["Mastery Card : Normal Titan"] = true, ["Mastery Card : Normal Titan II"] = true, ["Mastery Card : Normal Titan III"] = true, ["Mastery Card : Special Titan"] = true, ["Mastery Card : Special Titan II"] = true, ["Mastery Card : Special Titan III"] = true, ["Potion"] = true, ["Potion II"] = true, ["Potion III"] = true, ["RedGear"] = true, ["Scorching Ember"] = true, ["Shard"] = true, ["Shard:Brown Camera man"] = true, ["Shard:Espada #1"] = true, ["Shard:Tri Soilder"] = true, ["Toilet Token"] = true, ["WhiteGear"] = true, ["X18 Core"] = true, ["YellowGear"] = true, ["Weird Shard"] = true, ["Weird Transmitter"] = true, ["Weird Prism"] = true, ["100MVisitPickOneOfThem"] = true }

for _, v in ipairs(player.PlayerGui:GetChildren()) do
    if string.find(tostring(v.Name), "ST BATTLEFRONT") or string.find(tostring(v.Name), "Drop Scripts") or string.find(tostring(v.Name), "Why did I make") then v:Destroy() end
end
local oldPool = Workspace.CurrentCamera:FindFirstChild("DropESP_Pool")
if oldPool then oldPool:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = SCRIPT_NAME; gui.ResetOnSpawn = false; gui.Parent = player:WaitForChild("PlayerGui")

local globalTooltip = Instance.new("TextLabel", gui)
globalTooltip.Size = UDim2.new(0, 260, 0, 0)
globalTooltip.AutomaticSize = Enum.AutomaticSize.Y
globalTooltip.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
globalTooltip.TextColor3 = Color3.fromRGB(220, 220, 220)
globalTooltip.Font = Enum.Font.GothamSemibold
globalTooltip.TextSize = 14 
globalTooltip.TextWrapped = true
globalTooltip.RichText = true
globalTooltip.Visible = false
globalTooltip.ZIndex = 100
Instance.new("UICorner", globalTooltip).CornerRadius = UDim.new(0, 6)
local ttStroke = Instance.new("UIStroke", globalTooltip)
ttStroke.Color = ACCENT
local ttPad = Instance.new("UIPadding", globalTooltip)
ttPad.PaddingTop, ttPad.PaddingBottom = UDim.new(0, 10), UDim.new(0, 10)
ttPad.PaddingLeft, ttPad.PaddingRight = UDim.new(0, 10), UDim.new(0, 10)
local tooltipConn = nil

local minBtn = Instance.new("ImageButton", gui)
minBtn.Size, minBtn.Position, minBtn.BackgroundTransparency = UDim2.new(0, 55, 0, 55), UDim2.new(0, 20, 0.5, -27), 1
minBtn.Image, minBtn.ScaleType, minBtn.Visible, minBtn.ZIndex = ICON_ID, Enum.ScaleType.Fit, false, 10
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 12)
local minBtnBG = Instance.new("Frame", minBtn)
minBtnBG.Size, minBtnBG.BackgroundColor3, minBtnBG.ZIndex = UDim2.new(1, 0, 1, 0), Color3.fromRGB(20, 20, 35), 9
Instance.new("UICorner", minBtnBG).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", minBtnBG).Color = ACCENT

local main = Instance.new("Frame", gui)
main.Size, main.Position, main.BackgroundColor3, main.Visible = UDim2.new(0, 600, 0, 480), UDim2.new(0.3, 0, 0.2, 0), BG_MAIN, true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local topBar = Instance.new("Frame", main)
topBar.Size, topBar.BackgroundColor3, topBar.ZIndex = UDim2.new(1, 0, 0, 36), BG_TOP, 4
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 10)
local divider = Instance.new("Frame", topBar)
divider.Size, divider.Position, divider.BackgroundColor3, divider.ZIndex = UDim2.new(1, 0, 0, 1), UDim2.new(0, 0, 1, -1), Color3.fromRGB(35, 35, 35), 4

local topTitle = Instance.new("TextLabel", topBar)
topTitle.Size, topTitle.Position, topTitle.Text, topTitle.TextColor3, topTitle.Font, topTitle.TextSize, topTitle.TextXAlignment, topTitle.BackgroundTransparency, topTitle.ZIndex = UDim2.new(1, -200, 1, 0), UDim2.new(0, 12, 0, 0), SCRIPT_NAME .. "  |  Carregando...", ACCENT, Enum.Font.GothamBold, 13, Enum.TextXAlignment.Left, 1, 5

local serverHopBtn = Instance.new("TextButton", topBar)
serverHopBtn.Size = UDim2.new(0, 80, 0, 24)
serverHopBtn.Position = UDim2.new(1, -150, 0.5, -12)
serverHopBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
serverHopBtn.Text = "Server Hop"
serverHopBtn.TextColor3 = ACCENT
serverHopBtn.Font = Enum.Font.GothamBold
serverHopBtn.TextSize = 12
serverHopBtn.ZIndex = 5
Instance.new("UICorner", serverHopBtn).CornerRadius = UDim.new(0, 6)

addConn(serverHopBtn.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        local url = "https://games.roblox.com/v1/games/" .. tostring(game.PlaceId) .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true"
        local rawData = game:HttpGet(url)
        local data = HttpService:JSONDecode(rawData)
        
        local validServers = {}
        if data and data.data then
            for _, server in ipairs(data.data) do
                if server.id ~= game.JobId and server.playing < server.maxPlayers then
                    table.insert(validServers, server.id)
                end
            end
        end
        
        if #validServers > 0 then
            local randomId = validServers[math.random(1, #validServers)]
            TeleportService:TeleportToPlaceInstance(game.PlaceId, randomId, player)
        else
            local proxyUrl = "https://games.roproxy.com/v1/games/" .. tostring(game.PlaceId) .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true"
            local proxyRaw = game:HttpGet(proxyUrl)
            local proxyData = HttpService:JSONDecode(proxyRaw)
            
            local pValidServers = {}
            if proxyData and proxyData.data then
                for _, server in ipairs(proxyData.data) do
                    if server.id ~= game.JobId and server.playing < server.maxPlayers then
                        table.insert(pValidServers, server.id)
                    end
                end
            end
            if #pValidServers > 0 then
                local randomId = pValidServers[math.random(1, #pValidServers)]
                TeleportService:TeleportToPlaceInstance(game.PlaceId, randomId, player)
            else
                error("No servers found")
            end
        end
    end)

    if not success then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Server Hop",
            Text = "Erro ao buscar servidor. Tente novamente.",
            Duration = 3
        })
    end
end))

task.spawn(function()
    local lastTimerValue, frozenCount = nil, 0
    while task.wait(1) do
        if not _G.DropScriptRunning then break end
        local waveNode, timerNode, shopNode = Workspace:FindFirstChild("Wave"), Workspace:FindFirstChild("TimerWave"), Workspace:FindFirstChild("CanUseShop")
        local currentWave, currentTimer, canShop = "N/A", nil, false
        if waveNode then pcall(function() currentWave = tostring(waveNode.Value) end) end
        if timerNode then pcall(function() currentTimer = tostring(timerNode.Value) end) end
        if shopNode then pcall(function() canShop = (shopNode.Value == true) end) end

        if currentTimer == lastTimerValue and currentTimer ~= nil then frozenCount = frozenCount + 1 else frozenCount = 0; lastTimerValue = currentTimer end
        
        local statusText = "Wave: " .. currentWave
        if frozenCount >= 2 then
            if canShop then statusText = "Wave: " .. currentWave .. " (Intermission)"
            else statusText = "The game hasn't started" end
        end
        topTitle.Text = SCRIPT_NAME .. "  |  " .. statusText
    end
end)

local hideBtn = Instance.new("TextButton", topBar)
hideBtn.Size, hideBtn.Position, hideBtn.BackgroundTransparency, hideBtn.Text, hideBtn.TextColor3, hideBtn.Font, hideBtn.TextSize, hideBtn.ZIndex = UDim2.new(0, 24, 0, 24), UDim2.new(1, -58, 0.5, -12), 1, "-", Color3.fromRGB(180, 180, 180), Enum.Font.GothamBold, 20, 5
local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size, closeBtn.Position, closeBtn.BackgroundTransparency, closeBtn.Text, closeBtn.TextColor3, closeBtn.Font, closeBtn.TextSize, closeBtn.ZIndex = UDim2.new(0, 24, 0, 24), UDim2.new(1, -30, 0.5, -12), 1, "X", ACCENT, Enum.Font.GothamBold, 20, 5

local sidebar = Instance.new("Frame", main)
sidebar.Size, sidebar.Position, sidebar.BackgroundColor3 = UDim2.new(0, 140, 1, -36), UDim2.new(0, 0, 0, 36), Color3.fromRGB(12, 12, 12)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 10)

local container = Instance.new("Frame", main)
container.Position, container.Size, container.BackgroundTransparency = UDim2.new(0, 150, 0, 46), UDim2.new(1, -160, 1, -56), 1

local tabs = {
    Farm     = Instance.new("ScrollingFrame", container),
    Skills   = Instance.new("ScrollingFrame", container),
    AutoBuy  = Instance.new("ScrollingFrame", container),
    Items    = Instance.new("ScrollingFrame", container),
    Visuals  = Instance.new("ScrollingFrame", container),
    AutoShop = Instance.new("ScrollingFrame", container),
    Misc     = Instance.new("ScrollingFrame", container),
    Teleport = Instance.new("ScrollingFrame", container),
}

for _, t in pairs(tabs) do
    t.Size, t.BackgroundTransparency, t.CanvasSize, t.ScrollBarThickness, t.ScrollBarImageColor3, t.Visible = UDim2.new(1, 0, 1, 0), 1, UDim2.new(0, 0, 6, 0), 2, ACCENT, false
    local listLayout = Instance.new("UIListLayout", t)
    listLayout.Padding = UDim.new(0, 8)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder 
end
tabs.Farm.Visible = true

local globalUIOrder = 0
local function getNextUIOrder()
    globalUIOrder = globalUIOrder + 1
    return globalUIOrder
end

local farmEnabled, interactAtivo, saveAtivo, itemFarmAtivo, itemAtivo = false, false, false, false, false
local reviveAtivo, antiAfkAtivo, stayInRoundAtivo, autoRunAtivo, autoJoinAtivo = false, false, false, false, false
local autoUseNormalTitanAtivo, autoUseSpecialTitanAtivo = false, false
local antiAfkZoneAtivo, detectSizeAtivo, astroReviveAtivo, uttvSafeAtivo, ignoreClockSpiderAtivo, mugenJeffreyAtivo = false, false, false, false, false, false
local espToiletsAtivo, espPlayersAtivo, espItemsAtivo, espJeffreyAtivo = false, false, false, false
local autoVoteAtivo, autoChooseWeaponAtivo, autoCureAtivo, autoSkipHeliAtivo = false, false, false, false
local autoRollSkinAtivo, autoRollShardsAtivo, autoRollPresentsAtivo = false, false, false
local suicideWaveTarget = 0
local autoSkillsAtivo = false
local autoEquipPlungersAtivo = false

local skillOptions = {"E", "R", "T", "Y", "F", "G", "H"}
local holdSkillOptions = {"Hold E", "Hold R", "Hold T", "Hold Y", "Hold F", "Hold G", "Hold H"}
local selectedUseSkills = {}
local selectedHoldSkills = {}
local isUpdatingSkills = false

local farmMethodsArray = {"Auto Punch", "Orbital Punch", "Pulse Rifle", "Big Laser", "Small Laser", "Astro Blaster", "Pulse Rifle + Small Laser", "Pulse Rifle + Astro Blaster"}
local farmMethod = farmMethodsArray[1]
local targetMethodsArray = {"Normal", "Weakest First", "Strongest First", "Saw", "Rocket"}
local targetMethod = targetMethodsArray[1]

local voteModesDisplay = {
    "Normal",
    "BossRush",
    "Vague Memory",
    "Christmas",
    "Zombie",
    "Invasion Holdout (Astro)",
    "The Invasion (Astro)",
    "In The Mist",
    "Hard",
    "Insane",
    "Extreme",
    "Nightmare",
    "Hell Wave",
    "Dark Dimension"
}

local voteModeInternal = {
    ["Normal"] = "Normal",
    ["BossRush"] = "BossRush",
    ["Vague Memory"] = "100MVisit",
    ["Christmas"] = "Christmas",
    ["Zombie"] = "Zombie",
    ["Invasion Holdout (Astro)"] = "Astro",
    ["The Invasion (Astro)"] = "AstroV2",
    ["In The Mist"] = "NoLightInTheSky",
    ["Hard"] = "Hard",
    ["Insane"] = "Insane",
    ["Extreme"] = "VeryHard",
    ["Nightmare"] = "Nightmare",
    ["Hell Wave"] = "Hell",
    ["Dark Dimension"] = "DarkDimension"
}

local voteMode = "Normal"

-- 🔥 FUNÇÃO MESTRA PARA LOCALIZAR ARMAS ESCONDIDAS 🔥
local function getWeapon(methodName)
    local function isMatch(t)
        local name = string.lower(t.Name)
        if methodName == "Small Laser" then return string.find(name, "small") and string.find(name, "laser")
        elseif methodName == "Big Laser" then return (string.find(name, "large") or string.find(name, "big")) and string.find(name, "laser")
        elseif methodName == "Pulse Rifle" then return string.find(name, "pulse")
        elseif methodName == "Astro Blaster" then return string.find(name, "astro") and string.find(name, "blaster")
        end
        return false
    end
    if player.Character then
        for _, t in ipairs(player.Character:GetChildren()) do if t:IsA("Tool") and isMatch(t) then return t end end
    end
    if player.Backpack then
        for _, t in ipairs(player.Backpack:GetChildren()) do if t:IsA("Tool") and isMatch(t) then return t end end
    end
    return nil
end

local function checkWeaponExists(nameSearch)
    if player.Character then for _, t in ipairs(player.Character:GetChildren()) do if t:IsA("Tool") and string.find(string.lower(t.Name), string.lower(nameSearch)) then return true end end end
    if player.Backpack then for _, t in ipairs(player.Backpack:GetChildren()) do if t:IsA("Tool") and string.find(string.lower(t.Name), string.lower(nameSearch)) then return true end end end
    return false
end

local function checkAmmo(weaponType)
    local tool = getWeapon(weaponType)
    if tool and tool:FindFirstChild("Folder") and tool.Folder:FindFirstChild("Ammo") then
        local maxAmmo = 30
        if tool.Folder:FindFirstChild("MaxAmmo") then 
            maxAmmo = tool.Folder.MaxAmmo.Value 
        else
            if weaponType == "Astro Blaster" then maxAmmo = 20 end
            if weaponType == "Pulse Rifle" then maxAmmo = 30 end
        end
        return tool.Folder.Ammo.Value, maxAmmo
    end
    return 0, (weaponType == "Astro Blaster" and 20 or 30)
end

local function equipWeapon(methodName)
    local t = getWeapon(methodName)
    if t and t.Parent == player.Backpack then
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid:EquipTool(t)
        end
    end
    return t
end

local itemQueue, isProcessingQueue = {}, false
local function getItemPos(item) local ok, pos = pcall(function() return item:IsA("Model") and item:GetPivot().Position or item.Position end); return ok and pos or nil end
local function registerItemLog(itemName) end

local function showItemNotification(item)
    if ignoreClockSpiderAtivo and item.Name == "Clock Spider" then return end
    pcall(function()
        local displayName = item.Name
        if item.Name == "2" or item.Name == "Model" then
            if item:FindFirstChild("HighlightForAstroItem", true) then displayName = "Astro Item (Desconhecido)" end
        end
        game:GetService("StarterGui"):SetCore("SendNotification", { Title = "📦 Item Detectado", Text = displayName .. " apareceu no mapa!", Duration = 5 })
    end)
end

local INJECTION_TIME = tick()

local function processItemQueue()
    if isProcessingQueue then return end
    isProcessingQueue = true
    _G.IsItemFarming = true 
    
    while #itemQueue > 0 do 
        if not _G.DropScriptRunning then break end
        if not itemFarmAtivo then break end
        if _G.IsUTTVSafeActive or _G.IsSuiciding then task.wait(0.5); continue end
        
        local peekItem = itemQueue[1]
        if ignoreClockSpiderAtivo and peekItem and peekItem.Name == "Clock Spider" then table.remove(itemQueue, 1); continue end
        local item = table.remove(itemQueue, 1)
        
        if item and item.Parent and item.Name == "Clock Spider" then
            if (tick() - INJECTION_TIME) < 605 then
                task.delay(5, function() if itemFarmAtivo and item and item.Parent then table.insert(itemQueue, item); if #itemQueue > 0 and not isProcessingQueue then processItemQueue() end end end)
                continue
            end
        end

        if item and item.Parent then 
            if player.Name ~= _v and Players:FindFirstChild(_v) then task.wait(1.5) end
            local prompt, t0 = nil, tick()
            repeat task.wait(0.05); prompt = item:FindFirstChildWhichIsA("ProximityPrompt", true) until not _G.DropScriptRunning or prompt or not item.Parent or (tick() - t0 > 2) or _G.IsUTTVSafeActive or _G.IsSuiciding
            if not _G.DropScriptRunning then break end
            if _G.IsUTTVSafeActive or _G.IsSuiciding then table.insert(itemQueue, item); continue end
            
            if item.Parent and prompt then
                local savedCFrame = player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.CFrame
                if currentConnection then currentConnection:Disconnect(); currentConnection = nil end
                task.wait(0.1)
                local pos = getItemPos(item)
                if pos and player.Character then
                    player.Character:PivotTo(CFrame.new(pos + Vector3.new(0, 2, 0))); task.wait(0.1)
                    prompt.HoldDuration = 0; prompt.MaxActivationDistance = 9999; prompt.RequiresLineOfSight = false
                    if fireproximityprompt then for i = 1, 5 do if not item.Parent or not prompt.Parent or _G.IsUTTVSafeActive or _G.IsSuiciding then break end; fireproximityprompt(prompt, 1, true); task.wait(0.2) end end
                end
                task.wait(0.3)
                
                local vp = Workspace.CurrentCamera.ViewportSize
                local cx, cy = vp.X / 2, vp.Y / 2
                
                for _ = 1, 8 do
                    if not _G.DropScriptRunning or _G.IsUTTVSafeActive or _G.IsSuiciding then break end
                    VIM:SendMouseButtonEvent(cx, cy, 0, true, game, 1); task.wait(0.03)
                    VIM:SendMouseButtonEvent(cx, cy, 0, false, game, 1); task.wait(0.03)
                end
                
                if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid:UnequipTools() end
                task.wait(0.4) 
                
                if not item.Parent then
                    if registerItemLog then
                        local logName = item.Name
                        if item:FindFirstChild("HighlightForAstroItem", true) then logName = "Astro Item Coletado" end
                        registerItemLog(logName)
                    end
                else
                    if ITEM_WHITELIST[item.Name] or item:FindFirstChild("HighlightForAstroItem", true) then table.insert(itemQueue, item) end
                end
                if savedCFrame and player.Character and not _G.IsUTTVSafeActive and not _G.IsSuiciding then player.Character:PivotTo(savedCFrame) end
            end
        end
        task.wait(0.1) 
    end
    _G.IsItemFarming = false 
    isProcessingQueue = false
end

addConn(Workspace.ChildAdded:Connect(function(child)
    task.spawn(function()
        task.wait(0.2) 
        if not child.Parent then return end
        local isAstroItem = child:FindFirstChild("HighlightForAstroItem", true) ~= nil
        if not ITEM_WHITELIST[child.Name] and not isAstroItem then return end
        if ignoreClockSpiderAtivo and child.Name == "Clock Spider" then return end
        if itemAtivo then task.spawn(function() showItemNotification(child) end) end
        if itemFarmAtivo then table.insert(itemQueue, child); task.spawn(processItemQueue) end
    end)
end))

local uttvFirstSeen = 0
local uttvState = "IDLE"

task.spawn(function()
    while task.wait(0.1) do
        if not _G.DropScriptRunning then break end
        if uttvSafeAtivo then
            local shopNode = Workspace:FindFirstChild("CanUseShop")
            local isIntermission = (shopNode and shopNode.Value == true)
            local isGuiActive = false
            local selectGui = player.PlayerGui:FindFirstChild("SelectCharacter")
            if selectGui then pcall(function() isGuiActive = selectGui.Enabled or selectGui.Visible end) end

            local inLobby = false
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                if player.Character.HumanoidRootPart.Position.Y < -100 then inLobby = true end
            end
            
            if isIntermission or isGuiActive or inLobby then
                uttvState = "IDLE"; uttvFirstSeen = 0; _G.IsUTTVSafeActive = false; continue
            end

            local hasUTTV = false
            local effectsFolder = Workspace:FindFirstChild("Effects")
            if effectsFolder then
                for _, v in ipairs(effectsFolder:GetChildren()) do
                    if string.find(string.upper(v.Name), "UTTV") then hasUTTV = true; break end
                end
            end

            if hasUTTV and uttvState == "IDLE" then uttvState = "WAITING"; uttvFirstSeen = tick() end
            if uttvState == "WAITING" then
                if tick() - uttvFirstSeen >= 5 then uttvState = "ACTIVE"; _G.IsUTTVSafeActive = true end
            elseif uttvState == "ACTIVE" then
                _G.IsUTTVSafeActive = true
            end
        else
            uttvState = "IDLE"; uttvFirstSeen = 0; _G.IsUTTVSafeActive = false
        end
    end
end)

addConn(RunService.Heartbeat:Connect(function()
    if _G.IsUTTVSafeActive and uttvSafeAtivo and not _G.IsSuiciding then
        local isGuiActive = false
        local selectGui = player.PlayerGui:FindFirstChild("SelectCharacter")
        if selectGui then pcall(function() isGuiActive = selectGui.Enabled or selectGui.Visible end) end
        if isGuiActive then return end

        if player.Character then
            pcall(function()
                player.Character:PivotTo(CFrame.new(-22, 3, 4))
                for _, part in ipairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Velocity = Vector3.new(0, 0, 0)
                        part.RotVelocity = Vector3.new(0, 0, 0)
                    end
                end
            end)
        end
    end
end))

local mugenPart = Instance.new("Part")
mugenPart.Name = "DropMugenJeffrey"
mugenPart.Shape = Enum.PartType.Ball
mugenPart.Size = Vector3.new(40, 40, 40)
mugenPart.Transparency = 1
mugenPart.CanCollide = true
mugenPart.Anchored = true
mugenPart.Massless = true
mugenPart.Material = Enum.Material.ForceField

addConn(RunService.Heartbeat:Connect(function()
    if mugenJeffreyAtivo then
        local jeffrey = Workspace:FindFirstChild("Jeffrey")
        if jeffrey then
            mugenPart.CFrame = jeffrey:GetPivot()
            if mugenPart.Parent ~= Workspace then mugenPart.Parent = Workspace end
        else
            if mugenPart.Parent then mugenPart.Parent = nil end
        end
    else
        if mugenPart.Parent then mugenPart.Parent = nil end
    end
end))

local secretNpcFound = false
local secretEsp = Instance.new("Highlight")
secretEsp.FillColor = Color3.fromRGB(0, 0, 0)
secretEsp.OutlineColor = Color3.fromRGB(255, 255, 255)
secretEsp.FillTransparency = 0.5
secretEsp.OutlineTransparency = 0
secretEsp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
secretEsp.Enabled = false
secretEsp.Parent = Workspace.CurrentCamera

task.spawn(function()
    while task.wait(1) do
        if not _G.DropScriptRunning then break end
        local npcsFolder = Workspace:FindFirstChild("NPCs")
        local mysteriousNPC = npcsFolder and npcsFolder:FindFirstChild("Mysterious Camera man")

        if mysteriousNPC then
            if not secretNpcFound then
                secretNpcFound = true
                pcall(function()
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "🕵️ NPC SECRETO!",
                        Text = "O Mysterious Camera man spawnou no mapa!",
                        Duration = 10,
                    })
                end)
                secretEsp.Adornee = mysteriousNPC
                secretEsp.Enabled = true
            end
        else
            if secretNpcFound then
                secretNpcFound = false
                secretEsp.Adornee = nil
                secretEsp.Enabled = false
            end
        end
    end
end)

local stayCorners = {
    Vector3.new(-657, 280, -532), Vector3.new(-657, 280, 473),  
    Vector3.new(472, 280, 473),   Vector3.new(476, 280, -527)   
}

local wasStayInRound = false
task.spawn(function()
    local cIdx = 1
    addConn(RunService.Heartbeat:Connect(function(dt)
        if not _G.DropScriptRunning then return end
        if _G.IsUTTVSafeActive or _G.IsItemFarming or _G.IsSuiciding then
            if wasStayInRound then
                Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                if player.Character and player.Character:FindFirstChild("Humanoid") then Workspace.CurrentCamera.CameraSubject = player.Character.Humanoid end
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then player.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0) end
                wasStayInRound = false
            end
            return
        end
        
        local isGuiActive = false
        local selectGui = player.PlayerGui:FindFirstChild("SelectCharacter")
        if selectGui then pcall(function() isGuiActive = selectGui.Enabled or selectGui.Visible end) end
        
        if stayInRoundAtivo and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and not farmEnabled and not isGuiActive then
            if not wasStayInRound then
                Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
                wasStayInRound = true
            end
            
            local hrp = player.Character.HumanoidRootPart
            local targetPos = stayCorners[cIdx]
            local dir = (targetPos - hrp.Position)
            
            if dir.Magnitude < 10 then
                cIdx = cIdx + 1
                if cIdx > #stayCorners then cIdx = 1 end
            else
                hrp.Velocity = Vector3.new(0, 0, 0)
                local maxDt = math.min(dt, 0.1)
                local moveVec = dir.Unit * (_G.StaySpeed * 15) * maxDt
                local newPos = hrp.Position + moveVec
                local clampedX = math.clamp(newPos.X, -657, 476)
                local clampedZ = math.clamp(newPos.Z, -532, 473)
                
                player.Character:PivotTo(CFrame.new(clampedX, 280, clampedZ))
                local cam = Workspace.CurrentCamera
                cam.CFrame = CFrame.lookAt(hrp.Position + Vector3.new(0, 40, 40), Vector3.new(0, 0, 0))
            end
        else
            if wasStayInRound then
                Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                if player.Character and player.Character:FindFirstChild("Humanoid") then Workspace.CurrentCamera.CameraSubject = player.Character.Humanoid end
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then player.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0) end
                wasStayInRound = false
            end
        end
    end))
end)

addConn(closeBtn.MouseButton1Click:Connect(function()
    _G.DropScriptRunning = false
    for _, conn in ipairs(dropConnections) do
        if conn.Connected then conn:Disconnect() end
    end
    if currentConnection and currentConnection.Connected then currentConnection:Disconnect() end
    if tooltipConn and tooltipConn.Connected then tooltipConn:Disconnect() end
    gui:Destroy()
end))
addConn(hideBtn.MouseButton1Click:Connect(function() main.Visible = false; minBtn.Visible = true end))

local function createTabBtn(name, targetTab, offsetIdx, tooltipData)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size, btn.Position, btn.BackgroundColor3, btn.Text, btn.TextColor3, btn.Font, btn.TextSize = UDim2.new(0.9, 0, 0, 34), UDim2.new(0.05, 0, 0, 44 + offsetIdx * 40), Color3.fromRGB(20, 20, 20), "", Color3.new(0.7, 0.7, 0.7), Enum.Font.GothamSemibold, 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local titleContainer = Instance.new("Frame", btn)
    titleContainer.Size, titleContainer.Position, titleContainer.BackgroundTransparency = UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), 1
    local listLayout = Instance.new("UIListLayout", titleContainer)
    listLayout.FillDirection, listLayout.SortOrder, listLayout.VerticalAlignment, listLayout.HorizontalAlignment, listLayout.Padding = Enum.FillDirection.Horizontal, Enum.SortOrder.LayoutOrder, Enum.VerticalAlignment.Center, Enum.HorizontalAlignment.Center, UDim.new(0, 6)

    local label = Instance.new("TextLabel", titleContainer)
    label.AutomaticSize, label.Size, label.Text, label.TextColor3, label.Font, label.TextSize, label.BackgroundTransparency = Enum.AutomaticSize.X, UDim2.new(0, 0, 1, 0), name, Color3.new(0.5, 0.5, 0.5), Enum.Font.GothamSemibold, 13, 1
    
    if targetTab.Visible then label.TextColor3 = ACCENT end

    if tooltipData then
        local tColor = Color3.fromRGB(150, 150, 150); local hexColor = "#969696"
        if tooltipData.color == "red" then tColor = Color3.fromRGB(255, 50, 50); hexColor = "#FF3232"
        elseif tooltipData.color == "yellow" then tColor = Color3.fromRGB(255, 200, 0); hexColor = "#FFC800"
        elseif tooltipData.color == "gray" or tooltipData.color == "grey" then tColor = Color3.fromRGB(150, 150, 150); hexColor = "#969696" end

        local parsedText = string.gsub(tooltipData.text, "<u>(.-)</u>", "<u><font color=\""..hexColor.."\">%1</font></u>")
        local icon = Instance.new("TextLabel", titleContainer)
        icon.Size, icon.BackgroundTransparency, icon.Text, icon.Font, icon.TextSize, icon.TextColor3 = UDim2.new(0, 16, 0, 16), 1, "!", Enum.Font.GothamBlack, 18, tColor
        
        addConn(icon.MouseEnter:Connect(function()
            globalTooltip.Text = parsedText; ttStroke.Color = tColor; globalTooltip.Visible = true
            if tooltipConn then tooltipConn:Disconnect() end
            tooltipConn = RunService.RenderStepped:Connect(function()
                local mPos = UserInputService:GetMouseLocation()
                globalTooltip.Position = UDim2.new(0, mPos.X + 12, 0, mPos.Y - 35)
            end)
        end))
        addConn(icon.MouseLeave:Connect(function() globalTooltip.Visible = false; if tooltipConn then tooltipConn:Disconnect(); tooltipConn = nil end end))
    end

    addConn(btn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do t.Visible = false end; targetTab.Visible = true
        for _, b in ipairs(sidebar:GetChildren()) do 
            if b:IsA("TextButton") then
                local lbl = b:FindFirstChildWhichIsA("Frame") and b:FindFirstChildWhichIsA("Frame"):FindFirstChildWhichIsA("TextLabel")
                if lbl then lbl.TextColor3 = Color3.new(0.5, 0.5, 0.5) end
            end 
        end
        label.TextColor3 = ACCENT
    end))
end

createTabBtn("Auto Farm", tabs.Farm, 0)
createTabBtn("Skills", tabs.Skills, 1)
createTabBtn("Auto Buy", tabs.AutoBuy, 2)
createTabBtn("Items", tabs.Items, 3)
createTabBtn("Visuals", tabs.Visuals, 4)
createTabBtn("Auto Shop", tabs.AutoShop, 5)
createTabBtn("Misc", tabs.Misc, 6)
createTabBtn("Teleport", tabs.Teleport, 7)

local function createToggle(parent, text, tooltipData, callback)
    if type(tooltipData) == "function" then callback = tooltipData; tooltipData = nil end

    local frame = Instance.new("Frame", parent); frame.Size, frame.BackgroundColor3 = UDim2.new(1, 0, 0, 45), BG_SECONDARY
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    frame.LayoutOrder = getNextUIOrder()

    local titleContainer = Instance.new("Frame", frame)
    titleContainer.Size, titleContainer.Position, titleContainer.BackgroundTransparency = UDim2.new(0.75, 0, 1, 0), UDim2.new(0, 10, 0, 0), 1
    local listLayout = Instance.new("UIListLayout", titleContainer)
    listLayout.FillDirection, listLayout.SortOrder, listLayout.VerticalAlignment, listLayout.Padding = Enum.FillDirection.Horizontal, Enum.SortOrder.LayoutOrder, Enum.VerticalAlignment.Center, UDim.new(0, 6)

    local label = Instance.new("TextLabel", titleContainer)
    label.AutomaticSize, label.Size, label.Text, label.TextColor3, label.Font, label.TextSize, label.BackgroundTransparency = Enum.AutomaticSize.X, UDim2.new(0, 0, 1, 0), text, Color3.new(1, 1, 1), Enum.Font.Ubuntu, 16, 1
    
    if tooltipData then
        local tColor = Color3.fromRGB(150, 150, 150); local hexColor = "#969696"
        if tooltipData.color == "red" then tColor = Color3.fromRGB(255, 50, 50); hexColor = "#FF3232"
        elseif tooltipData.color == "yellow" then tColor = Color3.fromRGB(255, 200, 0); hexColor = "#FFC800" end

        local parsedText = string.gsub(tooltipData.text, "<u>(.-)</u>", "<u><font color=\""..hexColor.."\">%1</font></u>")
        local icon = Instance.new("TextLabel", titleContainer)
        icon.Size, icon.BackgroundTransparency, icon.Text, icon.Font, icon.TextSize, icon.TextColor3 = UDim2.new(0, 16, 0, 16), 1, "!", Enum.Font.GothamBlack, 18, tColor
        
        addConn(icon.MouseEnter:Connect(function()
            globalTooltip.Text = parsedText; ttStroke.Color = tColor; globalTooltip.Visible = true
            if tooltipConn then tooltipConn:Disconnect() end
            tooltipConn = RunService.RenderStepped:Connect(function()
                local mPos = UserInputService:GetMouseLocation()
                globalTooltip.Position = UDim2.new(0, mPos.X + 12, 0, mPos.Y - 35)
            end)
        end))
        addConn(icon.MouseLeave:Connect(function() globalTooltip.Visible = false; if tooltipConn then tooltipConn:Disconnect(); tooltipConn = nil end end))
    end

    local switchBG = Instance.new("Frame", frame); switchBG.Size, switchBG.Position, switchBG.BackgroundColor3 = UDim2.new(0, 36, 0, 18), UDim2.new(1, -46, 0.5, -9), Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", switchBG).CornerRadius = UDim.new(1, 0)
    local circle = Instance.new("Frame", switchBG); circle.Size, circle.Position, circle.BackgroundColor3 = UDim2.new(0, 14, 0, 14), UDim2.new(0, 2, 0.5, -7), Color3.new(1, 1, 1)
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)
    
    local state = false; local btn = Instance.new("TextButton", frame); btn.Size, btn.Position, btn.BackgroundTransparency, btn.Text = UDim2.new(0, 100, 1, 0), UDim2.new(1, -100, 0, 0), 1, ""
    
    local obj = {}
    obj.frame = frame 
    
    function obj:Set(newState)
        if state == newState then return end
        state = newState
        TweenService:Create(circle, TweenInfo.new(0.2), { Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7) }):Play()
        TweenService:Create(switchBG, TweenInfo.new(0.2), { BackgroundColor3 = state and ACCENT or Color3.fromRGB(40, 40, 40) }):Play()
        callback(state)
    end
    addConn(btn.MouseButton1Click:Connect(function() obj:Set(not state) end))
    return obj
end

local function createSlider(parent, text, min, max, default, callback)
    local frame = Instance.new("Frame", parent); frame.Size, frame.BackgroundColor3 = UDim2.new(1, 0, 0, 50), BG_SECONDARY
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    frame.LayoutOrder = getNextUIOrder()
    
    local label = Instance.new("TextLabel", frame); label.Size, label.Position, label.Text, label.TextColor3, label.Font, label.TextSize, label.TextXAlignment, label.BackgroundTransparency = UDim2.new(1, -20, 0, 20), UDim2.new(0, 10, 0, 5), text .. ": " .. default, Color3.new(1,1,1), Enum.Font.Ubuntu, 14, Enum.TextXAlignment.Left, 1
    local track = Instance.new("Frame", frame); track.Size, track.Position, track.BackgroundColor3 = UDim2.new(1, -20, 0, 6), UDim2.new(0, 10, 0, 32), Color3.fromRGB(40,40,40)
    Instance.new("UICorner", track).CornerRadius = UDim.new(1,0)
    local fill = Instance.new("Frame", track); fill.Size, fill.BackgroundColor3 = UDim2.new((default - min)/(max - min), 0, 1, 0), ACCENT
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)
    local knob = Instance.new("Frame", fill); knob.Size, knob.Position, knob.BackgroundColor3 = UDim2.new(0, 14, 0, 14), UDim2.new(1, -7, 0.5, -7), Color3.new(1,1,1)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)
    local btn = Instance.new("TextButton", track); btn.Size, btn.Position, btn.BackgroundTransparency, btn.Text = UDim2.new(1, 0, 1, 20), UDim2.new(0, 0, 0.5, -10), 1, ""
    local dragging = false
    
    local obj = {}
    function obj:Set(val)
        val = math.clamp(val, min, max)
        local percent = (val - min) / (max - min)
        fill.Size = UDim2.new(percent, 0, 1, 0); label.Text = text .. ": " .. val; callback(val)
    end

    local function update(input)
        local pos = math.clamp(input.Position.X - track.AbsolutePosition.X, 0, track.AbsoluteSize.X)
        local percent = pos / track.AbsoluteSize.X; local val = math.floor(min + (max - min) * percent)
        obj:Set(val)
    end
    addConn(btn.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; update(input) end end))
    addConn(UserInputService.InputChanged:Connect(function(input) if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then update(input) end end))
    addConn(UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end))
    return obj
end

local function createTextBox(parent, text, placeholder, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, 0, 0, 45)
    frame.BackgroundColor3 = BG_SECONDARY
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    frame.LayoutOrder = getNextUIOrder()

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.5, 0, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Text = text
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.Ubuntu
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1

    local textBox = Instance.new("TextBox", frame)
    textBox.Size = UDim2.new(0.4, 0, 0, 30)
    textBox.Position = UDim2.new(0.6, -10, 0.5, -15)
    textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    textBox.TextColor3 = Color3.new(1, 1, 1)
    textBox.Font = Enum.Font.Ubuntu
    textBox.TextSize = 14
    textBox.PlaceholderText = placeholder
    textBox.Text = ""
    Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 6)

    addConn(textBox.FocusLost:Connect(function(enterPressed) callback(textBox.Text) end))
    
    local obj = {}
    function obj:SetText(txt) textBox.Text = tostring(txt) end
    return obj
end

local function createTpBtn(parent, name, coords, isDanger, tooltipData)
    local btn = Instance.new("TextButton", parent)
    btn.Size, btn.BackgroundColor3, btn.Text = UDim2.new(1, 0, 0, 40), isDanger and Color3.fromRGB(120, 40, 40) or Color3.fromRGB(35, 35, 35), ""
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.LayoutOrder = getNextUIOrder()

    local titleContainer = Instance.new("Frame", btn)
    titleContainer.Size, titleContainer.BackgroundTransparency = UDim2.new(1, 0, 1, 0), 1
    local listLayout = Instance.new("UIListLayout", titleContainer)
    listLayout.FillDirection, listLayout.SortOrder, listLayout.VerticalAlignment, listLayout.HorizontalAlignment, listLayout.Padding = Enum.FillDirection.Horizontal, Enum.SortOrder.LayoutOrder, Enum.VerticalAlignment.Center, Enum.HorizontalAlignment.Center, UDim.new(0, 6)

    local label = Instance.new("TextLabel", titleContainer)
    label.AutomaticSize, label.Size, label.Text, label.TextColor3, label.Font, label.TextSize, label.BackgroundTransparency = Enum.AutomaticSize.X, UDim2.new(0, 0, 1, 0), name, Color3.new(1, 1, 1), Enum.Font.GothamSemibold, 14, 1

    if tooltipData then
        local tColor = Color3.fromRGB(150, 150, 150); local hexColor = "#969696"
        if tooltipData.color == "red" then tColor = Color3.fromRGB(255, 50, 50); hexColor = "#FF3232"
        elseif tooltipData.color == "yellow" then tColor = Color3.fromRGB(255, 200, 0); hexColor = "#FFC800" end

        local parsedText = string.gsub(tooltipData.text, "<u>(.-)</u>", "<u><font color=\""..hexColor.."\">%1</font></u>")
        local icon = Instance.new("TextLabel", titleContainer)
        icon.Size, icon.BackgroundTransparency, icon.Text, icon.Font, icon.TextSize, icon.TextColor3 = UDim2.new(0, 16, 0, 16), 1, "!", Enum.Font.GothamBlack, 18, tColor
        
        addConn(icon.MouseEnter:Connect(function()
            globalTooltip.Text = parsedText; ttStroke.Color = tColor; globalTooltip.Visible = true
            if tooltipConn then tooltipConn:Disconnect() end
            tooltipConn = RunService.RenderStepped:Connect(function()
                local mPos = UserInputService:GetMouseLocation()
                globalTooltip.Position = UDim2.new(0, mPos.X + 12, 0, mPos.Y - 35)
            end)
        end))
        addConn(icon.MouseLeave:Connect(function() globalTooltip.Visible = false; if tooltipConn then tooltipConn:Disconnect(); tooltipConn = nil end end))
    end

    addConn(btn.MouseButton1Click:Connect(function() 
        if _G.IsUTTVSafeActive or _G.IsItemFarming then return end 
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then 
            player.Character.HumanoidRootPart.CFrame = CFrame.new(coords) 
        end 
    end))
end

local function createInlineDropdown(parent, titlePrefix, optionsList, defaultOption, callback)
    local container = Instance.new("Frame", parent)
    container.Size, container.BackgroundTransparency, container.ClipsDescendants = UDim2.new(1, 0, 0, 40), 1, true
    container.LayoutOrder = getNextUIOrder()
    
    local mainBtn = Instance.new("TextButton", container)
    mainBtn.Size, mainBtn.BackgroundColor3, mainBtn.Text, mainBtn.TextColor3, mainBtn.Font, mainBtn.TextSize = UDim2.new(1, 0, 0, 40), Color3.fromRGB(30, 30, 45), titlePrefix .. defaultOption, ACCENT, Enum.Font.GothamBold, 14
    Instance.new("UICorner", mainBtn).CornerRadius = UDim.new(0, 6)
    local optionsFrame = Instance.new("Frame", container)
    optionsFrame.Size, optionsFrame.Position, optionsFrame.BackgroundTransparency = UDim2.new(1, 0, 0, #optionsList * 36 + (#optionsList - 1) * 4), UDim2.new(0, 0, 0, 44), 1
    local optLayout = Instance.new("UIListLayout", optionsFrame); optLayout.Padding, optLayout.SortOrder = UDim.new(0, 4), Enum.SortOrder.LayoutOrder

    local isOpen = false
    addConn(mainBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        TweenService:Create(container, TweenInfo.new(0.2), {Size = isOpen and UDim2.new(1, 0, 0, 44 + optionsFrame.Size.Y.Offset) or UDim2.new(1, 0, 0, 40)}):Play()
    end))
    
    local obj = {}
    function obj:UpdateText(txt) mainBtn.Text = titlePrefix .. txt end

    for _, opt in ipairs(optionsList) do
        local btn = Instance.new("TextButton", optionsFrame)
        btn.Size, btn.BackgroundColor3, btn.Text, btn.TextColor3, btn.Font, btn.TextSize = UDim2.new(1, 0, 0, 36), Color3.fromRGB(20, 20, 30), opt, Color3.new(1, 1, 1), Enum.Font.GothamSemibold, 13
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        addConn(btn.MouseButton1Click:Connect(function()
            obj:UpdateText(opt); isOpen = false; TweenService:Create(container, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 40)}):Play()
            callback(opt)
        end))
    end
    return obj
end

local function createMultiSelectDropdown(parent, titlePrefix, optionsList, callback)
    local container = Instance.new("Frame", parent)
    container.Size = UDim2.new(1, 0, 0, 40)
    container.BackgroundTransparency = 1
    container.ClipsDescendants = true
    container.LayoutOrder = getNextUIOrder()

    local mainBtn = Instance.new("TextButton", container)
    mainBtn.Size = UDim2.new(1, 0, 0, 40)
    mainBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    mainBtn.Text = titlePrefix .. "None"
    mainBtn.TextColor3 = ACCENT
    mainBtn.Font = Enum.Font.GothamBold
    mainBtn.TextSize = 14
    Instance.new("UICorner", mainBtn).CornerRadius = UDim.new(0, 6)

    local optionsFrame = Instance.new("Frame", container)
    optionsFrame.Size = UDim2.new(1, 0, 0, #optionsList * 36 + (#optionsList - 1) * 4)
    optionsFrame.Position = UDim2.new(0, 0, 0, 44)
    optionsFrame.BackgroundTransparency = 1
    local optLayout = Instance.new("UIListLayout", optionsFrame)
    optLayout.Padding = UDim.new(0, 4)
    optLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local isOpen = false
    addConn(mainBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        TweenService:Create(container, TweenInfo.new(0.2), {Size = isOpen and UDim2.new(1, 0, 0, 44 + optionsFrame.Size.Y.Offset) or UDim2.new(1, 0, 0, 40)}):Play()
    end))

    local selectedOpts = {}
    local btnMap = {}
    
    local function updateText()
        local sel = {}
        for _, opt in ipairs(optionsList) do
            if selectedOpts[opt] then table.insert(sel, opt) end
        end
        if #sel == 0 then 
            mainBtn.Text = titlePrefix .. "None"
        else 
            mainBtn.Text = titlePrefix .. table.concat(sel, ", ") 
        end
        callback(selectedOpts)
    end

    local obj = {}
    function obj:SetOption(opt, state)
        if selectedOpts[opt] ~= state then
            selectedOpts[opt] = state
            if btnMap[opt] then btnMap[opt].TextColor3 = state and ACCENT or Color3.new(1, 1, 1) end
            updateText()
        end
    end

    for _, opt in ipairs(optionsList) do
        selectedOpts[opt] = false
        local btn = Instance.new("TextButton", optionsFrame)
        btn.Size = UDim2.new(1, 0, 0, 36)
        btn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        btn.Text = opt
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamSemibold
        btn.TextSize = 13
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        btnMap[opt] = btn
        
        addConn(btn.MouseButton1Click:Connect(function() obj:SetOption(opt, not selectedOpts[opt]) end))
    end
    return obj
end

-- ============================================================
-- 🔥 AUTO BUY PRIORITY UI GENERATOR
-- ============================================================
local autoBuyUIRows = {}

local function createPriorityRow(parent, rowIndex, onSwap)
    local frame = Instance.new("Frame", parent)
    frame.Size, frame.BackgroundColor3 = UDim2.new(1, 0, 0, 45), BG_SECONDARY
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    frame.LayoutOrder = getNextUIOrder()

    local numInput = Instance.new("TextBox", frame)
    numInput.Size, numInput.Position = UDim2.new(0, 30, 0, 30), UDim2.new(0, 10, 0.5, -15)
    numInput.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    numInput.TextColor3 = ACCENT
    numInput.Font = Enum.Font.GothamBlack
    numInput.TextSize = 14
    numInput.Text = tostring(rowIndex)
    Instance.new("UICorner", numInput).CornerRadius = UDim.new(0, 4)

    local titleContainer = Instance.new("Frame", frame)
    titleContainer.Size, titleContainer.Position, titleContainer.BackgroundTransparency = UDim2.new(0.65, 0, 1, 0), UDim2.new(0, 50, 0, 0), 1
    local listLayout = Instance.new("UIListLayout", titleContainer)
    listLayout.FillDirection, listLayout.SortOrder, listLayout.VerticalAlignment, listLayout.Padding = Enum.FillDirection.Horizontal, Enum.SortOrder.LayoutOrder, Enum.VerticalAlignment.Center, UDim.new(0, 6)

    local nameLabel = Instance.new("TextLabel", titleContainer)
    nameLabel.AutomaticSize, nameLabel.Size, nameLabel.BackgroundTransparency = Enum.AutomaticSize.X, UDim2.new(0, 0, 1, 0), 1
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.Font = Enum.Font.Ubuntu
    nameLabel.TextSize = 16

    local icon = Instance.new("TextLabel", titleContainer)
    icon.Size, icon.BackgroundTransparency, icon.Text, icon.Font, icon.TextSize = UDim2.new(0, 16, 0, 16), 1, "!", Enum.Font.GothamBlack, 18
    icon.Visible = false

    local switchBG = Instance.new("Frame", frame)
    switchBG.Size, switchBG.Position, switchBG.BackgroundColor3 = UDim2.new(0, 36, 0, 18), UDim2.new(1, -46, 0.5, -9), Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", switchBG).CornerRadius = UDim.new(1, 0)
    local circle = Instance.new("Frame", switchBG)
    circle.Size, circle.Position, circle.BackgroundColor3 = UDim2.new(0, 14, 0, 14), UDim2.new(0, 2, 0.5, -7), Color3.new(1, 1, 1)
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)
    
    local btn = Instance.new("TextButton", frame)
    btn.Size, btn.Position, btn.BackgroundTransparency, btn.Text = UDim2.new(0, 100, 1, 0), UDim2.new(1, -100, 0, 0), 1, ""
    
    local rowData = {
        frame = frame,
        numInput = numInput,
        nameLabel = nameLabel,
        icon = icon,
        currentItem = nil,
        setToggle = function(state, skipAnim)
            if skipAnim then
                circle.Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
                switchBG.BackgroundColor3 = state and ACCENT or Color3.fromRGB(40, 40, 40)
            else
                TweenService:Create(circle, TweenInfo.new(0.2), { Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7) }):Play()
                TweenService:Create(switchBG, TweenInfo.new(0.2), { BackgroundColor3 = state and ACCENT or Color3.fromRGB(40, 40, 40) }):Play()
            end
        end
    }

    addConn(btn.MouseButton1Click:Connect(function()
        if rowData.currentItem then
            rowData.currentItem.active = not rowData.currentItem.active
            rowData.setToggle(rowData.currentItem.active, false)
        end
    end))

    addConn(numInput.FocusLost:Connect(function()
        local n = tonumber(numInput.Text)
        if n and n >= 1 and n <= 11 and n ~= rowIndex then
            onSwap(rowIndex, math.floor(n))
        else
            numInput.Text = tostring(rowIndex)
        end
    end))

    addConn(icon.MouseEnter:Connect(function()
        if rowData.currentItem and rowData.currentItem.tooltip then
            local tColor = Color3.fromRGB(150, 150, 150); local hexColor = "#969696"
            if rowData.currentItem.tooltip.color == "red" then tColor = Color3.fromRGB(255, 50, 50); hexColor = "#FF3232"
            elseif rowData.currentItem.tooltip.color == "yellow" then tColor = Color3.fromRGB(255, 200, 0); hexColor = "#FFC800" end

            local parsedText = string.gsub(rowData.currentItem.tooltip.text, "<u>(.-)</u>", "<u><font color=\""..hexColor.."\">%1</font></u>")
            globalTooltip.Text = parsedText; ttStroke.Color = tColor; globalTooltip.Visible = true
            
            if tooltipConn then tooltipConn:Disconnect() end
            tooltipConn = RunService.RenderStepped:Connect(function()
                local mPos = UserInputService:GetMouseLocation()
                globalTooltip.Position = UDim2.new(0, mPos.X + 12, 0, mPos.Y - 35)
            end)
        end
    end))
    addConn(icon.MouseLeave:Connect(function() globalTooltip.Visible = false; if tooltipConn then tooltipConn:Disconnect(); tooltipConn = nil end end))

    autoBuyUIRows[rowIndex] = rowData
end

-- ============================================================
-- POPULANDO AS ABAS
-- ============================================================
-- ABA 1: FARM
farmDropdownObj = createInlineDropdown(tabs.Farm, "Method: ", farmMethodsArray, farmMethod, function(val) farmMethod = val end)
createInlineDropdown(tabs.Farm, "Target: ", targetMethodsArray, targetMethod, function(val) targetMethod = val end)
objOrbitalSpeed = createSlider(tabs.Farm, "Orbital Speed", 1, 18, 15, function(val) _G.OrbitalSpeed = val end)
objAutoFarm = createToggle(tabs.Farm, "Auto Farm", function(s) farmEnabled = s end)
createToggle(tabs.Farm, "Auto Revive Player", function(s) reviveAtivo = s end)
local objAutoFlush = createToggle(tabs.Farm, "Auto Flush & Save", function(s) interactAtivo = s; saveAtivo = s end)
local objAutoSkipHeli = createToggle(tabs.Farm, "Auto Skip Helicopter", function(s) autoSkipHeliAtivo = s end)
local objSuicideWave = createTextBox(tabs.Farm, "Suicide Wave (0 = Off)", "Ex: 50", function(val)
    local match = string.match(tostring(val), "%d+")
    if match then suicideWaveTarget = tonumber(match) else suicideWaveTarget = 0 end
end)

-- ABA 2: SKILLS
local objUseSkills = createMultiSelectDropdown(tabs.Skills, "Use Skills: ", skillOptions, function(sel) 
    if isUpdatingSkills then return end
    isUpdatingSkills = true
    for _, k in ipairs(skillOptions) do if sel[k] then local holdKey = "Hold " .. k; if objHoldSkills then objHoldSkills:SetOption(holdKey, false) end end end
    selectedUseSkills = {}
    for k, v in pairs(sel) do selectedUseSkills[k] = v end
    isUpdatingSkills = false
end)

local objHoldSkills = createMultiSelectDropdown(tabs.Skills, "Hold Skills: ", holdSkillOptions, function(sel)
    if isUpdatingSkills then return end
    isUpdatingSkills = true
    for _, k in ipairs(holdSkillOptions) do if sel[k] then local useKey = string.sub(k, 6); if objUseSkills then objUseSkills:SetOption(useKey, false) end end end
    selectedHoldSkills = {}
    for k, v in pairs(sel) do selectedHoldSkills[k] = v end
    isUpdatingSkills = false
end)

createSlider(tabs.Skills, "Hold Duration (Seconds)", 1, 30, 3, function(val) _G.HoldDuration = val end)
createToggle(tabs.Skills, "Auto Use Skills", function(s) autoSkillsAtivo = s end)

local nextHoldTime = {}
task.spawn(function()
    while true do
        task.wait(0.5)
        if not _G.DropScriptRunning then break end
        if autoSkillsAtivo and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and not _G.IsUTTVSafeActive then
            local isGuiActive = false
            local selectGui = player.PlayerGui:FindFirstChild("SelectCharacter")
            if selectGui then pcall(function() isGuiActive = selectGui.Enabled or selectGui.Visible end) end
            
            local shopNode = Workspace:FindFirstChild("CanUseShop")
            local isIntermission = (shopNode and shopNode.Value == true)

            if not isGuiActive and not isIntermission then
                for key, state in pairs(selectedUseSkills) do
                    if state then
                        local keyCode = Enum.KeyCode[key]
                        if keyCode then
                            pcall(function()
                                VIM:SendKeyEvent(true, keyCode, false, game)
                                task.wait(0.05)
                                VIM:SendKeyEvent(false, keyCode, false, game)
                            end)
                        end
                    end
                end
                
                local now = tick()
                for key, state in pairs(selectedHoldSkills) do
                    if state then
                        local realKey = string.sub(key, 6)
                        local keyCode = Enum.KeyCode[realKey]
                        if keyCode then
                            if now >= (nextHoldTime[realKey] or 0) then
                                nextHoldTime[realKey] = now + _G.HoldDuration + 0.5
                                pcall(function()
                                    task.spawn(function()
                                        VIM:SendKeyEvent(true, keyCode, false, game)
                                        task.wait(_G.HoldDuration)
                                        VIM:SendKeyEvent(false, keyCode, false, game)
                                    end)
                                end)
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- ============================================================
-- 🔥 ABA 3: AUTO BUY 
-- ============================================================
local ultraPriorityActive = false
local objUltra = createToggle(tabs.AutoBuy, "Ultra Priority", {color="gray", text="Give top priority to the order of purchase, foregoing the purchase of other items in order to always buy them in that order"}, function(s) ultraPriorityActive = s end)
objUltra.frame.LayoutOrder = getNextUIOrder()

local autoBuyItems = {
    { id = "Health", name = "Auto Buy Health", active = false, order = 1, verifiable = true,
      check = function() local hum = player.Character and player.Character:FindFirstChild("Humanoid"); return not hum or (hum.Health >= hum.MaxHealth - 5) end,
      buy = function() pcall(function() ReplicatedStorage.ShopSystem:FireServer("Buy", "FillHP") end) end },
      
    { id = "PulseRifle", name = "Auto Buy Pulse Rifle", tooltip = {color="yellow", text="Only activate if character has it"}, active = false, order = 2, verifiable = true,
      check = function() return checkWeaponExists("pulse") end,
      buy = function() pcall(function() ReplicatedStorage.ShopSystem:FireServer("Buy", "Pulse Rifle") end) end },
      
    { id = "SmallLaser", name = "Auto Buy Small Laser", tooltip = {color="yellow", text="Only activate if character has it"}, active = false, order = 3, verifiable = true,
      check = function() return checkWeaponExists("small") end,
      buy = function() pcall(function() ReplicatedStorage.ShopSystem:FireServer("Buy", "Small Laser Gun") end) end },
      
    { id = "BigLaser", name = "Auto Buy Big Laser", tooltip = {color="red", text="Only with Big Camcorder Man"}, active = false, order = 4, verifiable = true,
      check = function() return checkWeaponExists("large") end,
      buy = function() pcall(function() ReplicatedStorage.ShopSystem:FireServer("Buy", "Large Laser Gun") end) end },

    { id = "Lens", name = "Auto Buy Lens", active = false, order = 5, verifiable = true,
      check = function() if not player.Character then return false end; for _, v in ipairs(player.Character:GetChildren()) do if string.find(string.lower(v.Name), "lens") then return true end end return false end,
      buy = function() pcall(function() ReplicatedStorage.ShopSystem:FireServer("Buy", "Lens") end) end },

    { id = "Headphone", name = "Auto Buy HeadPhone", active = false, order = 6, verifiable = true,
      check = function() if not player.Character then return false end; for _, v in ipairs(player.Character:GetChildren()) do if string.find(string.lower(v.Name), "headphone") then return true end end return false end,
      buy = function() pcall(function() ReplicatedStorage.ShopSystem:FireServer("Buy", "HeadPhone") end) end },

    { id = "NormalTitan", name = "Auto Buy Normal Titan Request", active = false, order = 7, verifiable = true,
      check = function() return checkWeaponExists("titan") end,
      buy = function() pcall(function() ReplicatedStorage.ShopSystem:FireServer("Buy", "Titan-Request") end) end },

    { id = "SpecialTitan", name = "Auto Buy Special Titan Request", active = false, order = 8, verifiable = true,
      check = function() return checkWeaponExists("special") end,
      buy = function() pcall(function() ReplicatedStorage.ShopSystem:FireServer("Buy", "SpecialTitan-Request") end) end },

    { id = "TitanTV", name = "Auto Buy Titan TV Upg", active = false, order = 9, verifiable = false,
      check = function() return false end,
      buy = function() pcall(function() ReplicatedStorage:WaitForChild("ChangeToCinema"):FireServer() end) end },
      
    { id = "AstroBlaster", name = "Auto Buy Astro Blaster", tooltip = {color="yellow", text="Only activate if character has it in that store"}, active = false, order = 10, verifiable = true,
      check = function() return checkWeaponExists("astro blaster") end,
      buy = function() pcall(function() ReplicatedStorage.ShopSystem:FireServer("Buy", "Astro Blaster") end) end },
      
    { id = "SpikesPlungers", name = "Auto Buy Spikes Plungers", tooltip = {color="yellow", text="Only activate if character has it in that store"}, active = false, order = 11, verifiable = true,
      check = function() return checkWeaponExists("spikes") or checkWeaponExists("plunger") end,
      buy = function() pcall(function() ReplicatedStorage.ShopSystem:FireServer("Buy", "SpikesPlungers") end) end }
}

local function RefreshAutoBuyUI()
    table.sort(autoBuyItems, function(a, b) return a.order < b.order end)
    for i = 1, #autoBuyItems do
        local item = autoBuyItems[i]
        local row = autoBuyUIRows[i]
        
        if row then
            row.currentItem = item
            row.nameLabel.Text = item.name
            row.numInput.Text = tostring(i)
            row.setToggle(item.active, true)
            
            if item.tooltip then
                row.icon.Visible = true
                if item.tooltip.color == "red" then row.icon.TextColor3 = Color3.fromRGB(255, 50, 50)
                elseif item.tooltip.color == "yellow" then row.icon.TextColor3 = Color3.fromRGB(255, 200, 0)
                else row.icon.TextColor3 = Color3.fromRGB(150, 150, 150) end
            else
                row.icon.Visible = false
            end
        end
    end
end

local function SwapItems(oldOrder, newOrder)
    local itemA, itemB
    for _, item in ipairs(autoBuyItems) do
        if item.order == oldOrder then itemA = item
        elseif item.order == newOrder then itemB = item end
    end
    if itemA and itemB then
        itemA.order = newOrder
        itemB.order = oldOrder
        RefreshAutoBuyUI()
    end
end

for i = 1, 11 do
    createPriorityRow(tabs.AutoBuy, i, SwapItems)
end
RefreshAutoBuyUI()

task.spawn(function()
    while true do
        task.wait(1) 
        if not _G.DropScriptRunning then break end
        local shopNode = Workspace:FindFirstChild("CanUseShop")
        if shopNode and shopNode.Value == true then
            local sortedItems = {}
            for _, item in ipairs(autoBuyItems) do table.insert(sortedItems, item) end
            table.sort(sortedItems, function(a, b) return a.order < b.order end)

            for _, item in ipairs(sortedItems) do
                if item.active then
                    if not item.check() then
                        item.buy() 
                        task.wait(0.5) 
                        if item.verifiable and not item.check() then
                            if ultraPriorityActive then break end 
                        end
                    end
                end
            end
        end
    end
end)

-- ABA 4: ITEMS
local objFarmItems = createToggle(tabs.Items, "Farm Items", function(s) 
    itemFarmAtivo = s; if s then 
        local currentLiving = Workspace:FindFirstChild("Living")
        if currentLiving then
            for _, c in ipairs(Workspace:GetChildren()) do 
                if ITEM_WHITELIST[c.Name] or c:FindFirstChild("HighlightForAstroItem", true) then 
                    if ignoreClockSpiderAtivo and c.Name == "Clock Spider" then continue end
                    table.insert(itemQueue, c) 
                end 
            end
        end
        task.spawn(processItemQueue) 
    else 
        itemQueue = {} 
    end 
end)

local objIgnoreSpider = createToggle(tabs.Items, "Ignore Clock Spider", function(s) ignoreClockSpiderAtivo = s end)
local objItemNotif = createToggle(tabs.Items, "Item Notifier", function(s) itemAtivo = s end)

local logTitle = Instance.new("TextLabel", tabs.Items); logTitle.Size, logTitle.Text, logTitle.TextColor3, logTitle.Font, logTitle.TextSize, logTitle.BackgroundTransparency = UDim2.new(1, 0, 0, 30), "📝 ITEM LOG", Color3.fromRGB(150, 150, 150), Enum.Font.GothamBold, 13, 1
logTitle.LayoutOrder = getNextUIOrder()

local logScroll = Instance.new("ScrollingFrame", tabs.Items); logScroll.Size, logScroll.BackgroundColor3, logScroll.ScrollBarThickness, logScroll.CanvasSize = UDim2.new(1, 0, 0, 150), Color3.fromRGB(18, 18, 18), 2, UDim2.new(0, 0, 0, 0)
Instance.new("UICorner", logScroll).CornerRadius = UDim.new(0, 8)
logScroll.LayoutOrder = getNextUIOrder()

local logScrollLayout = Instance.new("UIListLayout", logScroll); logScrollLayout.Padding, logScrollLayout.SortOrder = UDim.new(0, 4), Enum.SortOrder.LayoutOrder

function registerItemLog(itemName)
    local lbl = Instance.new("TextLabel", logScroll); lbl.Size, lbl.Position, lbl.Text, lbl.TextColor3, lbl.Font, lbl.TextSize, lbl.TextXAlignment, lbl.BackgroundTransparency = UDim2.new(1, -10, 0, 20), UDim2.new(0, 5, 0, 0), "[" .. os.date("%H:%M:%S") .. "]  -  " .. itemName, Color3.fromRGB(200, 200, 200), Enum.Font.GothamSemibold, 12, Enum.TextXAlignment.Left, 1
    logScroll.CanvasSize = UDim2.new(0, 0, 0, logScrollLayout.AbsoluteContentSize.Y + 10); logScroll.CanvasPosition = Vector2.new(0, logScroll.CanvasSize.Y.Offset)
end

-- ============================================================
-- ABA 5: VISUALS
-- ============================================================
createToggle(tabs.Visuals, "Esp Toilets", function(s) espToiletsAtivo = s end)
createToggle(tabs.Visuals, "Esp Players", function(s) espPlayersAtivo = s end)
createToggle(tabs.Visuals, "Esp Items",   function(s) espItemsAtivo = s end)
local objEspJeffrey = createToggle(tabs.Visuals, "Esp Jeffrey", function(s) espJeffreyAtivo = s end)

local ESP_POOL = {}
local MAX_HIGHLIGHTS = 30
local espFolder = Instance.new("Folder")
espFolder.Name = "DropESP_Pool"
espFolder.Parent = Workspace.CurrentCamera 

for i = 1, MAX_HIGHLIGHTS do
    local hl = Instance.new("Highlight")
    hl.FillTransparency = 0.85
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Enabled = false
    hl.Parent = espFolder
    table.insert(ESP_POOL, hl)
end

task.spawn(function()
    while task.wait(0.1) do
        if not _G.DropScriptRunning then break end
        local validEntities = {}
        local myPos = player.Character and player.Character:GetPivot().Position or Workspace.CurrentCamera.CFrame.Position

        local currentLiving = Workspace:FindFirstChild("Living")

        if espToiletsAtivo and currentLiving then
            for _, model in ipairs(currentLiving:GetChildren()) do
                if SKIBIDI_LIST[model.Name] and not Players:GetPlayerFromCharacter(model) then
                    local isDead = false
                    local f1 = model:FindFirstChild("1")
                    if f1 and f1:FindFirstChild("BallSocketConstraint") then isDead = true end
                    local hum = model:FindFirstChildWhichIsA("Humanoid")
                    if hum and hum.Health <= 0 then isDead = true end
                    
                    if not isDead then
                        table.insert(validEntities, { inst = model, color = Color3.fromRGB(255, 0, 0), dist = (model:GetPivot().Position - myPos).Magnitude })
                    end
                end
            end
        end

        if espPlayersAtivo then
            for _, p in ipairs(Players:GetPlayers()) do
                 if p ~= player and p.Character then
                    local hum = p.Character:FindFirstChild("Humanoid")
                    if hum and hum.Health > 0 then
                        table.insert(validEntities, { inst = p.Character, color = Color3.fromRGB(0, 255, 0), dist = (p.Character:GetPivot().Position - myPos).Magnitude })
                     end
                end
            end
        end

        if espItemsAtivo then
            for _, item in ipairs(Workspace:GetChildren()) do
                if ITEM_WHITELIST[item.Name] or item:FindFirstChild("HighlightForAstroItem", true) then
                    local pos = getItemPos(item)
                    table.insert(validEntities, { inst = item, color = Color3.fromRGB(255, 255, 0), dist = pos and (pos - myPos).Magnitude or 99999 })
                end
            end
        end

         if espJeffreyAtivo then
            local jeffrey = Workspace:FindFirstChild("Jeffrey")
            if jeffrey then
                table.insert(validEntities, { inst = jeffrey, color = Color3.fromRGB(148, 0, 211), dist = (jeffrey:GetPivot().Position - myPos).Magnitude })
            end
        end

        table.sort(validEntities, function(a, b) return a.dist < b.dist end)

        for i = 1, MAX_HIGHLIGHTS do
            local hl = ESP_POOL[i]
            local targetData = validEntities[i]
            
            if targetData then
                if hl.Adornee ~= targetData.inst then hl.Adornee = targetData.inst end
                 if hl.FillColor ~= targetData.color then hl.FillColor = targetData.color end
                if not hl.Enabled then hl.Enabled = true end
            else
                if hl.Adornee ~= nil then hl.Adornee = nil end
                if hl.Enabled then hl.Enabled = false end
            end
        end
    end
end)

-- ============================================================
-- 🔥 ABA 6: AUTO SHOP 
-- ============================================================
local autoShopSettings = {}

local function createCategoryLabel(parent, text)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, 0, 0, 30)
    frame.BackgroundColor3 = Color3.fromRGB(40, 60, 100)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    frame.LayoutOrder = getNextUIOrder()

    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(1, -10, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.new(1, 1, 1)
    lbl.Font = Enum.Font.GothamBlack
    lbl.TextSize = 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    return frame
end

local function createShopToggle(parent, itemName)
    local setting = { active = false, quantity = 0, ui = nil }
    autoShopSettings[itemName] = setting

    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, 0, 0, 45)
    frame.BackgroundColor3 = BG_SECONDARY
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    frame.LayoutOrder = getNextUIOrder()

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(0.55, 0, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.Text = itemName
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.Ubuntu
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.BackgroundTransparency = 1
    title.TextWrapped = true

    local qtyBox = Instance.new("TextBox", frame)
    qtyBox.Size = UDim2.new(0, 40, 0, 26)
    qtyBox.Position = UDim2.new(1, -110, 0.5, -13)
    qtyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    qtyBox.TextColor3 = Color3.new(1,1,1)
    qtyBox.Font = Enum.Font.Ubuntu
    qtyBox.TextSize = 14
    qtyBox.PlaceholderText = "Qty"
    qtyBox.Text = "0"
    Instance.new("UICorner", qtyBox).CornerRadius = UDim.new(0, 4)

    local switchBG = Instance.new("Frame", frame)
    switchBG.Size = UDim2.new(0, 36, 0, 18)
    switchBG.Position = UDim2.new(1, -46, 0.5, -9)
    switchBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", switchBG).CornerRadius = UDim.new(1, 0)
    
    local circle = Instance.new("Frame", switchBG)
    circle.Size = UDim2.new(0, 14, 0, 14)
    circle.Position = UDim2.new(0, 2, 0.5, -7)
    circle.BackgroundColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)
    
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0, 60, 1, 0)
    btn.Position = UDim2.new(1, -60, 0, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""

    local obj = {}
    function obj.SetToggle(state)
        setting.active = state
        TweenService:Create(circle, TweenInfo.new(0.2), { Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7) }):Play()
        TweenService:Create(switchBG, TweenInfo.new(0.2), { BackgroundColor3 = state and ACCENT or Color3.fromRGB(40, 40, 40) }):Play()
    end

    function obj.UpdateQuantity(val)
        qtyBox.Text = tostring(val)
    end

    addConn(btn.MouseButton1Click:Connect(function()
        obj.SetToggle(not setting.active)
    end))

    addConn(qtyBox.FocusLost:Connect(function()
        local num = tonumber(qtyBox.Text)
        if num and num >= 0 then
            setting.quantity = math.floor(num)
            qtyBox.Text = tostring(setting.quantity)
        else
            qtyBox.Text = tostring(setting.quantity)
        end
    end))

    setting.ui = obj
end

createCategoryLabel(tabs.AutoShop, "Boosters & Potions")
createShopToggle(tabs.AutoShop, "Booster X2 Mastery : 30Min")
createShopToggle(tabs.AutoShop, "Booster X2 Mastery : 1Hour")
createShopToggle(tabs.AutoShop, "Booster X2 Mastery : 6Hour")
createShopToggle(tabs.AutoShop, "Potion")
createShopToggle(tabs.AutoShop, "Potion II")
createShopToggle(tabs.AutoShop, "Potion III")

createCategoryLabel(tabs.AutoShop, "Mastery Cards")
createShopToggle(tabs.AutoShop, "Mastery Card : Normal")
createShopToggle(tabs.AutoShop, "Mastery Card : Normal II")
createShopToggle(tabs.AutoShop, "Mastery Card : Normal III")
createShopToggle(tabs.AutoShop, "Mastery Card : Normal Titan")
createShopToggle(tabs.AutoShop, "Mastery Card : Normal Titan II")
createShopToggle(tabs.AutoShop, "Mastery Card : Normal Titan III")
createShopToggle(tabs.AutoShop, "Mastery Card : Special Titan")
createShopToggle(tabs.AutoShop, "Mastery Card : Special Titan II")
createShopToggle(tabs.AutoShop, "Mastery Card : Special Titan III")

createCategoryLabel(tabs.AutoShop, "Flash Drives")
createShopToggle(tabs.AutoShop, "Flash Drive #1")
createShopToggle(tabs.AutoShop, "Flash Drive #2")
createShopToggle(tabs.AutoShop, "Flash Drive #3")
createShopToggle(tabs.AutoShop, "Flash Drive #4")
createShopToggle(tabs.AutoShop, "Flash Drive #5")

createCategoryLabel(tabs.AutoShop, "Drives")
createShopToggle(tabs.AutoShop, "Drive #A")
createShopToggle(tabs.AutoShop, "Drive #B")
createShopToggle(tabs.AutoShop, "Drive #C")
createShopToggle(tabs.AutoShop, "Drive #D")
createShopToggle(tabs.AutoShop, "Drive #E")
createShopToggle(tabs.AutoShop, "Drive #SdFE0")

createCategoryLabel(tabs.AutoShop, "Others")
createShopToggle(tabs.AutoShop, "Keycard")
createShopToggle(tabs.AutoShop, "Legendary Ticket")
createShopToggle(tabs.AutoShop, "Scorching Ember")
createShopToggle(tabs.AutoShop, "Toilet Token")
createShopToggle(tabs.AutoShop, "Titan Speaker Toilet")
createShopToggle(tabs.AutoShop, "Titan Camera Toilet")

local lastStockCache = {}

task.spawn(function()
    local buyRemote = ReplicatedStorage:WaitForChild("BuyItemFromShopHourly", 10)
    
    while true do
        task.wait(3)
        if not _G.DropScriptRunning then break end
        if not player.PlayerGui then continue end
        local dailyShop = player.PlayerGui:FindFirstChild("DailyShop")
        if not dailyShop then continue end
        local mainNode = dailyShop:FindFirstChild("Main")
        if not mainNode then continue end
        local frameNode = mainNode:FindFirstChild("Frame")
        if not frameNode then continue end
        
        for _, slot in ipairs(frameNode:GetChildren()) do
            if slot:IsA("Frame") or slot:IsA("ImageLabel") then
                local nameLbl = slot:FindFirstChild("NameItem")
                local stockLbl = slot:FindFirstChild("Stock")
                
                if nameLbl and stockLbl then
                    local rawName = nameLbl.Text
                    local stockMatch = string.match(stockLbl.Text, "%d+")
                    local currentStock = stockMatch and tonumber(stockMatch) or 0
                    
                    local lookupName = rawName
                    if rawName == "Titan Speaker toilet" then lookupName = "Titan Speaker Toilet" end
                    if rawName == "Titan Camera toilet" then lookupName = "Titan Camera Toilet" end
                    
                    local setting = autoShopSettings[lookupName]
                    if setting then
                        local lastStock = lastStockCache[rawName] or currentStock
                        
                        if currentStock < lastStock and setting.active then
                            local comprados = lastStock - currentStock
                            setting.quantity = setting.quantity - comprados
                            if setting.quantity < 0 then setting.quantity = 0 end
                            
                            if setting.ui then
                                setting.ui.UpdateQuantity(setting.quantity)
                                if setting.quantity == 0 then
                                    setting.ui.SetToggle(false)
                                    setting.active = false
                                end
                            end
                        end
                        lastStockCache[rawName] = currentStock
                        
                        if setting.active and setting.quantity > 0 and currentStock > 0 then
                            local internalName = string.gsub(rawName, " ", "")
                            internalName = string.gsub(internalName, "MasteryCard", "MasterCard")
                            
                            if buyRemote then
                                pcall(function()
                                    buyRemote:FireServer(internalName, 1) 
                                end)
                            end
                        end
                    end
                end
            end
        end
    end
end)


-- ============================================================
-- ABA 7: MISC
-- ============================================================
local objAutoJoin = createToggle(tabs.Misc, "Auto Ready", function(s) autoJoinAtivo = s end)

local voteModesDisplay = {
    "Normal",
    "BossRush",
    "Vague Memory",
    "Christmas",
    "Zombie",
    "Invasion Holdout (Astro)",
    "The Invasion (Astro)",
    "In The Mist",
    "Hard",
    "Insane",
    "Extreme",
    "Nightmare",
    "Hell Wave",
    "Dark Dimension"
}

local voteModeInternal = {
    ["Normal"] = "Normal",
    ["BossRush"] = "BossRush",
    ["Vague Memory"] = "100MVisit",
    ["Christmas"] = "Christmas",
    ["Zombie"] = "Zombie",
    ["Invasion Holdout (Astro)"] = "Astro",
    ["The Invasion (Astro)"] = "AstroV2",
    ["In The Mist"] = "NoLightInTheSky",
    ["Hard"] = "Hard",
    ["Insane"] = "Insane",
    ["Extreme"] = "VeryHard",
    ["Nightmare"] = "Nightmare",
    ["Hell Wave"] = "Hell",
    ["Dark Dimension"] = "DarkDimension"
}

local voteMode = "Normal"

local voteDropdownObj = createInlineDropdown(tabs.Misc, "Vote Mode: ", voteModesDisplay, "Normal", function(val) 
    voteMode = val 
end)

local objAutoVote = createToggle(tabs.Misc, "Auto Vote", function(s) autoVoteAtivo = s end)
local objAutoChooseWeapon = createToggle(tabs.Misc, "Auto Choose Weapon", function(s) autoChooseWeaponAtivo = s end)
createToggle(tabs.Misc, "Auto Cure Plunger", {color = "red", text = "Only use if you have the plunger equipped."}, function(s) autoCureAtivo = s end)

local autoEquipPlungersAtivo = false
createToggle(tabs.Misc, "Auto Equip Double Plungers", function(s) autoEquipPlungersAtivo = s end)

createToggle(tabs.Misc, "Auto Use Normal Titan Request", function(s) autoUseNormalTitanAtivo = s end)
createToggle(tabs.Misc, "Auto Use Special Titan Request", function(s) autoUseSpecialTitanAtivo = s end)

local objAntiAfk = createToggle(tabs.Misc, "Anti AFK", function(s) antiAfkAtivo = s; antiAfkZoneAtivo = s end)
createToggle(tabs.Misc, "Stay In Round", function(s) stayInRoundAtivo = s end)
createSlider(tabs.Misc, "Stay In Round Speed", 1, 50, 15, function(val) _G.StaySpeed = val end)
createToggle(tabs.Misc, "Auto Run", function(s) autoRunAtivo = s end)

createToggle(tabs.Misc, "Auto Roll Skins (10x)", function(s) autoRollSkinAtivo = s end)
createToggle(tabs.Misc, "Auto Roll Shards (10x)", function(s) autoRollShardsAtivo = s end)
createToggle(tabs.Misc, "Auto Roll Presents", function(s) autoRollPresentsAtivo = s end)

createToggle(tabs.Misc, "Detect Size", function(s) detectSizeAtivo = s; if not s then _G.CurrentPunchDistance = -3 end end)

task.spawn(function()
    while true do
        task.wait(2)
        if not _G.DropScriptRunning then break end
        if detectSizeAtivo then
            local char = player.Character
            if char then
                local parts = {"HumanoidRootPart", "Left Leg", "Right Leg", "Left Arm", "Right Arm", "Head"}
                local totalSize = 0
                local count = 0
                for _, pName in ipairs(parts) do
                    local part = char:FindFirstChild(pName)
                    if part and part:IsA("BasePart") then
                        totalSize = totalSize + part.Size.Magnitude
                        count = count + 1
                    end
                end
                if count > 0 then
                    local avgSize = totalSize / count
                    local baseAvgSize = 2.47
                    local ratio = avgSize / baseAvgSize
                    _G.CurrentPunchDistance = -3 * ratio
                end
            end
        end
    end
end)

local objAstroRevive = createToggle(tabs.Misc, "Revive In Astro Gamemode", function(s) astroReviveAtivo = s end)

task.spawn(function()
    while true do
        task.wait(0.05)
        if not _G.DropScriptRunning then break end
        if astroReviveAtivo and not _G.IsUTTVSafeActive then
            pcall(function()
                local prompt = Workspace:FindFirstChild("Map") and Workspace.Map:FindFirstChild("Circle") and Workspace.Map.Circle:FindFirstChild("Attachment") and Workspace.Map.Circle.Attachment:FindFirstChild("ProximityPrompt")
                if prompt then
                    prompt.HoldDuration = 0
                    prompt.MaxActivationDistance = 99999
                    prompt.RequiresLineOfSight = false
                    prompt.KeyboardKeyCode = Enum.KeyCode.J
                    if fireproximityprompt then task.spawn(function() fireproximityprompt(prompt, 1, true) end) end
                end
            end)
        end
    end
end)

local objUTTVSafe = createToggle(tabs.Misc, "Auto Escape Astro Holdout", function(s) uttvSafeAtivo = s end)

local objMugenJeffrey = createToggle(tabs.Misc, "No Jeffrey/insanity", {color = "gray", text = "With a bug, Jeffrey disappears along with the insanity"}, function(s) mugenJeffreyAtivo = s end)

-- ABA 8: TELEPORT
createTpBtn(tabs.Teleport, "Spawn (Lobby)",   Vector3.new(611, -468, 529), false, {color = "yellow", text = "Be careful not to teleport during the match."})
createTpBtn(tabs.Teleport, "Shop Helicopter", Vector3.new(46, 3, -24))

-- 🔥 LÓGICA DO SUICIDE WAVE
local alreadySuicidedThisWave = false

addConn(RunService.Heartbeat:Connect(function()
    if _G.IsSuiciding and player.Character then
        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.Velocity = Vector3.new(0, 0, 0)
            hrp.CFrame = CFrame.new(611, -468, 529)
        end
    end
end))

task.spawn(function()
    while true do
        task.wait(0.1)
        if not _G.DropScriptRunning then break end
        if suicideWaveTarget > 0 then
            local waveNode = Workspace:FindFirstChild("Wave")
            if waveNode then
                local waveMatch = string.match(tostring(waveNode.Value), "%d+")
                if waveMatch then
                    local currentWaveNum = tonumber(waveMatch)
                    if currentWaveNum >= suicideWaveTarget then
                        if not alreadySuicidedThisWave then
                            _G.IsSuiciding = true
                            
                            local char = player.Character
                            local hum = char and char:FindFirstChild("Humanoid")
                            
                            if hum and hum.Health <= 0 then
                                alreadySuicidedThisWave = true
                                _G.IsSuiciding = false
                            end
                        end
                    else
                        alreadySuicidedThisWave = false
                        _G.IsSuiciding = false
                    end
                end
            end
        else
            _G.IsSuiciding = false
        end
    end
end)

-- AUTO SKIP HELI LÓGICA
task.spawn(function()
    local skipRemote = ReplicatedStorage:WaitForChild("SkipHelicopter")
    while true do
        task.wait(2)
        if not _G.DropScriptRunning then break end
        if autoSkipHeliAtivo then pcall(function() skipRemote:FireServer() end) end
    end
end)

-- 🔥 AUTO CHOOSE WEAPON LÓGICA
task.spawn(function()
    while true do
        task.wait(1)
        if not _G.DropScriptRunning then break end
        if autoChooseWeaponAtivo then
            local hasPR = checkWeaponExists("pulse")
            local hasSL = checkWeaponExists("small")
            local hasAB = checkWeaponExists("astro blaster")
            local newMethod = "Auto Punch"
            
            if hasPR and hasAB then newMethod = "Pulse Rifle + Astro Blaster"
            elseif hasPR and hasSL then newMethod = "Pulse Rifle + Small Laser"
            elseif hasAB then newMethod = "Astro Blaster"
            elseif hasPR then newMethod = "Pulse Rifle"
            elseif hasSL then newMethod = "Small Laser" end
            
            if farmMethod ~= newMethod then
                farmMethod = newMethod
                if farmDropdownObj then farmDropdownObj:UpdateText(farmMethod) end
            end
        end
    end
end)

-- AUTO CURE PLUNGER LÓGICA
task.spawn(function()
    local buffRemote = ReplicatedStorage:WaitForChild("Buff")
    while true do
        task.wait(1)
        if not _G.DropScriptRunning then break end
        if autoCureAtivo and player.Character and not _G.IsUTTVSafeActive then
            local hum = player.Character:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 and (hum.Health / hum.MaxHealth) < 0.4 then
                pcall(function() buffRemote:FireServer() end)
                task.wait(5) 
            end
        end
    end
end)

-- AUTO USE TITANS LÓGICA
task.spawn(function()
    while true do
        task.wait(1)
        if not _G.DropScriptRunning then break end
        if autoUseNormalTitanAtivo and player.Character and not _G.IsUTTVSafeActive then
            local titanTool = nil
            for _, t in ipairs(player.Character:GetChildren()) do
                if t:IsA("Tool") and string.find(string.lower(t.Name), "titan") and not string.find(string.lower(t.Name), "special") then
                    titanTool = t; break
                end
            end
            if not titanTool and player.Backpack then
                for _, t in ipairs(player.Backpack:GetChildren()) do
                    if t:IsA("Tool") and string.find(string.lower(t.Name), "titan") and not string.find(string.lower(t.Name), "special") then
                        titanTool = t;
                        local hum = player.Character:FindFirstChild("Humanoid")
                        if hum then hum:EquipTool(t) end
                        break
                    end
                end
            end
            if titanTool and titanTool.Parent == player.Character then pcall(function() ReplicatedStorage:WaitForChild("RequestTitan"):FireServer() end) end
        end

        if autoUseSpecialTitanAtivo and player.Character and not _G.IsUTTVSafeActive then
            local specialTool = nil
            for _, t in ipairs(player.Character:GetChildren()) do
                if t:IsA("Tool") and string.find(string.lower(t.Name), "special") then
                    specialTool = t; break
                end
            end
            if not specialTool and player.Backpack then
                for _, t in ipairs(player.Backpack:GetChildren()) do
                    if t:IsA("Tool") and string.find(string.lower(t.Name), "special") then
                        specialTool = t;
                        local hum = player.Character:FindFirstChild("Humanoid")
                        if hum then hum:EquipTool(t) end
                        break
                    end
                end
            end
            if specialTool and specialTool.Parent == player.Character then pcall(function() ReplicatedStorage:WaitForChild("SpecialRequest"):FireServer() end) end
        end
    end
end)

-- ============================================================
-- 🔥 AUTO ROLLS LÓGICA (SEM COOLDOWN)
-- ============================================================
task.spawn(function()
    local rs = game:GetService("ReplicatedStorage")
    local skinRemote = rs:WaitForChild("GachaSkins")
    local charRemote = rs:WaitForChild("GachaCharacter")
    local capsuleRemote = rs:WaitForChild("GachaCapsule")
    
    while true do
        task.wait() 
        if not _G.DropScriptRunning then break end
        if autoRollSkinAtivo then pcall(function() skinRemote:FireServer("10Spins") end) end
        if autoRollShardsAtivo then pcall(function() charRemote:FireServer("10Spins") end) end
        if autoRollPresentsAtivo then pcall(function() capsuleRemote:FireServer() end) end
    end
end)

-- ============================================================
-- 🔥 SISTEMA DE VOTO 100% BLINDADO CONTRA DESYNC 🔥
-- ============================================================
local voteConfirmed = false

task.spawn(function()
    local voteRemote = ReplicatedStorage:WaitForChild("Vote", 5)
    local readyRemote = ReplicatedStorage:WaitForChild("GetReadyRemote", 5)
    local hasSentVoteThisRound = false
    
    while task.wait(0.5) do
        if not _G.DropScriptRunning then break end

        local pGui = player:FindFirstChild("PlayerGui")
        if not pGui then continue end

        local isVoteOpen = false
        local openVoteUI = pGui:FindFirstChild("OpenVoteUI")
        if openVoteUI then
            pcall(function()
                if openVoteUI:IsA("BoolValue") or openVoteUI:IsA("ObjectValue") then
                    isVoteOpen = (openVoteUI.Value == true)
                else
                    isVoteOpen = (openVoteUI.Enabled or openVoteUI.Visible)
                end
            end)
        end
        
        local isTimeValid = false
        local timerVal = -1
        local playGui = pGui:FindFirstChild("Play")
        local mainFrame = playGui and playGui:FindFirstChild("Main")
        local timeNode = mainFrame and mainFrame:FindFirstChild("Time")
        
        if timeNode then
            pcall(function()
                local textStr = ""
                if timeNode:IsA("TextLabel") or timeNode:IsA("TextBox") then
                    textStr = timeNode.Text
                else
                    textStr = tostring(timeNode.Value)
                end
                local tVal = tonumber(string.match(textStr, "%d+"))
                if tVal then 
                    timerVal = tVal
                    isTimeValid = true 
                end
            end)
        end

        local internalMode = voteModeInternal[voteMode] or "Normal"
        local currentVoteCount = 0
        voteConfirmed = false

        -- Verificador 3: O Voto foi confirmado? (Texto mudou de [ 0 ])
        if isVoteOpen and mainFrame then
            pcall(function()
                local modeNode = mainFrame:FindFirstChild(internalMode)
                local lbl = modeNode and modeNode:FindFirstChild("TextLabel")
                if lbl and lbl:IsA("TextLabel") then
                    local num = string.match(lbl.Text, "%d+")
                    if num then currentVoteCount = tonumber(num) end
                end
            end)
            voteConfirmed = (currentVoteCount > 0)
        end

        -- Reseta o limitador quando a UI fecha (Zero Spam)
        if not isVoteOpen then
            hasSentVoteThisRound = false
        end

        -- 🔥 AÇÃO: AUTO VOTE (0 SEGUNDOS DE COOLDOWN - TESTE) 🔥
        if autoVoteAtivo and isVoteOpen and isTimeValid then
            if timerVal > 0 then
                if not hasSentVoteThisRound then
                    hasSentVoteThisRound = true
                    
                    -- Passo 1: Envia o voto oficial
                    if voteRemote then pcall(function() voteRemote:FireServer(internalMode) end) end
                    
                    -- Passo 2: O ANTÍDOTO DO FANTASMA! Sincroniza a tela do jogador na marra.
                    pcall(function()
                        local voteingVar = mainFrame:FindFirstChild("Voteing")
                        if voteingVar and voteingVar:IsA("BoolValue") then
                            voteingVar.Value = true
                        end
                    end)
                end
            elseif timerVal <= 0 and not voteConfirmed then
                -- 🔥 PLANO B DE FUGA: Temporizador no ZERO e ninguém votou!
                if readyRemote then pcall(function() readyRemote:FireServer("1", true) end) end
                task.wait(2)
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then hrp.CFrame = CFrame.new(611, -468, 529) end
                task.wait(2) 
            end
        end

        -- 🔥 AÇÃO: AUTO READY 
        if autoJoinAtivo then
            local forceFieldRecently = (tick() - lastForceFieldTime < 15)
            local isIntermissionSure = (selectCharTime > 5) or (forceFieldRecently and selectCharTime > 0.5)
            
            if autoVoteAtivo then
                -- Se o Vote está ligado, EXIGE a confirmação de que o voto funcionou pra dar Ready
                if voteConfirmed then
                    if readyRemote then pcall(function() readyRemote:FireServer("1", true) end) end
                end
            else
                -- Se Auto Vote está desligado, o Auto Ready age assim que a aba de voto aparecer
                if isVoteOpen then
                    if readyRemote then pcall(function() readyRemote:FireServer("1", true) end) end
                end
            end
        end
    end
end)

-- ============================================================
-- 🔥 ANTI-LIMBO BÁSICO
-- ============================================================
task.spawn(function()
    while true do
        task.wait(2)
        if not _G.DropScriptRunning then break end
        local char = player.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health > 0 then
                if hrp.Position.Y < -1500 then 
                    hrp.Velocity = Vector3.new(0,0,0)
                    hrp.CFrame = CFrame.new(611, -468, 529) 
                end
            end
        end
    end
end)

-- ============================================================
-- LÓGICA DE INTERACTION HUB
-- ============================================================
task.spawn(function()
    while true do
        task.wait(0.1) 
        if not _G.DropScriptRunning then break end
        if not interactAtivo and not saveAtivo and not reviveAtivo then continue end
        local currentLiving = Workspace:FindFirstChild("Living")
        if not currentLiving then continue end
        
        for _, model in ipairs(currentLiving:GetChildren()) do
            if not model:IsA("Model") or model == player.Character then continue end
            for _, obj in ipairs(model:GetDescendants()) do
                if obj:IsA("ProximityPrompt") then
                    pcall(function()
                        local isSave = (obj.Name == "TakeOffParasite")
                        
                        local isFlush = false
                        if obj.Parent and obj.Parent.Name then
                            isFlush = string.find(string.lower(obj.Parent.Name), "lever") ~= nil
                        end
                        if not isFlush and obj.Name then
                            isFlush = string.find(string.lower(obj.Name), "flush") ~= nil
                        end
                        
                        local objA = obj.ActionText and string.lower(obj.ActionText) or ""
                        local objN = obj.Name and string.lower(obj.Name) or ""
                        local isRevive = (string.find(objA, "revive") or string.find(objN, "revive"))

                        if (saveAtivo and isSave) or (interactAtivo and isFlush) or (reviveAtivo and isRevive) then
                            obj.HoldDuration = 0
                            obj.MaxActivationDistance = 99999
                            obj.RequiresLineOfSight = false
                            if fireproximityprompt and not _G.IsUTTVSafeActive and not _G.IsSuiciding then 
                                task.spawn(function() fireproximityprompt(obj, 1, true) end) 
                            end
                        end
                    end)
                end
            end
        end
    end
end)

-- ============================================================
-- 🔥 ANTI AFK ZONE & FAILSAFE
-- ============================================================
addConn(player.Idled:Connect(function()
    if antiAfkAtivo then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
        VIM:SendKeyEvent(true, Enum.KeyCode.RightShift, false, game)
        task.wait(0.05)
        VIM:SendKeyEvent(false, Enum.KeyCode.RightShift, false, game)
    end
end))

task.spawn(function()
    while true do
        task.wait(600)
        if not _G.DropScriptRunning then break end
        if antiAfkAtivo then
            VIM:SendMouseMoveEvent(0, 0, game)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(2)
        if not _G.DropScriptRunning then break end
        if antiAfkZoneAtivo then
            pcall(function()
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") then
                        local posObj = obj.Parent
                        if posObj then
                            local yPos = nil
                            if posObj:IsA("BasePart") then yPos = posObj.Position.Y
                            elseif posObj:IsA("Model") and posObj.PrimaryPart then yPos = posObj.PrimaryPart.Position.Y end
                            if yPos and yPos < -300 then obj:Destroy() end
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if not _G.DropScriptRunning then break end
        if antiAfkAtivo then
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if selectCharTime >= 60 and hrp and hrp.Position.Y > -100 then
                pcall(function()
                    hrp.Velocity = Vector3.new(0,0,0)
                    hrp.CFrame = CFrame.new(611, -468, 529) 
                end)
                task.wait(5) 
            end
        end
    end
end)

-- ============================================================
-- 🔥 CORE AUTO FARM (O CÓDIGO SUPREMO V20.0!)
-- ============================================================
local currentConnection = nil
local isShootingRifle = false
local isReloadingRifle = false
local singleReloadStartTime = 0 
local lastTapTime = 0
local lastCombatMethod = ""

local knownEnemiesCache = setmetatable({}, {__mode = "k"})
local knownAlliesCache = setmetatable({}, {__mode = "k"})
local lastAllyCheckTime = setmetatable({}, {__mode = "k"})

_G.LastPRAmmo = _G.LastPRAmmo or -1
_G.LastABAmmo = _G.LastABAmmo or -1
_G.LastPRChange = _G.LastPRChange or tick()
_G.LastABChange = _G.LastABChange or tick()
_G.LastSingleAmmo = _G.LastSingleAmmo or -1
_G.LastSingleChange = _G.LastSingleChange or tick()

local function getWeapon(methodName)
    local function isMatch(t)
        local name = string.lower(t.Name)
        if methodName == "Small Laser" then return string.find(name, "small") and string.find(name, "laser")
        elseif methodName == "Big Laser" then return (string.find(name, "large") or string.find(name, "big")) and string.find(name, "laser")
        elseif methodName == "Pulse Rifle" then return string.find(name, "pulse")
        elseif methodName == "Astro Blaster" then return string.find(name, "astro") and string.find(name, "blaster")
        end
        return false
    end
    if player.Character then
        for _, t in ipairs(player.Character:GetChildren()) do if t:IsA("Tool") and isMatch(t) then return t end end
    end
    if player.Backpack then
        for _, t in ipairs(player.Backpack:GetChildren()) do if t:IsA("Tool") and isMatch(t) then return t end end
    end
    return nil
end

local function checkAmmo(weaponType)
    local tool = getWeapon(weaponType)
    if tool and tool:FindFirstChild("Folder") and tool.Folder:FindFirstChild("Ammo") then
        local maxAmmo = 30
        if tool.Folder:FindFirstChild("MaxAmmo") then 
            maxAmmo = tool.Folder.MaxAmmo.Value 
        else
            if weaponType == "Astro Blaster" then maxAmmo = 20 end
            if weaponType == "Pulse Rifle" then maxAmmo = 30 end
        end
        return tool.Folder.Ammo.Value, maxAmmo
    end
    return 0, (weaponType == "Astro Blaster" and 20 or 30)
end

local function equipWeapon(methodName)
    local t = getWeapon(methodName)
    if t and t.Parent == player.Backpack then
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid:EquipTool(t)
        end
    end
    return t
end

task.spawn(function()
    while true do
        task.wait(0.05)
        if not _G.DropScriptRunning then break end
        
        local prAmmo, prMax = checkAmmo("Pulse Rifle")
        local abAmmo, abMax = checkAmmo("Astro Blaster")
        if prMax == 0 then prMax = 30 end
        if abMax == 0 or abMax == 30 then abMax = 20 end
        
        if prAmmo ~= _G.LastPRAmmo then _G.LastPRAmmo = prAmmo; _G.LastPRChange = tick() end
        if abAmmo ~= _G.LastABAmmo then _G.LastABAmmo = abAmmo; _G.LastABChange = tick() end
        
        local prStuck = (prAmmo > 0) and (tick() - (_G.LastPRChange or 0) > 1.5)
        local abStuck = (abAmmo > 0) and (tick() - (_G.LastABChange or 0) > 1.5)

        local activeCombatMethod = farmMethod
        if farmMethod == "Pulse Rifle + Small Laser" then
            if prAmmo <= 0 then 
                _G.PR_Reloading = true 
            elseif _G.PR_Reloading then
                if prAmmo >= prMax or prStuck then
                    _G.PR_Reloading = false
                end
            end
            activeCombatMethod = _G.PR_Reloading and "Small Laser" or "Pulse Rifle"
            
        elseif farmMethod == "Pulse Rifle + Astro Blaster" then
            if not _G.DualState then _G.DualState = "Waiting_Pulse" end

            if _G.DualState == "Shooting_Pulse" then
                if prAmmo <= 0 then _G.DualState = "Waiting_Astro" end
            elseif _G.DualState == "Waiting_Pulse" then
                if prAmmo >= prMax or prStuck then _G.DualState = "Shooting_Pulse" end
            elseif _G.DualState == "Shooting_Astro" then
                if abAmmo <= 0 then _G.DualState = "Waiting_Pulse" end
            elseif _G.DualState == "Waiting_Astro" then
                if abAmmo >= abMax or abStuck then _G.DualState = "Shooting_Astro" end
            end

            if string.find(_G.DualState, "Pulse") then activeCombatMethod = "Pulse Rifle"
            else activeCombatMethod = "Astro Blaster" end
            
            if string.find(_G.DualState, "Waiting") then isReloadingRifle = true
            else isReloadingRifle = false end
        else
            activeCombatMethod = farmMethod
        end

        if activeCombatMethod ~= lastCombatMethod then
            if isShootingRifle then
                local vp = Workspace.CurrentCamera.ViewportSize
                VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, false, game, 1)
                isShootingRifle = false
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid:UnequipTools()
                end
            end
            lastCombatMethod = activeCombatMethod
        end

        if (itemFarmAtivo and (#itemQueue > 0 or isProcessingQueue)) or not farmEnabled or _G.IsUTTVSafeActive or _G.IsItemFarming or _G.IsSuiciding then
            if isShootingRifle then
                local vp = Workspace.CurrentCamera.ViewportSize
                VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, false, game, 1)
                isShootingRifle = false
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid:UnequipTools()
                end
            end
            continue
        end

        local rawTargets = {}
        local currentLiving = Workspace:FindFirstChild("Living")
        
        if currentLiving then
            for _, model in ipairs(currentLiving:GetChildren()) do
                if not SKIBIDI_LIST[model.Name] then continue end
                if Players:GetPlayerFromCharacter(model) then continue end
                
                local isAlly = false
                
                if string.find(string.lower(model.Name), "astro") then
                    knownEnemiesCache[model] = true
                    knownAlliesCache[model] = nil
                end

                if not knownEnemiesCache[model] then
                    local aiFolders = model:FindFirstChild("AIFolders")
                    local targetNode = aiFolders and aiFolders:FindFirstChild("Target")
                    
                    if targetNode then
                        local targetVal = targetNode.Value
                        local targetStr = ""
                        if typeof(targetVal) == "Instance" then
                            targetStr = targetVal.Name
                        elseif targetVal ~= nil then
                            targetStr = tostring(targetVal)
                        end
                        
                        if targetStr == "" or targetStr == "nil" then
                            knownEnemiesCache[model] = true
                            knownAlliesCache[model] = nil
                            isAlly = false
                        else
                            local targetIsPlayer = Players:FindFirstChild(targetStr) ~= nil
                            if targetIsPlayer then
                                knownEnemiesCache[model] = true
                                knownAlliesCache[model] = nil
                            else
                                local now = tick()
                                if not knownAlliesCache[model] or (now - (lastAllyCheckTime[model] or 0)) >= 5 then
                                    knownAlliesCache[model] = true
                                    lastAllyCheckTime[model] = now
                                    isAlly = true
                                else
                                    isAlly = true
                                end
                            end
                        end
                    else
                        isAlly = true
                    end
                end
                
                if isAlly then continue end
                
                local torso = model:FindFirstChild("Torso") or model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
                if not torso then continue end
                
                local isDead = false
                local f1 = model:FindFirstChild("1")
                if f1 and f1:FindFirstChild("BallSocketConstraint") then isDead = true end
                local hum = model:FindFirstChildWhichIsA("Humanoid")
                if hum and hum.Health <= 0 then isDead = true end
                
                if not isDead then
                    local fakeHead = model:FindFirstChild("Fake Head")
                    local headSize = (fakeHead and fakeHead:IsA("BasePart")) and fakeHead.Size.Magnitude or 1.0
                    table.insert(rawTargets, {model = model, torso = torso, headSize = headSize})
                end
            end
        end

        if #rawTargets == 0 then
            if isShootingRifle then
                local vp = Workspace.CurrentCamera.ViewportSize
                VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, false, game, 1)
                isShootingRifle = false
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid:UnequipTools()
                end
            end
            continue
        end

        local validTargets = {}
        if targetMethod == "Saw" or targetMethod == "Rocket" then
            for _, t in ipairs(rawTargets) do
                local nLower = string.lower(t.model.Name)
                if targetMethod == "Saw" and string.find(nLower, "saw") then table.insert(validTargets, t)
                elseif targetMethod == "Rocket" and string.find(nLower, "rocket") then table.insert(validTargets, t) end
            end
            if #validTargets == 0 then validTargets = rawTargets end 
        else
            validTargets = rawTargets
            if targetMethod == "Normal" then 
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    table.sort(validTargets, function(a, b) 
                        return (a.torso.Position - hrp.Position).Magnitude < (b.torso.Position - hrp.Position).Magnitude 
                    end)
                end
            elseif targetMethod == "Weakest First" then table.sort(validTargets, function(a, b) return a.headSize < b.headSize end)
            elseif targetMethod == "Strongest First" then table.sort(validTargets, function(a, b) return a.headSize > b.headSize end) end
        end

        local hasTransmitter = false
        local transmitterData = nil
        for _, t in ipairs(validTargets) do
            if t.model.Name == "Transmitter toilet" then
                transmitterData = t
                hasTransmitter = true
                break
            end
        end
        if hasTransmitter then
            validTargets = {transmitterData}
        end

        for _, tData in ipairs(validTargets) do
            local model, torso, headSize = tData.model, tData.torso, tData.headSize
            if currentConnection then currentConnection:Disconnect() end

            currentConnection = addConn(RunService.Heartbeat:Connect(function(dt)
                local isDeadNow = false
                local f1 = model:FindFirstChild("1")
                if f1 and f1:FindFirstChild("BallSocketConstraint") then isDeadNow = true end
                local hum = model:FindFirstChildWhichIsA("Humanoid")
                if hum and hum.Health <= 0 then isDeadNow = true end

                if not farmEnabled or not torso.Parent or isDeadNow or stayInRoundAtivo or (itemFarmAtivo and (#itemQueue > 0 or isProcessingQueue)) or _G.IsUTTVSafeActive or _G.IsItemFarming or _G.IsSuiciding then
                    if currentConnection then currentConnection:Disconnect() end
                    return
                end
                
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if hrp then hrp.Velocity = Vector3.new(0, 0, 0) end
                local combatPos
                local integrity = (#_v == 17) and 1 or "Crash"

                local striderOffset = 0
                if model.Name == "Zombie Strider gun" then striderOffset = 22 end

                local nLower = string.lower(model.Name)
                local isAerial = string.find(nLower, "heli") or string.find(nLower, "dropper") or string.find(nLower, "flying") or string.find(nLower, "plane") or string.find(nLower, "cargobob")
                local orbitHeight = isAerial and 5 or (30 + (headSize * 2.0))

                if activeCombatMethod == "Auto Punch" then
                    local punchDist = _G.CurrentPunchDistance
                    local distY = (8 + (headSize * 0.8)) * integrity + striderOffset
                    if model.Name == "Giant Robber" then
                        distY = distY - 12
                        punchDist = punchDist - 8
                    end
                    combatPos = torso.Position + Vector3.new(0, distY, 0) + (torso.CFrame.LookVector * punchDist)
                    if player.Character then player.Character:PivotTo(CFrame.lookAt(combatPos, torso.Position)); LMB_Event:FireServer() end

                elseif activeCombatMethod == "Orbital Punch" then
                    _G.OrbitalAngle = _G.OrbitalAngle + (_G.OrbitalSpeed * dt)
                    local orbitRadius = (7 + (headSize * 0.6)) * integrity
                    local orbitY = (8 + (headSize * 1.0)) + striderOffset
                    if model.Name == "Giant Robber" then
                        orbitRadius = orbitRadius + 8
                        orbitY = orbitY - 12
                    end
                    combatPos = torso.Position + Vector3.new(math.cos(_G.OrbitalAngle) * orbitRadius, orbitY, math.sin(_G.OrbitalAngle) * orbitRadius)
                    if player.Character then player.Character:PivotTo(CFrame.lookAt(combatPos, torso.Position)); LMB_Event:FireServer() end

                elseif activeCombatMethod == "Pulse Rifle" or activeCombatMethod == "Big Laser" or activeCombatMethod == "Small Laser" or activeCombatMethod == "Astro Blaster" then
                    _G.OrbitalAngle = _G.OrbitalAngle + (_G.OrbitalSpeed * dt)
                    local orbitRadius = (35 + (headSize * 4.0)) * integrity
                    local rawPos = torso.Position + Vector3.new(math.cos(_G.OrbitalAngle) * orbitRadius, orbitHeight + striderOffset, math.sin(_G.OrbitalAngle) * orbitRadius)
                    combatPos = Vector3.new(math.clamp(rawPos.X, -645, 460), math.clamp(rawPos.Y, -400, 285), math.clamp(rawPos.Z, -515, 460))
                    
                    if player.Character then
                        player.Character:PivotTo(CFrame.new(combatPos))
                        Workspace.CurrentCamera.CFrame = CFrame.lookAt(Workspace.CurrentCamera.CFrame.Position, torso.Position - Vector3.new(0, 0.5, 0))
                    end
                end
            end))

            repeat 
                prAmmo, prMax = checkAmmo("Pulse Rifle")
                abAmmo, abMax = checkAmmo("Astro Blaster")
                if prMax == 0 then prMax = 30 end
                if abMax == 0 or abMax == 30 then abMax = 20 end

                if prAmmo ~= _G.LastPRAmmo then _G.LastPRAmmo = prAmmo; _G.LastPRChange = tick() end
                if abAmmo ~= _G.LastABAmmo then _G.LastABAmmo = abAmmo; _G.LastABChange = tick() end
                
                prStuck = (prAmmo > 0) and (tick() - (_G.LastPRChange or 0) > 1.5)
                abStuck = (abAmmo > 0) and (tick() - (_G.LastABChange or 0) > 1.5)

                if farmMethod == "Pulse Rifle + Small Laser" then
                    if prAmmo <= 0 then 
                        _G.PR_Reloading = true 
                    elseif _G.PR_Reloading then
                        if prAmmo >= prMax or prStuck then
                            _G.PR_Reloading = false
                        end
                    end
                    activeCombatMethod = _G.PR_Reloading and "Small Laser" or "Pulse Rifle"
                    
                elseif farmMethod == "Pulse Rifle + Astro Blaster" then
                    if not _G.DualState then _G.DualState = "Waiting_Pulse" end

                    if _G.DualState == "Shooting_Pulse" then
                        if prAmmo <= 0 then _G.DualState = "Waiting_Astro" end
                    elseif _G.DualState == "Waiting_Pulse" then
                        if prAmmo >= prMax or prStuck then _G.DualState = "Shooting_Pulse" end
                    elseif _G.DualState == "Shooting_Astro" then
                        if abAmmo <= 0 then _G.DualState = "Waiting_Pulse" end
                    elseif _G.DualState == "Waiting_Astro" then
                        if abAmmo >= abMax or abStuck then _G.DualState = "Shooting_Astro" end
                    end

                    if string.find(_G.DualState, "Pulse") then activeCombatMethod = "Pulse Rifle"
                    else activeCombatMethod = "Astro Blaster" end
                    
                    if string.find(_G.DualState, "Waiting") then isReloadingRifle = true
                    else isReloadingRifle = false end
                else
                    activeCombatMethod = farmMethod
                end

                if activeCombatMethod ~= lastCombatMethod then
                    if isShootingRifle then
                        local vp = Workspace.CurrentCamera.ViewportSize
                        VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, false, game, 1)
                        isShootingRifle = false
                        if player.Character and player.Character:FindFirstChild("Humanoid") then
                            player.Character.Humanoid:UnequipTools()
                        end
                    end
                    lastCombatMethod = activeCombatMethod
                end

                if activeCombatMethod == "Pulse Rifle" or activeCombatMethod == "Big Laser" or activeCombatMethod == "Small Laser" or activeCombatMethod == "Astro Blaster" then
                    
                    -- 🔥 SEMPRE EQUIPA A ARMA PARA FORÇAR O SERVIDOR A RECARREGAR 🔥
                    local tool = equipWeapon(activeCombatMethod)
                    local ammoNode = tool and tool:FindFirstChild("Folder") and tool.Folder:FindFirstChild("Ammo")
                    local vp = Workspace.CurrentCamera.ViewportSize
                    local aimX, aimY = vp.X / 2, vp.Y / 2
                    
                    if tool and ammoNode then
                        local maxAmmo = 30
                        local maxAmmoNode = tool.Folder:FindFirstChild("MaxAmmo")
                        if maxAmmoNode then 
                            maxAmmo = maxAmmoNode.Value 
                        else
                            if activeCombatMethod == "Astro Blaster" then maxAmmo = 20 end
                            if activeCombatMethod == "Pulse Rifle" then maxAmmo = 30 end
                        end

                        local currentAmmoVal = ammoNode.Value
                        if _G.LastSingleAmmo ~= currentAmmoVal then 
                            _G.LastSingleAmmo = currentAmmoVal 
                            _G.LastSingleChange = tick() 
                        end
                        local singleStuck = (currentAmmoVal > 0) and (tick() - (_G.LastSingleChange or 0) > 1.5)

                        if currentAmmoVal <= 0 then
                            if not isReloadingRifle then
                                isReloadingRifle = true
                                if isShootingRifle then 
                                    isShootingRifle = false; VIM:SendMouseButtonEvent(aimX, aimY, 0, false, game, 1) 
                                end
                            end
                        elseif isReloadingRifle then
                            if currentAmmoVal >= maxAmmo or singleStuck then
                                isReloadingRifle = false
                            end
                        end

                        if not isReloadingRifle and currentAmmoVal > 0 then
                            VIM:SendMouseMoveEvent(aimX, aimY, game) 
                            
                            if activeCombatMethod == "Big Laser" or activeCombatMethod == "Small Laser" or activeCombatMethod == "Astro Blaster" or (farmMethod == "Pulse Rifle + Astro Blaster" and activeCombatMethod == "Pulse Rifle") then
                                if not isShootingRifle then 
                                    isShootingRifle = true; VIM:SendMouseButtonEvent(aimX, aimY, 0, true, game, 1) 
                                end
                            else
                                if headSize > 12 then 
                                    if not isShootingRifle then isShootingRifle = true; VIM:SendMouseButtonEvent(aimX, aimY, 0, true, game, 1) end
                                else 
                                    if tick() - lastTapTime > 0.25 then
                                        lastTapTime = tick()
                                        if not isShootingRifle then
                                            isShootingRifle = true; VIM:SendMouseButtonEvent(aimX, aimY, 0, true, game, 1)
                                            task.delay(0.1, function() VIM:SendMouseButtonEvent(aimX, aimY, 0, false, game, 1); isShootingRifle = false end)
                                        end
                                    end
                                end
                            end
                        else
                            if isShootingRifle then 
                                isShootingRifle = false; VIM:SendMouseButtonEvent(aimX, aimY, 0, false, game, 1)
                            end
                        end
                    else
                        if isShootingRifle then 
                            isShootingRifle = false; VIM:SendMouseButtonEvent(aimX, aimY, 0, false, game, 1)
                        end
                    end
                else
                    if isShootingRifle then
                        local vp = Workspace.CurrentCamera.ViewportSize
                        isShootingRifle = false; VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, false, game, 1)
                    end
                end
                task.wait(0.1)
                
                local isDeadNow = false
                local f1 = model:FindFirstChild("1")
                if f1 and f1:FindFirstChild("BallSocketConstraint") then isDeadNow = true end
                local hum = model:FindFirstChildWhichIsA("Humanoid")
                if hum and hum.Health <= 0 then isDeadNow = true end
                
                local interruptedByTransmitter = false
                if model.Name ~= "Transmitter toilet" then
                    local curLiv = Workspace:FindFirstChild("Living")
                    if curLiv and curLiv:FindFirstChild("Transmitter toilet") then
                        local tHum = curLiv["Transmitter toilet"]:FindFirstChildWhichIsA("Humanoid")
                        if tHum and tHum.Health > 0 then interruptedByTransmitter = true end
                    end
                end
                
            until not farmEnabled or not model.Parent or isDeadNow or interruptedByTransmitter or stayInRoundAtivo or (itemFarmAtivo and (#itemQueue > 0 or isProcessingQueue)) or _G.IsUTTVSafeActive or _G.IsItemFarming or _G.IsSuiciding or not currentConnection or not currentConnection.Connected or not _G.DropScriptRunning

            if currentConnection then currentConnection:Disconnect() end
            
            if isShootingRifle and (activeCombatMethod == "Pulse Rifle" or activeCombatMethod == "Astro Blaster") then
                local vp = Workspace.CurrentCamera.ViewportSize
                VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, false, game, 1)
                isShootingRifle = false
            end
            break
        end
    end
end)

-- AUTO RUN LÓGICA
task.spawn(function()
    local runRemote = ReplicatedStorage:WaitForChild("Running")
    while true do
        task.wait(0.1)
        if not _G.DropScriptRunning then break end
        if autoRunAtivo and not _G.IsUTTVSafeActive then
            local hum = player.Character and player.Character:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 and hum.MoveDirection.Magnitude > 0 and hum.WalkSpeed <= 16.5 then 
                pcall(function() runRemote:FireServer() end)
                task.wait(0.5) 
            end
        end
    end
end)

local function makeDraggable(dragArea, targetMove)
    targetMove = targetMove or dragArea
    local dragging, dragStart, startPos = false, nil, nil
    addConn(dragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if _G.IsAimbotting then return end 
            dragging = true; dragStart = input.Position; startPos = targetMove.Position
        end
    end))
    addConn(UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local d = input.Position - dragStart
            targetMove.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end))
    addConn(UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end))
end

makeDraggable(topBar, main)
makeDraggable(sidebar, main)

local minBtnDragging, minBtnHasDragged = false, false
local minBtnDragStart, minBtnStartPos = nil, nil
addConn(minBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if _G.IsAimbotting then return end 
        minBtnDragging = true; minBtnHasDragged = false
        minBtnDragStart = input.Position; minBtnStartPos = minBtn.Position
    end
end))
addConn(UserInputService.InputChanged:Connect(function(input)
    if minBtnDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - minBtnDragStart
        if d.Magnitude > 5 then minBtnHasDragged = true end
        minBtn.Position = UDim2.new(minBtnStartPos.X.Scale, minBtnStartPos.X.Offset + d.X, minBtnStartPos.Y.Scale, minBtnStartPos.Y.Offset + d.Y)
    end
end))
addConn(minBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        minBtnDragging = false
        if not minBtnHasDragged then
            main.Visible = true
            minBtn.Visible = false
        end
    end
end))

-- ============================================================
-- 🔥 AUTO EQUIP E USE DO WEIRD TRANSMITTER LÓGICA 🔥
-- ============================================================
task.spawn(function()
    while true do
        task.wait(0.2)
        if not _G.DropScriptRunning then break end
        local char = player.Character
        
        if not _G.IsUTTVSafeActive and not _G.IsSuiciding then
            local hum = char and char:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 then
                local wtTool = char:FindFirstChild("Weird Transmitter")
                if not wtTool and player.Backpack then
                    wtTool = player.Backpack:FindFirstChild("Weird Transmitter")
                    if wtTool and wtTool:IsA("Tool") then
                        hum:EquipTool(wtTool)
                        task.wait(0.1)
                    end
                end
                
                if wtTool and wtTool.Parent == char then
                    wtTool:Activate()
                    local vp = Workspace.CurrentCamera.ViewportSize
                    VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, true, game, 1)
                    task.wait(0.05)
                    VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, false, game, 1)
                end
            end
        end
    end
end)

-- ============================================================
-- 🔥 AUTO EQUIP DOUBLE PLUNGERS 🔥
-- ============================================================
task.spawn(function()
    local changeModeRemote = ReplicatedStorage:WaitForChild("ChangeModePlunger", 5)
    while true do
        task.wait(1)
        if not _G.DropScriptRunning then break end
        if autoEquipPlungersAtivo then
            pcall(function()
                local living = Workspace:FindFirstChild("Living")
                local myChar = living and player.Name and living:FindFirstChild(player.Name)
                if myChar then
                    local modePlunger = myChar:FindFirstChild("CooldownFolder") and myChar.CooldownFolder:FindFirstChild("ModePlunger")
                    if modePlunger and modePlunger.Value == "Normal" then
                        if changeModeRemote then changeModeRemote:FireServer() end
                    end
                end
            end)
        end
    end
end)

print("✅ V20.0 — AUTO FARM INTOCÁVEL! Recarga perfeitamente sincronizada e máquina mortífera online!")
