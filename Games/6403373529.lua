local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
	Name = "SnipeWare Hub Loader",
	LoadingTitle = "Loading SnipeWare...",
	LoadingSubtitle = "Loading Hub...",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = SnipeWareLoader, -- Create a custom folder for your hub/game
		FileName = "SnipeWare"
	},
        Discord = {
        	Enabled = true,
        	Invite = "22A6QddM2U", -- The Discord invite code, do not include discord.gg/
        	RememberJoins = false -- Set this to false to make them join the discord every time they load it up
        },
	KeySystem = true, -- Set this to true to use our key system
	KeySettings = {
		Title = "SnipeWare Hub",
		Subtitle = "Key System",
		Note = "SnipeWare hub is still being worked on.",
		FileName = "SnipeWareKeySystem",
		SaveKey = false,
		GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
		Key = "https://pastebin.com/raw/FnF0qEVx"
	}
})

local ScriptsTab = Window:CreateTab("Slap Battles")
local Section = ScriptsTab:CreateSection("Slap Battles")

local Button = ScriptsTab:CreateButton({
	Name = "Slap Battles Walkspeed Bypass",
	Callback = function()
		 loadstring(game:HttpGet("https://raw.githubusercontent.com/NighterEpic/Faded/main/YesEpic", true))()
	end,
})

if getgenv().Rogue_AlreadyLoaded ~= nil then error("Rogue Hub was already found running or you have other scripts executed!") return else getgenv().Rogue_AlreadyLoaded = 0 end

if game.PlaceId ~= 4543144283 then return end

local sound = Instance.new("Sound")
sound.Parent = game:GetService("Workspace")
sound.SoundId = "rbxassetid://1548304764"
sound.PlayOnRemove = true
sound.Volume = 0.5

local ourColor = Color3.fromRGB(153, 148, 148)

function CheckConfigFile()
    if not isfile("/Rogue Hub/Configs/Keybind.ROGUEHUB") then return Enum.KeyCode.RightControl else return Enum.KeyCode[game:GetService("HttpService"):JSONDecode(readfile("/Rogue Hub/Configs/Keybind.ROGUEHUB"))["Key"]] or Enum.KeyCode.RightControl end
end

local Config = {
    WindowName = "Rogue Hub | " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    Color = ourColor,
    Keybind = CheckConfigFile()
}

getgenv().settings = {
    walkspeedbypass = false,
    killAura = false,
    walkValue = 50,
    jumpValue = 50
}

local func
local attackFunc

if getgc then
    for _, v in next, getgc() do
	local exploitFunction = isexecutorclosure or is_synapse_function or is_exploit_function	
		
        if type(v) == "function" and not exploitFunction(v) and getinfo(v).name == "dropbomb" then
            func = v
        elseif type(v) == "function" and not exploitFunction(v) and getinfo(v).name == "attack" then
            attackFunc = v
        end

        if func and attackFunc then
            break
        end
    end
end

if makefolder and isfolder and not isfolder("Snipe Ware") then
    makefolder("Snipe Ware")
    
    makefolder("Snipe Ware/Configs")
    makefolder("Snipe Ware/Data")
end

if readfile and isfile and isfile("Snipe Ware/Configs/SlapBattle_Config.SNIPEWARE") then
    getgenv().settings = game:GetService("HttpService"):JSONDecode(readfile("Snipe Ware/Configs/SlapBattle_Config.SNIPEWARE"))
end

local function saveSettings()
    if writefile then
        writefile("Snipe Ware/Configs/SlapBattle_Config.SNIPEWARE", game:GetService("HttpService"):JSONEncode(getgenv().settings))
    end
end

local localPlr = game:GetService("Players").LocalPlayer
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Bracket/main/BracketV3.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))

local mainTab = Window:CreateTab("Main")
local mainSec = mainTab:CreateSection("Farming")

localPlr.CharacterAdded:Connect(function()
    local humanoid = localPlr.Character:WaitForChild("Humanoid")
    
    localPlr.Character.Humanoid.WalkSpeed = getgenv().settings.walkValue
    localPlr.Character.Humanoid.JumpPower = getgenv().settings.jumpValue
    
    if getgenv().settings.killAura and getgc then
        for _, v in next, localPlr.Character:GetChildren() do
            if v.Name == "Hitbox" and v:IsA("Part") then
                v.Touched:Connect(function(touchedPart)
                    if touchedPart.Name == "HumanoidRootPart" and getgenv().settings.killAura then
                        attackFunc()
                    end
                end)
            end
        end
    end
end)


local walkspeedbypasstog = mainSec:CreateToggle("Walk Speed Bypass", getgenv().settings.walkspeedbypass, function(bool)
    getgenv().settings.walkspeedbypass = bool
    saveSettings()
end)


    
-- Fun Section

local funSec = mainTab:CreateSection("Fun & Other")


if getgc then
    local hitboxTog = funSec:CreateToggle("Killaura", getgenv().settings.killAura, function(bool)
        getgenv().settings.killAura = bool
        saveSettings()
    
        if getgenv().settings.killAura and localPlr.Character then
            for _, v in next, localPlr.Character:GetChildren() do
                if v.Name == "Hitbox" and v:IsA("Part") then
                    v.Touched:Connect(function(touchedPart)
                        if touchedPart.Name == "HumanoidRootPart" and getgenv().settings.killAura then
                            attackFunc()
                        end
                    end)
                end
            end
        end
    end)
end

local walkSlider = funSec:CreateSlider("Walkspeed", localPlr.Character.Humanoid.WalkSpeed,200,getgenv().settings.walkValue,true, function(value)
	getgenv().settings.walkValue = value
	localPlr.Character:FindFirstChild("Humanoid").WalkSpeed = getgenv().settings.walkValue
    saveSettings()
end)

local jumpSlider = funSec:CreateSlider("Jump Power", localPlr.Character.Humanoid.JumpPower,200,getgenv().settings.jumpValue,true, function(value)
	getgenv().settings.jumpValue = value
	localPlr.Character:FindFirstChild("Humanoid").JumpPower = getgenv().settings.jumpValue
    saveSettings()
end)

-- Shops Section



-- Power Up Section

-- Info

local infoTab = Window:CreateTab("Extra")
local uiSec = infoTab:CreateSection("UI Settings")

local uiColor = uiSec:CreateColorpicker("UI Color", function(color)
	Window:ChangeColor(color)
end)

uiColor:UpdateColor(Config.Color)

local uiTog = uiSec:CreateToggle("UI Toggle", nil, function(bool)
	Window:Toggle(bool)
end)

uiTog:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(key)
	if key == "Escape" or key == "Backspace" then key = "NONE" end
	
    if key == "NONE" then return else Config.Keybind = Enum.KeyCode[key]; writefile("/Rogue Hub/Configs/Keybind.ROGUEHUB", game:GetService("HttpService"):JSONEncode({Key = key})) end
end)

uiTog:SetState(true)

local uiRainbow = uiSec:CreateToggle("Rainbow UI", nil, function(bool)
	getgenv().rainbowUI = bool
	
	if getgenv().rainbowUI == false then
	    Window:ChangeColor(Config.Color)
	end
    
    while getgenv().rainbowUI and task.wait() do
        local hue = tick() % 10 / 10
        local rainbow = Color3.fromHSV(hue, 1, 1)
            
        Window:ChangeColor(rainbow)
        uiColor:UpdateColor(rainbow)
    end
end)

local infoSec = infoTab:CreateSection("Credits")

local req = http_request or request or syn.request

infoSec:CreateButton("Owner 1 of SnipeWare: aeon#2331", function()
    setclipboard("aeon#2331")
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "SnipeWare",
        Text = "Copied owner 1 to clipboard.",
        Duration = 5
    })
end)

infoSec:CreateButton("Owner 2 of SnipeWare: Glumpys;)!#5964", function()
    setclipboard("Glumpys;)!#5964")
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Script Notification",
        Text = "Copied Kyron's discord username and tag to your clipboard.",
        Duration = 5
    })
end)

infoSec:CreateButton("Join us on discord!", function()
	if req then
        req({
            Url = "dsc.gg/SnipeWare",
            Method = "POST",
            
            Headers = {
                ["Content-Type"] = "application/json",
                ["origin"] = "https://discord.com",
            },
                    
            Body = game:GetService("HttpService"):JSONEncode(
            {
                ["args"] = {
                ["code"] = "VdrHU8KP7c",
                },
                        
                ["cmd"] = "INVITE_BROWSER",
                ["nonce"] = "."
            })
        })
    else
        setclipboard("https://dsc.gg/SnipeWare")
    
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "SnipeWare",
            Text = "Copied our discord server to your clipboard.",
            Duration = 5
        })
    end
end)


    

    
    if getgenv().settings.walkspeedbypass then
        if game.PlaceId == 9431156611 and getrawmetatable and hookmetamethod then
            local old
            old = hookmetamethod(game, "__namecall", function(self, ...)
                local method = getnamecallmethod()
                
                if not checkcaller() and tostring(self) == "WS" and tostring(method) == "FireServer" then
                    return
                end
                
                return old(self, ...)
            end)
        elseif game.PlaceId ~= 9431156611 and getrawmetatable and hookmetamethod then
            local old
            old = hookmetamethod(game, "__namecall", function(self, ...)
                local method = getnamecallmethod()
                
                if not checkcaller() and tostring(self) == "WalkSpeedChanged" and tostring(method) == "FireServer" then
                    return
                end
                
                return old(self, ...)
            end)
        end
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "SnipeWare",
    Text = "Loaded.",
    Duration = 5
})

sound:Destroy()

task.wait(5)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Note",
    Text = "SnipeWare is currently in alpha.",
    Duration = 10
})
