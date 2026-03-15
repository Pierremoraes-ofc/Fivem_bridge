local progress = {}

function progress.doProgressbar(duration, label, anim)
    if lib.progressBar({
            duration = duration,
            label = label,
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
            },
            anim = {
                dict = anim[1],
                cip = anim[2],
            }
        })
    then
        return true
    else
        return false
    end
end

function progress.doProgressCircle(duration, label, anim)
    if lib.progressCircle({
            duration = duration,
            label = label,
            position = Config.OxCirclePosition,
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
            },
            anim = {
                dict = anim[1],
                clip = anim[2],
            }
        })
    then
        return true
    else
        return false
    end
end

return progress
