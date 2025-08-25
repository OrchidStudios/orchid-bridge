exports('getTimeInTimeZone', function(timeZone)
    local date = os.date("!*t")
    date.hour = (date.hour + timeZone) % 24

    local new_time = { date.hour < 10 and "0" .. date.hour or date.hour, date.min < 10 and "0" .. date.min or date.min }

    return new_time
end)
