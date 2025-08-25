Core = require '@ox_core.lib.init'

Events = {
    playerLoaded = "ox:playerLoaded", -- player loaded event
    setJob = "ox:setGroup" -- setJob event
}

Framework = {
    RegisterUsableItem = function ()
        -- Refer to ox_inventory documentation
        -- ox_core does not provide such export
    end,

    ---@param job string
    ---@return table, number
    GetActivePlayers = function (job)
        local players = Core.GetPlayers({ job = job })
        return players, #players
    end,

    GetPlayerFromId = function(src)
        local player = Core.GetPlayerFromUserId(src)
    
        if not player then return nil end
    
        local self = {}
    
        self.hasJob = function(jobName, grade)
            if player.getGroup({ [jobName] = (grade or 0) }) ~= nil then return true end
            return false
        end
    
        self.addItem = function(item, cnt)
            return inventory:AddItem(self.source, item, cnt)
        end
    
        self.removeItem = function(item, cnt)
            return inventory:RemoveItem(self.source, item, cnt)
        end
    
        self.canCarryItem = function(item, cnt)
            return inventory:CanCarryItem(self.source, item, cnt)
        end

        self.hasItem = function (item, cnt, metadata)
            return inventory:GetItemCount(self.source, item, cnt, metadata) > 0
        end

        self.isAdmin = function ()
            if player.getGroup({ ['admin'] = 1 }) ~= nil then return true end
            return false
        end
    
        self.source = src
        self.identifier = GetPlayerIdentifierByType(src, 'license')
    
        return self
    end
}
