local bg
local chichi
local bgYukari
local desks
local bg1
local bg2
local bg3

function create()
    self.camZoom = 0.8
    self.camSpeed = 1.5

    self.boyfriendPos = {x = 440, y = 200}
    self.gfPos = {x = 630, y = 140}
    self.dadPos = {x = -250, y = 200}

    self.ratingPos = {x = -480, y = 450}

    bg = Sprite(-958, -95):loadTexture(paths.getImage(SCRIPT_PATH .. "bg"))
    bg.scale = {x = 1.35, y = 1.35}
    self:add(bg)

    if paths.formatToSongPath(PlayState.SONG.song) == 'her-lullaby' then
        bgYukari = Sprite(-540, 76)
        bgYukari:setFrames(paths.getSparrowAtlas(SCRIPT_PATH .. "bgyukari"))
        bgYukari:addAnimByPrefix('bop', 'anim', 24, false)
        bgYukari.scale = {x = 0.9, y = 0.9}
        self:add(bgYukari)
    end

    chichi = Sprite(225, 216)
    chichi:setFrames(paths.getSparrowAtlas(SCRIPT_PATH .. "chichispeaker"))
    chichi:addAnimByPrefix('speak', 'chichispeak', 24, false)
    chichi.scale = {x = 0.55, y = 0.55}
    self:add(chichi)

    desks = Sprite(-1065, -24):loadTexture(paths.getImage(SCRIPT_PATH .. "desks"))
    desks.scale = {x = 1.35, y = 1.35}
    desks:setScrollFactor(1.35, 1.35)
    self:add(desks, true)

    bg1 = Sprite(-725, 430)
    bg1:setFrames(paths.getSparrowAtlas(SCRIPT_PATH .. "bg1"))
    bg1:addAnimByPrefix('bop', 'bgchars1', 24, false)
    bg1.scale = {x = 1.4, y = 1.4}
    bg1:setScrollFactor(1.4, 1.4)
    self:add(bg1, true)

    bg2 = Sprite(-925, -320)
    bg2:setFrames(paths.getSparrowAtlas(SCRIPT_PATH .. "bg2"))
    bg2:addAnimByPrefix('bop', 'bgchars2', 24, false)
    bg2.scale = {x = 1.35, y = 1.35}
    bg2:setScrollFactor(1.45, 1.45)
    self:add(bg2, true)

    bg3 = Sprite(715, 714)
    bg3:setFrames(paths.getSparrowAtlas(SCRIPT_PATH .. "bg3"))
    bg3:addAnimByPrefix('bop', 'bgchars3', 24, false)
    bg3.scale = {x = 1.35, y = 1.35}
    bg3:setScrollFactor(1.5, 1.5)
    self:add(bg3, true)
end

function countdownTick(tick)
    chichi:play('speak', true)

    if (tick-1) % 2 == 0 then
        if bgYukari ~= nil then
            bgYukari:play('bop', true)
        end

        bg1:play('bop', true)
        bg2:play('bop', true)
        bg3:play('bop', true)
    end
end

function beat()
    chichi:play('speak', true)

    if curBeat % 2 == 0 then
        if bgYukari ~= nil then
            bgYukari:play('bop', true)
        end

        bg1:play('bop', true)
        bg2:play('bop', true)
        bg3:play('bop', true)
    end

    if paths.formatToSongPath(PlayState.SONG.song) == 'tkbonklerz' then
        if curBeat == 410 or curBeat == 740 then
            for _, spr in ipairs({bg, chichi, desks, bg1, bg2, bg3}) do
                Timer.tween(1, spr.color, {[1] = 0.4, [2] = 0.4, [3] = 0.4})
            end
        end
        if curBeat == 472 or curBeat == 772 then
            for _, spr in ipairs({bg, chichi, desks, bg1, bg2, bg3}) do
                Timer.tween(1, spr.color, {[1] = 1, [2] = 1, [3] = 1})
            end
        end
        if curBeat == 805 then
            for _, spr in ipairs({bg, chichi, desks, bg1, bg2, bg3, state.gf}) do
                spr.visible = false
            end

            game.camera.bgColor = {1, 1, 1, 1}

            for _, spr in ipairs({state.dad, state.boyfriend}) do
                spr.color = Color.BLACK
            end
        end
        if curBeat == 836 then
            for _, spr in ipairs({bg, chichi, desks, bg1, bg2, bg3, state.gf}) do
                spr.visible = true
            end

            for _, spr in ipairs({bg, chichi, desks, bg1, bg2, bg3}) do
                spr.color = {0.4, 0.4, 0.4}
            end

            game.camera.bgColor = {0, 0, 0, 1}

            for _, spr in ipairs({state.dad, state.boyfriend}) do
                spr.color = Color.WHITE
            end
        end
    end
end