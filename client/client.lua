local isOpen = false
local ESX = exports["base"]:getSharedObject()
local wait = 0
local function toggleNuiFrame(shouldShow)
  SetNuiFocus(shouldShow, shouldShow)
  SendReactMessage('setVisible', shouldShow)
end






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

Citizen.CreateThread(function()
  for _,v in pairs(config.marketPos) do
    local blip = AddBlipForCoord(v.pos.x, v.pos.y, v.pos.z)
    SetBlipSprite(blip, config.blips.sprite, true)
    SetBlipColour(blip, config.blips.color)
    SetBlipScale(blip, config.blips.scale)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(v.name)
    EndTextCommandSetBlipName(blip)
  end

  while true do
      local time = 1500
      for _,v in pairs(config.marketPos) do 
          local dist = Vdist(GetEntityCoords(PlayerPedId(), false), v.pos.x,v.pos.y,v.pos.z) 
          if (dist <= 2) then  
              time = 1 
              ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour accéder au '..v.name)
              DrawMarker(27, v.pos.x, v.pos.y, v.pos.z-0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)   
              if IsControlJustPressed(1,51) then
                SendReactMessage('LTD:GetItems', json.encode(v.items))
                SendReactMessage('LTD:GetLTDName', v.name)
                toggleNuiFrame(true)
                isOpen = true
            end
        end
    end
    Wait(time)
  end
end)






RegisterNUICallback("hideFrame", function(data)
  toggleNuiFrame(false)
  isOpen = false
end)

RegisterNUICallback('PayeCart', function(data, cb)
  ESX.TriggerServerCallback('ltd:payeCart', function(success)
    if success then
      SendReactMessage('LTD:SendNotification', {message = config.notification.accept, type = 'success'})
    else
      SendReactMessage('LTD:SendNotification', {message = config.notification.cancel, type = 'error'})
    end
  end, data)
  cb({})
end)




function SendReactMessage(action, data)
  SendNUIMessage({
    action = action,
    data = data
  })
end