function playerUpdateX()
   player.x = player.x + (jumpForce * jumpForceDirection)

   if player.x < 0 then
      player.x = 0
   elseif player.x > stage.width - player.w  then
      player.x = stage.width - player.w
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

function playerCollision()
   if not player.isJumping then
      for i=1, platformCount do
         if platforms[i].y - wiggleRoom < player.y + player.h and
            platforms[i].y > player.y + player.h and
            player.x > platforms[i].x - (player.w / 2) and
         player.x + player.w < platforms[i].x + platforms[i].w + wiggleRoom then
            player.isJumping = true
         end
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

   platformCount = 3
   platforms = {}
   for i=1, platformCount do
      platforms[i] = {}
      platforms[i].x = 50 + (i * 50)
      platforms[i].y = 300 + (i * 80)
      platforms[i].w = 300
      platforms[i].h = 10
   end

   jumpHeight = 150
   jumpSpeed = 3
   jumpForceDirection = 0
   jumpForce = 2

   wiggleRoom = 5
end

function love.update()
   playerUpdateX()
   playerUpdateY()
   playerCollision()
end


function love.draw()
   if game.state == 'over' then
      love.graphics.print("Game Over!", 100, 100)
   end

   love.graphics.setColor( 100, 100, 100, 255 )

   for i=1, platformCount do
      love.graphics.rectangle( 'fill', platforms[i].x, platforms[i].y, platforms[i].w, platforms[i].h)
   end

   love.graphics.setColor( 255, 255, 255, 255 )
   love.graphics.draw( player.sprite, player.x, player.y)
end

function love.keypressed( key, scancode, isrepeat )
   if key == 'right' then
      jumpForceDirection = 1
   elseif key == 'left' then
      jumpForceDirection = -1
   end
end
