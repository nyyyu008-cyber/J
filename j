-- [[ EVIL THE J (real) - Ultimate Baldi's Basics Multi-Tab Control Panel ]]
-- Designed with Dark Red Aesthetic & Organized Categorized UI

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

-- Global States
local States = {
    GodMode = false,
    InfiniteStamina = false,
    InfiniteItems = false,
    AntiAFK = false,
    ESPItems = false,
    WalkSpeed = 16,
    JumpPower = 50,
    Fly = false,
    FlySpeed = 50,
    Noclip = false,
    TargetNotebooks = 7
}

-- -------------------------------------------------------------
-- Core Anti-AFK Service
-- -------------------------------------------------------------
local VirtualUser = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    if States.AntiAFK then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

-- -------------------------------------------------------------
-- UI Construction (Evil Crimson Theme)
-- -------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EvilTheJ_MultiTabPanel"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Toggle Icon Button (Mobile & PC Friendly)
local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Name = "EvilIconToggle"
ToggleBtn.Size = UDim2.new(0, 55, 0, 55)
ToggleBtn.Position = UDim2.new(0, 15, 0.4, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
ToggleBtn.BorderColor3 = Color3.fromRGB(225, 0, 0)
ToggleBtn.BorderSizePixel = 2
ToggleBtn.Image = "rbxassetid://1002345678" -- Placeholder texture
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

local ToggleTitle = Instance.new("TextLabel")
ToggleTitle.Size = UDim2.new(1, 0, 1, 0)
ToggleTitle.BackgroundTransparency = 1
ToggleTitle.Text = "EVIL\nJ"
ToggleTitle.TextColor3 = Color3.fromRGB(255, 30, 30)
ToggleTitle.TextSize = 12
ToggleTitle.Font = Enum.Font.GothamBold
ToggleTitle.Parent = ToggleBtn

-- Main Container Window
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 480, 0, 320)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
MainFrame.BorderColor3 = Color3.fromRGB(180, 0, 0)
MainFrame.BorderSizePixel = 2
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(25, 5, 5)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 10)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "EVIL THE J (real) — Control Panel"
Title.TextColor3 = Color3.fromRGB(255, 40, 40)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Sidebar Navigation (Categories)
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 130, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SideLayout = Instance.new("UIListLayout")
SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideLayout.Padding = UDim.new(0, 5)
SideLayout.Parent = Sidebar

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 10)
SidePadding.PaddingLeft = UDim.new(0, 8)
SidePadding.PaddingRight = UDim.new(0, 8)
SidePadding.Parent = Sidebar

-- Content Pages Container
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -140, 1, -50)
ContentArea.Position = UDim2.new(0, 135, 0, 45)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

local Pages = {}

local function createTab(name, layoutOrder)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, 0, 0, 32)
    tabBtn.BackgroundColor3 = Color3.fromRGB(30, 20, 20)
    tabBtn.Text = name
    tabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabBtn.Font = Enum.Font.GothamMedium
    tabBtn.TextSize = 12
    tabBtn.LayoutOrder = layoutOrder
    tabBtn.Parent = Sidebar
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = tabBtn

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Color3.fromRGB(180, 0, 0)
    page.Visible = false
    page.Parent = ContentArea

    local pageLayout = Instance.new("UIListLayout")
    pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pageLayout.Padding = UDim.new(0, 8)
    pageLayout.Parent = page

    Pages[name] = {Button = tabBtn, Page = page}

    tabBtn.MouseButton1Click:Connect(function()
        for _, tData in pairs(Pages) do
            tData.Page.Visible = false
            tData.Button.BackgroundColor3 = Color3.fromRGB(30, 20, 20)
            tData.Button.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        page.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(160, 20, 20)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    return page
end

-- Create Menu Categories
local PlayerPage = createTab("👤 Player", 1)
local MovementPage = createTab("🚀 Movement", 2)
local MapPage = createTab("📚 Map & Books", 3)
local VisualsPage = createTab("👁 Visuals & AFK", 4)

-- Select first tab by default
Pages["👤 Player"].Page.Visible = true
Pages["👤 Player"].Button.BackgroundColor3 = Color3.fromRGB(160, 20, 20)

-- Helper GUI Functions
local function createToggle(parent, labelText, defaultState, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = defaultState and Color3.fromRGB(140, 20, 20) or Color3.fromRGB(30, 32, 40)
    btn.Text = labelText .. ": " .. (defaultState and "ON" or "OFF")
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 13
    btn.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    local state = defaultState
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(140, 20, 20) or Color3.fromRGB(30, 32, 40)
        btn.Text = labelText .. ": " .. (state and "ON" or "OFF")
        callback(state)
    end)
    return btn
end

local function createButton(parent, labelText, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(45, 25, 25)
    btn.Text = labelText
    btn.TextColor3 = Color3.fromRGB(255, 220, 220)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- -------------------------------------------------------------
-- CATEGORY 1: 👤 Player Functions
-- -------------------------------------------------------------
createToggle(PlayerPage, "God Mode (อมตะ)", false, function(s)
    States.GodMode = s
end)

createToggle(PlayerPage, "Infinite Stamina (พลังกายไม่ลด)", false, function(s)
    States.InfiniteStamina = s
end)

createToggle(PlayerPage, "Infinite Items (ไอเทมไม่ลด/ไม่หาย)", false, function(s)
    States.InfiniteItems = s
end)

-- Loop Handlers for Player
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if char then
        -- God Mode
        if States.GodMode then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.Health = hum.MaxHealth
            end
        end
        -- Infinite Stamina (Baldi Specifics)
        if States.InfiniteStamina then
            local staminaVal = LocalPlayer:FindFirstChild("Stamina") or char:FindFirstChild("Stamina")
            if staminaVal and staminaVal:IsA("ValueBase") then
                staminaVal.Value = 100
            end
        end
    end
end)

-- -------------------------------------------------------------
-- CATEGORY 2: 🚀 Movement Functions
-- -------------------------------------------------------------
createToggle(MovementPage, "Fly Mode (บิน)", false, function(s)
    States.Fly = s
end)

createToggle(MovementPage, "Noclip (เดินทะลุกำแพง)", false, function(s)
    States.Noclip = s
end)

-- Speed & Jump Box
local speedFrame = Instance.new("Frame")
speedFrame.Size = UDim2.new(1, -10, 0, 35)
speedFrame.BackgroundTransparency = 1
speedFrame.Parent = MovementPage

local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0.48, 0, 1, 0)
speedBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
speedBox.Text = "WalkSpeed: 30"
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.Font = Enum.Font.Gotham
speedBox.TextSize = 12
speedBox.Parent = speedFrame
local sbCorner = Instance.new("UICorner")
sbCorner.CornerRadius = UDim.new(0, 6)
sbCorner.Parent = speedBox

speedBox.FocusLost:Connect(function()
    local val = tonumber(string.match(speedBox.Text, "%d+"))
    if val then
        States.WalkSpeed = val
        speedBox.Text = "WalkSpeed: " .. tostring(val)
    end
end)

local jumpBox = Instance.new("TextBox")
jumpBox.Size = UDim2.new(0.48, 0, 1, 0)
jumpBox.Position = UDim2.new(0.52, 0, 0, 0)
jumpBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
jumpBox.Text = "JumpPower: 100"
jumpBox.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpBox.Font = Enum.Font.Gotham
jumpBox.TextSize = 12
jumpBox.Parent = speedFrame
local jbCorner = Instance.new("UICorner")
jbCorner.CornerRadius = UDim.new(0, 6)
jbCorner.Parent = jumpBox

jumpBox.FocusLost:Connect(function()
    local val = tonumber(string.match(jumpBox.Text, "%d+"))
    if val then
        States.JumpPower = val
        jumpBox.Text = "JumpPower: " .. tostring(val)
    end
end)

-- Movement Loops
RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = States.WalkSpeed
            hum.JumpPower = States.JumpPower
        end
        if States.Noclip then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- -------------------------------------------------------------
-- CATEGORY 3: 📚 Map & Books Functions
-- -------------------------------------------------------------
local bookInputFrame = Instance.new("Frame")
bookInputFrame.Size = UDim2.new(1, -10, 0, 35)
bookInputFrame.BackgroundTransparency = 1
bookInputFrame.Parent = MapPage

local bookAmountBox = Instance.new("TextBox")
bookAmountBox.Size = UDim2.new(0.4, 0, 1, 0)
bookAmountBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
bookAmountBox.Text = "7"
bookAmountBox.PlaceholderText = "จำนวนสมุด"
bookAmountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
bookAmountBox.Font = Enum.Font.GothamBold
bookAmountBox.Parent = bookInputFrame
local babCorner = Instance.new("UICorner")
babCorner.CornerRadius = UDim.new(0, 6)
babCorner.Parent = bookAmountBox

local setProgressBtn = Instance.new("TextButton")
setProgressBtn.Size = UDim2.new(0.56, 0, 1, 0)
setProgressBtn.Position = UDim2.new(0.44, 0, 0, 0)
setProgressBtn.BackgroundColor3 = Color3.fromRGB(160, 20, 20)
setProgressBtn.Text = "ตั้งค่าสมุดทันที"
setProgressBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
setProgressBtn.Font = Enum.Font.GothamBold
setProgressBtn.TextSize = 12
setProgressBtn.Parent = bookInputFrame
local spCorner = Instance.new("UICorner")
spCorner.CornerRadius = UDim.new(0, 6)
spCorner.Parent = setProgressBtn

setProgressBtn.MouseButton1Click:Connect(function()
    local count = tonumber(bookAmountBox.Text) or 7
    -- Force Leaderstats & Local Values
    local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
    if leaderstats then
        for _, v in ipairs(leaderstats:GetChildren()) do
            if string.find(string.lower(v.Name), "notebook") or string.find(string.lower(v.Name), "book") then
                v.Value = count
            end
        end
    end
    -- Trigger Map Notebook Models
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if string.find(string.lower(obj.Name), "notebook") or string.find(string.lower(obj.Name), "book") then
            if obj:IsA("ClickDetector") then
                fireclickdetector(obj)
            elseif obj:IsA("BasePart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj, 0)
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj, 1)
            end
        end
    end
end)

createButton(MapPage, "เสกไอเทม Evil Book ใส่กระเป๋า", function()
    local tool = Instance.new("Tool")
    tool.Name = "Evil J Book"
    tool.RequiresHandle = false
    tool.Parent = LocalPlayer:WaitForChild("Backpack")
end)

-- -------------------------------------------------------------
-- CATEGORY 4: 👁 Visuals & Anti-AFK
-- -------------------------------------------------------------
createToggle(VisualsPage, "มองเห็นไอเทมทะลุกำแพง (Item ESP)", false, function(s)
    States.ESPItems = s
    if not s then
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:FindFirstChild("EvilESP") then
                v.EvilESP:Destroy()
            end
        end
    end
end)

createToggle(VisualsPage, "Anti-AFK (กันหลุดออกจากเกม)", false, function(s)
    States.AntiAFK = s
end)

-- Item ESP Loop
RunService.RenderStepped:Connect(function()
    if States.ESPItems then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if (obj:IsA("Tool") or string.find(string.lower(obj.Name), "item") or string.find(string.lower(obj.Name), "notebook")) and not obj:FindFirstChild("EvilESP") then
                local highlight = Instance.new("Highlight")
                highlight.Name = "EvilESP"
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.5
                highlight.Parent = obj
            end
        end
    end
end)

-- Toggle GUI Visibility Logic
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.RightControl then
        MainFrame.Visible = not MainFrame.Visible
    end
end)
