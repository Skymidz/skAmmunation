Config = {}

Config.Locale = "fr" -- "fr" or "en"
Config.Color = "~r~"
Config.ColorRGB = { r = 222, g = 50, b = 50 }
Config.DrawDistance = 2.0
Config.ShowPed = true
Config.itemWeapon = true
Config.RequirePPA = true
Config.PricePPA = 45000

Config.Webhook = {
    State = false, 
    Link = "",
}

-- true for sale and false for the reverse
Config.Etat = {
    NoLethal = true,
    Lethal = true,
    Ammo = true
}

-- Weapon on the Menu (if you use the weapons in item use your db if not use the gta wiki)
Config.Weapon = {
    NoLethal = {
        { Label = "Couteau", Name = "WEAPON_KNIFE", Price = 15000 },
        { Label = "Batte de Baseball", Name = "WEAPON_BAT", Price = 15000 },
    },
    Lethal = {
        { Label = "Pistolet", Name = "WEAPON_PISTOL", Price = 50000 },
        { Label = "Carabine", Name = "WEAPON_CARBINERIFLE", Price = 125000 },
    },
    Ammo = {
        { Label = "Munition de Pistolet", Name = "ammo_pistol", Price = 450, Min = 1, Max = 30 },
        { Label = "Munition de SMG", Name = "ammo_smg", Price = 600, Min = 1, Max = 30  },
        { Label = "Munition de Fusil d'Assaut", Name = "ammo_rifle", Price = 750, Min = 1, Max = 30 },
    }
}

-- Info Blips
Config.Blips = {
    Show = true, 
    Name = "Ammunation",
    Modele = 110,
    Color = 1,
    Size = 0.8,
}

-- Position Blips & Ped
Config.Pos = {
    { Ped = "a_m_y_beachvesp_01", Coords = vector3(810.12, -2159.01, 29.62), Heading = 358.68 },
    { Ped = "a_m_y_beachvesp_01", Coords = vector3(22.99, -1105.59, 29.80), Heading = 160.90 },
}

-- Don't Touch
Config.PercentagePannel = 0.0

