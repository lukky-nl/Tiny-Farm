local mainMenu = require("src.menus.mainMenu")
local settingsMenu = require("src.menus.settingsMenu")
local aboutMenu = require("src.menus.aboutMenu")

local menuState = {}

local currentMenu

local inputHelpImage
local backgroundImage
local backgroundBarImage
local backgroundOffset

local paused = false

menuState.load = function(self,pause)
  currentMenu = mainMenu
  mainMenu.setPause(pause)
  paused = pause
  inputHelpImage = love.graphics.newImage("assets/img/menu/input_help.png")
  backgroundImage = love.graphics.newImage("assets/img/menu/menuBG.png")
  backgroundBarImage= love.graphics.newImage("assets/img/menu/menuSideBar.png")
  backgroundOffset = 0
end

menuState.update = function(self)
  local menuFeedback = currentMenu.update()

  if menuFeedback == 0 then
    return 1
  end

  if menuFeedback == 1 then
    currentMenu = settingsMenu
  end

  if menuFeedback == 2 then
    currentMenu = aboutMenu
  end

  if menuFeedback == 3 then
    love.event.quit( )
  end

  if menuFeedback == 14 then
    currentMenu = mainMenu
  end
  if menuFeedback == 23 then
    currentMenu = mainMenu
  end


  if backgroundOffset > -128 then
    backgroundOffset = backgroundOffset - 1
  else
    backgroundOffset = 0
  end

end

menuState.draw = function(self)
  if paused == false then
    for x=0,love.graphics.getWidth()+128,128 do
      for y=0,love.graphics.getHeight()+128,128 do
        love.graphics.draw(backgroundImage,x+backgroundOffset,y+backgroundOffset)
      end
    end
  end
  love.graphics.draw(backgroundBarImage,-200,0)
  currentMenu.draw()
  love.graphics.draw(inputHelpImage,love.graphics.getWidth()-128,love.graphics.getHeight()-128)
end

return menuState
