ESX = nil
Citizen.CreateThread(function() while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Citizen.Wait(0) end end)

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do Citizen.Wait(850) end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        return result
    else
        Citizen.Wait(850)
        return nil
    end
end

function CheckPPA()
    ESX.TriggerServerCallback('skAmmu:CheckLicense', function(result)
        if result then Menu.PlayerPPA = true else Menu.PlayerPPA = false end
    end)
end

function startAnim(lib, anim)
    ESX.Streaming.RequestAnimDict(lib, function()
        TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
    end)
end

Citizen.CreateThread(function()
    while true do 
        local interval = 750
        for k,v in pairs(Config.Pos) do 
            local distance = #(v.Coords - GetEntityCoords(PlayerPedId()))
            if distance <= Config.DrawDistance then 
                interval = 0
                RageUI.Text({ message = _U("DisplayMenu"), time_display = 1 })
                if IsControlJustPressed(1,51) then
                    if Config.RequirePPA then CheckPPA() end
                    LoadMenuAmmu()
                end
                break
            end 
        end
        Wait(interval)
    end
end)

if Config.ShowPed then
    Citizen.CreateThread(function()
        for k,v in pairs(Config.Pos) do 
            local hash = GetHashKey(v.Ped)
            while not HasModelLoaded(hash) do RequestModel(hash) Wait(25) end
            local ped = CreatePed("PED_TYPE_CIVFEMALE", hash, v.Coords.x, v.Coords.y, v.Coords.z-0.9, v.Heading, false, false)
            SetBlockingOfNonTemporaryEvents(ped, true)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
        end
    end)
end

if Config.Blips.Show then 
    Citizen.CreateThread(function()
        for k,v in pairs(Config.Pos) do 
            local blip = AddBlipForCoord(v.Coords.x, v.Coords.y, v.Coords.z)
            SetBlipSprite(blip, Config.Blips.Modele)
            SetBlipScale(blip, Config.Blips.Size)
            SetBlipColour(blip, Config.Blips.Color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(Config.Blips.Name)
            EndTextCommandSetBlipName(blip)
        end
    end)
end