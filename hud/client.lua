local ESX = exports["es_extended"]:getSharedObject()
local hudVisible = Config.DefaultVisible
local isUiLoaded = false

-- Initialize HUD data on player spawn
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    SendNUIMessage({
        action = "init",
        config = Config
    })
    isUiLoaded = true
    updateHudData(xPlayer)
end)

-- Handle account updates from ESX
RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
    if not isUiLoaded then return end
    
    if account.name == 'money' then
        SendNUIMessage({ action = "updateMoney", value = account.money })
    elseif account.name == 'bank' then
        SendNUIMessage({ action = "updateBank", value = account.money })
    elseif account.name == 'black_money' then
        SendNUIMessage({ action = "updateBlackMoney", value = account.money })
    end
end)

-- Fetch data manually if script restarts mid-game
Citizen.CreateThread(function()
    while ESX.GetPlayerData().accounts == nil do
        Citizen.Wait(10)
    end
    
    SendNUIMessage({
        action = "init",
        config = Config
    })
    isUiLoaded = true
    updateHudData(ESX.GetPlayerData())
end)

function updateHudData(playerData)
    local serverId = GetPlayerServerId(PlayerId())
    local cash = 0
    local bank = 0
    local blackMoney = 0

    for _, account in ipairs(playerData.accounts) do
        if account.name == 'money' then cash = account.money
        elseif account.name == 'bank' then bank = account.money
        elseif account.name == 'black_money' then blackMoney = account.money end
    end

    SendNUIMessage({
        action = "updateAll",
        cash = cash,
        bank = bank,
        blackMoney = blackMoney,
        serverId = serverId
    })
end

-- Toggle Command
RegisterCommand('hud', function()
    hudVisible = not hudVisible
    if not hudVisible then
        SendNUIMessage({ action = "setVisibility", toggle = false })
    end
    ESX.ShowNotification("HUD " .. (hudVisible and "~g~Enabled" or "~r~Disabled"))
end, false)

-- Visibility Thread (Checks Minimap status and Pause Menu)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200) -- Low frequency check to save performance
        
        if hudVisible then
            -- Hide HUD if pause menu is active or radar is hidden (like in a loading screen or pause map)
            if IsPauseMenuActive() or IsRadarHidden() then
                SendNUIMessage({ action = "setVisibility", toggle = false })
            else
                SendNUIMessage({ action = "setVisibility", toggle = true })
            end
        end
    end
end)