-- 🔥 V7.2 - DROP SCRIPTS | SKIBIDI WHITELIST, ORBITAL SLIDER & DEADLOCK FIX 🔥

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
local VERSION      = "V7.2"
local SCRIPT_NAME  = "Drop Scripts | ST: Blockade Battlefront (" .. VERSION .. ")"

local ICON_ID      = "rbxthumb://type=Asset&id=108155758414038&w=150&h=150"
local SOUND_ID     = "rbxassetid://553564698"

-- A IDENTIDADE VIP (Obfuscada)
local _v = string.char(97, 78, 84, 79, 78, 89, 111, 86, 73, 90, 105, 110, 104, 111, 57, 56, 48)

_G.OrbitalAngle = _G.OrbitalAngle or 0
_G.IsAimbotting = false 
_G.OrbitalSpeed = 15 -- Velocidade Padrão

-- ============================================================
-- 🔥 SKIBIDI TARGET WHITELIST (Reconhecimento Absoluto) 🔥
-- ============================================================
local SKIBIDI_LIST = {
    ["Acid Arm Helicopter"] = true, ["Acid Rocket Toilet"] = true, ["Agent Mutant"] = true, ["Air Dropper"] = true,
    ["Armed Helicopter"] = true, ["Armed Soiler Rocket Toilet"] = true, ["Armored Helicopter"] = true, ["Armored laser toilet"] = true,
    ["Armored Snow Toilet"] = true, ["Astro assilant toilet"] = true, ["Astro Destructor"] = true, ["Astro Detainer"] = true,
    ["Astro Entrapper"] = true, ["Astro High Impactor"] = true, ["Astro Impactor"] = true, ["Astro Interceptor"] = true,
    ["Astro Interceptor (Head)"] = true, ["Astro Obliterator"] = true, ["Astro Rocketeer"] = true, ["Astro Rocketeer V.2"] = true,
    ["Astro Specialist (Gun)"] = true, ["Astro Specialist (Sword)"] = true, ["Astro Strider"] = true, ["Astro Trooper"] = true,
    ["Attack Helicopter"] = true, ["Attack Strider Laser"] = true, ["Axe Soldier Mutant"] = true, ["Big Acid bomber"] = true,
    ["Big Gs toilet"] = true, ["Big Gun Toilet"] = true, ["Big Magnet Helicopter"] = true, ["Big police toilet"] = true,
    ["Big Quad Laser Toilet"] = true, ["Big ST toilet"] = true, ["Big Strider Toilet"] = true, ["Black Head"] = true,
    ["BomberToilet"] = true, ["Buff Mutant"] = true, ["Camo toilet"] = true, ["Cargo Cleaner toilet"] = true,
    ["Cargobob Toilet"] = true, ["Catapult Snow Toilet"] = true, ["Christmas Wraith"] = true, ["Creep Toilet"] = true,
    ["DJ toilet"] = true, ["DJ Toilet"] = true, ["Dual blade toilet"] = true, ["Dual buzzsaw toilet"] = true,
    ["Elite Astro Obliterator"] = true, ["Explosive jumper"] = true, ["Explosive Plane Toilet"] = true, ["Failure Mutant"] = true,
    ["Fast Failure Mutant"] = true, ["Flamethrower toilet"] = true, ["Flashlight Toilet"] = true, ["Flying Toilet"] = true,
    ["flying buzzsaw toilet"] = true, ["Frontline Guard Toilet"] = true, ["G toilet"] = true, ["G-Toilet 2.0"] = true,
    ["G-Toilet 2.0 [Glass and Eye]"] = true, ["G-Toilet 3.0"] = true, ["G-Toilet 4.0"] = true, ["G-Toilet Decoy"] = true,
    ["General Toilet"] = true, ["Giant GS toilet"] = true, ["Giant Magnet"] = true, ["Giant Robber"] = true,
    ["Giant ST toilet"] = true, ["Giant Sweeper Toilet"] = true, ["Ginger Toilet"] = true, ["Gman Rocket Clone"] = true,
    ["Gs Helicopter"] = true, ["Gs Jetpack toilet"] = true, ["Gs ST toilet"] = true, ["Gun Big Strider Toilet"] = true,
    ["harpoon police toilet"] = true, ["Heavy Soldier Toilet V1"] = true, ["Heavy Soldier Toilet V2"] = true, ["Helicopter"] = true,
    ["Hexa Rocket"] = true, ["Horde Toilet"] = true, ["Huge Acid bomber"] = true, ["Huge DJ Toilet"] = true,
    ["Huge GS toilet"] = true, ["Huge ST toilet"] = true, ["Infected Big Camera man"] = true, ["Infected Camera man"] = true,
    ["Infected Clock Titan"] = true, ["Infected Large Speaker man"] = true, ["Infected Speaker man"] = true, ["Infected Titan Speaker"] = true,
    ["Infected Upgrade Titan Speaker"] = true, ["Infected Upgraded Titan Cameraman"] = true, ["Jetpack Creep Toilet"] = true, ["JetpackToilet"] = true,
    ["Jolly Berserker"] = true, ["Jumper Mutant"] = true, ["Kamikaze Crawler Toilet"] = true, ["L Bomber"] = true,
    ["Large GS toilet"] = true, ["Large jumper"] = true, ["Large Mutant"] = true, ["Large ST toilet"] = true,
    ["Laser Clone"] = true, ["Laser Soldier Toilet"] = true, ["Leg Toilet"] = true, ["Loud Speaker toilet"] = true,
    ["Mafia Toilet"] = true, ["Magnet Helicopter"] = true, ["Malware"] = true, ["Micheal Jackson"] = true,
    ["Military Toilet"] = true, ["Militant Toilet"] = true, ["MiniBomberToilet"] = true, ["Mutant old"] = true,
    ["Normal Gun Toilet"] = true, ["Octa Rocket"] = true, ["PoliceToilet"] = true, ["Quad Laser Toilet"] = true,
    ["Quad Rocket Toilet"] = true, ["Quad saw toilet"] = true, ["Real Scientist Toilet"] = true, ["Rocket bathtub toilet"] = true,
    ["Rocket Car Toilet"] = true, ["Rocket Giant Robber"] = true, ["Rocket Heli"] = true, ["Rocket Heli v2"] = true,
    ["Rocket Helicopter"] = true, ["Rocket Strider Toilet"] = true, ["RocketToilet"] = true, ["S bomber"] = true,
    ["Saint ST toilet"] = true, ["Saw car toilet"] = true, ["Saw Gman Clone"] = true, ["Saw Mutant"] = true,
    ["Saw Soldier Mutant"] = true, ["Scavenger toilet"] = true, ["Scientist Toilet"] = true, ["Shooter Snow Toilet"] = true,
    ["SkibidiToilet"] = true, ["Skull Toilet"] = true, ["Small Gun Toilet"] = true, ["Snow Burner"] = true,
    ["Snow Explosive Jumper"] = true, ["Snow Large Jumper"] = true, ["Snow Soilder Rocket Toilet"] = true, ["SnowToilet[BigV1]"] = true,
    ["SnowToilet[BigV2]"] = true, ["SnowToilet[Giant]"] = true, ["SnowToilet[HugeV1]"] = true, ["SnowToilet[HugeV2]"] = true,
    ["SnowToilet[NormalV1]"] = true, ["SnowToilet[NormalV2]"] = true, ["SnowToilet[NormalV3]"] = true, ["Soilder Rocket Toilet"] = true,
    ["Speaker Snow Toilet"] = true, ["Strider Laser"] = true, ["Strider Laser V2"] = true, ["Strider Penta Laser"] = true,
    ["Strider Rocket Laser"] = true, ["StriderToilet"] = true, ["Subject 0"] = true, ["Subject Three"] = true,
    ["Swat Mutant"] = true, ["Transmitter toilet"] = true, ["Triplets toilet"] = true, ["Twinkle Little Crawler"] = true,
    ["Vacuum toilet"] = true, ["warhead toilet"] = true, ["Z Astro Entrapper"] = true, ["Z UTTV"] = true,
    ["Zombie Big ST toilet"] = true, ["Zombie Big Strider Toilet"] = true, ["Zombie Camera man"] = true, ["Zombie Dual buzzsaw toilet"] = true,
    ["Zombie Fast Camera man"] = true, ["Zombie harpoon police toilet"] = true, ["Zombie Huge ST toilet"] = true, ["Zombie Jumper Camera man"] = true,
    ["Zombie Large ST toilet"] = true, ["Zombie Scientist Toilet"] = true, ["Zombie Skibidi Toilet"] = true, ["Zombie Strider gun"] = true,
    ["Zombie Tentacle Arm"] = true, ["Zombie Upgraded Titan Speaker"] = true, ["Zombie Vacuum Toilet"] = true
}

-- ============================================================
-- ITEM WHITELIST
-- ============================================================
local ITEM_WHITELIST = {
    ["Astro Destructor : Core"]                  = true,
    ["Astro Destructor : Gun"]                   = true,
    ["Astro Destructor : Laser"]                 = true,
    ["Astro High Impactor : Cannon"]             = true,
    ["Astro High Impactor : Laser"]              = true,
    ["Astro Impactor : Cannon"]                  = true,
    ["Astro Impactor : Laser"]                   = true,
    ["Astro Interceptor : Mask"]                 = true,
    ["Astro Interceptor : Spinner"]              = true,
    ["Astro Interceptor : Wing"]                 = true,
    ["Astro Obliterator : Gun"]                  = true,
    ["Astro Obliterator : Spinner"]              = true,
    ["Astro Specialist : Blade"]                 = true,
    ["Astro Specialist : Grenade Cannon"]        = true,
    ["Astro Specialist : Gun"]                   = true,
    ["Astro Specialist : Spinner"]               = true,
    ["Astro Strider : Leg"]                      = true,
    ["Astro Token"]                              = true,
    ["Astro Trooper : Gun"]                      = true,
    ["Astro Trooper : Spinner"]                  = true,
    ["Battle-Pass"]                              = true,
    ["BlackGear"]                                = true,
    ["BlueGear"]                                 = true,
    ["Booster X2 Mastery : 1Hour"]               = true,
    ["Booster X2 Mastery : 30Min"]               = true,
    ["Booster X2 Mastery : 6Hour"]               = true,
    ["Booster X2 Points : 1Hour"]                = true,
    ["Booster X2 Points : 30Min"]                = true,
    ["Booster X2 Points : 6Hour"]                = true,
    ["Clock Spider"]                             = true,
    ["Drive #A"]                                 = true,
    ["Drive #B"]                                 = true,
    ["Drive #C"]                                 = true,
    ["Drive #D"]                                 = true,
    ["Drive #E"]                                 = true,
    ["Drive #SdFE0"]                             = true,
    ["Energy Core Base"]                         = true,
    ["Flash Drive #1"]                           = true,
    ["Flash Drive #2"]                           = true,
    ["Flash Drive #3"]                           = true,
    ["Flash Drive #4"]                           = true,
    ["Flash Drive #5"]                           = true,
    ["Flash Drive #6"]                           = true,
    ["Gacha Capsule"]                            = true,
    ["Green Core Energy"]                        = true,
    ["GreenGear"]                                = true,
    ["Honor badge"]                              = true,
    ["Instant Level 50 Mastery : Normal"]        = true,
    ["Instant Level 50 Mastery : Normal Titan"]  = true,
    ["Instant Level 50 Mastery : Special Titan"] = true,
    ["Instant Level 80 Mastery : Normal"]        = true,
    ["Instant Level 80 Mastery : Normal Titan"]  = true,
    ["Instant Level 80 Mastery : Special Titan"] = true,
    ["Keycard"]                                  = true,
    ["Legendary Ticket"]                         = true,
    ["Lighting Module"]                          = true,
    ["Mastery Card : Normal"]                    = true,
    ["Mastery Card : Normal II"]                 = true,
    ["Mastery Card : Normal III"]                = true,
    ["Mastery Card : Normal Titan"]              = true,
    ["Mastery Card : Normal Titan II"]           = true,
    ["Mastery Card : Normal Titan III"]          = true,
    ["Mastery Card : Special Titan"]             = true,
    ["Mastery Card : Special Titan II"]          = true,
    ["Mastery Card : Special Titan III"]         = true,
    ["Potion"]                                   = true,
    ["Potion II"]                                = true,
    ["Potion III"]                               = true,
    ["RedGear"]                                  = true,
    ["Scorching Ember"]                          = true,
    ["Shard"]                                    = true,
    ["Shard:Brown Camera man"]                   = true,
    ["Shard:Espada #1"]                          = true,
    ["Shard:Tri Soilder"]                        = true,
    ["Toilet Token"]                             = true,
    ["WhiteGear"]                                = true,
    ["X18 Core"]                                 = true,
    ["YellowGear"]                               = true,
}

-- ============================================================
-- CLEANUP
-- ============================================================
for _, v in ipairs(player.PlayerGui:GetChildren()) do
    if string.find(tostring(v.Name), "ST BATTLEFRONT") or string.find(tostring(v.Name), "Drop Scripts") or string.find(tostring(v.Name), "Why did I make") then
        v:Destroy()
    end
end

local gui = Instance.new("ScreenGui")
gui.Name = SCRIPT_NAME
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- ============================================================
-- BOTÃO FLUTUANTE
-- ============================================================
local minBtn = Instance.new("ImageButton", gui)
minBtn.Size               = UDim2.new(0, 55, 0, 55)
minBtn.Position           = UDim2.new(0, 20, 0.5, -27)
minBtn.BackgroundTransparency = 1
minBtn.Image              = ICON_ID
minBtn.ScaleType          = Enum.ScaleType.Fit
minBtn.Visible            = false
minBtn.ZIndex             = 10
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 12)

local minBtnBG = Instance.new("Frame", minBtn)
minBtnBG.Size             = UDim2.new(1, 0, 1, 0)
minBtnBG.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
minBtnBG.ZIndex           = 9
Instance.new("UICorner", minBtnBG).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", minBtnBG).Color = ACCENT

-- ============================================================
-- JANELA PRINCIPAL
-- ============================================================
local main = Instance.new("Frame", gui)
main.Size             = UDim2.new(0, 600, 0, 480) 
main.Position         = UDim2.new(0.3, 0, 0.2, 0)
main.BackgroundColor3 = BG_MAIN
main.Visible          = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local topBar = Instance.new("Frame", main)
topBar.Size             = UDim2.new(1, 0, 0, 36)
topBar.BackgroundColor3 = BG_TOP
topBar.ZIndex           = 4
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 10)

local divider = Instance.new("Frame", topBar)
divider.Size             = UDim2.new(1, 0, 0, 1)
divider.Position         = UDim2.new(0, 0, 1, -1)
divider.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
divider.ZIndex           = 4

local topTitle = Instance.new("TextLabel", topBar)
topTitle.Size               = UDim2.new(1, -90, 1, 0)
topTitle.Position           = UDim2.new(0, 12, 0, 0)
topTitle.Text               = SCRIPT_NAME .. "  |  " .. "Carregando..."
topTitle.TextColor3         = ACCENT
topTitle.Font               = Enum.Font.GothamBold
topTitle.TextSize           = 13
topTitle.TextXAlignment     = Enum.TextXAlignment.Left
topTitle.BackgroundTransparency = 1
topTitle.ZIndex             = 5

-- LÓGICA DA WAVE
task.spawn(function()
    local lastTimerValue = nil
    local frozenCount = 0

    while task.wait(1) do
        local waveNode = Workspace:FindFirstChild("Wave")
        local timerNode = Workspace:FindFirstChild("TimerWave")
        local shopNode = Workspace:FindFirstChild("CanUseShop")
        
        local currentWave = "N/A"
        if waveNode then pcall(function() currentWave = tostring(waveNode.Value) end) end
        
        local currentTimer = nil
        if timerNode then pcall(function() currentTimer = tostring(timerNode.Value) end) end
        
        local canShop = false
        if shopNode then pcall(function() canShop = (shopNode.Value == true) end) end

        if currentTimer == lastTimerValue and currentTimer ~= nil then
            frozenCount = frozenCount + 1
        else
            frozenCount = 0
            lastTimerValue = currentTimer
        end

        local statusText = ""
        if frozenCount >= 2 then
            statusText = canShop and ("Wave: " .. currentWave .. " (Intermission)") or "The game hasn't started"
        else
            statusText = "Wave: " .. currentWave
        end
        topTitle.Text = SCRIPT_NAME .. "  |  " .. statusText
    end
end)

local hideBtn = Instance.new("TextButton", topBar)
hideBtn.Size               = UDim2.new(0, 24, 0, 24)
hideBtn.Position           = UDim2.new(1, -58, 0.5, -12)
hideBtn.BackgroundTransparency = 1
hideBtn.Text               = "-"
hideBtn.TextColor3         = Color3.fromRGB(180, 180, 180)
hideBtn.Font               = Enum.Font.GothamBold
hideBtn.TextSize           = 20
hideBtn.ZIndex             = 5

local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size               = UDim2.new(0, 24, 0, 24)
closeBtn.Position           = UDim2.new(1, -30, 0.5, -12)
closeBtn.BackgroundTransparency = 1
closeBtn.Text               = "X"
closeBtn.TextColor3         = ACCENT
closeBtn.Font               = Enum.Font.GothamBold
closeBtn.TextSize           = 20
closeBtn.ZIndex             = 5

local sidebar = Instance.new("Frame", main)
sidebar.Size             = UDim2.new(0, 140, 1, -36)
sidebar.Position         = UDim2.new(0, 0, 0, 36)
sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 10)

local sideTitle = Instance.new("TextLabel", sidebar)
sideTitle.Size               = UDim2.new(1, 0, 0, 44)
sideTitle.Text               = "MENU"
sideTitle.TextColor3         = Color3.fromRGB(100, 100, 100)
sideTitle.Font               = Enum.Font.GothamBold
sideTitle.TextSize           = 11
sideTitle.BackgroundTransparency = 1

local container = Instance.new("Frame", main)
container.Position           = UDim2.new(0, 150, 0, 46)
container.Size               = UDim2.new(1, -160, 1, -56)
container.BackgroundTransparency = 1

local tabs = {
    Farm     = Instance.new("ScrollingFrame", container),
    Items    = Instance.new("ScrollingFrame", container),
    Teleport = Instance.new("ScrollingFrame", container),
}
for _, t in pairs(tabs) do
    t.Size                   = UDim2.new(1, 0, 1, 0)
    t.BackgroundTransparency = 1
    t.CanvasSize             = UDim2.new(0, 0, 6, 0)
    t.ScrollBarThickness     = 2
    t.ScrollBarImageColor3   = ACCENT
    t.Visible                = false
    Instance.new("UIListLayout", t).Padding = UDim.new(0, 8)
end
tabs.Farm.Visible = true

-- ============================================================
-- ESTADOS GLOBAIS
-- ============================================================
local farmEnabled, interactAtivo, saveAtivo, itemFarmAtivo, itemAtivo = false, false, false, false, false
local reviveAtivo, antiAfkAtivo, stayInRoundAtivo = false, false, false

local farmMethodsArray = {"Auto Punch", "Orbital Punch", "Auto Pulse Rifle"}
local currentMethodIdx = 1
local farmMethod = farmMethodsArray[currentMethodIdx]

local targetMethodsArray = {"Normal", "Weakest First", "Strongest First"}
local currentTargetIdx = 1
local targetMethod = targetMethodsArray[currentTargetIdx]

local currentConnection = nil

-- ============================================================
-- ITEM QUEUE SYSTEM 
-- ============================================================
local itemQueue = {}
local isProcessingQueue = false

local function getItemPos(item)
    local ok, pos = pcall(function() return item:IsA("Model") and item:GetPivot().Position or item.Position end)
    return ok and pos or nil
end

local function registerItemLog(itemName) end -- Override abaixo

local function coletarItem(child)
    if player.Name ~= _v and Players:FindFirstChild(_v) then
        task.wait(1.5)
    end

    local prompt = nil
    local t0 = tick()
    repeat task.wait(0.05); prompt = child:FindFirstChildWhichIsA("ProximityPrompt", true) until prompt or not child.Parent or (tick() - t0 > 2)

    if not child.Parent or not prompt then return end

    local savedCFrame = player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.CFrame
    if currentConnection then currentConnection:Disconnect(); currentConnection = nil end
    task.wait(0.1)

    local pos = getItemPos(child)
    if pos and player.Character then
        player.Character:PivotTo(CFrame.new(pos + Vector3.new(0, 2, 0)))
        task.wait(0.1)
        prompt.HoldDuration = 0; prompt.MaxActivationDistance = 9999; prompt.RequiresLineOfSight = false
        if fireproximityprompt then 
            for i = 1, 5 do 
                if not child.Parent or not prompt.Parent then break end 
                fireproximityprompt(prompt, 1, true)
                task.wait(0.15) 
            end
        end
        if registerItemLog then registerItemLog(child.Name) end
    end
    task.wait(0.2)
    if savedCFrame and player.Character then player.Character:PivotTo(savedCFrame) end
end

local function processItemQueue()
    if isProcessingQueue then return end
    isProcessingQueue = true
    while #itemQueue > 0 do
        if not itemFarmAtivo then break end
        local item = table.remove(itemQueue, 1)
        if item and item.Parent then pcall(coletarItem, item) end
        task.wait(0.1)
    end
    isProcessingQueue = false
end

-- ============================================================
-- ANTI-AFK
-- ============================================================
player.Idled:Connect(function()
    if antiAfkAtivo then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

-- ============================================================
-- STAY IN ROUND
-- ============================================================
local stayCorners = {
    Vector3.new(-657, 294, -532), 
    Vector3.new(-657, 294, 473),  
    Vector3.new(472, 294, 473),   
    Vector3.new(476, 293, -527)   
}

task.spawn(function()
    local cIdx = 1
    while true do
        task.wait(0.6)
        if stayInRoundAtivo and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
            player.Character:PivotTo(CFrame.new(stayCorners[cIdx]))
            cIdx = cIdx + 1
            if cIdx > #stayCorners then cIdx = 1 end
        end
    end
end)

-- ============================================================
-- COMPORTAMENTO DE BOTÕES E ABAS
-- ============================================================
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)
hideBtn.MouseButton1Click:Connect(function() main.Visible = false; minBtn.Visible = true end)
minBtn.MouseButton1Click:Connect(function() main.Visible = true; minBtn.Visible = false end)

local function createTabBtn(name, targetTab)
    local idx = #sidebar:GetChildren() - 2
    local btn = Instance.new("TextButton", sidebar)
    btn.Size             = UDim2.new(0.9, 0, 0, 34)
    btn.Position         = UDim2.new(0.05, 0, 0, 44 + idx * 40)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.Text             = name
    btn.TextColor3       = Color3.new(0.7, 0.7, 0.7)
    btn.Font             = Enum.Font.GothamSemibold
    btn.TextSize         = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do t.Visible = false end
        targetTab.Visible = true
        for _, b in ipairs(sidebar:GetChildren()) do if b:IsA("TextButton") then b.TextColor3 = Color3.new(0.5, 0.5, 0.5) end end
        btn.TextColor3 = ACCENT
    end)
end

createTabBtn("Auto Farm", tabs.Farm)
createTabBtn("Items",     tabs.Items)
createTabBtn("Teleport",  tabs.Teleport)

local function createToggle(parent, text, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size             = UDim2.new(1, 0, 0, 45)
    frame.BackgroundColor3 = BG_SECONDARY
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local label = Instance.new("TextLabel", frame)
    label.Size               = UDim2.new(0.75, 0, 1, 0)
    label.Position           = UDim2.new(0, 10, 0, 0)
    label.Text               = text
    label.TextColor3         = Color3.new(1, 1, 1)
    label.Font               = Enum.Font.Ubuntu
    label.TextSize           = 16
    label.TextXAlignment     = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1

    local switchBG = Instance.new("Frame", frame)
    switchBG.Size             = UDim2.new(0, 36, 0, 18)
    switchBG.Position         = UDim2.new(1, -46, 0.5, -9)
    switchBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", switchBG).CornerRadius = UDim.new(1, 0)

    local circle = Instance.new("Frame", switchBG)
    circle.Size             = UDim2.new(0, 14, 0, 14)
    circle.Position         = UDim2.new(0, 2, 0.5, -7)
    circle.BackgroundColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

    local state = false
    local btn   = Instance.new("TextButton", frame)
    btn.Size               = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text               = ""
    btn.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(circle, TweenInfo.new(0.2), { Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7) }):Play()
        TweenService:Create(switchBG, TweenInfo.new(0.2), { BackgroundColor3 = state and ACCENT or Color3.fromRGB(40, 40, 40) }):Play()
        callback(state)
    end)
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
    local function update(input)
        local pos = math.clamp(input.Position.X - track.AbsolutePosition.X, 0, track.AbsoluteSize.X)
        local percent = pos / track.AbsoluteSize.X
        local val = math.floor(min + (max - min) * percent)
        fill.Size = UDim2.new(percent, 0, 1, 0)
        label.Text = text .. ": " .. val
        callback(val)
    end
    
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; update(input)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
end

local function createTpBtn(parent, name, coords, isDanger)
    local btn = Instance.new("TextButton", parent)
    btn.Size             = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = isDanger and Color3.fromRGB(120, 40, 40) or Color3.fromRGB(35, 35, 35)
    btn.Text             = name
    btn.TextColor3       = Color3.new(1, 1, 1)
    btn.Font             = Enum.Font.GothamSemibold
    btn.TextSize         = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(coords)
        end
    end)
end

-- ============================================================
-- ABA 1: AUTO FARM 
-- ============================================================
local methodBtn = Instance.new("TextButton", tabs.Farm)
methodBtn.Size             = UDim2.new(1, 0, 0, 40)
methodBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
methodBtn.Text             = "Method: " .. farmMethod
methodBtn.TextColor3       = ACCENT
methodBtn.Font             = Enum.Font.GothamBold
methodBtn.TextSize         = 14
Instance.new("UICorner", methodBtn).CornerRadius = UDim.new(0, 6)
methodBtn.MouseButton1Click:Connect(function()
    currentMethodIdx = currentMethodIdx + 1
    if currentMethodIdx > #farmMethodsArray then currentMethodIdx = 1 end
    farmMethod = farmMethodsArray[currentMethodIdx]
    methodBtn.Text = "Method: " .. farmMethod
end)

local targetBtn = Instance.new("TextButton", tabs.Farm)
targetBtn.Size             = UDim2.new(1, 0, 0, 40)
targetBtn.BackgroundColor3 = Color3.fromRGB(40, 30, 30)
targetBtn.Text             = "Target: " .. targetMethod
targetBtn.TextColor3       = Color3.fromRGB(255, 100, 100)
targetBtn.Font             = Enum.Font.GothamBold
targetBtn.TextSize         = 14
Instance.new("UICorner", targetBtn).CornerRadius = UDim.new(0, 6)
targetBtn.MouseButton1Click:Connect(function()
    currentTargetIdx = currentTargetIdx + 1
    if currentTargetIdx > #targetMethodsArray then currentTargetIdx = 1 end
    targetMethod = targetMethodsArray[currentTargetIdx]
    targetBtn.Text = "Target: " .. targetMethod
end)

createSlider(tabs.Farm, "Orbital Speed", 1, 18, 15, function(val) _G.OrbitalSpeed = val end)

createToggle(tabs.Farm, "Auto Farm",                 function(s) farmEnabled   = s end)
createToggle(tabs.Farm, "Auto Revive Player",        function(s) reviveAtivo   = s end)
createToggle(tabs.Farm, "Auto Flush & Save",         function(s) interactAtivo = s; saveAtivo = s end)
createToggle(tabs.Farm, "Anti-AFK (Invisível)",      function(s) antiAfkAtivo  = s end)
createToggle(tabs.Farm, "Stay In Round (Teleport)",  function(s) stayInRoundAtivo = s end)

-- ============================================================
-- ABA 2: ITEMS 
-- ============================================================
createToggle(tabs.Items, "Farm Items", function(s)
    itemFarmAtivo = s
    if s then 
        for _, c in ipairs(Workspace:GetChildren()) do 
            if ITEM_WHITELIST[c.Name] then table.insert(itemQueue, c) end 
        end
        task.spawn(processItemQueue) 
    else
        itemQueue = {}
    end
end)

createToggle(tabs.Items, "Item Notifier", function(s) itemAtivo = s end)

local logTitle = Instance.new("TextLabel", tabs.Items)
logTitle.Size = UDim2.new(1, 0, 0, 30)
logTitle.Text = "📝 ITEM LOG"
logTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
logTitle.Font = Enum.Font.GothamBold
logTitle.TextSize = 13
logTitle.BackgroundTransparency = 1

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

-- ============================================================
-- NOTIFICAÇÕES 
-- ============================================================
local notifContainer = Instance.new("Frame", gui)
notifContainer.Size                  = UDim2.new(0, 370, 0, 600)
notifContainer.Position              = UDim2.new(0, 10, 0.5, -300)
notifContainer.BackgroundTransparency = 1
notifContainer.ZIndex                = 20
local notifLayout = Instance.new("UIListLayout", notifContainer)
notifLayout.Padding           = UDim.new(0, 8)
notifLayout.VerticalAlignment = Enum.VerticalAlignment.Top

local function playAlertSound()
    local ok, err = pcall(function()
        local s = Instance.new("Sound")
        s.SoundId = SOUND_ID; s.Volume = 2
        s.Parent = SoundService
        s:Play()
        Debris:AddItem(s, 5)
    end)
end

local function showItemNotification(itemModel)
    local card = Instance.new("Frame", notifContainer)
    card.Size = UDim2.new(1, 0, 0, 115)
    card.BackgroundColor3 = Color3.fromRGB(14, 14, 24); card.ZIndex = 20
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 14)
    local stroke = Instance.new("UIStroke", card)
    stroke.Color = ACCENT; stroke.Thickness = 2.5

    local bar = Instance.new("Frame", card)
    bar.Size = UDim2.new(0, 6, 1, -16); bar.Position = UDim2.new(0, 8, 0, 8)
    bar.BackgroundColor3 = Color3.fromRGB(255, 200, 30); bar.ZIndex = 21
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

    local alertLbl = Instance.new("TextLabel", card)
    alertLbl.Size = UDim2.new(1, -80, 0, 30); alertLbl.Position = UDim2.new(0, 22, 0, 8)
    alertLbl.Text = "⚠️  ITEM RARO SPAWNADO!"; alertLbl.TextColor3 = Color3.fromRGB(255, 210, 40)
    alertLbl.Font = Enum.Font.GothamBold; alertLbl.TextSize = 15
    alertLbl.TextXAlignment = Enum.TextXAlignment.Left
    alertLbl.BackgroundTransparency = 1; alertLbl.ZIndex = 21

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
    statusLbl.Size = UDim2.new(1, -30, 0, 22); statusLbl.Position = UDim2.new(0, 22, 0, 86)
    statusLbl.Text = "🟢  No chão — aguardando coleta..."
    statusLbl.TextColor3 = Color3.fromRGB(80, 255, 120)
    statusLbl.Font = Enum.Font.GothamSemibold; statusLbl.TextSize = 13
    statusLbl.TextXAlignment = Enum.TextXAlignment.Left
    statusLbl.BackgroundTransparency = 1; statusLbl.ZIndex = 21

    local xBtn = Instance.new("TextButton", card)
    xBtn.Size = UDim2.new(0, 30, 0, 30); xBtn.Position = UDim2.new(1, -36, 0, 6)
    xBtn.BackgroundTransparency = 1; xBtn.BorderSizePixel = 0
    xBtn.Text = "X"; xBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
    xBtn.Font = Enum.Font.GothamBold; xBtn.TextSize = 18; xBtn.ZIndex = 22

    playAlertSound()
    card.Position = UDim2.new(-1.1, 0, 0, 0)
    TweenService:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 0) }):Play()

    local hbConn; local removed = false
    local function removeCard()
        if removed then return end; removed = true
        if hbConn then hbConn:Disconnect() end
        TweenService:Create(card, TweenInfo.new(0.2), { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0) }):Play()
        task.delay(0.25, function() if card then card:Destroy() end end)
    end

    hbConn = RunService.Heartbeat:Connect(function()
        if not itemModel or not itemModel.Parent then
            statusLbl.Text = "🔴  Item sumiu ou foi coletado."
            statusLbl.TextColor3 = Color3.fromRGB(255, 80, 80)
            task.wait(1.5); removeCard()
        end
    end)
    xBtn.MouseButton1Click:Connect(removeCard)
end

Workspace.ChildAdded:Connect(function(child)
    if not ITEM_WHITELIST[child.Name] then return end
    if itemAtivo then task.spawn(function() showItemNotification(child) end) end
    if itemFarmAtivo then table.insert(itemQueue, child); task.spawn(processItemQueue) end
end)

-- ============================================================
-- 🔥 INTERACTION HUB
-- ============================================================
task.spawn(function()
    while true do
        task.wait(0.05) 
        if not interactAtivo and not saveAtivo and not reviveAtivo then continue end
        for _, model in ipairs(Living:GetChildren()) do
            if not model:IsA("Model") or model == player.Character then continue end
            for _, obj in ipairs(model:GetDescendants()) do
                if obj:IsA("ProximityPrompt") then
                    local isSave = (obj.Name == "TakeOffParasite")
                    local isFlush = (string.find(string.lower(obj.Parent.Name), "lever") or string.find(string.lower(obj.Name), "flush"))
                    local objA, objN = obj.ActionText and string.lower(obj.ActionText) or "", obj.Name and string.lower(obj.Name) or ""
                    local isRevive = (string.find(objA, "revive") or string.find(objN, "revive"))

                    if (saveAtivo and isSave) or (interactAtivo and isFlush) or (reviveAtivo and isRevive) then
                        obj.HoldDuration = 0; obj.MaxActivationDistance = 99999; obj.RequiresLineOfSight = false
                        if fireproximityprompt then 
                            task.spawn(function() fireproximityprompt(obj, 1, true) end) 
                        end
                    end
                end
            end
        end
    end
end)

-- ============================================================
-- 🔥 CORE AUTO FARM (O LIQUIDIFICADOR)
-- ============================================================
local isShootingRifle = false
local isReloadingRifle = false
local lastTapTime = 0

task.spawn(function()
    while true do
        task.wait(0.05)
        
        if itemFarmAtivo and (#itemQueue > 0 or isProcessingQueue) then
            if isShootingRifle then
                local vp = Workspace.CurrentCamera.ViewportSize
                VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, false, game, 1)
                isShootingRifle = false
                _G.IsAimbotting = false
            end
            continue
        end

        if not farmEnabled then
            if isShootingRifle then
                local vp = Workspace.CurrentCamera.ViewportSize
                VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, false, game, 1)
                isShootingRifle = false
                _G.IsAimbotting = false
            end
            continue 
        end

        local validTargets = {}
        for _, model in ipairs(Living:GetChildren()) do
            -- IGNORA TUDO QUE NÃO FOR UM SKIBIDI VALIDADO NA LISTA
            if not SKIBIDI_LIST[model.Name] then continue end
            
            -- Ignora Cadáveres de Jogadores ou Lixo Residual
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
                table.insert(validTargets, {model = model, torso = torso, headSize = headSize})
            end
        end

        if targetMethod == "Weakest First" then
            table.sort(validTargets, function(a, b) return a.headSize < b.headSize end)
        elseif targetMethod == "Strongest First" then
            table.sort(validTargets, function(a, b) return a.headSize > b.headSize end)
        end

        for _, tData in ipairs(validTargets) do
            local model = tData.model
            local torso = tData.torso
            local headSize = tData.headSize
            
            if currentConnection then currentConnection:Disconnect() end
            _G.IsAimbotting = false

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

                if farmMethod == "Auto Punch" then
                    local distY = (8 + (headSize * 0.8)) * integrity
                    local offsetBack = torso.CFrame.LookVector * -3
                    combatPos = torso.Position + Vector3.new(0, distY, 0) + offsetBack
                    if player.Character then
                        player.Character:PivotTo(CFrame.lookAt(combatPos, torso.Position))
                        LMB_Event:FireServer()
                    end

                elseif farmMethod == "Orbital Punch" then
                    local orbitSpeed = _G.OrbitalSpeed
                    _G.OrbitalAngle = _G.OrbitalAngle + (orbitSpeed * dt)
                    local orbitRadius = (7 + (headSize * 0.6)) * integrity
                    local yOffset = 8 + (headSize * 1.0)
                    combatPos = torso.Position + Vector3.new(math.cos(_G.OrbitalAngle) * orbitRadius, yOffset, math.sin(_G.OrbitalAngle) * orbitRadius)
                    if player.Character then
                        player.Character:PivotTo(CFrame.lookAt(combatPos, torso.Position))
                        LMB_Event:FireServer()
                    end

                elseif farmMethod == "Auto Pulse Rifle" then
                    local orbitSpeed = _G.OrbitalSpeed
                    _G.OrbitalAngle = _G.OrbitalAngle + (orbitSpeed * dt)

                    local orbitRadius = (35 + (headSize * 4.0)) * integrity
                    local yOffset = 30 + (headSize * 2.0)
                    local rawPos = torso.Position + Vector3.new(math.cos(_G.OrbitalAngle) * orbitRadius, yOffset, math.sin(_G.OrbitalAngle) * orbitRadius)
                    
                    local safeX = math.clamp(rawPos.X, -645, 460)
                    local safeY = math.clamp(rawPos.Y, -400, 285)
                    local safeZ = math.clamp(rawPos.Z, -515, 460)
                    combatPos = Vector3.new(safeX, safeY, safeZ)
                    
                    if player.Character then
                        local tool = player.Character:FindFirstChild("Pulse Rifle") or player.Backpack:FindFirstChild("Pulse Rifle")
                        if tool and tool.Parent == player.Backpack then
                            player.Character.Humanoid:EquipTool(tool)
                        end

                        player.Character:PivotTo(CFrame.new(combatPos))
                        
                        local targetCenter = torso.Position - Vector3.new(0, 0.5, 0)
                        Workspace.CurrentCamera.CFrame = CFrame.lookAt(Workspace.CurrentCamera.CFrame.Position, targetCenter)
                        
                        _G.IsAimbotting = true
                    end
                end
            end)

            repeat 
                if farmMethod == "Auto Pulse Rifle" then
                    local tool = player.Character and player.Character:FindFirstChild("Pulse Rifle")
                    local ammoNode = tool and tool:FindFirstChild("Folder") and tool.Folder:FindFirstChild("Ammo")
                    
                    local vp = Workspace.CurrentCamera.ViewportSize
                    local aimX, aimY = vp.X / 2, vp.Y / 2
                    
                    if tool and ammoNode then
                        if ammoNode.Value <= 0 then
                            isReloadingRifle = true
                            if isShootingRifle then
                                isShootingRifle = false
                                VIM:SendMouseButtonEvent(aimX, aimY, 0, false, game, 1)
                            end
                        elseif isReloadingRifle and ammoNode.Value >= 30 then
                            isReloadingRifle = false
                        end

                        if not isReloadingRifle and ammoNode.Value > 0 then
                            VIM:SendMouseMoveEvent(aimX, aimY, game) 
                            
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
                elseif farmMethod ~= "Auto Pulse Rifle" and isShootingRifle then
                    local vp = Workspace.CurrentCamera.ViewportSize
                    isShootingRifle = false
                    VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, false, game, 1)
                end
                task.wait(0.1)
                
                local isDeadNow = false
                local f1 = model:FindFirstChild("1")
                if f1 and f1:FindFirstChild("BallSocketConstraint") then isDeadNow = true end
                local hum = model:FindFirstChildWhichIsA("Humanoid")
                if hum and hum.Health <= 0 then isDeadNow = true end
                
            until not farmEnabled or not model.Parent or isDeadNow or stayInRoundAtivo or (itemFarmAtivo and (#itemQueue > 0 or isProcessingQueue)) or not currentConnection or not currentConnection.Connected

            if currentConnection then currentConnection:Disconnect() end
            
            if isShootingRifle then
                local vp = Workspace.CurrentCamera.ViewportSize
                VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, false, game, 1)
                isShootingRifle = false
            end
            _G.IsAimbotting = false
            
            break
        end
    end
end)

createTpBtn(tabs.Teleport, "Spawn (Lobby)",   Vector3.new(611, -468, 529))
createTpBtn(tabs.Teleport, "Ready Plataform", Vector3.new(557, -468, 465))
createTpBtn(tabs.Teleport, "Shop Helicopter", Vector3.new(46, 3, -24))

-- ============================================================
-- DRAG (BLINDADO CONTRA O AIMBOT)
-- ============================================================
local function makeDraggable(obj)
    local dragging, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if _G.IsAimbotting then return end 
            dragging = true; dragStart = input.Position; startPos = main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local d = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X,
                                      startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
end
makeDraggable(topBar)
makeDraggable(sidebar)

print("✅ V7.2 — Target Whitelist Ativa. Orbital Slider Injetado.")