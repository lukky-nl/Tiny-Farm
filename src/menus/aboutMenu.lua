local aboutMenu = {}

local titleFont = love.graphics.newFont("assets/fonts/pixel.ttf", 30)
local menuFont = love.graphics.newFont("assets/fonts/pixel.ttf", 15)

local topOffset = love.graphics.getHeight()/2-100

local cursor = 3

local returning = false

aboutMenu.update = function()
  function love.keypressed( key )
    if key == "space" then
      returning = true
    end
  end
  if returning then
    returning = false
    return cursor+20
  end
end

aboutMenu.draw = function()
  topOffset = love.graphics.getHeight()/2-120

  love.graphics.setFont(titleFont)
  love.graphics.printf("About",0, topOffset, 300,"center")
  love.graphics.setFont(menuFont)
  love.graphics.printf("Made By : ",0, topOffset+100, 300,"center")
  love.graphics.printf("Lukky_d",0, topOffset+130, 300,"center")
  love.graphics.printf("",0, topOffset+160, 300,"center")
  love.graphics.printf("Back",0, topOffset+190, 300,"center")

  love.graphics.printf(">            <",0, (topOffset+100)+cursor*30, 300,"center")
end

return aboutMenu
