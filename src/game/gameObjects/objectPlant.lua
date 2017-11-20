local objectPlant = {}

objectPlant.update = function(self,playerX,playerY)
  self.settings[1] = self.settings[1]  + 1
  if self.settings[1] > 500 and self.spriteIndex < 3 then
    self.spriteIndex = self.spriteIndex + 1
    self.settings[1] = 0
  end
  return 0
end

objectPlant.use = function(self)
  if self.spriteIndex == 3 then
    return 1
  end
  return 0
end

return objectPlant
