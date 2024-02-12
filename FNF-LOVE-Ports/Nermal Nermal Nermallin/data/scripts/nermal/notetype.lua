function onNoteHit(event)
    if event.note then
        if event.note.type == 'Hey' then
            event:cancelAnim()
            if event.character then
                event.character:playAnim('hey')
                event.character.lastHit = math.floor(PlayState.conductor.time)
            end
        end
    end
end