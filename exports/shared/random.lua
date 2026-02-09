math.randomseed(IsDuplicityVersion() and os.time() or GetGameTimer())

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
            if not usedNames[item[1]] then
                table.insert(available, item)
            end
        end

        if #available == 0 then break end

        -- Calculate total weight
        local totalWeight = 0
        for _, item in ipairs(available) do
            totalWeight = totalWeight + (item[3] or 70)
        end

        -- Weighted selection using cumulative distribution
        local roll = math.random() * totalWeight
        local cumulative = 0
        local selectedItem = nil

        for _, item in ipairs(available) do
            cumulative = cumulative + (item[3] or 70)
            if roll <= cumulative then
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
