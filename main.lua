if not game:IsLoaded() then
    game.Loaded:Wait()
end

local req = http_request or request or syn.request

if not req then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Errorr",
        Text = "Your exploit is unsupported with SnipeWare!",
        Duration = 5
    })
    return
end

if makefolder and isfolder and not isfolder("SnipeWare") then
    makefolder("Snipe Ware")

    makefolder("Snipe Ware/Configs")
    makefolder("Snipe Ware/Data")
end

if not isfile("/Snipe Ware/Configs/Quotes.SNIPEWARE") then 
    writefile("/Snipe Ware/Configs/Quotes.SNIPEWARE", req({ Url = "https://raw.githubusercontent.com/MoonExecutor/SnipeWare/main/Quotes.SNIPEWARE" }).Body);
end

if not isfile("/Snipe Ware/Configs/Keybind.SNIPEWARE") then
    writefile("/Snipe Ware/Configs/Keybind.SNIPEWARE", game:GetService("HttpService"):JSONEncode({
        Key = "RightControl"
    }))
end

local response = req({
    Url = "https://raw.githubusercontent.com/MoonExecutor/SnipeWare/main/Games/" .. game.PlaceId .. ".lua",
    Method = "GET"
})

if response.Body ~= "404: Not Found" then
    -- Anti AFK
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 2, true, nil, 0)
        wait(1)
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 2, false, nil, 0)
    end)

    -- If its not 404 why make another HTTP request?
    -- ^ Answer to above - Kitzoon is big dumb
    loadstring(response.Body)()
else
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Snipe Ware Error",
        Text = "The game you are trying to execute on is not supported.",
        Duration = 5
    })

    return
end
