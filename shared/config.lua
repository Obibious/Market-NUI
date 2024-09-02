config = {}


config.esxVersion = 'import' -- 'new' == ESX v1.2 | 'old' == ESX v1.0 | import = remplacer @base/imports.lua par @VotreEsx/imports.lua dans fxmanifest.lua > shared_scripts

config.blips = {sprite = 52, color = 2, scale = 0.70}

config.notification = { -- Pour les notifications dans le LTD
    accept = 'Paiement effectué avec succès',
    cancel = 'Paiement refusé', 
}

config.marketPos = { -- Les positions des ltd avec leurs items

    { name = 'LTD Sud', pos = vector3(25.7391, -1345.982, 29.49702), items = { -- Copie colle ça pour ajouter des ltd
        { label='Pain', name='bread', price=1},
        { label='Eau', name='water', price=5},
        { label='Cookie', name='cookie', price=2},
        { label='Téléphone', name='phone', price=200},

    }},
}


-- support discord https://discord.gg/W9v2Mz9M3Z