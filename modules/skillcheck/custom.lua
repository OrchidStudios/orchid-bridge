return {
    circle = function (data)
        return lib.skillCheck(data)
    end,

    arrows = function (data)
        lib.minigame('arrows', data) -- does not exist in ox_lib be default
    end
}
