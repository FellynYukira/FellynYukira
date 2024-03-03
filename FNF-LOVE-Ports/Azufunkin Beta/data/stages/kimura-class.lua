function create()
    self.camZoom = 1.02

    self.dadPos = {x = 450, y = 50}
    self.boyfriendPos = {x = 162, y = 50}

    self.ratingPos = {x = 0, y = 280}

    local bgkimura = Sprite(95):loadTexture(paths.getImage(SCRIPT_PATH .. "bgkimura"))
    bgkimura:setScrollFactor()
    bgkimura.scale = {x = 1.7, y = 1.7}
    self:add(bgkimura)

    local theborder = Sprite(-9):loadTexture(paths.getImage(SCRIPT_PATH .. "theborder"))
    theborder:setScrollFactor()
    theborder.scale = {x = 1.52, y = 1.52}
    self:add(theborder, true)
end

local splitMode = false

local bgkaorin
function postCreate()
    state.judgeSprites.scale = {x = 0.8, y = 0.8}

    bgkaorin = Sprite(148, -4):loadTexture(paths.getImage(SCRIPT_PATH .. "bgkaorin"))
    bgkaorin:setScrollFactor()
    bgkaorin.scale = {x = 1.6, y = 1.6}
    state:insert(state:indexOf(state.boyfriend), bgkaorin)

    state.dad:setScrollFactor()
    state.boyfriend:setScrollFactor()
    state.judgeSprites:setScrollFactor()
    state.gf.visible = false
end

function onCameraMove(event)
    if not splitMode and bgkaorin ~= nil then
        bgkaorin.visible = (event.target == "bf")
        state.boyfriend.visible = (event.target == "bf")
    end
end

function beat()
    if curBeat == 240 then
        splitMode = true
        state.boyfriend.y = state.boyfriend.y - 720
        state.boyfriend.visible = true

        Timer.tween(1.5, state.boyfriend, {y = state.boyfriend.y + 720}, 'out-circ');
        Timer.tween(1.5, state.dad, {x = state.dad.x + 130}, 'out-circ');
    end
end