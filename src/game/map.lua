local npc = require("src.game.npc")
local gameObject = require("src.game.gameObject")

local map = {}

-- Helper Functons ------------------------------------------

local addObject = function(self,obj)
  self.gameObjects[#self.gameObjects+1] = gameObject.create(obj[1],obj[2],obj[3],obj[4],obj[5])
end

local copyMap = function(t)
  local r = {}
  for i = 1,#t,1 do
    r[i] = t[i]
  end
  return r
end

local drawChat = function(self,playerX,playerY)
  for i = 1,#self.npcs,1 do
    self.npcs[i]:drawChat(playerX,playerY)
  end
end

local tryInteract = function(self,tryX,tryY)
  for i = 1,#self.npcs,1 do
    if self.npcs[i].x == tryX and self.npcs[i].y == tryY then
      self.npcs[i]:use()
    end
  end
  for i = 1,#self.gameObjects,1 do
    if self.gameObjects[i].x == tryX and self.gameObjects[i].y == tryY then
      r = self.gameObjects[i]:use()
      if r == 1 then
        self.gameObjects[i].x = -100
        self.gameObjects[i].y = -100
        self.cropHarvested = true
      end
    end
  end
end


local getObjectOn = function(self,x,y)
  for i = 1,#self.gameObjects,1 do
    if self.gameObjects[i].x == x and self.gameObjects[i].y == y then
      return false
    end
  end
  return true
end

-- Core Functons ------------------------------------------

local load = function(self)
  self.collisionMap = copyMap(self.collisionMapClean)
  for i = 1,#self.npcData,1 do
    local pp = npc.create(self.npcData[i][1],self.npcData[i][2],self.npcData[i][3],self.npcData[i][4],self.npcData[i][5])
    self.npcs[i] = pp
  end
end

local update = function(self,playerX,playerY)

  local returnValue = 0
  local tempReturn = 0
  -- Update Game Objects
  for i = 1,#self.gameObjects,1 do
    local tempReturn = self.gameObjects[i]:update(playerX,playerY)
    if tempReturn ~= 0 then
      if tempReturn[1] == 1 then
        returnValue = tempReturn
      end
    end
  end
  -- Update NPCS
  for i = 1,#self.npcs,1 do
    self.npcs[i]:update(self)
  end

  -- Handeling Return from Game Objects & NPCS
  return returnValue
end

local draw = function(self,playerX,playerY)
  -- Drawing Tiles
  for y = 0,self.height-1,1 do
    for x = 0,self.width-1,1 do
      if y > (playerY/tileSize)-(tileScale+1/2) and y < (playerY/tileSize)+(tileScale+1/2) and x > (playerX/tileSize)-((love.graphics.getWidth()/tileSize)+1/2) and x < (playerX/tileSize)+((love.graphics.getWidth()/tileSize)+1/2) then
        local tileIndex = 1+((y*(self.width))+x);
        local tile = love.graphics.newQuad((17*(self.tilemap[tileIndex]-1)), 0, 16, 16, 425, 425)

        love.graphics.draw(
        self.tileset,
        tile,
        x*tileSize+((love.graphics.getWidth()/2)-(tileSize/2))-playerX,
        y*tileSize+((love.graphics.getHeight()/2)-(tileSize/2))-playerY,
        0,
        0.063*tileSize,0.0625*tileSize
        )
      end
    end
  end
  -- Drawing Game Objects
  for i = 1,#self.gameObjects,1 do
    self.gameObjects[i]:draw(playerX,playerY)
  end
  -- Drawing NPCS
  for i = 1,#self.npcs,1 do
    self.npcs[i]:draw(playerX,playerY)
  end
end

map.create = function(mapData)
  local inst = {}
    inst.tileset = love.graphics.newImage(mapData.tilesetSource)
    inst.tileset:setFilter("nearest", "nearest")
    inst.height = mapData.height
    inst.width = mapData.width
    inst.tilemap = mapData.tilemap
    inst.collisionMapClean = mapData.collisionMapClean
    inst.collisionMap = copyMap(mapData.collisionMapClean)
    inst.draw = draw
    inst.update = update
    inst.gameObjects = {}
    inst.objectData = mapData.objects
    for i = 1,#inst.objectData,1 do
      local obj = gameObject.create(mapData.objects[i][1],mapData.objects[i][2],mapData.objects[i][3],mapData.objects[i][4],mapData.objects[i][5])
      inst.gameObjects[i] = obj
    end
    inst.load = load
    inst.npcs = {}
    inst.npcData = mapData.npcs
    for i = 1,#inst.npcData,1 do
      local pp = npc.create(inst.npcData[i][1],inst.npcData[i][2],inst.npcData[i][3],inst.npcData[i][4],inst.npcData[i][5])
      inst.npcs[i] = pp
    end

    inst.cropHarvested = false

    inst.getObjectOn = getObjectOn
    inst.drawChat = drawChat

    inst.addObject = addObject

    inst.tryInteract = tryInteract

    inst.currentDialog = {}

  return inst

end

return map
