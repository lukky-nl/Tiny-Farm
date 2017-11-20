local npc = {}

local textFont = love.graphics.newFont("assets/fonts/pixel.ttf", 12)

-- Helper Functons ------------------------------------------

local drawChat = function(self,playerX,playerY)
  if self.talking == true then
    love.graphics.draw(self.dialogBox,self.x*tileSize+((love.graphics.getWidth()/2)-(tileSize))-playerX,self.y*tileSize+((love.graphics.getHeight()/2)-(tileSize*1.8))-playerY,0,0.063*tileSize,0.063*tileSize)
    love.graphics.setColor( 0, 0, 0, 255 )
    love.graphics.setFont(textFont)
    love.graphics.printf(self.dialog,self.x*tileSize+((love.graphics.getWidth()/2)-(tileSize*0.9))-playerX,self.y*tileSize+((love.graphics.getHeight()/2)-(tileSize*1.5))-playerY,tileSize*1.8,"center")
    love.graphics.setColor( 255, 255, 255, 255 )
  end
end

-- Core functions -----------------

local draw = function(self,playerX,playerY)
  local tile = love.graphics.newQuad(16.05*self.facing, 0, 16, 16, 64, 16)
  love.graphics.draw(
  self.sprite,
  tile,
  self.drawX+((love.graphics.getWidth()/2)-(tileSize/2))-playerX,self.drawY+((love.graphics.getHeight()/2)-(tileSize*0.8))-playerY,0,
  0.063*tileSize,0.063*tileSize)
end

npc.create = function(spriteSource,x,y,npcData,name)
  local inst = {}
    inst.name = name

    inst.x = x
    inst.y = y

    inst.update = npcData.update
    inst.use = npcData.use

    inst.facing = 0

    inst.drawX = inst.x*tileSize
    inst.drawY = inst.y*tileSize

    inst.settings = {}

    for i = 1,#npcData.settings,1 do
        inst.settings[i] = npcData.settings[i]
    end

    inst.sprite = love.graphics.newImage(spriteSource)
    inst.sprite:setFilter("nearest", "nearest")

    inst.draw = draw
    inst.drawChat = drawChat

    inst.talking = false
    inst.dialog = ""
    inst.dialogBox = love.graphics.newImage("assets/img/game/ui/chat.png")
    inst.dialogBox:setFilter("nearest", "nearest")

    inst.isWalking = false
    inst.bufferX = 0
    inst.bufferY = 0
    inst.tempX = 0
    inst.tempY = 0

  return inst
end

return npc
