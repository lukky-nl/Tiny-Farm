local player = require("src.game.player")

local map = require("src.game.map")
  local mapFarmTest = require("assets.maps.mapFarmTiled")
  local mapRoadTest = require("assets.maps.mapRoadTiled")
  local mapTownTest = require("assets.maps.mapTownTiled")

local gameState = {}

local currentMap

local maps = {}

tileSize = 0
tileScale = 12

gameState.load = function(self)
  self.crops = 0
  self.seeds = 10


  maps = {map.create(mapFarmTest),map.create(mapRoadTest),map.create(mapTownTest)}
  currentMap = maps[1]
  currentMap:load()

  tileSize = math.floor(love.graphics.getHeight()/tileScale)

  self.player = player.create(1,1)
end



gameState.update = function(self)
  self.player:update(currentMap,self)

  local mapReturn = currentMap:update(self.player.x,self.player.y)

  if mapReturn ~= 0 then
    if mapReturn[1] == 1 then

      currentMap = maps[mapReturn[2]]
      currentMap:load()

      self.player.x = mapReturn[3]
      self.player.y = mapReturn[4]

    end
  end

  if currentMap.cropHarvested == true then
    self.crops = self.crops + 1
    currentMap.cropHarvested = false
  end

end

gameState.draw = function(self)

  currentMap:draw(self.player.drawX,self.player.drawY)

  self.player:draw()

  currentMap:drawChat(self.player.drawX,self.player.drawY)

  love.graphics.setNewFont(12)
  love.graphics.print("FPS:"..tostring(love.timer.getFPS()), 1, 1)
end

return gameState
