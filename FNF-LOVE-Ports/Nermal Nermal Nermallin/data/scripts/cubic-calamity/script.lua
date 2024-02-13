local keepScroll = false
local black

function create()
    if ClientPrefs.data.middleScroll then keepScroll = true
    else ClientPrefs.data.middleScroll = true end
end
function postCreate()
    black = Graphic(-100, 0, 1500, 1500, {0, 0, 0})
    black.cameras = {state.camHUD}
    state:add(black)
    visibility()

    if keepScroll then keepScroll = false
    else ClientPrefs.data.middleScroll = false end
end

function songStart()
    Timer.tween(1.8, black, {alpha = 0})
end

function visibility()
    state.timeArcBG.visible = false
    state.timeArc.visible = false
    state.timeTxt.visible = false
    state.scoreTxt.visible = false
    state.iconP1.visible = false
    state.iconP2.visible = false
    state.healthBarBG.visible = false
    state.healthBar.visible = false
end