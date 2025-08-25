math.randomseed(os.time())

---@param loot { [1]: string, [2]: { [1]: number, [2]: number }, [3]?: number }[]
---@param itemCount number
---@return { [1]: string, [2]: number }[]
local function randomLoot(loot, itemCount)
    local items = {}
    local usedNames = {}
    local size = #loot

    for _ = 1, itemCount do
        if #items >= size then break end

        -- Filter out already used items
        local available = {}
        for _, item in ipairs(loot) do
            local name = item[1]
            if not usedNames[name] then
                table.insert(available, item)
            end
        end

        if #available == 0 then break end

        -- Calculate total weight
        local totalWeight = 0
        for _, item in ipairs(available) do
            local chance = (item[3] or 70)
            totalWeight = totalWeight + chance
        end

        -- Weighted selection
        local roll = math.random(1, totalWeight)
        local acc = 0
        local selectedItem = nil

        for _, item in ipairs(available) do
            local weight = item[3] == 100 and 100000 or (item[3] or 70)
            acc = acc + weight
            if roll <= acc then
                selectedItem = item
                break
            end
        end

        if selectedItem then
            local count = math.random(selectedItem[2][1], selectedItem[2][2])
            if count > 0 then
                items[#items + 1] = { selectedItem[1], count }
                usedNames[selectedItem[1]] = true
            end
        end
    end

    return items
end


exports('randomLoot', randomLoot)
