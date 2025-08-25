local Core = exports.qbx_core

Events = {
    playerLoaded = "QBCore:Server:OnPlayerLoaded",
    setJob = "QBCore:Client:OnJobUpdate"
}


Framework = {
    RegisterUsableItem = function (item, data)
        return exports.qbx_core:CreateUseableItem(item, data)
    end,

    ---@param job string
    ---@return table, number
    GetActivePlayers = function (job)
        local amount players = Core:GetDutyCountJob(job)
        return players, amount
    end,

    GetPlayerFromId = function (src)
        local player = Core:GetPlayer(source)

        if not player then return nil end
    
        local self = {}

        self.job = player.PlayerData.job

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
            return inventory:GetItemCount(self.source, item, cnt, metadata) > 0
        end

        self.isAdmin = function ()
            return IsPlayerAceAllowed(self.source, "admin")
        end

        self.source = src
        self.identifier = player.PlayerData.citizenid
        
        return self
    end
}
