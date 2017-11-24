function playerUpdateX()
   player.x = player.x + (jumpForce * jumpForceDirection)

   if player.x < 0 then
      player.x = 0
   elseif player.x > stage.width - (player.w * 0.8)  then
      player.x = stage.width - (player.w * 0.8)
   end

end

function playerUpdateY()
   if player.isJumping then
      player.y = player.y - jumpSpeed
      if player.y < jumpHeight then
         player.isJumping = false
      end
   else
      player.y = player.y + (jumpSpeed * 0.4)
      if player.y > stage.height then
         game.state = 'over'
      end
   end
end


function love.load()
   game = {}
   game.state = 'play'

   stage = {}
   stage.width = love.graphics.getWidth()
   stage.height = love.graphics.getHeight()

   player = {}
   player.w = 100
   player.h = 100
   player.x = stage.width / 2 - 50
   player.y = stage.height - 100
   player.isJumping = true
   --player.jumpingSound = love.audio.newSource("")
   player.sprite = love.graphics.newImage("tessa.png")

   jumpHeight = 150
   jumpSpeed = 3
   jumpForceDirection = 0
   jumpForce = 2
end

function love.update()
   playerUpdateX()
   playerUpdateY()
end


function love.draw()
   if game.state == 'over' then
      love.graphics.print("Game Over!", 100, 100)
   end

   love.graphics.draw( player.sprite, player.x, player.y, 0, 0.2)
end

function love.keypressed( key, scancode, isrepeat )
   if key == 'right' then
      jumpForceDirection = 1
   elseif key == 'left' then
      jumpForceDirection = -1
   end
end
