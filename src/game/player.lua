local plantObject = require("src.game.gameObjects.objectPlant")

local player = {}

local update = function(self,map,game)
  if self.floatingUp then
    self.float = self.float - 1
  else
    self.float = self.float + 1
  end

  if self.float  > self.maxFloat then
    self.floatingUp = true
  end

  if self.float  < 0 then
    self.floatingUp = false
  end

  local speed = tileSize/self.stepsPerTile

  if self.isWalking == false then
    if love.keyboard.isDown("w") then
      if map.collisionMap[1+((self.y-1)*(map.width))+self.x] == 1 then
        self.bufferY = self.bufferY - tileSize
        self.isWalking = true
        self.tempY = -1
      end
      self.facing = 3
    elseif love.keyboard.isDown("s") then
      if map.collisionMap[1+((self.y+1)*(map.width))+self.x] == 1 then
        self.bufferY = self.bufferY + tileSize
        self.isWalking = true
        self.tempY = 1
      end
      self.facing = 0
    elseif love.keyboard.isDown("a") then
      if map.collisionMap[1+((self.y)*(map.width))+self.x-1] == 1 then
        self.bufferX = self.bufferX - tileSize
        self.isWalking = true
        self.tempX = -1
      end
      self.facing = 1
    elseif love.keyboard.isDown("d") then
      if map.collisionMap[1+((self.y)*(map.width))+self.x+1] == 1 then
        self.bufferX = self.bufferX + tileSize
        self.isWalking = true
        self.tempX = 1
      end
      self.facing = 2
    end
    function love.keypressed(key)
       if key == "e" then
          if map.tilemap[1+((self.tileLookingY)*30)+self.tileLookingX] == 7 and map:getObjectOn(self.tileLookingX,self.tileLookingY) and game.seeds > 0 then
            game.seeds = game.seeds - 1
            map:addObject({"assets/img/game/objects/ugly_plant.png",self.tileLookingX,self.tileLookingY,plantObject,{0,0,0}})
          end
          map:tryInteract(self.tileLookingX,self.tileLookingY)
       end
    end
    self.drawX = self.x*tileSize
    self.drawY = self.y*tileSize
  else
    if self.bufferX > 0 then
      self.bufferX = self.bufferX - speed
      self.drawX = self.drawX + speed
    elseif self.bufferX < 0 then
      self.bufferX = self.bufferX + speed
      self.drawX = self.drawX - speed
    elseif self.bufferY < 0 then
      self.bufferY = self.bufferY + speed
      self.drawY = self.drawY - speed
    elseif self.bufferY > 0 then
      self.bufferY = self.bufferY - speed
      self.drawY = self.drawY + speed
    else

      map.collisionMap[1+((self.y)*(map.width))+self.x] = 1
      self.x = self.x + self.tempX
      self.y = self.y + self.tempY
      map.collisionMap[1+((self.y)*(map.width))+self.x] = 2
      self.drawX = self.x*tileSize
      self.drawY = self.y*tileSize
      self.tempX = 0
      self.tempY = 0
      self.isWalking = false
    end
  end
  if self.facing == 0 then
    self.tileLookingX = self.x
    self.tileLookingY = self.y+1
  elseif self.facing == 1 then
    self.tileLookingX = self.x -1
    self.tileLookingY = self.y
  elseif self.facing == 2 then
    self.tileLookingX = self.x +1
    self.tileLookingY = self.y
  elseif self.facing == 3 then
    self.tileLookingX = self.x
    self.tileLookingY = self.y-1
  end
end

local draw = function(self)
  local spriteClipping = love.graphics.newQuad(16*self.facing, 0, 16, 16, 64, 16)
  love.graphics.draw(
  self.sprite,
  spriteClipping,
  (love.graphics.getWidth()/2)-(tileSize/2),(love.graphics.getHeight()/2)-(tileSize*0.8)+(self.float/8),
  0,
  0.0625*tileSize,0.0625*tileSize
)
end

player.create = function(x,y)
  local inst = {}
    inst.x = x
    inst.y = y

    inst.drawX = x*tileSize
    inst.drawY = y*tileSize

    inst.update = update
    inst.draw = draw

    inst.sprite = love.graphics.newImage("assets/img/game/units/blue.png")
    inst.sprite:setFilter("nearest", "nearest")

    inst.facing = 0
    inst.stepsPerTile = 8
    inst.tileLookingX = 0
    inst.tileLookingY = 0

    inst.isWalking = false
    inst.bufferX = 0
    inst.bufferY = 0
    inst.tempX = 0
    inst.tempY = 0

    inst.float = 0
    inst.maxFloat = 24
    inst.floatingUp = false
  return inst
end

return player
