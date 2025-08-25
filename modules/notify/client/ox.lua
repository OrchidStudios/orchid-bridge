--- @param text string
--- @param type 'info' | 'success' | 'error' | 'warning'
--- @param duration number
return function(data)
    data.duration = 5000
    lib.notify(data)
end