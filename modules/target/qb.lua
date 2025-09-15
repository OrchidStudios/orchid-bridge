lib.print.warn('addEntity and removeEntity might not work as expected due to usage of qb-target')
lib.print.warn('Consider switching to ox_target for full compatibility')

local function convertOxOptions(options)
    local distance = 7

    if options.options then
        options = options.options
    end

    for _, v in pairs(options) do
        if v.distance and v.distance < distance then
            distance = v.distance
        end

        if v.groups then
            if type(v.groups) == 'string' then
                v.job = { [v.groups] = 0 }
            elseif type(v.groups) == 'table' then
                v.job, v.gang = {}, {}
                for group, grade in pairs(v.groups) do
                    if group == 'ballas' or group == 'vagos' then
                        v.gang[group] = grade
                    else
                        v.job[group] = grade
                    end
                end
            end
        end

        if v.items then
            v.item = v.items
        end

        if v.onSelect then
            v.action = function(entity)
                v.entity = entity
                v.coords = entity and GetEntityCoords(entity) or nil
                v.distance = entity and #(GetEntityCoords(cache.Ped) - GetEntityCoords(entity)) or nil
                v.onSelect(v)
            end
        elseif v.export then
            v.action = function(entity)
                local resource, exportName = string.strsplit('.', v.export)
                v.entity = entity
                v.coords = entity and GetEntityCoords(entity) or nil
                v.distance = entity and #(GetEntityCoords(cache.Ped) - GetEntityCoords(entity)) or nil
                exports[resource][exportName](nil, v)
            end
        end

        if v.canInteract then
            local original = v.canInteract
            v.canInteract = function(entity, dist, data)
                return original(entity, dist, entity and GetEntityCoords(entity) or nil, data.name, data.bone)
            end
        end

        if v.serverEvent then
            v.type = 'server'
            v.event = v.serverEvent
        elseif v.command then
            v.type = 'command'
            v.event = v.command
        elseif v.event then
            v.type = 'client'
        end
    end

    return distance, options
end

local target = {
    addLocalEntity = function(self, entities, options)
        local distance, opts = convertOxOptions(options)
        exports['qb-target']:AddTargetEntity(entities, { options = opts, distance = distance })
    end,

    removeLocalEntity = function(self, entities, labels)
        exports['qb-target']:RemoveTargetEntity(entities, labels)
    end,

    addEntity = function(self, entities, options)
        for i = 1, #entities do
            entities[i] = NetworkGetEntityFromNetworkId(entities[i])
        end
        local distance, opts = convertOxOptions(options)
        exports['qb-target']:AddTargetEntity(entities, { options = opts, distance = distance })
    end,

    removeEntity = function(self, entities, labels)
        lib.print.warn('removeEntity might not work as expected due to usage of qb-target')
        for i = 1, #entities do
            entities[i] = NetworkGetEntityFromNetworkId(entities[i])
        end
        exports['qb-target']:RemoveTargetEntity(entities, labels)
    end,

    addModel = function(self, models, options)
        local distance, opts = convertOxOptions(options)
        exports['qb-target']:AddTargetModel(models, { options = opts, distance = distance })
    end,

    removeModel = function(self, models, labels)
        exports['qb-target']:RemoveTargetModel(models, labels)
    end,

    addGlobalPlayer = function(self, options)
        local distance, opts = convertOxOptions(options)
        exports['qb-target']:AddGlobalPlayer({ options = opts, distance = distance })
    end,

    addGlobalVehicle = function(self, options)
        local distance, opts = convertOxOptions(options)
        exports['qb-target']:AddGlobalVehicle({ options = opts, distance = distance })
    end
}

return target
