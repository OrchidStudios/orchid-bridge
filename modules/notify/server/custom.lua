--- @param text string | table
--- @param type 'info' | 'success' | 'error' | 'warning'
--- @param duration number
return function(source, data, notifyType, duration)
    if type(data) ~= 'table' then
        data = {
            description = data,
            type = notifyType,
            duration = duration
        }
    end

    
end