local moveVal = 10
local camAngle = 0

function postUpdate(dt)
	state:cameraMovement()
	local section = PlayState.SONG.notes[curSection + 1]
	if section then
		local target

		if section.mustHitSection then target = "boyfriend"
		elseif section.gfSection then target = "gf"
		else target = "dad" end

		if state[target] then
			if state[target].curAnim.name == 'singLEFT' or state[target].curAnim.name == 'singLEFT-alt' then
				state.camFollow.x = state.camFollow.x - moveVal
				camAngle = -1
			elseif state[target].curAnim.name == 'singDOWN' or state[target].curAnim.name == 'singDOWN-alt' then
				state.camFollow.y = state.camFollow.y + moveVal
				camAngle = 0
			elseif state[target].curAnim.name == 'singUP' or state[target].curAnim.name == 'singUP-alt' then
				state.camFollow.y = state.camFollow.y - moveVal
				camAngle = 0
			elseif state[target].curAnim.name == 'singRIGHT' or state[target].curAnim.name == 'singRIGHT-alt' then
				state.camFollow.x = state.camFollow.x + moveVal
				camAngle = 1
			end
		end
	end
    game.camera.angle = util.coolLerp(game.camera.angle, camAngle, state.stage.camSpeed, dt)
end