love.graphics.setBackgroundColor(0, 0, 128)
math.randomseed(os.time())

state = "menu" -- either menu, game, game_over
squareSize = 15
w = 600 -- get this dynamically
h = 450

-- we need to set the variables once globally
snake = {}
apple = {}
score = 0
speed = 0
updateDelay = 0
direction = 'right'
newDirection = nil
addNew = false

snakeImage = nil
appleImage = nil

function love.load()
   resetGame()
   snakeImage = love.graphics.newImage('assets/snake.png')
   appleImage = love.graphics.newImage('assets/apple.png')
   menuImage = love.graphics.newImage('assets/menu.png')
   gameOverImage = love.graphics.newImage('assets/game-over.png')
end

function resetGame()
   snake = {}
   apple = {}
   score = 0
   speed = 0
   updateDelay = 0
   direction = 'right'
   newDirection = nil
   addNew = false

   buildSnake(3) -- arbitrary start number
   randomApple()
end

function buildSnake(start)
   for i=1,start do      
      snake[i] = {}
      snake[i].x = 150 + i * squareSize
      snake[i].y = 150 -- 150 is arbitrary      
   end
end

function randomApple()
   apple.x = math.floor(math.random(40) * squareSize) -- width - squareSize
   apple.y = math.floor(math.random(30) * squareSize) -- height - squareSize
end

function love.update(dt)
   if state == "game" then

      speed = math.min(10, math.floor(score/5))
      updateDelay = updateDelay + 1

      if updateDelay % (10 - speed) == 0 then
         head = updateSnake()
         selfCollision(head)
         appleCollision(head)
         wallCollision(head)
      end
   end
end

function wallCollision(head)
   if head.x >= 600 or head.x < 0 or head.y >= 450 or head.y < 0 then
      state = "game_over"
   end
end

function selfCollision(head)
   for i=1, #snake -1 do
      if snake[i].x == head.x and snake[i].y == head.y then
         state = "game_over"
      end
   end
end

function appleCollision(head)
   if head.x == apple.x and head.y == apple.y then
      growSnake(apple)
      randomApple()
      score = score + 1
   end
end

function growSnake(apple)
   newSnake = {}
   newSnake.x = apple.x
   newSnake.y = apple.y
   table.insert(snake, 1, newSnake)
end

function updateSnake()   
   firstCell = snake[#snake]
   lastCell = table.remove(snake, 1)

   if direction == "right" then
      lastCell.x = firstCell.x + squareSize
      lastCell.y = firstCell.y
   elseif direction == "left" then
      lastCell.x = firstCell.x - squareSize
      lastCell.y = firstCell.y
   elseif direction == "up" then
      lastCell.x = firstCell.x
      lastCell.y = firstCell.y - squareSize
   elseif direction == "down" then
      lastCell.x = firstCell.x
      lastCell.y = firstCell.y + squareSize
   end

   table.insert(snake, lastCell)
   firstCell = lastCell

   return firstCell
end

function love.draw()
   if state == "game" then
      for i=1, #snake do
         love.graphics.draw(snakeImage, snake[i].x, snake[i].y)
      end
      love.graphics.draw(appleImage, apple.x, apple.y)
      love.graphics.print("SCORE " .. score, 30, 20)
      love.graphics.print("SPEED " .. speed, 500, 20)
   elseif state == "menu" then
      love.graphics.draw(menuImage, 0, 0)
   elseif state == "game_over" then
      love.graphics.draw(gameOverImage, 0, 0)
      love.graphics.print("LAST SCORE: " .. score, 250, 210)
   end
   
end

function love.keyreleased(key)
   if key == "right" and direction ~= "left" then
      direction = "right"
   elseif key == "left" and direction ~= "right" then
      direction = "left"
   elseif key == "up" and direction ~= "down" then
      direction = "up"
   elseif key == "down" and direction ~= "up" then
      direction = "down"
   end
end


function love.mousereleased(x, y, button)
   if state == "menu" then
      state = "game"
   elseif state == "game_over" then
      resetGame()
      state = "game"
   end
end
