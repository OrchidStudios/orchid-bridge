local buttonToControl = {
    ["F1"] = "~INPUT_REPLAY_START_STOP_RECORDING~",
    ["E"] = "~INPUT_CONTEXT~",
    ["SPACE"] = "~INPUT_JUMP~",
    ["ENTER"] = "~INPUT_ENTER~",
    ["LMB"] = "~INPUT_ATTACK~",
    ["RMB"] = "~INPUT_ATTACK2~",
    ["ESC"] = "~INPUT_FRONTEND_CANCEL~",
    ["SHIFT"] = "~INPUT_SPRINT~",
    ["BACKSPACE"] = "~INPUT_FRONTEND_RRIGHT~",
    ["Q"] = "~INPUT_COVER~",
    ["A"] = "~INPUT_MOVE_LEFT_ONLY~",
    ["W"] = "~INPUT_MOVE_UP_ONLY~",
    ["S"] = "~INPUT_MOVE_DOWN_ONLY~",
    ["D"] = "~INPUT_MOVE_RIGHT_ONLY~",
    ["CTRL"] = "~INPUT_DUCK~",
}

local textUI = {}

textUI.shown = false
textUI.withSound = true

---@param buttons { button: string, description: string } | string
textUI.show = function (buttons)
    local text = ""
    if type(buttons) == "string" then
        text = buttons
    else
        for _, button in ipairs(buttons) do
            local upper = string.upper(button.button)
            text = text .. ("%s %s~n~"):format(buttonToControl[upper] or "N/A", button.description)
        end
    end

    textUI.shown = true
    CreateThread(function()
        local CurrentResource = GetCurrentResourceName()
        while textUI.shown do
            AddTextEntry(CurrentResource, text)
            BeginTextCommandDisplayHelp(CurrentResource)
            EndTextCommandDisplayHelp(0, false, textUI.withSound, 50)
            Wait(0)
        end
    end)
end

textUI.hide = function ()
    textUI.shown = false
end

textUI.isActive = function ()
    return textUI.shown
end

return textUI