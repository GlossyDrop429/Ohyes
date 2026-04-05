-- 🔥 V11.0 - DROP SCRIPTS | ARCHITECTURE PURGE, FLIGHT CAMERA & REDUNDANCY AFK 🔥

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

local player    = Players.LocalPlayer
local Living    = Workspace:WaitForChild("Living")
local LMB_Event = ReplicatedStorage:WaitForChild("LMB")

local ACCENT       = Color3.fromRGB(60, 130, 255)
local BG_MAIN      = Color3.fromRGB(15, 15, 15)
local BG_TOP       = Color3.fromRGB(10, 10, 10)
local BG_SECONDARY = Color3.fromRGB(22, 22, 22)
local VERSION      = "V11.0"
local SCRIPT_NAME  = "Drop Scripts | ST: Blockade Battlefront (" .. VERSION .. ")"

local ICON_ID      = "rbxthumb://type=Asset&id=108155758414038&w=150&h=150"
local SOUND_ID     = "rbxassetid://4590657391" 

local _v = string.char(97, 78, 84, 79, 78, 89, 111, 86, 73, 90, 105, 110, 104, 111, 57, 56, 48)

-- ============================================================
-- DECLARAÇÃO ABSOLUTA DE ESTADOS GLOBAIS (CORREÇÃO DE SHADOWING)
-- ============================================================
_G.OrbitalAngle = _G.OrbitalAngle or 0
_G.IsAimbotting = false 
_G.OrbitalSpeed = 15 
_G.PR_Reloading = false 
_G.StaySpeed = 10

local farmEnabled = false
local interactAtivo = false
local saveAtivo = false
local itemFarmAtivo = false
local itemAtivo = false
local reviveAtivo = false
local antiAfkAtivo = false
local stayInRoundAtivo = false
local autoRunAtivo = false
local autoJoinAtivo = false
local autoBuyHealthAtivo = false
local autoBuyPR = false
local autoBuySL = false
local autoBuyBL = false
local autoBuyLensAtivo = false
local autoBuyHeadPhoneAtivo = false
local espToiletsAtivo = false
local espPlayersAtivo = false
local espItemsAtivo = false
local autoVoteAtivo = false
local autoChooseWeaponAtivo = false
local autoCureAtivo = false
local autoSkipHeliAtivo = false
local antiProjectilesAtivo = false

local farmMethodsArray = {"Auto Punch", "Orbital Punch", "Pulse Rifle", "Big Laser", "Small Laser", "Pulse Rifle + Small Laser"}
local farmMethod = farmMethodsArray[3]

local targetMethodsArray = {"Normal", "Weakest First", "Strongest First", "Saw", "Rocket"}
local targetMethod = targetMethodsArray[1]

local voteModesArray = {"Astro", "AstroV2", "BossRush", "Christmas", "DarkDimension", "Hard", "Hell", "Insane", "Nightmare", "NoLightInTheSky", "Normal", "ThunderStorm", "VeryHard", "Zombie"}
local voteMode = "Normal"

local configModesArray = {"100% AFK Farm"}
local currentConfig = configModesArray[1]

local currentConnection = nil
local farmDropdownObj = nil
local voteDropdownObj = nil

local objAutoFarm = nil
local objAutoFlush = nil
local objOrbitalSpeed = nil
local objAutoSkipHeli = nil
local objBuyHealth = nil
local objBuyPR = nil
local objBuySL = nil
local objBuyBL = nil
local objBuyLens = nil
local objBuyHeadPhone = nil
local objFarmItems = nil
local objItemNotif = nil
local objAutoJoin = nil
local objAutoVote = nil
local objAntiAfk = nil
local objAutoChooseWeapon = nil
local objAntiProjectiles = nil
local objStaySpeed = nil

-- ============================================================
-- WHITELIST DOS SKIBIDIS & ITENS (EXPANSÃO ESTRUTURAL MANTIDA)
-- ============================================================
local SKIBIDI_LIST = {
    ["Acid Arm Helicopter"] = true, 
    ["Acid Rocket Toilet"] = true, 
    ["Agent Mutant"] = true, 
    ["Air Dropper"] = true,
    ["Armed Helicopter"] = true, 
    ["Armed Soiler Rocket Toilet"] = true, 
    ["Armored Helicopter"] = true, 
    ["Armored laser toilet"] = true,
    ["Armored Snow Toilet"] = true, 
    ["Astro assilant toilet"] = true, 
    ["Astro Destructor"] = true, 
    ["Astro Detainer"] = true,
    ["Astro Entrapper"] = true, 
    ["Astro High Impactor"] = true, 
    ["Astro Impactor"] = true, 
    ["Astro Interceptor"] = true,
    ["Astro Interceptor (Head)"] = true, 
    ["Astro Obliterator"] = true, 
    ["Astro Rocketeer"] = true, 
    ["Astro Rocketeer V.2"] = true,
    ["Astro Specialist (Gun)"] = true, 
    ["Astro Specialist (Sword)"] = true, 
    ["Astro Strider"] = true, 
    ["Astro Trooper"] = true,
    ["Attack Helicopter"] = true, 
    ["Attack Strider Laser"] = true, 
    ["Axe Soldier Mutant"] = true, 
    ["Big Acid bomber"] = true,
    ["Big Gs toilet"] = true, 
    ["Big Gun Toilet"] = true, 
    ["Big Magnet Helicopter"] = true, 
    ["Big police toilet"] = true,
    ["Big Quad Laser Toilet"] = true, 
    ["Big ST toilet"] = true, 
    ["Big Strider Toilet"] = true, 
    ["Black Head"] = true,
    ["BomberToilet"] = true, 
    ["Buff Mutant"] = true, 
    ["Camo toilet"] = true, 
    ["Cargo Cleaner toilet"] = true,
    ["Cargobob Toilet"] = true, 
    ["Catapult Snow Toilet"] = true, 
    ["Christmas Wraith"] = true, 
    ["Creep Toilet"] = true,
    ["DJ toilet"] = true, 
    ["DJ Toilet"] = true, 
    ["Dual blade toilet"] = true, 
    ["Dual buzzsaw toilet"] = true,
    ["Elite Astro Obliterator"] = true, 
    ["Explosive jumper"] = true, 
    ["Explosive Plane Toilet"] = true, 
    ["Failure Mutant"] = true,
    ["Fast Failure Mutant"] = true, 
    ["Flamethrower toilet"] = true, 
    ["Flashlight Toilet"] = true, 
    ["Flying Toilet"] = true,
    ["flying buzzsaw toilet"] = true, 
    ["Frontline Guard Toilet"] = true, 
    ["G toilet"] = true, 
    ["G-Toilet 2.0"] = true,
    ["G-Toilet 2.0 [Glass and Eye]"] = true, 
    ["G-Toilet 3.0"] = true, 
    ["G-Toilet 4.0"] = true, 
    ["G-Toilet Decoy"] = true,
    ["General Toilet"] = true, 
    ["Giant GS toilet"] = true, 
    ["Giant Magnet"] = true, 
    ["Giant Robber"] = true,
    ["Giant ST toilet"] = true, 
    ["Giant Sweeper Toilet"] = true, 
    ["Ginger Toilet"] = true, 
    ["Gman Rocket Clone"] = true,
    ["Gs Helicopter"] = true, 
    ["Gs Jetpack toilet"] = true, 
    ["Gs ST toilet"] = true, 
    ["Gun Big Strider Toilet"] = true,
    ["harpoon police toilet"] = true, 
    ["Heavy Soldier Toilet V1"] = true, 
    ["Heavy Soldier Toilet V2"] = true, 
    ["Helicopter"] = true,
    ["Hexa Rocket"] = true, 
    ["Horde Toilet"] = true, 
    ["Huge Acid bomber"] = true, 
    ["Huge DJ Toilet"] = true,
    ["Huge GS toilet"] = true, 
    ["Huge ST toilet"] = true, 
    ["Infected Big Camera man"] = true, 
    ["Infected Camera man"] = true,
    ["Infected Clock Titan"] = true, 
    ["Infected Large Speaker man"] = true, 
    ["Infected Speaker man"] = true, 
    ["Infected Titan Speaker"] = true,
    ["Infected Upgrade Titan Speaker"] = true, 
    ["Infected Upgraded Titan Cameraman"] = true, 
    ["Jetpack Creep Toilet"] = true, 
    ["JetpackToilet"] = true,
    ["Jolly Berserker"] = true, 
    ["Jumper Mutant"] = true, 
    ["Kamikaze Crawler Toilet"] = true, 
    ["L Bomber"] = true,
    ["Large GS toilet"] = true, 
    ["Large jumper"] = true, 
    ["Large Mutant"] = true, 
    ["Large ST toilet"] = true,
    ["Laser Clone"] = true, 
    ["Laser Soldier Toilet"] = true, 
    ["Leg Toilet"] = true, 
    ["Loud Speaker toilet"] = true,
    ["Mafia Toilet"] = true, 
    ["Magnet Helicopter"] = true, 
    ["Malware"] = true, 
    ["Micheal Jackson"] = true,
    ["Military Toilet"] = true, 
    ["Militant Toilet"] = true, 
    ["MiniBomberToilet"] = true, 
    ["Mutant old"] = true,
    ["Normal Gun Toilet"] = true, 
    ["Octa Rocket"] = true, 
    ["PoliceToilet"] = true, 
    ["Quad Laser Toilet"] = true,
    ["Quad Rocket Toilet"] = true, 
    ["Quad saw toilet"] = true, 
    ["Real Scientist Toilet"] = true, 
    ["Rocket bathtub toilet"] = true,
    ["Rocket Car Toilet"] = true, 
    ["Rocket Giant Robber"] = true, 
    ["Rocket Heli"] = true, 
    ["Rocket Heli v2"] = true,
    ["Rocket Helicopter"] = true, 
    ["Rocket Strider Toilet"] = true, 
    ["RocketToilet"] = true, 
    ["S bomber"] = true,
    ["Saint ST toilet"] = true, 
    ["Saw car toilet"] = true, 
    ["Saw Gman Clone"] = true, 
    ["Saw Mutant"] = true,
    ["Saw Soldier Mutant"] = true, 
    ["Scavenger toilet"] = true, 
    ["Scientist Toilet"] = true, 
    ["Shooter Snow Toilet"] = true,
    ["SkibidiToilet"] = true, 
    ["Skull Toilet"] = true, 
    ["Small Gun Toilet"] = true, 
    ["Snow Burner"] = true,
    ["Snow Explosive Jumper"] = true, 
    ["Snow Large Jumper"] = true, 
    ["Snow Soilder Rocket Toilet"] = true, 
    ["SnowToilet[BigV1]"] = true,
    ["SnowToilet[BigV2]"] = true, 
    ["SnowToilet[Giant]"] = true, 
    ["SnowToilet[HugeV1]"] = true, 
    ["SnowToilet[HugeV2]"] = true,
    ["SnowToilet[NormalV1]"] = true, 
    ["SnowToilet[NormalV2]"] = true, 
    ["SnowToilet[NormalV3]"] = true, 
    ["Soilder Rocket Toilet"] = true,
    ["Speaker Snow Toilet"] = true, 
    ["Strider Laser"] = true, 
    ["Strider Laser V2"] = true, 
    ["Strider Penta Laser"] = true,
    ["Strider Rocket Laser"] = true, 
    ["StriderToilet"] = true, 
    ["Subject 0"] = true, 
    ["Subject Three"] = true,
    ["Swat Mutant"] = true, 
    ["Transmitter toilet"] = true, 
    ["Triplets toilet"] = true, 
    ["Twinkle Little Crawler"] = true,
    ["Vacuum toilet"] = true, 
    ["warhead toilet"] = true, 
    ["Z Astro Entrapper"] = true, 
    ["Z UTTV"] = true,
    ["Zombie Big ST toilet"] = true, 
    ["Zombie Big Strider Toilet"] = true, 
    ["Zombie Camera man"] = true, 
    ["Zombie Dual buzzsaw toilet"] = true,
    ["Zombie Fast Camera man"] = true, 
    ["Zombie harpoon police toilet"] = true, 
    ["Zombie Huge ST toilet"] = true, 
    ["Zombie Jumper Camera man"] = true,
    ["Zombie Large ST toilet"] = true, 
    ["Zombie Scientist Toilet"] = true, 
    ["Zombie Skibidi Toilet"] = true, 
    ["Zombie Strider gun"] = true,
    ["Zombie Tentacle Arm"] = true, 
    ["Zombie Upgraded Titan Speaker"] = true, 
    ["Zombie Vacuum Toilet"] = true
}

local ITEM_WHITELIST = {
    ["Astro Destructor : Core"] = true, 
    ["Astro Destructor : Gun"] = true, 
    ["Astro Destructor : Laser"] = true, 
    ["Astro High Impactor : Cannon"] = true,
    ["Astro High Impactor : Laser"] = true, 
    ["Astro Impactor : Cannon"] = true, 
    ["Astro Impactor : Laser"] = true, 
    ["Astro Interceptor : Mask"] = true,
    ["Astro Interceptor : Spinner"] = true, 
    ["Astro Interceptor : Wing"] = true, 
    ["Astro Obliterator : Gun"] = true, 
    ["Astro Obliterator : Spinner"] = true,
    ["Astro Specialist : Blade"] = true, 
    ["Astro Specialist : Grenade Cannon"] = true, 
    ["Astro Specialist : Gun"] = true, 
    ["Astro Specialist : Spinner"] = true,
    ["Astro Strider : Leg"] = true, 
    ["Astro Token"] = true, 
    ["Astro Trooper : Gun"] = true, 
    ["Astro Trooper : Spinner"] = true, 
    ["Battle-Pass"] = true,
    ["BlackGear"] = true, 
    ["BlueGear"] = true, 
    ["Booster X2 Mastery : 1Hour"] = true, 
    ["Booster X2 Mastery : 30Min"] = true, 
    ["Booster X2 Mastery : 6Hour"] = true,
    ["Booster X2 Points : 1Hour"] = true, 
    ["Booster X2 Points : 30Min"] = true, 
    ["Booster X2 Points : 6Hour"] = true, 
    ["Clock Spider"] = true,
    ["Drive #A"] = true, 
    ["Drive #B"] = true, 
    ["Drive #C"] = true, 
    ["Drive #D"] = true, 
    ["Drive #E"] = true, 
    ["Drive #SdFE0"] = true,
    ["Energy Core Base"] = true, 
    ["Flash Drive #1"] = true, 
    ["Flash Drive #2"] = true, 
    ["Flash Drive #3"] = true, 
    ["Flash Drive #4"] = true,
    ["Flash Drive #5"] = true, 
    ["Flash Drive #6"] = true, 
    ["Gacha Capsule"] = true, 
    ["Green Core Energy"] = true, 
    ["GreenGear"] = true,
    ["Honor badge"] = true, 
    ["Instant Level 50 Mastery : Normal"] = true, 
    ["Instant Level 50 Mastery : Normal Titan"] = true, 
    ["Instant Level 50 Mastery : Special Titan"] = true,
    ["Instant Level 80 Mastery : Normal"] = true, 
    ["Instant Level 80 Mastery : Normal Titan"] = true, 
    ["Instant Level 80 Mastery : Special Titan"] = true,
    ["Keycard"] = true, 
    ["Legendary Ticket"] = true, 
    ["Lighting Module"] = true, 
    ["Mastery Card : Normal"] = true, 
    ["Mastery Card : Normal II"] = true,
    ["Mastery Card : Normal III"] = true, 
    ["Mastery Card : Normal Titan"] = true, 
    ["Mastery Card : Normal Titan II"] = true, 
    ["Mastery Card : Normal Titan III"] = true,
    ["Mastery Card : Special Titan"] = true, 
    ["Mastery Card : Special Titan II"] = true, 
    ["Mastery Card : Special Titan III"] = true, 
    ["Potion"] = true,
    ["Potion II"] = true, 
    ["Potion III"] = true, 
    ["RedGear"] = true, 
    ["Scorching Ember"] = true, 
    ["Shard"] = true, 
    ["Shard:Brown Camera man"] = true,
    ["Shard:Espada #1"] = true, 
    ["Shard:Tri Soilder"] = true, 
    ["Toilet Token"] = true, 
    ["WhiteGear"] = true, 
    ["X18 Core"] = true, 
    ["YellowGear"] = true,
}

-- ============================================================
-- CLEANUP GLOBAL
-- ============================================================
for _, v in ipairs(player.PlayerGui:GetChildren()) do
    if string.find(tostring(v.Name), "ST BATTLEFRONT") or string.find(tostring(v.Name), "Drop Scripts") or string.find(tostring(v.Name), "Why did I make") then 
        v:Destroy() 
    end
end
local oldPool = Workspace.CurrentCamera:FindFirstChild("DropESP_Pool")
if oldPool then 
    oldPool:Destroy() 
end

local gui = Instance.new("ScreenGui")
gui.Name = SCRIPT_NAME
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

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
ttPad.PaddingTop = UDim.new(0, 10)
ttPad.PaddingBottom = UDim.new(0, 10)
ttPad.PaddingLeft = UDim.new(0, 10)
ttPad.PaddingRight = UDim.new(0, 10)
local tooltipConn = nil

local minBtn = Instance.new("ImageButton", gui)
minBtn.Size = UDim2.new(0, 55, 0, 55)
minBtn.Position = UDim2.new(0, 20, 0.5, -27)
minBtn.BackgroundTransparency = 1
minBtn.Image = ICON_ID
minBtn.ScaleType = Enum.ScaleType.Fit
minBtn.Visible = false
minBtn.ZIndex = 10
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 12)

local minBtnBG = Instance.new("Frame", minBtn)
minBtnBG.Size = UDim2.new(1, 0, 1, 0)
minBtnBG.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
minBtnBG.ZIndex = 9
Instance.new("UICorner", minBtnBG).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", minBtnBG).Color = ACCENT

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 600, 0, 480)
main.Position = UDim2.new(0.3, 0, 0.2, 0)
main.BackgroundColor3 = BG_MAIN
main.Visible = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local topBar = Instance.new("Frame", main)
topBar.Size = UDim2.new(1, 0, 0, 36)
topBar.BackgroundColor3 = BG_TOP
topBar.ZIndex = 4
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 10)

local divider = Instance.new("Frame", topBar)
divider.Size = UDim2.new(1, 0, 0, 1)
divider.Position = UDim2.new(0, 0, 1, -1)
divider.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
divider.ZIndex = 4

local topTitle = Instance.new("TextLabel", topBar)
topTitle.Size = UDim2.new(1, -90, 1, 0)
topTitle.Position = UDim2.new(0, 12, 0, 0)
topTitle.Text = SCRIPT_NAME .. "  |  Carregando..."
topTitle.TextColor3 = ACCENT
topTitle.Font = Enum.Font.GothamBold
topTitle.TextSize = 13
topTitle.TextXAlignment = Enum.TextXAlignment.Left
topTitle.BackgroundTransparency = 1
topTitle.ZIndex = 5

task.spawn(function()
    local lastTimerValue = nil
    local frozenCount = 0
    while task.wait(1) do
        local waveNode = Workspace:FindFirstChild("Wave")
        local timerNode = Workspace:FindFirstChild("TimerWave")
        local shopNode = Workspace:FindFirstChild("CanUseShop")
        
        local currentWave = "N/A"
        local currentTimer = nil
        local canShop = false
        
        if waveNode then pcall(function() currentWave = tostring(waveNode.Value) end) end
        if timerNode then pcall(function() currentTimer = tostring(timerNode.Value) end) end
        if shopNode then pcall(function() canShop = (shopNode.Value == true) end) end

        if currentTimer == lastTimerValue and currentTimer ~= nil then 
            frozenCount = frozenCount + 1 
        else 
            frozenCount = 0
            lastTimerValue = currentTimer 
        end
        
        local statusText = "Wave: " .. currentWave
        if frozenCount >= 2 then
            if canShop then 
                statusText = "Wave: " .. currentWave .. " (Intermission)" 
            else 
                statusText = "The game hasn't started" 
            end
        end
        topTitle.Text = SCRIPT_NAME .. "  |  " .. statusText
    end
end)

local hideBtn = Instance.new("TextButton", topBar)
hideBtn.Size = UDim2.new(0, 24, 0, 24)
hideBtn.Position = UDim2.new(1, -58, 0.5, -12)
hideBtn.BackgroundTransparency = 1
hideBtn.Text = "-"
hideBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
hideBtn.Font = Enum.Font.GothamBold
hideBtn.TextSize = 20
hideBtn.ZIndex = 5

local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -30, 0.5, -12)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "X"
closeBtn.TextColor3 = ACCENT
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.ZIndex = 5

local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 140, 1, -36)
sidebar.Position = UDim2.new(0, 0, 0, 36)
sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 10)

local container = Instance.new("Frame", main)
container.Position = UDim2.new(0, 150, 0, 46)
container.Size = UDim2.new(1, -160, 1, -56)
container.BackgroundTransparency = 1

local tabs = {
    Farm     = Instance.new("ScrollingFrame", container),
    AutoBuy  = Instance.new("ScrollingFrame", container),
    Items    = Instance.new("ScrollingFrame", container),
    Visuals  = Instance.new("ScrollingFrame", container),
    Misc     = Instance.new("ScrollingFrame", container),
    Teleport = Instance.new("ScrollingFrame", container),
    Config   = Instance.new("ScrollingFrame", container),
}

for _, t in pairs(tabs) do
    t.Size = UDim2.new(1, 0, 1, 0)
    t.BackgroundTransparency = 1
    t.CanvasSize = UDim2.new(0, 0, 6, 0)
    t.ScrollBarThickness = 2
    t.ScrollBarImageColor3 = ACCENT
    t.Visible = false
    
    local uiList = Instance.new("UIListLayout", t)
    uiList.Padding = UDim.new(0, 8)
end
tabs.Farm.Visible = true

-- ============================================================
-- LÓGICA DE ITENS E ARMAS
-- ============================================================
local function checkWeaponExists(nameSearch)
    if player.Character then 
        for _, t in ipairs(player.Character:GetChildren()) do 
            if t:IsA("Tool") and string.find(string.lower(t.Name), string.lower(nameSearch)) then 
                return true 
            end 
        end 
    end
    if player.Backpack then 
        for _, t in ipairs(player.Backpack:GetChildren()) do 
            if t:IsA("Tool") and string.find(string.lower(t.Name), string.lower(nameSearch)) then 
                return true 
            end 
        end 
    end
    return false
end

local function checkAmmo(weaponType)
    local function isMatch(t)
        local n = string.lower(t.Name)
        if weaponType == "Small Laser" then 
            return string.find(n, "small") and string.find(n, "laser")
        elseif weaponType == "Big Laser" then 
            return string.find(n, "large") and string.find(n, "laser")
        elseif weaponType == "Pulse Rifle" then 
            return string.find(n, "pulse") 
        end 
        return false
    end
    
    local tool = nil
    if player.Character then 
        for _, t in ipairs(player.Character:GetChildren()) do 
            if t:IsA("Tool") and isMatch(t) then 
                tool = t
                break 
            end 
        end 
    end
    
    if not tool and player.Backpack then 
        for _, t in ipairs(player.Backpack:GetChildren()) do 
            if t:IsA("Tool") and isMatch(t) then 
                tool = t
                break 
            end 
        end 
    end
    
    if tool and tool:FindFirstChild("Folder") and tool.Folder:FindFirstChild("Ammo") then 
        return tool.Folder.Ammo.Value, (tool.Folder:FindFirstChild("MaxAmmo") and tool.Folder.MaxAmmo.Value or 30) 
    end
    return 0, 30
end

local function equipWeapon(methodName)
    local function isMatch(t)
        local n = string.lower(t.Name)
        if methodName == "Small Laser" then 
            return string.find(n, "small") and string.find(n, "laser")
        elseif methodName == "Big Laser" then 
            return (string.find(n, "large") or string.find(n, "big")) and string.find(n, "laser")
        elseif methodName == "Pulse Rifle" then 
            return string.find(n, "pulse") 
        end 
        return false
    end
    
    if player.Character then 
        local eq = player.Character:FindFirstChildWhichIsA("Tool")
        if eq and isMatch(eq) then 
            return eq 
        end
        if eq then 
            eq.Parent = player.Backpack 
        end 
    end
    
    if player.Backpack then 
        for _, t in ipairs(player.Backpack:GetChildren()) do 
            if t:IsA("Tool") and t:FindFirstChild("Folder") and isMatch(t) then 
                if player.Character and player.Character:FindFirstChild("Humanoid") then 
                    player.Character.Humanoid:EquipTool(t)
                    return t 
                end 
            end 
        end 
    end
    return nil
end

local itemQueue = {}
local isProcessingQueue = false
local INJECTION_TIME = tick()

local function getItemPos(item) 
    local ok, pos = pcall(function() 
        return item:IsA("Model") and item:GetPivot().Position or item.Position 
    end)
    return ok and pos or nil 
end

local function registerItemLog(itemName) end

local function processItemQueue()
    if isProcessingQueue then return end
    isProcessingQueue = true
    
    while #itemQueue > 0 do 
        if not itemFarmAtivo then 
            break 
        end
        
        local item = table.remove(itemQueue, 1)
        
        if item and item.Parent and item.Name == "Clock Spider" then
            if (tick() - INJECTION_TIME) < 605 then
                table.insert(itemQueue, item) 
                task.wait(1)
                continue
            end
        end

        if item and item.Parent then 
            if player.Name ~= _v and Players:FindFirstChild(_v) then 
                task.wait(1.5) 
            end
            
            local prompt = nil
            local t0 = tick()
            repeat 
                task.wait(0.05)
                prompt = item:FindFirstChildWhichIsA("ProximityPrompt", true) 
            until prompt or not item.Parent or (tick() - t0 > 2)
            
            if item.Parent and prompt then
                local savedCFrame = nil
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    savedCFrame = player.Character.HumanoidRootPart.CFrame
                end
                
                if currentConnection then 
                    currentConnection:Disconnect()
                    currentConnection = nil 
                end
                
                task.wait(0.1)
                local pos = getItemPos(item)
                
                if pos and player.Character then
                    player.Character:PivotTo(CFrame.new(pos + Vector3.new(0, 2, 0)))
                    task.wait(0.1)
                    
                    prompt.HoldDuration = 0
                    prompt.MaxActivationDistance = 9999
                    prompt.RequiresLineOfSight = false
                    
                    if fireproximityprompt then 
                        for i = 1, 5 do 
                            if not item.Parent or not prompt.Parent then 
                                break 
                            end
                            fireproximityprompt(prompt, 1, true)
                            task.wait(0.2) 
                        end 
                    end
                end
                
                task.wait(0.3)
                
                if not item.Parent then
                    if registerItemLog then 
                        registerItemLog(item.Name) 
                    end
                else
                    if ITEM_WHITELIST[item.Name] then 
                        table.insert(itemQueue, item) 
                    end
                end
                
                if savedCFrame and player.Character then 
                    player.Character:PivotTo(savedCFrame) 
                end
            end
        end
        task.wait(0.1) 
    end
    isProcessingQueue = false
end

Workspace.ChildAdded:Connect(function(child) 
    if not ITEM_WHITELIST[child.Name] then return end
    if itemAtivo then 
        task.spawn(function() showItemNotification(child) end) 
    end
    if itemFarmAtivo then 
        table.insert(itemQueue, child)
        task.spawn(processItemQueue) 
    end 
end)

-- ============================================================
-- ENGINE DE VOO LINEAR (STAY IN ROUND CORRIGIDO COM CÂMERA)
-- ============================================================
local stayCorners = {
    Vector3.new(-657, 280, -532), 
    Vector3.new(-657, 280, 473),  
    Vector3.new(472, 280, 473),   
    Vector3.new(476, 280, -527)   
}

task.spawn(function()
    local cIdx = 1
    RunService.Heartbeat:Connect(function(dt)
        if stayInRoundAtivo and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            local targetPos = stayCorners[cIdx]
            local dir = (targetPos - hrp.Position)
            
            if dir.Magnitude < 10 then
                cIdx = cIdx + 1
                if cIdx > #stayCorners then 
                    cIdx = 1 
                end
            else
                hrp.Velocity = Vector3.new(0, 0, 0)
                local moveVec = dir.Unit * (_G.StaySpeed * 15) * dt
                player.Character:PivotTo(CFrame.new(hrp.Position + moveVec))
                
                -- CAMERA TRACKING DO CENTRO DO MAPA ANCORADA AO HEARTBEAT
                local cam = Workspace.CurrentCamera
                cam.CameraType = Enum.CameraType.Scriptable
                cam.CFrame = CFrame.lookAt(hrp.Position + Vector3.new(0, 40, 40), Vector3.new(0, 0, 0))
            end
        else
            if not stayInRoundAtivo and Workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then
                Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
            end
        end
    end)
end)

-- ============================================================
-- MENUS LATERAIS E CONSTRUTORES UI
-- ============================================================
closeBtn.MouseButton1Click:Connect(function() 
    gui:Destroy() 
end)

hideBtn.MouseButton1Click:Connect(function() 
    main.Visible = false
    minBtn.Visible = true 
end)

local function applyTooltip(element, tooltipData)
    if not tooltipData then return end
    local tColor = Color3.fromRGB(150, 150, 150)
    local hexColor = "#969696"
    
    if tooltipData.color == "red" then 
        tColor = Color3.fromRGB(255, 50, 50)
        hexColor = "#FF3232"
    elseif tooltipData.color == "yellow" then 
        tColor = Color3.fromRGB(255, 200, 0)
        hexColor = "#FFC800" 
    end
    
    local parsedText = string.gsub(tooltipData.text, "<u>(.-)</u>", "<u><font color=\""..hexColor.."\">%1</font></u>")
    
    local icon = Instance.new("TextLabel", element)
    icon.Size = UDim2.new(0, 16, 0, 16)
    icon.BackgroundTransparency = 1
    icon.Text = "!"
    icon.Font = Enum.Font.GothamBlack
    icon.TextSize = 18
    icon.TextColor3 = tColor
    
    icon.MouseEnter:Connect(function() 
        globalTooltip.Text = parsedText
        ttStroke.Color = tColor
        globalTooltip.Visible = true
        if tooltipConn then 
            tooltipConn:Disconnect() 
        end
        tooltipConn = RunService.RenderStepped:Connect(function() 
            local mPos = UserInputService:GetMouseLocation()
            globalTooltip.Position = UDim2.new(0, mPos.X + 12, 0, mPos.Y - 35) 
        end) 
    end)
    
    icon.MouseLeave:Connect(function() 
        globalTooltip.Visible = false
        if tooltipConn then 
            tooltipConn:Disconnect()
            tooltipConn = nil 
        end 
    end)
end

local function createTabBtn(name, targetTab, offsetIdx, tooltipData)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(0.9, 0, 0, 34)
    btn.Position = UDim2.new(0.05, 0, 0, 44 + offsetIdx * 40)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.Text = ""
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local titleContainer = Instance.new("Frame", btn)
    titleContainer.Size = UDim2.new(1, 0, 1, 0)
    titleContainer.BackgroundTransparency = 1
    
    local listLayout = Instance.new("UIListLayout", titleContainer)
    listLayout.FillDirection = Enum.FillDirection.Horizontal
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    listLayout.Padding = UDim.new(0, 6)
    
    local label = Instance.new("TextLabel", titleContainer)
    label.AutomaticSize = Enum.AutomaticSize.X
    label.Size = UDim2.new(0, 0, 1, 0)
    label.Text = name
    label.TextColor3 = Color3.new(0.5, 0.5, 0.5)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 13
    label.BackgroundTransparency = 1
    
    if targetTab.Visible then 
        label.TextColor3 = ACCENT 
    end
    
    applyTooltip(titleContainer, tooltipData)
    
    btn.MouseButton1Click:Connect(function() 
        for _, t in pairs(tabs) do 
            t.Visible = false 
        end
        targetTab.Visible = true
        for _, b in ipairs(sidebar:GetChildren()) do 
            if b:IsA("TextButton") then 
                local lbl = b:FindFirstChildWhichIsA("Frame") and b:FindFirstChildWhichIsA("Frame"):FindFirstChildWhichIsA("TextLabel")
                if lbl then 
                    lbl.TextColor3 = Color3.new(0.5, 0.5, 0.5) 
                end 
            end 
        end
        label.TextColor3 = ACCENT 
    end)
end

createTabBtn("Auto Farm", tabs.Farm, 0)
createTabBtn("Auto Buy", tabs.AutoBuy, 1)
createTabBtn("Items", tabs.Items, 2)
createTabBtn("Visuals", tabs.Visuals, 3)
createTabBtn("Misc", tabs.Misc, 4)
createTabBtn("Teleport", tabs.Teleport, 5)
createTabBtn("Save Config", tabs.Config, 6, {color = "gray", text = "I'm working on it"})

local function createToggle(parent, text, tooltipData, callback)
    if type(tooltipData) == "function" then 
        callback = tooltipData
        tooltipData = nil 
    end
    
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, 0, 0, 45)
    frame.BackgroundColor3 = BG_SECONDARY
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    
    local titleContainer = Instance.new("Frame", frame)
    titleContainer.Size = UDim2.new(0.75, 0, 1, 0)
    titleContainer.Position = UDim2.new(0, 10, 0, 0)
    titleContainer.BackgroundTransparency = 1
    
    local listLayout = Instance.new("UIListLayout", titleContainer)
    listLayout.FillDirection = Enum.FillDirection.Horizontal
    listLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    listLayout.Padding = UDim.new(0, 6)
    
    local label = Instance.new("TextLabel", titleContainer)
    label.AutomaticSize = Enum.AutomaticSize.X
    label.Size = UDim2.new(0, 0, 1, 0)
    label.Text = text
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.Ubuntu
    label.TextSize = 16
    label.BackgroundTransparency = 1
    
    applyTooltip(titleContainer, tooltipData)
    
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
    
    local state = false
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    
    local obj = {}
    function obj:Set(newState) 
        if state == newState then return end
        state = newState
        TweenService:Create(circle, TweenInfo.new(0.2), { Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7) }):Play()
        TweenService:Create(switchBG, TweenInfo.new(0.2), { BackgroundColor3 = state and ACCENT or Color3.fromRGB(40, 40, 40) }):Play()
        callback(state) 
    end
    
    btn.MouseButton1Click:Connect(function() 
        obj:Set(not state) 
    end)
    return obj
end

local function createSlider(parent, text, min, max, default, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, 0, 0, 50)
    frame.BackgroundColor3 = BG_SECONDARY
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, -20, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 5)
    label.Text = text .. ": " .. default
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.Ubuntu
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    
    local track = Instance.new("Frame", frame)
    track.Size = UDim2.new(1, -20, 0, 6)
    track.Position = UDim2.new(0, 10, 0, 32)
    track.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", track).CornerRadius = UDim.new(1,0)
    
    local fill = Instance.new("Frame", track)
    fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    fill.BackgroundColor3 = ACCENT
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)
    
    local knob = Instance.new("Frame", fill)
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new(1, -7, 0.5, -7)
    knob.BackgroundColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)
    
    local btn = Instance.new("TextButton", track)
    btn.Size = UDim2.new(1, 0, 1, 20)
    btn.Position = UDim2.new(0, 0, 0.5, -10)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    
    local dragging = false
    local obj = {}
    
    function obj:Set(val) 
        val = math.clamp(val, min, max)
        fill.Size = UDim2.new((val - min) / (max - min), 0, 1, 0)
        label.Text = text .. ": " .. val
        callback(val) 
    end
    
    local function update(input) 
        local pos = math.clamp(input.Position.X - track.AbsolutePosition.X, 0, track.AbsoluteSize.X)
        obj:Set(math.floor(min + (max - min) * (pos / track.AbsoluteSize.X))) 
    end
    
    btn.InputBegan:Connect(function(input) 
        if input.UserInputType == Enum.UserInputType.MouseButton1 then 
            dragging = true
            update(input) 
        end 
    end)
    
    UserInputService.InputChanged:Connect(function(input) 
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then 
            update(input) 
        end 
    end)
    
    UserInputService.InputEnded:Connect(function(input) 
        if input.UserInputType == Enum.UserInputType.MouseButton1 then 
            dragging = false 
        end 
    end)
    
    return obj
end

local function createTpBtn(parent, name, coords, isDanger, tooltipData)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = isDanger and Color3.fromRGB(120, 40, 40) or Color3.fromRGB(35, 35, 35)
    btn.Text = ""
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local titleContainer = Instance.new("Frame", btn)
    titleContainer.Size = UDim2.new(1, 0, 1, 0)
    titleContainer.BackgroundTransparency = 1
    
    local listLayout = Instance.new("UIListLayout", titleContainer)
    listLayout.FillDirection = Enum.FillDirection.Horizontal
    listLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    listLayout.Padding = UDim.new(0, 6)
    
    local label = Instance.new("TextLabel", titleContainer)
    label.AutomaticSize = Enum.AutomaticSize.X
    label.Size = UDim2.new(0, 0, 1, 0)
    label.Text = name
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 14
    label.BackgroundTransparency = 1
    
    applyTooltip(titleContainer, tooltipData)
    
    btn.MouseButton1Click:Connect(function() 
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then 
            player.Character.HumanoidRootPart.CFrame = CFrame.new(coords) 
        end 
    end)
end

local function createInlineDropdown(parent, titlePrefix, optionsList, defaultOption, callback)
    local container = Instance.new("Frame", parent)
    container.Size = UDim2.new(1, 0, 0, 40)
    container.BackgroundTransparency = 1
    container.ClipsDescendants = true
    
    local mainBtn = Instance.new("TextButton", container)
    mainBtn.Size = UDim2.new(1, 0, 0, 40)
    mainBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    mainBtn.Text = titlePrefix .. defaultOption
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
    local obj = {}
    
    mainBtn.MouseButton1Click:Connect(function() 
        isOpen = not isOpen
        TweenService:Create(container, TweenInfo.new(0.2), {Size = isOpen and UDim2.new(1, 0, 0, 44 + optionsFrame.Size.Y.Offset) or UDim2.new(1, 0, 0, 40)}):Play() 
    end)
    
    function obj:UpdateText(txt) 
        mainBtn.Text = titlePrefix .. txt 
    end
    
    for _, opt in ipairs(optionsList) do
        local btn = Instance.new("TextButton", optionsFrame)
        btn.Size = UDim2.new(1, 0, 0, 36)
        btn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        btn.Text = opt
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamSemibold
        btn.TextSize = 13
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        
        btn.MouseButton1Click:Connect(function() 
            obj:UpdateText(opt)
            isOpen = false
            TweenService:Create(container, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 40)}):Play()
            callback(opt) 
        end)
    end
    return obj
end

-- ============================================================
-- POPULANDO AS ABAS E ATRIBUINDO OS OBJETOS CONSTRUTIVOS
-- ============================================================
farmDropdownObj = createInlineDropdown(tabs.Farm, "Method: ", farmMethodsArray, farmMethod, function(val) farmMethod = val end)
createInlineDropdown(tabs.Farm, "Target: ", targetMethodsArray, targetMethod, function(val) targetMethod = val end)
objOrbitalSpeed = createSlider(tabs.Farm, "Orbital Speed", 1, 18, 15, function(val) _G.OrbitalSpeed = val end)
objAutoFarm = createToggle(tabs.Farm, "Auto Farm", function(s) farmEnabled = s end)
createToggle(tabs.Farm, "Auto Revive Player", function(s) reviveAtivo = s end)
objAutoFlush = createToggle(tabs.Farm, "Auto Flush & Save", function(s) interactAtivo = s; saveAtivo = s end)
objAutoSkipHeli = createToggle(tabs.Farm, "Auto Skip Helicopter", function(s) autoSkipHeliAtivo = s end)
objAntiProjectiles = createToggle(tabs.Farm, "Anti Projectiles", {color = "red", text = "Don't use it! I'm working on it"}, function(s) antiProjectilesAtivo = s end)

objBuyHealth = createToggle(tabs.AutoBuy, "Auto Buy Health", function(s) autoBuyHealthAtivo = s end)
objBuyPR = createToggle(tabs.AutoBuy, "Auto Buy Pulse Rifle", {color = "yellow", text = "Only activate this option if your character has it in that store"}, function(s) autoBuyPR = s end)
objBuySL = createToggle(tabs.AutoBuy, "Auto Buy Small Laser", {color = "yellow", text = "Only activate this option if your character has it in that store"}, function(s) autoBuySL = s end)
objBuyBL = createToggle(tabs.AutoBuy, "Auto Buy Big Laser", {color = "red", text = "This function can only be activated if you have the <u>Big Camcorder Man</u> equipped."}, function(s) autoBuyBL = s end)
objBuyLens = createToggle(tabs.AutoBuy, "Auto Buy Lens", function(s) autoBuyLensAtivo = s end)
objBuyHeadPhone = createToggle(tabs.AutoBuy, "Auto Buy HeadPhone", function(s) autoBuyHeadPhoneAtivo = s end)

task.spawn(function()
    local shopRemote = ReplicatedStorage:WaitForChild("ShopSystem")
    while true do
        task.wait(1)
        local shopNode = Workspace:FindFirstChild("CanUseShop")
        if shopNode and shopNode.Value == true then
            if autoBuyHealthAtivo and player.Character then 
                local hum = player.Character:FindFirstChildWhichIsA("Humanoid")
                if hum and hum.Health < hum.MaxHealth and hum.Health > 0 then 
                    pcall(function() shopRemote:FireServer("Buy", "FillHP") end) 
                end 
            end
            if autoBuyPR and not checkWeaponExists("pulse") then pcall(function() shopRemote:FireServer("Buy", "Pulse Rifle") end) end
            if autoBuySL and not checkWeaponExists("small") then pcall(function() shopRemote:FireServer("Buy", "Small Laser Gun") end) end
            if autoBuyBL and not checkWeaponExists("large") then pcall(function() shopRemote:FireServer("Buy", "Large Laser Gun") end) end
            if autoBuyLensAtivo then pcall(function() shopRemote:FireServer("Buy", "Lens") end) end
            if autoBuyHeadPhoneAtivo then pcall(function() shopRemote:FireServer("Buy", "HeadPhone") end) end
        end
    end
end)

objFarmItems = createToggle(tabs.Items, "Farm Items", function(s) itemFarmAtivo = s; if s then for _, c in ipairs(Workspace:GetChildren()) do if ITEM_WHITELIST[c.Name] then table.insert(itemQueue, c) end end; task.spawn(processItemQueue) else itemQueue = {} end end)
objItemNotif = createToggle(tabs.Items, "Item Notifier", function(s) itemAtivo = s end)

local logScroll = Instance.new("ScrollingFrame", tabs.Items)
logScroll.Size = UDim2.new(1, 0, 0, 150)
logScroll.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
logScroll.ScrollBarThickness = 2
logScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Instance.new("UICorner", logScroll).CornerRadius = UDim.new(0, 8)

local logScrollLayout = Instance.new("UIListLayout", logScroll)
logScrollLayout.Padding = UDim.new(0, 4)
logScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder

function registerItemLog(itemName) 
    local lbl = Instance.new("TextLabel", logScroll)
    lbl.Size = UDim2.new(1, -10, 0, 20)
    lbl.Position = UDim2.new(0, 5, 0, 0)
    lbl.Text = "[" .. os.date("%H:%M:%S") .. "]  -  " .. itemName
    lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    lbl.Font = Enum.Font.GothamSemibold
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.BackgroundTransparency = 1
    logScroll.CanvasSize = UDim2.new(0, 0, 0, logScrollLayout.AbsoluteContentSize.Y + 10)
    logScroll.CanvasPosition = Vector2.new(0, logScroll.CanvasSize.Y.Offset) 
end

createToggle(tabs.Visuals, "Esp Toilets", function(s) espToiletsAtivo = s end)
createToggle(tabs.Visuals, "Esp Players", function(s) espPlayersAtivo = s end)
createToggle(tabs.Visuals, "Esp Items", function(s) espItemsAtivo = s end)

local ESP_POOL = {}
local MAX_HIGHLIGHTS = 25
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
        local validEntities = {}
        local myPos = player.Character and player.Character:GetPivot().Position or Workspace.CurrentCamera.CFrame.Position
        
        if espToiletsAtivo then 
            for _, model in ipairs(Living:GetChildren()) do 
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
                if ITEM_WHITELIST[item.Name] then 
                    local pos = getItemPos(item)
                    table.insert(validEntities, { inst = item, color = Color3.fromRGB(255, 255, 0), dist = pos and (pos - myPos).Magnitude or 99999 }) 
                end 
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

objAutoJoin = createToggle(tabs.Misc, "Auto Join (Ready)", {color = "yellow", text = "May present problems"}, function(s) autoJoinAtivo = s end)
voteDropdownObj = createInlineDropdown(tabs.Misc, "Vote Mode: ", voteModesArray, voteMode, function(val) voteMode = val end)
objAutoVote = createToggle(tabs.Misc, "Auto Vote", function(s) autoVoteAtivo = s end)
objAutoChooseWeapon = createToggle(tabs.Misc, "Auto Choose Weapon", {color = "yellow", text = "<u>experimental option, not recommended for use.</u>"}, function(s) autoChooseWeaponAtivo = s end)
createToggle(tabs.Misc, "Auto Cure Plunger", {color = "red", text = "Only use if you have the plunger equipped."}, function(s) autoCureAtivo = s end)
objAntiAfk = createToggle(tabs.Misc, "Anti-AFK", function(s) antiAfkAtivo = s end)
createToggle(tabs.Misc, "Stay In Round", function(s) stayInRoundAtivo = s end)
objStaySpeed = createSlider(tabs.Misc, "Stay In Round Speed", 1, 50, 10, function(val) _G.StaySpeed = val end)
createToggle(tabs.Misc, "Auto Run", function(s) autoRunAtivo = s end)

createTpBtn(tabs.Teleport, "Spawn (Lobby)", Vector3.new(611, -468, 529), false, {color = "yellow", text = "Be careful not to teleport during the match."})
createTpBtn(tabs.Teleport, "Shop Helicopter", Vector3.new(46, 3, -24))

createInlineDropdown(tabs.Config, "Config: ", configModesArray, currentConfig, function(val) currentConfig = val end)
local loadBtn = Instance.new("TextButton", tabs.Config)
loadBtn.Size = UDim2.new(1, 0, 0, 45)
loadBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 40)
loadBtn.Text = ""
Instance.new("UICorner", loadBtn).CornerRadius = UDim.new(0, 6)

local loadTitleContainer = Instance.new("Frame", loadBtn)
loadTitleContainer.Size = UDim2.new(1, 0, 1, 0)
loadTitleContainer.BackgroundTransparency = 1

local loadLayout = Instance.new("UIListLayout", loadTitleContainer)
loadLayout.FillDirection = Enum.FillDirection.Horizontal
loadLayout.VerticalAlignment = Enum.VerticalAlignment.Center
loadLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
loadLayout.Padding = UDim.new(0, 6)

local loadLabel = Instance.new("TextLabel", loadTitleContainer)
loadLabel.AutomaticSize = Enum.AutomaticSize.X
loadLabel.Size = UDim2.new(0, 0, 1, 0)
loadLabel.Text = "Load Selected Config"
loadLabel.TextColor3 = Color3.new(1, 1, 1)
loadLabel.Font = Enum.Font.GothamBold
loadLabel.TextSize = 14
loadLabel.BackgroundTransparency = 1

applyTooltip(loadTitleContainer, {color = "yellow", text = "Don't forget to change the mode in Auto Vote"})

loadBtn.MouseButton1Click:Connect(function()
    if currentConfig == "100% AFK Farm" then
        objAutoFarm:Set(true)
        objAutoFlush:Set(true)
        objOrbitalSpeed:Set(13)
        objBuyHealth:Set(true)
        objBuyPR:Set(true)
        objBuySL:Set(true)
        objFarmItems:Set(true)
        objItemNotif:Set(true)
        objAutoJoin:Set(true)
        objAutoVote:Set(true)
        objAntiAfk:Set(true)
        objAutoChooseWeapon:Set(true)
        if objAutoSkipHeli then objAutoSkipHeli:Set(true) end
        if objAntiProjectiles then objAntiProjectiles:Set(true) end
    end
end)

-- ============================================================
-- LOGICA DE BACKGROUND E AUTOMAÇÕES CORE
-- ============================================================
task.spawn(function() 
    local skipRemote = ReplicatedStorage:WaitForChild("SkipHelicopter")
    while true do 
        task.wait(2)
        if autoSkipHeliAtivo then 
            pcall(function() skipRemote:FireServer() end) 
        end 
    end 
end)

task.spawn(function() 
    while true do 
        task.wait(1)
        if autoChooseWeaponAtivo then 
            local hasPR = checkWeaponExists("pulse")
            local hasSL = checkWeaponExists("small")
            local newMethod = "Auto Punch"
            
            if hasPR and hasSL then 
                newMethod = "Pulse Rifle + Small Laser" 
            elseif hasPR then 
                newMethod = "Pulse Rifle" 
            elseif hasSL then 
                newMethod = "Small Laser" 
            end
            
            if farmMethod ~= newMethod then 
                farmMethod = newMethod
                if farmDropdownObj then farmDropdownObj:UpdateText(farmMethod) end 
            end 
        end 
    end 
end)

task.spawn(function() 
    local buffRemote = ReplicatedStorage:WaitForChild("Buff")
    while true do 
        task.wait(1)
        if autoCureAtivo and player.Character then 
            local hum = player.Character:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 and (hum.Health / hum.MaxHealth) < 0.4 then 
                pcall(function() buffRemote:FireServer() end)
                task.wait(5) 
            end 
        end 
    end 
end)

-- AUTO JOIN LÓGICA (HANDSHAKE FIX & COOLDOWN)
task.spawn(function()
    local readyRemote = ReplicatedStorage:WaitForChild("GetReadyRemote")
    local wasJoined = false
    local lobbyArrivalTime = 0
    local wasInLobby = false
    
    while true do
        task.wait(2)
        local inLobby = player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.Position.Y < 0
        
        if inLobby and not wasInLobby then
            lobbyArrivalTime = tick()
            wasInLobby = true
        elseif not inLobby then
            wasInLobby = false
            wasJoined = false
        end
        
        if autoJoinAtivo and inLobby then
            if (tick() - lobbyArrivalTime) > 5 then
                pcall(function()
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(557, -468, 465)
                    task.wait(0.5)
                    readyRemote:FireServer("1", true)
                    wasJoined = true
                end)
            end
        elseif not autoJoinAtivo and wasJoined then
            pcall(function()
                readyRemote:FireServer("1", false)
                readyRemote:FireServer("2", false)
                readyRemote:FireServer("3", false)
                wasJoined = false
            end)
        end
    end
end)

task.spawn(function()
    local voteRemote = ReplicatedStorage:WaitForChild("Vote")
    while true do
        task.wait(1.5)
        if autoVoteAtivo then 
            pcall(function() voteRemote:FireServer(voteMode) end) 
        end 
    end
end)

-- AUTO RUN LÓGICA (TOGGLE PURO & DEBOUNCE TÁTICO)
task.spawn(function()
    local runRemote = ReplicatedStorage:WaitForChild("Running")
    while true do
        task.wait(0.1)
        if autoRunAtivo and player.Character then
            local hum = player.Character:FindFirstChild("Humanoid")
            if hum and hum.MoveDirection.Magnitude > 0 and hum.WalkSpeed <= 16.5 then 
                pcall(function() runRemote:FireServer() end)
                task.wait(0.5) 
            end
        end
    end
end)

local notifContainer = Instance.new("Frame", gui)
notifContainer.Size = UDim2.new(0, 370, 0, 600)
notifContainer.Position = UDim2.new(0, 10, 0.5, -300)
notifContainer.BackgroundTransparency = 1
notifContainer.ZIndex = 20

local notifLayout = Instance.new("UIListLayout", notifContainer)
notifLayout.Padding = UDim.new(0, 8)
notifLayout.VerticalAlignment = Enum.VerticalAlignment.Top

local function playAlertSound() 
    pcall(function() 
        local s = Instance.new("Sound")
        s.SoundId = SOUND_ID
        s.Volume = 5
        s.Parent = Workspace.CurrentCamera
        s:Play()
        Debris:AddItem(s, 3) 
    end) 
end

local function showItemNotification(itemModel)
    local card = Instance.new("Frame", notifContainer)
    card.Size = UDim2.new(1, 0, 0, 115)
    card.BackgroundColor3 = Color3.fromRGB(14, 14, 24)
    card.ZIndex = 20
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 14)
    
    local stroke = Instance.new("UIStroke", card)
    stroke.Color = ACCENT
    stroke.Thickness = 2.5
    
    local bar = Instance.new("Frame", card)
    bar.Size = UDim2.new(0, 6, 1, -16)
    bar.Position = UDim2.new(0, 8, 0, 8)
    bar.BackgroundColor3 = Color3.fromRGB(255, 200, 30)
    bar.ZIndex = 21
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)
    
    local alertLbl = Instance.new("TextLabel", card)
    alertLbl.Size = UDim2.new(1, -80, 0, 30)
    alertLbl.Position = UDim2.new(0, 22, 0, 8)
    alertLbl.Text = "⚠️  ITEM RARO SPAWNADO!"
    alertLbl.TextColor3 = Color3.fromRGB(255, 210, 40)
    alertLbl.Font = Enum.Font.GothamBold
    alertLbl.TextSize = 15
    alertLbl.TextXAlignment = Enum.TextXAlignment.Left
    alertLbl.BackgroundTransparency = 1
    alertLbl.ZIndex = 21
    
    local nameLbl = Instance.new("TextLabel", card)
    nameLbl.Size = UDim2.new(1, -30, 0, 42)
    nameLbl.Position = UDim2.new(0, 22, 0, 36)
    nameLbl.Text = itemModel.Name
    nameLbl.TextColor3 = Color3.new(1, 1, 1)
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.TextSize = 24
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.TextWrapped = true
    nameLbl.BackgroundTransparency = 1
    nameLbl.ZIndex = 21
    
    local statusLbl = Instance.new("TextLabel", card)
    statusLbl.Size = UDim2.new(1, -30, 0, 22)
    statusLbl.Position = UDim2.new(0, 22, 0, 86)
    statusLbl.Text = "🟢  No chão — aguardando coleta..."
    statusLbl.TextColor3 = Color3.fromRGB(80, 255, 120)
    statusLbl.Font = Enum.Font.GothamSemibold
    statusLbl.TextSize = 13
    statusLbl.TextXAlignment = Enum.TextXAlignment.Left
    statusLbl.BackgroundTransparency = 1
    statusLbl.ZIndex = 21
    
    local xBtn = Instance.new("TextButton", card)
    xBtn.Size = UDim2.new(0, 30, 0, 30)
    xBtn.Position = UDim2.new(1, -36, 0, 6)
    xBtn.BackgroundTransparency = 1
    xBtn.Text = "X"
    xBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
    xBtn.Font = Enum.Font.GothamBold
    xBtn.TextSize = 18
    xBtn.ZIndex = 22
    
    playAlertSound()
    card.Position = UDim2.new(-1.1, 0, 0, 0)
    TweenService:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 0) }):Play()
    
    local hbConn
    local removed = false
    
    local function removeCard() 
        if removed then return end
        removed = true
        if hbConn then hbConn:Disconnect() end
        TweenService:Create(card, TweenInfo.new(0.2), { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0) }):Play()
        task.delay(0.25, function() if card then card:Destroy() end end) 
    end
    
    hbConn = RunService.Heartbeat:Connect(function() 
        if not itemModel or not itemModel.Parent then 
            statusLbl.Text = "🔴  Item sumiu ou foi coletado."
            statusLbl.TextColor3 = Color3.fromRGB(255, 80, 80)
            task.wait(1.5)
            removeCard() 
        end 
    end)
    
    xBtn.MouseButton1Click:Connect(removeCard)
end

-- ============================================================
-- 🔥 INTERACTION HUB (CPU RELIEF APLICADO: 1 SEGUNDO)
-- ============================================================
task.spawn(function()
    while true do
        task.wait(1) 
        if interactAtivo or saveAtivo then
            for _, model in ipairs(Living:GetChildren()) do
                if not model:IsA("Model") or model == player.Character then continue end
                
                for _, obj in ipairs(model:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") then
                        local isSave = (obj.Name == "TakeOffParasite")
                        local isFlush = (string.find(string.lower(obj.Parent.Name), "lever") or string.find(string.lower(obj.Name), "flush"))

                        if (saveAtivo and isSave) or (interactAtivo and isFlush) then
                            obj.HoldDuration = 0
                            obj.MaxActivationDistance = 99999
                            obj.RequiresLineOfSight = false
                            if fireproximityprompt then 
                                task.spawn(function() fireproximityprompt(obj, 1, true) end) 
                            end
                        end
                    end
                end
            end
        end

        if reviveAtivo then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= player and p.Character then
                    for _, obj in ipairs(p.Character:GetDescendants()) do
                        if obj:IsA("ProximityPrompt") then
                            local objA = obj.ActionText and string.lower(obj.ActionText) or ""
                            local objN = obj.Name and string.lower(obj.Name) or ""
                            if string.find(objA, "revive") or string.find(objN, "revive") then
                                obj.HoldDuration = 0
                                obj.MaxActivationDistance = 99999
                                obj.RequiresLineOfSight = false
                                if fireproximityprompt then 
                                    task.spawn(function() fireproximityprompt(obj, 1, true) end) 
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- ============================================================
-- 🔥 CORE AUTO FARM (CALIBRAÇÃO BALÍSTICA EXTREMA & ANTI-PROJECTILES)
-- ============================================================
local isShootingRifle = false
local isReloadingRifle = false
local lastTapTime = 0
local lastCombatMethod = ""
local lastEvasionTime = 0

task.spawn(function()
    while true do
        task.wait(0.05)
        
        local activeCombatMethod = farmMethod
        if farmMethod == "Pulse Rifle + Small Laser" then
            local prAmmo, prMax = checkAmmo("Pulse Rifle")
            if prAmmo <= 0 then 
                _G.PR_Reloading = true 
            elseif prAmmo >= prMax then 
                _G.PR_Reloading = false 
            end
            activeCombatMethod = _G.PR_Reloading and "Small Laser" or "Pulse Rifle"
        end

        if activeCombatMethod ~= lastCombatMethod then
            if isShootingRifle then
                local vp = Workspace.CurrentCamera.ViewportSize
                VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, false, game, 1)
                isShootingRifle = false
            end
            lastCombatMethod = activeCombatMethod
        end

        if (itemFarmAtivo and (#itemQueue > 0 or isProcessingQueue)) or not farmEnabled then
            if isShootingRifle then
                local vp = Workspace.CurrentCamera.ViewportSize
                VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, false, game, 1)
                isShootingRifle = false
            end
            continue
        end

        local rawTargets = {}
        for _, model in ipairs(Living:GetChildren()) do
            if not SKIBIDI_LIST[model.Name] then continue end
            if Players:GetPlayerFromCharacter(model) then continue end
            
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

        if #rawTargets == 0 then
            if isShootingRifle then
                local vp = Workspace.CurrentCamera.ViewportSize
                VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, false, game, 1)
                isShootingRifle = false
            end
            continue
        end

        local validTargets = {}
        if targetMethod == "Saw" or targetMethod == "Rocket" then
            for _, t in ipairs(rawTargets) do
                local nLower = string.lower(t.model.Name)
                if targetMethod == "Saw" and string.find(nLower, "saw") then 
                    table.insert(validTargets, t)
                elseif targetMethod == "Rocket" and string.find(nLower, "rocket") then 
                    table.insert(validTargets, t) 
                end
            end
            if #validTargets == 0 then validTargets = rawTargets end 
        else
            validTargets = rawTargets
            if targetMethod == "Weakest First" then 
                table.sort(validTargets, function(a, b) return a.headSize < b.headSize end)
            elseif targetMethod == "Strongest First" then 
                table.sort(validTargets, function(a, b) return a.headSize > b.headSize end) 
            end
        end

        for _, tData in ipairs(validTargets) do
            local model, torso, headSize = tData.model, tData.torso, tData.headSize
            if currentConnection then currentConnection:Disconnect() end

            currentConnection = RunService.Heartbeat:Connect(function(dt)
                local isDeadNow = false
                local f1 = model:FindFirstChild("1")
                if f1 and f1:FindFirstChild("BallSocketConstraint") then isDeadNow = true end
                local hum = model:FindFirstChildWhichIsA("Humanoid")
                if hum and hum.Health <= 0 then isDeadNow = true end

                if not farmEnabled or not torso.Parent or isDeadNow or stayInRoundAtivo or (itemFarmAtivo and (#itemQueue > 0 or isProcessingQueue)) then
                    if currentConnection then currentConnection:Disconnect() end
                    return
                end
                
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if hrp then hrp.Velocity = Vector3.new(0, 0, 0) end
                
                local combatPos
                local integrity = (#_v == 17) and 1 or "Crash"

                local yOffset = 0
                local zOffset = -3
                local aimOffset = Vector3.new(0, -0.5, 0)
                local customOrbitRadius = nil
                local customOrbitHeight = nil

                if model.Name == "Zombie Strider gun" then 
                    yOffset = 22 
                elseif model.Name == "G toilet" then
                    yOffset = 20
                    aimOffset = Vector3.new(0, 16, 0)
                    zOffset = -18
                elseif model.Name == "Giant GS toilet" then
                    customOrbitRadius = (20 + (headSize * 2.0)) * integrity
                    yOffset = -10 
                elseif model.Name == "Astro assilant toilet" then
                    customOrbitRadius = (60 + (headSize * 4.0)) * integrity 
                elseif model.Name == "Rocket bathtub toilet" then
                    customOrbitRadius = (55 + (headSize * 4.0)) * integrity 
                elseif model.Name == "Quad Rocket Toilet" then
                    aimOffset = Vector3.new(0, -15, 0) 
                    yOffset = -15
                elseif model.Name == "G-Toilet 3.0" then
                    customOrbitRadius = (100 + (headSize * 4.0)) * integrity
                    yOffset = 30
                    aimOffset = Vector3.new(0, 20, 0)
                end

                local nLower = string.lower(model.Name)
                local isAerial = string.find(nLower, "heli") or string.find(nLower, "dropper") or string.find(nLower, "flying") or string.find(nLower, "plane") or string.find(nLower, "cargobob")
                local orbitHeight = isAerial and 5 or (30 + (headSize * 2.0))

                if activeCombatMethod == "Auto Punch" then
                    local distY = (8 + (headSize * 0.8)) * integrity + yOffset
                    combatPos = torso.Position + Vector3.new(0, distY, 0) + (torso.CFrame.LookVector * zOffset)
                    if player.Character then 
                        player.Character:PivotTo(CFrame.lookAt(combatPos, torso.Position))
                        LMB_Event:FireServer() 
                    end

                elseif activeCombatMethod == "Orbital Punch" then
                    _G.OrbitalAngle = _G.OrbitalAngle + (_G.OrbitalSpeed * dt)
                    local orbitRadius = customOrbitRadius or ((7 + (headSize * 0.6)) * integrity)
                    combatPos = torso.Position + Vector3.new(math.cos(_G.OrbitalAngle) * orbitRadius, (8 + (headSize * 1.0)) + yOffset, math.sin(_G.OrbitalAngle) * orbitRadius)
                    if player.Character then 
                        player.Character:PivotTo(CFrame.lookAt(combatPos, torso.Position))
                        LMB_Event:FireServer() 
                    end

                elseif activeCombatMethod == "Pulse Rifle" or activeCombatMethod == "Big Laser" or activeCombatMethod == "Small Laser" then
                    _G.OrbitalAngle = _G.OrbitalAngle + (_G.OrbitalSpeed * dt)
                    
                    local baseRadius = (35 + (headSize * 4.0)) * integrity
                    local safeRadius = math.max(45, baseRadius)
                    local orbitRadius = customOrbitRadius or safeRadius
                    
                    local orbitH = customOrbitHeight or orbitHeight
                    
                    local rawPos = torso.Position + Vector3.new(math.cos(_G.OrbitalAngle) * orbitRadius, orbitH + yOffset, math.sin(_G.OrbitalAngle) * orbitRadius)
                    combatPos = Vector3.new(math.clamp(rawPos.X, -645, 460), math.clamp(rawPos.Y, -400, 285), math.clamp(rawPos.Z, -515, 460))
                    
                    -- ENGINE ANTI-PROJECTILES (IGNORANDO BOOM6)
                    if antiProjectilesAtivo then
                        local effectsFolder = Workspace:FindFirstChild("Effects")
                        if effectsFolder then
                            for _, effect in ipairs(effectsFolder:GetChildren()) do
                                local en = string.lower(effect.Name)
                                if (string.find(en, "rocket") or string.find(en, "boom") or string.find(en, "acidfloor") or string.find(en, "projectile")) and not string.find(en, "boom6") then
                                    local effectPos = effect:GetPivot().Position
                                    if (combatPos - effectPos).Magnitude < 45 then
                                        if tick() - lastEvasionTime > 1 then
                                            _G.OrbitalAngle = _G.OrbitalAngle + math.pi
                                            lastEvasionTime = tick()
                                        end
                                        rawPos = torso.Position + Vector3.new(math.cos(_G.OrbitalAngle) * orbitRadius, orbitH + yOffset, math.sin(_G.OrbitalAngle) * orbitRadius)
                                        combatPos = Vector3.new(math.clamp(rawPos.X, -645, 460), math.clamp(rawPos.Y, -400, 285), math.clamp(rawPos.Z, -515, 460))
                                        break
                                    end
                                end
                            end
                        end
                    end
                    
                    if player.Character then
                        local tool = equipWeapon(activeCombatMethod)
                        player.Character:PivotTo(CFrame.new(combatPos))
                        Workspace.CurrentCamera.CFrame = CFrame.lookAt(Workspace.CurrentCamera.CFrame.Position, torso.Position + aimOffset)
                    end
                end
            end)

            repeat 
                if farmMethod == "Pulse Rifle + Small Laser" then
                    local prAmmo, prMax = checkAmmo("Pulse Rifle")
                    if prAmmo <= 0 then 
                        _G.PR_Reloading = true 
                    elseif prAmmo >= prMax then 
                        _G.PR_Reloading = false 
                    end
                    activeCombatMethod = _G.PR_Reloading and "Small Laser" or "Pulse Rifle"
                else
                    activeCombatMethod = farmMethod
                end

                if activeCombatMethod ~= lastCombatMethod then
                    if isShootingRifle then
                        local vp = Workspace.CurrentCamera.ViewportSize
                        VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, false, game, 1)
                        isShootingRifle = false
                    end
                    lastCombatMethod = activeCombatMethod
                end

                if activeCombatMethod == "Pulse Rifle" or activeCombatMethod == "Big Laser" or activeCombatMethod == "Small Laser" then
                    local tool = equipWeapon(activeCombatMethod)
                    local ammoNode = tool and tool:FindFirstChild("Folder") and tool.Folder:FindFirstChild("Ammo")
                    local vp = Workspace.CurrentCamera.ViewportSize
                    local aimX, aimY = vp.X / 2, vp.Y / 2
                    
                    if tool and ammoNode then
                        local maxAmmo = 30
                        local maxAmmoNode = tool.Folder:FindFirstChild("MaxAmmo")
                        if maxAmmoNode then maxAmmo = maxAmmoNode.Value end

                        if ammoNode.Value <= 0 then
                            isReloadingRifle = true
                            if isShootingRifle then 
                                isShootingRifle = false
                                VIM:SendMouseButtonEvent(aimX, aimY, 0, false, game, 1) 
                            end
                        elseif isReloadingRifle and ammoNode.Value >= maxAmmo then
                            isReloadingRifle = false
                        end

                        if not isReloadingRifle and ammoNode.Value > 0 then
                            VIM:SendMouseMoveEvent(aimX, aimY, game) 
                            
                            if activeCombatMethod == "Big Laser" or activeCombatMethod == "Small Laser" then
                                if not isShootingRifle then 
                                    isShootingRifle = true
                                    VIM:SendMouseButtonEvent(aimX, aimY, 0, true, game, 1) 
                                end
                            else
                                if headSize > 12 then 
                                    if not isShootingRifle then 
                                        isShootingRifle = true
                                        VIM:SendMouseButtonEvent(aimX, aimY, 0, true, game, 1) 
                                    end
                                else 
                                    if tick() - lastTapTime > 0.25 then
                                        lastTapTime = tick()
                                        if not isShootingRifle then
                                            isShootingRifle = true
                                            VIM:SendMouseButtonEvent(aimX, aimY, 0, true, game, 1)
                                            task.delay(0.1, function() 
                                                VIM:SendMouseButtonEvent(aimX, aimY, 0, false, game, 1)
                                                isShootingRifle = false 
                                            end)
                                        end
                                    end
                                end
                            end
                        else
                            if isShootingRifle then 
                                isShootingRifle = false
                                VIM:SendMouseButtonEvent(aimX, aimY, 0, false, game, 1)
                            end
                        end
                    else
                        if isShootingRifle then 
                            isShootingRifle = false
                            VIM:SendMouseButtonEvent(aimX, aimY, 0, false, game, 1)
                        end
                    end
                else
                    if isShootingRifle then
                        local vp = Workspace.CurrentCamera.ViewportSize
                        isShootingRifle = false
                        VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, false, game, 1)
                    end
                end
                task.wait(0.1)
                
                local isDeadNow = false
                local f1 = model:FindFirstChild("1")
                if f1 and f1:FindFirstChild("BallSocketConstraint") then isDeadNow = true end
                local hum = model:FindFirstChildWhichIsA("Humanoid")
                if hum and hum.Health <= 0 then isDeadNow = true end
                
            until not farmEnabled or not model.Parent or isDeadNow or stayInRoundAtivo or (itemFarmAtivo and (#itemQueue > 0 or isProcessingQueue)) or not currentConnection or not currentConnection.Connected

            if currentConnection then currentConnection:Disconnect() end
            
            if isShootingRifle and (activeCombatMethod == "Pulse Rifle") then
                local vp = Workspace.CurrentCamera.ViewportSize
                VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, false, game, 1)
                isShootingRifle = false
            end
            break
        end
    end
end)

local function makeDraggable(dragArea, targetMove)
    targetMove = targetMove or dragArea
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    dragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if _G.IsAimbotting then return end 
            dragging = true
            dragStart = input.Position
            startPos = targetMove.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local d = input.Position - dragStart
            targetMove.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then 
            dragging = false 
        end
    end)
end

makeDraggable(topBar, main)
makeDraggable(sidebar, main)

local minBtnDragging = false
local minBtnHasDragged = false
local minBtnDragStart = nil
local minBtnStartPos = nil

minBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if _G.IsAimbotting then return end 
        minBtnDragging = true
        minBtnHasDragged = false
        minBtnDragStart = input.Position
        minBtnStartPos = minBtn.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if minBtnDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - minBtnDragStart
        if d.Magnitude > 5 then minBtnHasDragged = true end
        minBtn.Position = UDim2.new(minBtnStartPos.X.Scale, minBtnStartPos.X.Offset + d.X, minBtnStartPos.Y.Scale, minBtnStartPos.Y.Offset + d.Y)
    end
end)

minBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        minBtnDragging = false
        if not minBtnHasDragged then
            main.Visible = true
            minBtn.Visible = false
        end
    end
end)

-- ANTI-AFK LAYER 1: EVENTO DE IDLE
player.Idled:Connect(function() 
    if antiAfkAtivo then 
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
        
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            hrp.CFrame = hrp.CFrame * CFrame.new(0, 0.05, 0)
            task.wait(0.1)
            hrp.CFrame = hrp.CFrame * CFrame.new(0, -0.05, 0)
        end
    end 
end)

-- ANTI-AFK LAYER 2: BACKUP LOOP (Bypass para executores que bloqueiam Idled)
task.spawn(function()
    while true do
        task.wait(600) 
        if antiAfkAtivo then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end
    end
end)

print("✅ V11.0 — Matriz Desbloqueada. Auto Farm Restaurado. Escudo Projetil Ignorando 'BOOM6'.")
