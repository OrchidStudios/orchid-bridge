local blips = {}
local function createBlip(settings, coords)
    local resource = GetInvokingResource()
    if not blips[resource] then
        blips[resource] = {}
    end

    if not coords then
        if settings.coords then
            coords = settings.coords
        else
            error('No coordinates provided for blip')
        end 
    end

	local blip
    if settings.sprite then
        blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, settings.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, settings.scale or 0.8)
        SetBlipColour(blip, settings.colour)
        SetBlipAsShortRange(blip, true)
        if settings.name then
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(settings.name)
            EndTextCommandSetBlipName(blip)
        end
    elseif settings.radius then
        blip = AddBlipForRadius(coords.x, coords.y, coords.z, settings.radius + 0.0)
        SetBlipColour(blip, settings.colour)
        SetBlipAlpha(blip, 130) -- Semi-transparent
        SetBlipAsShortRange(blip, true)
    end

    blips[resource][#blips[resource]+1] = blip

    local retBlip = {
        blip = blip
    }
    function retBlip:remove()
        RemoveBlip(self.blip)
    end
	return retBlip
end

exports('createBlip', createBlip)

AddEventHandler('onResourceStop', function(resourceName)
    if blips[resourceName] then
        for _, blip in pairs(blips[resourceName]) do
            RemoveBlip(blip)
        end
        blips[resourceName] = nil
    end
end)