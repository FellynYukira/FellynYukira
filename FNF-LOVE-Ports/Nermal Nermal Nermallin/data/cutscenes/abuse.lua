function create()
    state.boyfriend.visible = false
    state.dad.visible = false

    local bfCustcene = Character(state.stage.boyfriendPos.x+42, state.stage.boyfriendPos.y+20,
                            'bfShot', true)
    state:add(bfCustcene)

    local dadCutscene = Character(state.stage.dadPos.x, state.stage.dadPos.y,
                            'angrynermal', false)
    state:add(dadCutscene)

    local x, y = dadCutscene:getMidpoint()
    state.camFollow.x = x + 150 + (dadCutscene.cameraPosition.x +
                                    state.stage.dadCam.x)
    state.camFollow.y = y - 100 + (dadCutscene.cameraPosition.y +
                                    state.stage.dadCam.y)

    Timer.after(1, function()
        state:remove(bfCustcene)
        state:remove(dadCutscene)

        local garfJumpIn = Sprite(141, -808)
        garfJumpIn:setFrames(paths.getSparrowAtlas('garfieldjumpin'))
        garfJumpIn.scale = {x = 2, y = 2}
        garfJumpIn:updateHitbox()
        garfJumpIn:addAnimByPrefix('jumpIn', 'garf jumpscare fr fr', 24, false)
        garfJumpIn:play('jumpIn')
        state:add(garfJumpIn)

        Timer.after(2, function()
            state:remove(garfJumpIn)
            state.boyfriend.x = state.boyfriend.x - 90

            state.boyfriend.visible = true
            state.dad.visible = true

            state:startCountdown()
        end)
    end)
end