local progress = {}
local ESX = exports["es_extended"]:getSharedObject()

function progress.doProgressbar(duration, label, anim)
    ESX.Progressbar(label, duration, {
        FreezePlayer = true,
        animation = {
            type = "anim",
            dict = anim[1],
            lib = anim[2]
        },
        onFinish = function()
            return true
        end,
        onCancel = function()
            return false
        end
    })
end

return progress
