if config.esxVersion == 'new' then
	ESX = exports['es_extended']:getSharedObject()
elseif config.esxVersion == 'old' then
    ESX = nil
    while not ESX do
        TriggerEvent(Config.Trigger["getSharedObject"], function(obj)
            ESX = obj
        end)
        Wait(500)
    end
end

RegisterServerEvent('ltd:payeCart')
AddEventHandler('ltd:payeCart', function(data, cb)
    xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if data.method == 'cash' then
            if xPlayer.getMoney() >= data.totalPrice then
                for _, item in pairs(data.cart) do
                    xPlayer.addInventoryItem(item.name, item.quantity)
                end
                xPlayer.removeMoney(data.totalPrice)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez payé ' .. data.totalPrice .. '~g~$~s~ pour ' .. data.totalItems .. ' ~b~Articles~s~')
                cb(true)
            else
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas assez d\'argent')
                cb(false)
                
            end 
        end
        if data.method == 'card' then
            if xPlayer.getAccount('bank').money >= data.totalPrice then
                for _, item in pairs(data.cart) do
                    xPlayer.addInventoryItem(item.name, item.quantity)
                end
                xPlayer.removeAccount('bank', data.totalPrice)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez payé ' .. data.totalPrice .. '~g~$~s~ pour ' .. data.totalItems .. ' ~b~Articles~s~')
                cb(true)
                print('Paiement effectué avec succès')
            else
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas assez d\'argent')
                cb(false)
            end
        end
    end
end)


ESX.RegisterServerCallback('ltd:payeCart', function(source, cb, data)
    xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if data.method == 'cash' then
            if xPlayer.getMoney() >= data.totalPrice then
                for _, item in pairs(data.cart) do
                    xPlayer.addInventoryItem(item.name, item.quantity)
                end
                xPlayer.removeMoney(data.totalPrice)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez payé ' .. data.totalPrice .. '~g~$~s~ pour ' .. data.totalItems .. ' ~b~Articles~s~')
                cb(true)
            else
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas assez d\'argent')
                cb(false)
            end 
        end
        if data.method == 'card' then
            if xPlayer.getAccount('bank').money >= data.totalPrice then
                for _, item in pairs(data.cart) do
                    xPlayer.addInventoryItem(item.name, item.quantity)
                end
                xPlayer.removeAccountMoney('bank', data.totalPrice)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez payé ' .. data.totalPrice .. '~g~$~s~ pour ' .. data.totalItems .. ' ~b~Articles~s~')
                cb(true)
            else
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas assez d\'argent')
                cb(false)
        
            end
        end
    end
end)
