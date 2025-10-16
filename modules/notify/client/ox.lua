--- @param text string | table
--- @param type 'info' | 'success' | 'error' | 'warning'
--- @param duration number
return function(data, notifyType, duration)
    print(data)
    if type(data) ~= 'table' then
        data = {
            description = data,
            type = notifyType,
            duration = duration
        }
    end
    lib.notify(data)
end
