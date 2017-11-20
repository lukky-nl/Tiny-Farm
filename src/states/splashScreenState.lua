local splashScreenState = {}

local backgroundImage

splashScreenState.load = function(self)

  backgroundImage = love.graphics.newImage("assets/img/menu/splashScreen.png")
  self.timeout = 200
end

splashScreenState.update = function(self)
  self.timeout = self.timeout - 1
  local returnValue = 0
  if self.timeout < 0 then
    returnValue = 2
  end
  return returnValue
end

splashScreenState.draw = function(self)
  love.graphics.printf("SplashScreen",0, 40, love.graphics.getWidth(),"center")
  love.graphics.draw(backgroundImage, (love.graphics.getWidth()/2)-960, (love.graphics.getHeight()/2)-540)
end

return splashScreenState
