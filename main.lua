function love.load()
   stage = {}
   stage.width = love.graphics.getWidth()
   stage.height = love.graphics.getHeight()

   player = {}
   player.w = 100
   player.h = 100
   player.x = stage.width / 2 - 50
   player.y = stage.height - 100
   player.isJumping = false
   --player.jumpingSound = love.audio.newSource("")
   player.sprite = love.graphics.newImage("tessa.png")
end


function love.update()

end


function love.draw()
   love.graphics.draw( player.sprite, player.x, player.y, 0, 0.2)
end
