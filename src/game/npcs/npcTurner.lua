local npcTurner = {}

npcTurner.settings = {0,100,200}

npcTurner.update = function(self)
  self.settings[1] = self.settings[1] + 1
  if self.settings[1] > self.settings[2] then
    self.facing = self.facing + 1
    if self.facing > 3 then
      self.facing = 0
    end
    self.settings[1] = 0
  end
  if self.talking == true then
    self.settings[3] = self.settings[3] - 1
    if self.settings[3] < 0 then
      self.settings[3] = 300
      self.talking = false
    end
  end
end

npcTurner.use = function(self)
  if self.settings[2] > 60 then
    self.dialog = "Hello i'm "..self.name
    self.settings[2] = 50
  else
    self.dialog = "..."
    self.settings[2] = 100
  end

  self.talking = true
end

return npcTurner
