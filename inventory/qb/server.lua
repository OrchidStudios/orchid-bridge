local resource = 'qb-inventory'

if GetResourceState('qs-inventory') == 'started' then
    resource = 'qs-inventory'
end

local inv = {}

function inv:AddItem(source, name, amount, metadata, slot)
    return exports[resource]:AddItem(source, name, amount or 1, slot, metadata)
end

function inv:RemoveItem(source, name, amount, slot)
    return exports[resource]:RemoveItem(source, name, amount or 1, slot)
end

function inv:GetItemCount(source, name)
    return exports[resource]:GetItemCount(source, name)
end

function inv:HasItem(source, name, amount)
    return self:HasItem(source, name) >= amount
end

function inv:RegisterStash(name, label, slots, weight, distance, jobs, items, coords)
    return exports[resource]:CreateInventory(name, {
        label = label,
        slots = slots or 20,
        weight = weight or 100000,
        distance = distance or 2.5,
        jobs = jobs or {},
        items = items or {},
        coords = coords or nil
    })
end

function inv:CanCarryItem(source, name, amount)
    return exports[resource]:CanAddItem(source, name, amount or 1)
end

function inv:ClearInventory(source)
    return
end

function inv:GetItem(source, slot, metadata, returns)
    return
end


function inv:SetMetadata(source, slot, metadata)
    return
end

return inv
