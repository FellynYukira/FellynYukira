function onNoteHit(event)
    if event.note then
        if event.note.type == 'Alt Animation' then
            event:cancelAnim()
            if event.character then event.character:sing(event.note.data, 'alt') end
        end
        if event.note.type == 'GF Sing' then
            event:cancelAnim()
            if state.gf then state.gf:sing(event.note.data, 'alt') end
        end
    end
end