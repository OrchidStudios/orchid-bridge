local Core
if Orchid.framework == 'qbox' then
    Core = exports['qbx_core']:GetCoreObject()
else
    Core = exports['qb-core']:GetCoreObject()
end

Events = {
    playerLoaded = "QBCore:Player:SetPlayerData",
    setJob = "QBCore:Client:OnJobUpdate"
}


Framework = {
    RegisterUsableItem = function (item, data)
        if Orchid.framework == 'qbox' then
            return exports.qbx_core:CreateUseableItem(item, data)
        else
            return Core.Functions.CreateUseableItem(item, data)
        end
    end,

    ---@param job string
    ---@return table, number
    GetActivePlayers = function (job)
        local players, amount = Core.Functions.GetPlayersOnDuty(job)
        return players, amount
    end,

    GetPlayerFromId = function (src)
        local player = Core.Functions.GetPlayer(src)

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
            if Config.Inventory == 'qb-inventory' then
                return inventory:CanAddItem(self.source, item, cnt)
            end
            
            return inventory:CanCarryItem(self.source, item, cnt)
        end

        self.hasItem = function (item, cnt, metadata)
            return inventory:GetItemCount(self.source, item, cnt, metadata) > 0
        end

        self.isAdmin = function ()
            return Core.Functions.HasPermission(self.source, 'admin')
        end

        self.source = src
        self.identifier = player.PlayerData.citizenid
        
        return self
    end
}


