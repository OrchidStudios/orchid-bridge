return {
    ---@param buttons { button: string, description: string }[]
    show = function (buttons)
        local text = ""
        if type(buttons) == "string" then
            text = buttons
        else
            for _, button in ipairs(buttons) do
                text = text .. " [" .. button.button .. "] - " .. button.description .. "  \n"
            end
        end
        lib.showTextUI(text, {
            position = 'left-center',
        })
    end,

    hide = function ()
        lib.hideTextUI()
    end,

    isActive = function ()
        return lib.isTextUIOpen()
    end,
}
