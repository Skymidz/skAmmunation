ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function sendWebhook(titre,description,footer)
    local embeds = {
        {
            ["title"] = "**"..titre.."**",
			["description"] = description,
            ["type"] = "rich",
            ["color"] = 49151,
            ["footer"] =  {
                ["text"]= footer
            },
        }
    }
	PerformHttpRequest(Config.Webhook.Link, function(err, text, headers) end, 'POST', json.encode({ embeds = embeds }), { ['Content-Type'] = 'application/json' })
end

ESX.RegisterServerCallback('skAmmu:CheckLicense', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local idPlayer = xPlayer.identifier
	MySQL.Async.fetchAll('SELECT * FROM user_licenses WHERE type = @type AND owner = @owner', { ['@type']  = "weapon", ['@owner'] = idPlayer }, function(result)
		if #result >= 1 then
			cb(true)
		else
			cb(false)
		end
	end)
end)

RegisterNetEvent('skAmmu:BuyPPA')
AddEventHandler('skAmmu:BuyPPA', function(price)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()
	if playerMoney >= price then
		TriggerEvent('esx_license:addLicense', source, 'weapon', function() end)
		xPlayer.removeMoney(price)
		TriggerClientEvent('esx:showNotification', source, _U("SuccessPPA"))
		if Config.Webhook.State and Config.Webhook.Link ~= "" then sendWebhook(_U("Log:Title"), _U("Log:DescPPA", GetPlayerName(source)), _U("Log:Footer")) end
	else 
		TriggerClientEvent('esx:showNotification', source, _U("NoMoney"))
	end
end)

RegisterNetEvent('skAmmu:BuyWeapon')
AddEventHandler('skAmmu:BuyWeapon', function(price, weaponName, weaponLabel)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()
	if price == nil or weaponName == nil then print("Error Price or name Weapon") end 
	if playerMoney >= price then
		if Config.itemWeapon then 
			xPlayer.addInventoryItem(weaponName, 1)
		else
			xPlayer.addWeapon(weaponName, 1)
		end
		xPlayer.removeMoney(price)
		TriggerClientEvent('esx:showNotification', source, _U("SuccessWeapon", weaponLabel))
		if Config.Webhook.State and Config.Webhook.Link ~= "" then sendWebhook(_U("Log:Title"), _U("Log:DescWeapon", GetPlayerName(source), weaponLabel), _U("Log:Footer")) end
	else 
		TriggerClientEvent('esx:showNotification', source, _U("NoMoney"))
	end
end)

RegisterNetEvent('skAmmu:BuyAmmo')
AddEventHandler('skAmmu:BuyAmmo', function(price, ammoName, ammoLabel, ammoNumber)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()
	local NewPrice = price * ammoNumber
	if price == nil or ammoName == nil or ammoNumber == nil then print("Error Price, Name or Number Ammo") return end 
	if playerMoney >= NewPrice then
		if Config.itemWeapon then 
			xPlayer.addInventoryItem(ammoName, ammoNumber)
		else 
			xPlayer.addWeapon(ammoName, ammoNumber)
		end 
		xPlayer.removeMoney(NewPrice)
		TriggerClientEvent('esx:showNotification', source, _U("SuccessAmmo", ammoNumber, ammoLabel))
		if Config.Webhook.State and Config.Webhook.Link ~= "" then sendWebhook(_U("Log:Title"), _U("Log:DescAmmo", GetPlayerName(source), ammoNumber, ammoLabel), _U("Log:Footer")) end
	else 
		TriggerClientEvent('esx:showNotification', source, _U("NoMoney"))
	end
end)

print("[^1Auteur^7] : ^4Skymidz#7333^7")