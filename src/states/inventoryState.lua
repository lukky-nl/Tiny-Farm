local inventoryState = {}

local currentMenu

local inputHelpImage
local backgroundBarImage
local backgroundOffset


local titleFont = love.graphics.newFont("assets/fonts/pixel.ttf", 30)
local textFont = love.graphics.newFont("assets/fonts/pixel.ttf", 15)


inventoryState.load = function(self)
  self.crops = 0
  self.seeds = 0
  inputHelpImage = love.graphics.newImage("assets/img/menu/input_help.png")
  backgroundBarImage= love.graphics.newImage("assets/img/menu/menuSideBar.png")
  backgroundOffset = 0
end

inventoryState.update = function(self,game)
  self.crops = game.crops
  self.seeds = game.seeds
  local returnValue = 0
  if love.keyboard.isDown( "space" ) then
    returnValue = 1
  end
  return returnValue
end

inventoryState.draw = function(self)
  love.graphics.setFont(titleFont)
  love.graphics.draw(backgroundBarImage,-200,0)
  love.graphics.draw(inputHelpImage,love.graphics.getWidth()-128,love.graphics.getHeight()-128)
  love.graphics.printf("Inventory",0, 20, 300,"center")
    love.graphics.setFont(textFont)
  love.graphics.printf("Wheat : "..self.crops,20, (love.graphics.getHeight()/2)-40, 280,"left")
  love.graphics.printf("Seeds : "..self.seeds,20, (love.graphics.getHeight()/2)-20, 280,"left")

  love.graphics.printf("Space to close",0, love.graphics.getHeight()-40, 300,"center")
end

return inventoryState
