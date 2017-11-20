local gameObject = {}

-- Core functions -----------------

local draw = function(self,playerX,playerY)
  local tile = love.graphics.newQuad(16.05*self.spriteIndex, 0, 16, 16, 64, 16)
  love.graphics.draw(
  self.sprite,
  tile,
  self.x*tileSize+((love.graphics.getWidth()/2)-(tileSize/2))-playerX,self.y*tileSize+((love.graphics.getHeight()/2)-(tileSize/2))-playerY,0,
  0.063*tileSize,0.063*tileSize)
end

gameObject.create = function(spriteSource,x,y,objectData,settings)
  local inst = {}
    inst.x = x
    inst.y = y
    inst.spriteIndex = 0

    inst.sprite = love.graphics.newImage(spriteSource)
    inst.sprite:setFilter("nearest", "nearest")
    inst.settings = settings
    for i = 1,#settings,1 do
        inst.settings[i] = settings[i]
    end
    inst.update = objectData.update
    inst.use = objectData.use
    inst.draw = draw

  return inst
end

return gameObject
