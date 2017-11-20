local objectTeleport = {}

objectTeleport.update = function(self,playerX,playerY)
  if playerX == self.x and playerY == self.y then
    return {self.settings[1],self.settings[2],self.settings[3],self.settings[4]}
  end
  return 0
end

objectTeleport.use = function(self)
  return 0
end

return objectTeleport
