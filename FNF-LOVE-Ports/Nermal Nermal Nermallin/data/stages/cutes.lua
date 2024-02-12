function create()
    self.camZoom = 0.8
    self.camSpeed = 0.5

    self.boyfriendPos = {x = 900, y = -150}
    self.gfPos = {x = 600, y = -250}
    self.dadPos = {x = 300, y = -200}

    local bg = Sprite(-230,-240):loadTexture(paths.getImage('bgstuffs/cutes'))
    self:add(bg)
end