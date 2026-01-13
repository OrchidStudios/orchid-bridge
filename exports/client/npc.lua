local Config = lib.load('data.config')
local target = require("modules.target." .. Config.target)

local points = {}

local function createInteractivePed(ped, options)
    if not ped or not options then return end
    local resource = GetInvokingResource()
    if not points[resource] then
        points[resource] = {}
    end

    local point = lib.points.new({
        coords = vec3(ped.coords.x, ped.coords.y, ped.coords.z),
        distance = ped.distance or 40.0,
        onEnter = function(self)
            if self.entity and DoesEntityExist(self.entity) then
                DeleteEntity(self.entity)
            end
            ped.hash =  lib.requestModel(ped.hash or ped.model, 5000)
            self.entity = CreatePed(2, ped.hash, ped.coords.x, ped.coords.y, ped.coords.z, false, false)
        
            while not DoesEntityExist(self.entity) do
                Wait(50)
            end
    
            SetEntityHeading(self.entity, ped.coords.w)
            if ped.scenario ~= false then
                TaskStartScenarioInPlace(self.entity, ped.scenario or "WORLD_HUMAN_CLIPBOARD", 0, true)
            end
            FreezeEntityPosition(self.entity, true)
            SetBlockingOfNonTemporaryEvents(self.entity, true)
            SetEntityInvincible(self.entity, true)
            SetModelAsNoLongerNeeded(ped.hash)

            Entity(self.entity).state:set('missionPed', true)
        
            target:addLocalEntity(self.entity, options)
        end,

        onExit = function(self)
            if self.entity and DoesEntityExist(self.entity) then
                DeleteEntity(self.entity)
            end
            self.entity = nil
        end,
    })

    points[resource][#points[resource]+1] = point

    return point
end
    
exports('createInteractivePed', createInteractivePed)

AddEventHandler('onResourceStop', function(resourceName)
    if points[resourceName] then
        for _, point in pairs(points[resourceName]) do
            point:onExit()
            point:remove()
        end
        points[resourceName] = nil
    end
end)