local camMove = true

local moveVal = 15
local mustPress = ""
local camOffset = {x = 0, y = 0}

local resetTimer = 0

function onCameraMove(event)
	mustPress = event.target == "bf" and true or false
end

function postUpdate(dt)
	if camMove then
		if resetTimer > 0 then
			resetTimer = resetTimer - dt
		else
			camOffset.x = 0
			camOffset.y = 0
		end

		state.camFollow.x = state.camFollow.x + camOffset.x
		state.camFollow.y = state.camFollow.y + camOffset.y
	end
end

function onNoteHit(event)
	if camMove and event.note.mustPress == mustPress then
		switch(event.note.data, {
			[0]=function()
				camOffset.x = -moveVal
				camOffset.y = 0
			end,
			[1]=function()
				camOffset.x = 0
				camOffset.y = moveVal
			end,
			[2]=function()
				camOffset.x = 0
				camOffset.y = -moveVal
			end,
			[3]=function()
				camOffset.x = moveVal
				camOffset.y = 0
			end
		})
		resetTimer = 0.15
	end
end