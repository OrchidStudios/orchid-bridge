Core = exports['orchid-core']:getSharedObject()

Events = {
    playerLoaded = "orchid:playerLoaded", -- player loaded event
    setJob = "orchid:setJob" -- setJob event
}

local RoleRanks = {
    owner = 100,
    s = 90,
    admin = 70,
    event = 50,
    mod = 30,
}

local PermissionTree = {}

Framework = {
    RegisterPermission = function(path, value)
        local node = PermissionTree

        for part in path:gmatch("[^.]+") do
            node[part] = node[part] or {}
            node = node[part]
        end

        node._value = value -- "group.s"
    end,

    RegisterUsableItem = Core.RegisterUsableItem,

    ---@param job string
    ---@return table, number
    GetActivePlayers = function (job)
        local players = Core.GetExtendedPlayers('job', job)
        return players, #players
    end,

    GetPlayerFromId = function (src)
        local player = Core.GetPlayerFromId(src)
    
        if not player then return nil end
    
        local self = {}

        self.job = player.getJob()

        self.hasJob = function(jobName, grade)
            return self.job.name == jobName and self.job.grade >= (grade or 0)
        end
    
        self.addItem = function (item, cnt)
           return inventory:AddItem(self.source, item, cnt)
        end

        self.removeItem = function (item, cnt)
            return inventory:RemoveItem(self.source, item, cnt)
        end

        self.canCarryItem = function (item, cnt)
            return inventory:CanCarryItem(self.source, item, cnt)
        end

        self.hasItem = function (item, cnt, metadata)
            return inventory:GetItemCount(self.source, item, metadata) >= cnt
        end

        self.isAdmin = function ()
            return player.hasRole('admin') or player.hasRole('s') or player.hasRole('event')
        end

        self.hasPermission = function(path)
            local node = PermissionTree
            local playerRank = 0

            -- Determine highest role rank
            for role, rank in pairs(RoleRanks) do
                if player.hasRole(role) and rank > playerRank then
                    playerRank = rank
                end
            end

            for part in path:gmatch("[^.]+") do
                node = node[part]
                if not node then return false end

                if node._value then
                    local requiredRank = RoleRanks[node._value]
                    if requiredRank and playerRank >= requiredRank then
                        return true
                    end
                end
            end

            if node and node._value then
                local requiredRank = RoleRanks[node._value]
                return requiredRank and playerRank >= requiredRank
            end

            return false
        end

        self.getAccount = player.getAccount
        self.removeAccountMoney = player.removeAccountMoney

        self.getName = player.getName
        
        self.identifier = player.getIdentifier()
        self.source = src

        return self
    end
}
