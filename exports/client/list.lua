---@alias Item string[]
---@alias Button { icon: string, label: string, onSelect: function }

    local currentList

---@class ListMenu : OxClass
---@field label string
---@field items Item[]
---@field buttons Button[]
ListMenu = lib.class('ListMenu')

---@param label string
---@param items Item[]
---@param buttons Button[]
function ListMenu:constructor(label, categories, items, buttons)
    self.label = label
    self.items = items
    self.buttons = buttons
    self.categories = categories

    self.uiItems = {}
    self.uiButtons = {}

    for i = 1, #self.items do
        local item = self.items[i]
        self.uiItems[i] = item.text
    end
    for i = 1, #self.buttons do
        self.uiButtons[i] = {
            icon = self.buttons[i].icon,
            label = self.buttons[i].label
        }
    end
end

function ListMenu:open()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'openUltimateList',
        data = {
            categories = self.categories,
            label = self.label,
            items = self.uiItems,
            buttons = self.uiButtons
        }
    })
end

function ListMenu:close()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'closeUltimateList'
    })
end

function ListMenu:onSelect(itemIndex, buttonIndex)
    self.buttons[buttonIndex].onSelect(itemIndex, self.items[itemIndex], self.items[itemIndex].args)
end


local function openList(data)
    currentList = ListMenu:new(data.label, data.categories, data.items, data.buttons)
    currentList:open()
end

local function closeList()
    if currentList then
        currentList:close()
        currentList = nil
    end
end

exports('openList', openList)
exports('closeList', closeList)

RegisterNuiCallback('listButtonClicked', function (data, cb)
    local itemIndex = data.itemIndex
    local buttonIndex = data.buttonIndex

    if currentList then
        currentList:onSelect(itemIndex, buttonIndex)
    end

    cb(true)
end)


RegisterNuiCallback('closeList', function (_, cb)
    SetNuiFocus(false, false)
    cb(true)
end)

