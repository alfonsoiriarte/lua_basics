
RegisterCommand("getCar", function(source, args)
    local playerPed = GetPlayerPed(-1)
    local x,y,z = GetEntityCoords(playerPed)
    print(x,y,z);
end, false)



RegisterCommand("getCar", function(source, args)
    --Primer argumento del '/getCar "ARGUMENTO1"' O 'adder' hardcoded
    local vehicleName = args[1] or 'adder'

    --Checkea vehicleName y printea en el chat
    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then
        TriggerEvent('chat:AddMessage', {
            args = {'Vehicle not recognised: ' .. vehicleName}
        })
        return
    end
    --Requiere el model de vehicle name, y genera un delay (codigo bloqueante) hasta que cargue el model
    RequestModel(vehicleName)

    while not HasModelLoaded(vehicleName) do
        Wait(500)
    end

    local playerPed = GetPlayerPed(-1)
    local pos = GetEntityCoords(playerPed)

    local vehicle = CreateVehicle(vehicleName, pos.x, pos.y, pos.x, GetEntityHeading(playerPed), true, true)


    SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)


    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeeded(vehicleName)


    mensaje('Carrito')

end, false)

RegisterCommand("removeCar", function()
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    DeleteEntity(vehicle)
end, false)

Citizen.CreateThread(function()
    local h_key = 74
    local x_key = 73
    while true do
        Citizen.Wait(1)
        if IsControlJustReleased(1, h_key) then
            giveWeapon("weapon_pistol",999)
            alert("Pistola recibida")
        end
        if IsControlJustReleased(1, x_key) then
            RemoveAllPedWeapons(GetPlayerPed(-1), true)
            alert("Armas eliminadas")
        end
    end
end)

function alert(msg)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end


function mensaje(text)
    TriggerEvent("chatMessage","[Server]",{255,0,0}, text)
end

function giveWeapon(hash, ammo)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(hash), 999, false, false)
end