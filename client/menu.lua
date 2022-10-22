ESX = nil
Citizen.CreateThread(function() while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Citizen.Wait(0) end end)

Menu = {
    PlayerPPA = false,
}

--- Load du Menu Ammu
function LoadMenuAmmu()
    local MenuAmmu = RageUI.CreateMenu("~u~".._U("NameMenu1"), _U("DescMenu"), 400, 40, 'skbanner', 'sk_banner')
    local SubMenuNoLethal = RageUI.CreateSubMenu(MenuAmmu,  "~u~".._U("NameMenu2"), _U("DescMenu"))
    local SubMenuLethal = RageUI.CreateSubMenu(MenuAmmu,  "~u~".._U("NameMenu3"), _U("DescMenu"))
    local SubMenuMun = RageUI.CreateSubMenu(MenuAmmu,  "~u~".._U("NameMenu4"), _U("DescMenu"))

    RageUI.Visible(MenuAmmu, not RageUI.Visible(MenuAmmu))
    while MenuAmmu do
        Citizen.Wait(0)
        RageUI.IsVisible(MenuAmmu,true,true,true,function()
            if not Config.Etat.NoLethal and not Config.Etat.NoLethal and not Config.Etat.NoLethal and Menu.PlayerPPA then 
                RageUI.Separator("")
                RageUI.Separator(_U("NoVente"))
                RageUI.Separator("")
            end
            if Config.Etat.NoLethal then 
                RageUI.ButtonWithStyle(Config.Color.."→~s~ ".._U("Menu1:BTN1"), nil, {}, true, function(h, a, s) end, SubMenuNoLethal)
            end
            if Config.RequirePPA and not Menu.PlayerPPA then
                RageUI.ButtonWithStyle(Config.Color.."→~s~ ".._U("Menu1:BTN2"), nil, {RightLabel = _U("Price", Config.PricePPA)}, true, function(h, a, s)
                    if s then
                        startAnim('mp_common', 'givetake1_a')
                        Progress1, NumberBTN = true, 2
                    end
                end)
            end 
            if Config.RequirePPA then
                if Config.Etat.Lethal then 
                    RageUI.ButtonWithStyle(Config.Color.."→~s~ ".._U("Menu1:BTN3"), nil, {}, Menu.PlayerPPA, function(h, a, s) end, SubMenuLethal)
                end 
                if Config.Etat.Ammo then 
                    RageUI.ButtonWithStyle(Config.Color.."→~s~ ".._U("Menu1:BTN4"), nil, {}, Menu.PlayerPPA, function(h, a, s) end, SubMenuMun)
                end
            else
                if Config.Etat.Lethal then 
                    RageUI.ButtonWithStyle(Config.Color.."→~s~ ".._U("Menu1:BTN3"), nil, {}, true, function(h, a, s) end, SubMenuLethal)
                end 
                if Config.Etat.Ammo then 
                    RageUI.ButtonWithStyle(Config.Color.."→~s~ ".._U("Menu1:BTN4"), nil, {}, true, function(h, a, s) end, SubMenuMun)
                end
            end 
            if Progress1 == true then
                RageUI.PercentagePanel(Config.PercentagePannel, _U("Paiement"), '', '', {}, NumberBTN)
                if Config.PercentagePannel < 1.0 then
                    Config.PercentagePannel = Config.PercentagePannel + 0.004
                else                             
                    TriggerServerEvent("skAmmu:BuyPPA", Config.PricePPA)
                    Progress1, Config.PercentagePannel = false, 0.0
                    RageUI.CloseAll()
                end
            end 
        end, function() end, 1)

        RageUI.IsVisible(SubMenuNoLethal,true,true,true,function()
            if #Config.Weapon.NoLethal == 0 then 
                RageUI.Separator("")
                RageUI.Separator(_U("0NoLethal"))
                RageUI.Separator("")
            end
            for k,v in pairs(Config.Weapon.NoLethal) do 
                RageUI.ButtonWithStyle(Config.Color.."→~s~ "..v.Label, nil, {RightLabel = _U("Price", v.Price)}, true, function(h, a, s)
                    if s then
                        startAnim('mp_common', 'givetake1_a')
                        Progress2, NumberBTN, priceWeapon2, nameWeapon2, labelWeapon2 = true, k, v.Price, v.Name, v.Label
                    end
                end)
            end
            if Progress2 == true then
                RageUI.PercentagePanel(Config.PercentagePannel, _U("Paiement"), '', '', {}, NumberBTN)
                if Config.PercentagePannel < 1.0 then
                    Config.PercentagePannel = Config.PercentagePannel + 0.004
                else
                    TriggerServerEvent("skAmmu:BuyWeapon", priceWeapon2, nameWeapon2, labelWeapon2)
                    Progress2, Config.PercentagePannel, priceWeapon2, nameWeapon2, labelWeapon2 = false, 0.0, nil, nil, nil
                    RageUI.CloseAll()
                end
            end 
        end, function() end, 1)

        RageUI.IsVisible(SubMenuLethal,true,true,true,function()
            if #Config.Weapon.Lethal == 0 then 
                RageUI.Separator("")
                RageUI.Separator(_U("0Lethal"))
                RageUI.Separator("")
            end
            for k,v in pairs(Config.Weapon.Lethal) do 
                RageUI.ButtonWithStyle(Config.Color.."→~s~ "..v.Label, nil, {RightLabel = _U("Price", v.Price)}, true, function(h, a, s)
                    if s then
                        startAnim('mp_common', 'givetake1_a')
                        Progress3, NumberBTN, priceWeapon3, nameWeapon3, labelWeapon3 = true, k, v.Price, v.Name, v.Label
                    end
                end)
            end
            if Progress3 == true then
                RageUI.PercentagePanel(Config.PercentagePannel, _U("Paiement"), '', '', {}, NumberBTN)
                if Config.PercentagePannel < 1.0 then
                    Config.PercentagePannel = Config.PercentagePannel + 0.004
                else
                    TriggerServerEvent("skAmmu:BuyWeapon", priceWeapon3, nameWeapon3, labelWeapon3)
                    Progress3, Config.PercentagePannel, priceWeapon3, nameWeapon3, labelWeapon3 = false, 0.0, nil, nil, nil
                    RageUI.CloseAll()
                end
            end 
        end, function() end, 1)

        RageUI.IsVisible(SubMenuMun,true,true,true,function()
            if #Config.Weapon.Ammo == 0 then 
                RageUI.Separator("")
                RageUI.Separator(_U("0Ammo"))
                RageUI.Separator("")
            end
            for k,v in pairs(Config.Weapon.Ammo) do 
                RageUI.ButtonWithStyle(Config.Color.."→~s~ "..v.Label, nil, {RightLabel = _U("Price", v.Price)}, true, function(h, a, s)
                    if s then
                        local input1 = KeyboardInput("skAmmu", _U("Menu4:InputAmmo", v.Min, v.Max), "", 3)
                        if tonumber(input1) > v.Max or tonumber(input1) < v.Min then
                            input1 = nil
                            ESX.ShowNotification(_U("Menu4:ErrorInputAmmo", v.Min, v.Max))
                            return
                        end
                        startAnim('mp_common', 'givetake1_a')
                        Progress4, NumberBTN, priceAmmo4, nameAmmo4, labelAmmo4, numberAmmo4 = true, k, v.Price, v.Name, v.Label, input1
                    end
                end)
            end
            if Progress4 == true then
                RageUI.PercentagePanel(Config.PercentagePannel, _U("Paiement"), '', '', {}, NumberBTN)
                if Config.PercentagePannel < 1.0 then
                    Config.PercentagePannel = Config.PercentagePannel + 0.004
                else
                    TriggerServerEvent("skAmmu:BuyAmmo", priceAmmo4, nameAmmo4, labelAmmo4, numberAmmo4)
                    Progress4, Config.PercentagePannel, priceAmmo4, nameAmmo4, labelAmmo4, numberAmmo4, input1 = false, 0.0, nil, nil, nil, nil, nil
                    RageUI.CloseAll()
                end
            end 
        end, function() end, 1)

        if not RageUI.Visible(MenuAmmu) and not RageUI.Visible(SubMenuNoLethal) and not RageUI.Visible(SubMenuLethal) and not RageUI.Visible(SubMenuMun) then
            MenuAmmu=RMenu:DeleteType("Ammunation", true)
            FreezeEntityPosition(PlayerPedId(), false)
        end
        if RageUI.Visible(MenuAmmu) or RageUI.Visible(SubMenuNoLethal) or RageUI.Visible(SubMenuLethal) or RageUI.Visible(SubMenuMun) then 
            FreezeEntityPosition(PlayerPedId(), true)
        end 
    end
end