math.randomseed( os.time() )

function playerUpdateX()
   player.x = player.x + (jumpForce * jumpForceDirection)
   if player.x < 0 then
      player.x = 0
   elseif player.x > stage.width - player.w  then
      player.x = stage.width - player.w
   end
end

function playerUpdateY(dt)
   if player.isJumping then
      game.notYetScore = game.notYetScore + 1
      player.y = player.y - jumpSpeed

      if player.y < jumpMaxHeight then
         game.score = game.score + game.notYetScore
         game.notYetScore = 0
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
         if platforms[i].y < stage.height then
            if platforms[i].y - wiggleRoom < player.y + player.h and
               platforms[i].y + platforms[i].h > player.y + player.h and
               player.x > platforms[i].x - (player.w / 2) and
            player.x + player.w < platforms[i].x + platforms[i].w + wiggleRoom then
               player.isJumping = true
            end
         end
      end
   end
end

function love.load()
   game = {}
   game.state = 'play'
   game.score = 0
   game.notYetScore = 0

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

   platformCount = 30
   platforms = {}
   for i=1, platformCount do
      platforms[i] = {}
      platforms[i].x = math.random(0, stage.width - 100)
      platforms[i].y = stage.height - math.random(90, 100) * i
      platforms[i].w = 120
      platforms[i].h = 10
   end

   --jumpHeight = 200
   jumpMaxHeight = 100
   jumpSpeed = 3
   jumpForceDirection = 0
   jumpForce = 2

   wiggleRoom = 5
end

function love.update(dt)
   playerUpdateX()
   playerUpdateY(dt)
   playerCollision()

   if player.isJumping then
      for i=1, platformCount do
         platforms[i].y = platforms[i].y + (jumpSpeed * 1.1)
      end
   end
end

function love.draw()
   love.graphics.setBackgroundColor( 181, 214, 217 )
   if game.state == 'over' then
      love.graphics.print("Game Over!", 100, 100)
   end

   love.graphics.setColor( 62, 170, 175, 255 )
   for i=1, platformCount do
      love.graphics.rectangle( 'fill', platforms[i].x, platforms[i].y, platforms[i].w, platforms[i].h)
   end
   love.graphics.setColor( 255, 255, 255, 255 )
   love.graphics.draw( player.sprite, player.x, player.y)

   love.graphics.setColor( 51, 51, 51, 255 )
   love.graphics.print("Height: ".. math.floor(game.score), 300, 30)
end

function love.keypressed( key, scancode, isrepeat )
   if key == 'right' then
      jumpForceDirection = 1
   elseif key == 'left' then
      jumpForceDirection = -1
   end
end
