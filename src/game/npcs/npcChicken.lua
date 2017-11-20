local npcChicken = {}

npcChicken.settings = {0,50,50,0}


npcChicken.update = function(self,map)

  local speed = tileSize/8
  if self.isWalking == false then
    if self.settings[4] == 1 then
      if map.collisionMap[1+((self.y-1)*(map.width))+self.x] == 1 then
        self.bufferY = self.bufferY - tileSize
        self.isWalking = true
        self.tempY = -1
      end
      self.facing = 3
    elseif self.settings[4] == 2 then
      if map.collisionMap[1+((self.y+1)*(map.width))+self.x] == 1 then
        self.bufferY = self.bufferY + tileSize
        self.isWalking = true
        self.tempY = 1
      end
      self.facing = 0
    elseif self.settings[4] == 3 then
      if map.collisionMap[1+((self.y)*(map.width))+self.x-1] == 1 then
        self.bufferX = self.bufferX - tileSize
        self.isWalking = true
        self.tempX = -1
      end
      self.facing = 1
    elseif self.settings[4] == 4 then
      if map.collisionMap[1+((self.y)*(map.width))+self.x+1] == 1 then
        self.bufferX = self.bufferX + tileSize
        self.isWalking = true
        self.tempX = 1
      end
      self.facing = 2
    elseif self.settings[4] == 5 then
      self.dialog = "Bok Bok"
      self.talking = true
      self.settings[4] = 0
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
      if self.isWalking then
        map.collisionMap[1+((self.y)*(map.width))+self.x] = 1
      end
      self.x = self.x + self.tempX
      self.y = self.y + self.tempY
      map.collisionMap[1+((self.y)*(map.width))+self.x] = 2
      self.drawX = self.x*tileSize
      self.drawY = self.y*tileSize
      self.tempX = 0
      self.tempY = 0
      self.isWalking = false
      self.settings[4] = 0
    end
  end


  self.settings[1] = self.settings[1] + 1
  if self.settings[1] > self.settings[2] then
    self.settings[4] = math.floor(math.random(5))
    self.settings[1] = 0
    self.settings[2] =  math.floor(math.random(100))+50
  end

  if self.talking == true then
    self.settings[3] = self.settings[3] - 1
    if self.settings[3] < 0 then
      self.settings[3] = 50
      self.talking = false
    end
  end
  return 0
end

npcChicken.use = function(self)

end

return npcChicken
