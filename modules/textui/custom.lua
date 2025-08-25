return {
    ---@param buttons { button: string, description: string }[]
    show = function (buttons)
        if type(buttons) == "string" then
             lib.showTextUI(buttons, {
                position = 'left-center',
            })
        else
            lib.showKeyBind(buttons)
        end
    end,

    hide = function ()
        lib.hideKeyBind()
    end,

    isActive = function ()
        return lib.isKeyBindOpen()
    end
}