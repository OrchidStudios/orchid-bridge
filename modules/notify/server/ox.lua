--- @param data table
return function(source, data)
    data.duration = 5000
    lib.notify(source, data)
end