return {
    start = function (data)
        lib.progressBar(data)
    end,

    stop = function ()
        lib.cancelProgress()
    end,

    isActive = function ()
        return lib.progressActive()
    end
}
