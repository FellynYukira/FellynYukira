local tomo
local kagura

function postCreate()
    tomo = Character(-120, 130, "tomo")
    state:insert(table.find(state.members, state.dad), tomo)

    kagura = Character(-400, 230, "kagura")
    state:insert(table.find(state.members, state.dad) + 1, kagura)
end

function update(dt)
    for _, n in pairs(state.notesGroup.members) do
        if n.type == "kag" or n.type == "kagLaugh" or n.type == "tomo" then
            n.visible = false
        end
    end
    for _, n in pairs(state.sustainsGroup.members) do
        if n.type == "kag" or n.type == "kagLaugh" or n.type == "tomo" then
            n.visible = false
        end
    end
end

function onSettingChange(type)
    if type == 'gameplay' then
        for _, n in pairs(state.notesGroup.members) do
            if n.type == "kag" or n.type == "kagLaugh" or n.type == "tomo" then
                n.visible = false
            end
        end
        for _, n in pairs(state.sustainsGroup.members) do
            if n.type == "kag" or n.type == "kagLaugh" or n.type == "tomo" then
                n.visible = false
            end
        end
    end
end

function countdownTick(tick)
    tomo:beat(tick)
    kagura:beat(tick)
end

function beat()
    tomo:beat(curBeat)
    kagura:beat(curBeat)

    if curBeat == 276 then
        tomo.x = tomo.x - 30
        tomo.alpha = 0.000001
        Timer.tween(0.7, tomo, {x = tomo.x + 30, alpha = 1}, 'out-sine')
    end
    if curBeat == 805 then
        for _, spr in ipairs({tomo, kagura}) do
            spr.color = Color.BLACK
        end
    end
    if curBeat == 836 then
        for _, spr in ipairs({tomo, kagura}) do
            spr.color = Color.WHITE
        end
    end
end

function onNoteHit(event)
    if event.note.type == "kag" or event.note.type == "kagLaugh" or event.note.type == "tomo" then
        event:cancelStrumGlow()
        event:cancelAnim()
        if event.note.type == "tomo" then
            tomo:sing(event.note.data, '')
        end
        if event.note.type == "kag" then
            kagura:sing(event.note.data, '')
        end
        if event.note.type == "kagLaugh" then
            kagura:playAnim('laugh', true)
            kagura.lastHit = PlayState.conductor.time
        end
    end
end

function onEvent(event)
    if event.name == "disappear" then
        if event.params[1] == "tomo" then
            tomo.visible = false
        end
        if event.params[1] == "kracgura" then
            kagura.visible = false
        end
    elseif event.name == "appear" then
        if event.params[1] == "tomo" then
            tomo.visible = true
        end
        if event.params[1] == "kracgura" then
            kagura.visible = true
        end
    end
end