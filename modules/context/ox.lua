---@class Context
---https://overextended.dev/ox_lib/Modules/Interface/Client/context

return {
    ---@param data Context
    register = function(data)
        lib.register(data)
    end,

    show = function(id)
        lib.show(id)
    end,

    hide = function(onExit)
        lib.hide(onExit)
    end,
}
