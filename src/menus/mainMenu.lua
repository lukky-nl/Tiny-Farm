local mainMenu = {}

local titleFont = love.graphics.newFont("assets/fonts/pixel.ttf", 30)
local menuFont = love.graphics.newFont("assets/fonts/pixel.ttf", 15)

local topOffset = love.graphics.getHeight()/2-100

local cursor = 0

local returning = false

local pauseMenu

mainMenu.setPause = function(p)
  pauseMenu = p
  cursor = 0
end

mainMenu.update = function()
  function love.keypressed( key )
    if key == "w" then
      if cursor > 0 then
        cursor = cursor - 1
      end
    end
    if key == "s" then
     if cursor < 3 then
       cursor = cursor + 1
     end
    end
    if key == "space" then
      returning = true
    end
  end
  if returning then
    returning = false
    return cursor
  end
end

mainMenu.draw = function()
  topOffset = love.graphics.getHeight()/2-120

  love.graphics.setFont(titleFont)
  if pauseMenu == true then
    love.graphics.printf("PAUSED",0, 40, 300,"center")
  end
  love.graphics.printf("Tiny Farm",0, topOffset, 300,"center")
  love.graphics.setFont(menuFont)
  if pauseMenu == false then
    love.graphics.printf("Enter Game",0, topOffset+100, 300,"center")
  else
    love.graphics.printf("Resume Game",0, topOffset+100, 300,"center")
  end
  love.graphics.printf("Settings",0, topOffset+130, 300,"center")
  love.graphics.printf("About",0, topOffset+160, 300,"center")
  love.graphics.printf("Quit",0, topOffset+190, 300,"center")

  love.graphics.printf(">              <",0, (topOffset+100)+cursor*30, 300,"center")
end

return mainMenu
