---@meta
--[[
    Portions of this file are adapted from ox_lib
    Copyright © 2025 Linden <https://github.com/thelindat>
    Licensed under LGPL-3.0 or later
    <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Original code in this file
    Copyright © 2025 Orchid Studios <https://github.com/OrchidStudios>
    Licensed under LGPL-3.0 or later
    <https://www.gnu.org/licenses/lgpl-3.0.en.html>
]]

if not _VERSION:find('5.4') then
    error('Lua 5.4 must be enabled in the resource manifest!', 2)
end

local resourceName = GetCurrentResourceName()
local bridge = 'orchid-bridge'

if resourceName == bridge then return end

if lib and lib.name == bridge then
    error(("Cannot load orchid-bridge more than once.\n\tRemove any duplicate entries from '@%s/fxmanifest.lua'"):format(resourceName))
end

local export = exports[bridge]

if GetResourceState(bridge) ~= 'started' then
    error('^1orchid-bridge must be started before this resource.^0', 0)
end

-- Ignore invalid types during msgpack.pack (e.g. userdata)
msgpack.setoption('ignore_invalid', true)

local LoadResourceFile = LoadResourceFile
local context = IsDuplicityVersion() and 'server' or 'client'

local config = lib.load('data.config')

-----------------------------------------------------------------------------------------------
-- Module
-----------------------------------------------------------------------------------------------
local loadModule = function (module)
    if not config[module] then return lib.print.error(("[orchid-bridge] No %s module set in config"):format(module)) end
    
    local dir = ('modules/%s'):format(module)
    local path = ('%s/%s/%s.lua'):format(dir, context, config[module])
    local chunk = LoadResourceFile(bridge, (path))
    if not chunk and context == 'client' then
        path = ('%s/%s.lua'):format(dir, config[module])
        chunk = LoadResourceFile(bridge, path)
    end

    if not chunk then return end

    local fn, err = load(chunk, ('@@%s'):format(path))

    if not fn or err then
        return error(('\n^1Error importing module (%s): %s^0'):format(dir, err), 3)
    end

    local result = fn()
    return result
end

local function call(self, index, ...)
    return export[index](nil, ...)
end


local function detectFramework()
    if GetResourceState('es_extended') == 'started' then
        return 'esx'
    elseif GetResourceState('ox_core') == 'started' then
        return 'ox'
    elseif GetResourceState('qbx_core') == 'started' then
        return 'qbox'
    elseif GetResourceState('qb-core') == 'started' then
        return 'qb'
    else
        return 'custom'
    end
end

local function detectInventory()
    if GetResourceState('ox_inventory') == 'started' then
        return 'ox'
    elseif GetResourceState('qb-inventory') == 'started' then
        return 'qb'
    elseif GetResourceState('qs-inventory') == 'started' then
        return 'qb'
    else
        return 'custom'
    end
end

Orchid = setmetatable({
    context = context,
    framework = detectFramework(),
    inventory = detectInventory(),
    notify = function(...) end,
    target = {},
    textUI = {},
    contextMenu = {},
    config = lib.load('data.config')
}, {
    __index = call,
    __call = call,
})

local loadAllModules = function ()
    for key, value in pairs(config) do
        Orchid[key] = loadModule(key)
    end
end

local function printStartup() 
    print("^3======= Orchid Bridge Loaded =======^7")
    print((" %s: \t ^5%s^7"):format("Framework", Orchid.framework))

    print("^3======= Modules Loaded =============^7")
    for key, value in pairs(Orchid) do
        if key ~= "config" and key ~= "framework" and key ~= "context" then
            print((" %s: \t ^5%s^7"):format(key, config[key] or Orchid[key]))
        end
    end
    print("^3====================================^7")
end


require(("framework.%s.%s"):format(Orchid.framework, context))
inventory = require(("inventory.%s.%s"):format(Orchid.inventory, context))

loadAllModules()

printStartup()