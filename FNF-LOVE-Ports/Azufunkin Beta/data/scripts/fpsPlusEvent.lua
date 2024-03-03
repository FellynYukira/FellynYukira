local eventTable = {}

function create()
    local eventFile = paths.getJSON('songs/' .. paths.formatToSongPath(PlayState.SONG.song) .. '/events')
    if eventFile then
        for _, event in pairs(eventFile.events.events) do
            local splitVal = event[4]:split(";")

            local ev = {
                params = {},
                time = 0,
                name = ""
            }

            ev.name = splitVal[1];
            ev.time = event[2];
            for i, val in pairs(splitVal) do
                if i ~= 1 then table.insert(ev.params, val) end
            end

            table.insert(eventTable, ev);
        end
    end
end

function postUpdate(dt)
    if #eventTable > 0 then
        table.sort(eventTable, Conductor.sortByTime)
        if eventTable[1].time <= PlayState.notePosition then
            executeEvent(table.remove(eventTable, 1))
        end
    end
end

function executeEvent(event)
    switch(event.name, {
        ["camBop"] = function()
            game.camera.zoom = game.camera.zoom + 0.015
            state.camHUD.zoom = state.camHUD.zoom + 0.03
        end,
        ["camBopBig"] = function()
            game.camera.zoom = game.camera.zoom + 0.025
            state.camHUD.zoom = state.camHUD.zoom + 0.04
        end,
        ["flash"] = function()
            game.camera:flash(Color.WHITE, tonumber(event.params[1]))
        end,
        ["flashHud"] = function()
            state.camHUD:flash(Color.WHITE, tonumber(event.params[1]))
        end,
        ["fadeOut"] = function()
            game.camera:fade(Color.BLACK, tonumber(event.params[1]))
        end,
        ["fadeOutHud"] = function()
            state.camHUD:fade(Color.BLACK, tonumber(event.params[1]))
        end,
        ["gamealpha"] = function()
            local alpha = tonumber(event.params[1])
            if alpha <= 0 then alpha = 0.000001 end
            game.camera.alpha = alpha
        end,
        ["camZoom"] = function()
            local zoomChange = tonumber(event.params[1])
            local duration = tonumber(event.params[2])
            local tweenEase = getTweenEase(event.params[3])
            Timer.tween(duration, game.camera, {zoom = zoomChange}, tweenEase)
            Timer.tween(duration, state.stage, {camZoom = zoomChange}, tweenEase)
        end,
        ["playAnim"] = function()
            switch(event.params[1], {
                ["dad"] = function() state.dad:playAnim(event.params[2]) end,
                ["gf"] = function() state.gf:playAnim(event.params[2]) end,
                default = function() state.boyfriend:playAnim(event.params[2]) end
            })
        end,
        ["angle"] = function()
            game.camera.angle = tonumber(event.params[1])
            Timer.tween(0.4, game.camera, {angle = 0}, 'out-circ')
        end
    })
    state.scripts:call("onEvent", event)
end

function getTweenEase(ease)
    ease = ease:lower()
    local direction = ''

    if ease:find('inout') then
        direction = 'in-out'
        ease = ease:gsub('inout', '')
    elseif ease:find('in') then
        direction = 'in'
        ease = ease:gsub('in', '')
    elseif ease:find('out') then
        direction = 'out'
        ease = ease:gsub('out', '')
    end

    local easeString = direction .. '-'

    if ease == 'back' then return easeString .. 'back'
    elseif ease == 'bounce' then return easeString .. 'bounce'
    elseif ease == 'circ' then return easeString .. 'circ'
    elseif ease == 'cube' then return easeString .. 'cubic'
    elseif ease == 'elastic' then return easeString .. 'elastic'
    elseif ease == 'expo' then return easeString .. 'expo'
    elseif ease == 'quad' then return easeString .. 'quad'
    elseif ease == 'quart' then return easeString .. 'quart'
    elseif ease == 'quint' then return easeString .. 'quint'
    elseif ease == 'sine' then return easeString .. 'sine'
    else return 'linear' end
end