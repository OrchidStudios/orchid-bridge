-- Refer to the folder module

return {
    -- supported frameworks (will be detected automatically):
    -- ox | esx | qbx| qb | custom (check framework/custom)


    -- ox  : ox_target
    -- qb  : qb-target
    -- sleepless : sleepless_interact
    target = 'ox',

    -- In most our resource used for displaying keybinds
    -- ox       :  ox_lib
    -- default  :  GTA Help Text
    -- custom   :  your own
    textUI = 'default',

    -- Context menu
    -- ox       : ox_lib
    -- custom   : your own
    contextMenu = 'ox',

    -- ox       : ox_lib
    -- custom   : your own
    notify = 'ox',

    -- ox       : ox_lib
    -- custom   : your own
    progress = 'ox',

    -- ox       : ox_lib
    -- custom   : your own
    skillCheck = 'ox'
}