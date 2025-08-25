Wait(1000)

local currentResource = GetCurrentResourceName()

exports[currentResource]:openList({
    label = 'Example List',
    categories = {
        "Label", "Description", "Some", "Text"
    },
    items = {
        { text = { 'Item 1', 'Description 1', 'Lama 2' }, args = { id = 2 } },
        { text = { 'Item 2', 'Description 2', 'Digger 3' }, args = { id = 4 } },
        { text = { 'Item 3', 'Description 3', 'Iceman 1' }, args = { id = 7 } },
        { text = { 'Item 3', 'Description 3', 'Iceman 1' }, args = { id = 7 } },
        { text = { 'Item 1', 'Description 1', 'Lama 2' }, args = { id = 2 } },
    },
    buttons = {
        { icon = 'fa-solid fa-check', label = 'Select', onSelect = function(itemIndex, item, args) print('Selected item:', itemIndex, 'with args:', args) end },
        { icon = 'fa-solid fa-trash', label = 'Delete', onSelect = function(itemIndex, item, args) print('Deleted item:', itemIndex, 'with args:', args) end },
        { icon = 'fa-solid fa-edit', label = 'Edit', onSelect = function(itemIndex, item, args) print('Edited item:', itemIndex, 'with args:', args) end }
    }
})
