local inventory = {}

local addItem = function(self,itemId)
  
end

local removeItem = function(self,itemId)

end

local useItem = function(self,itemId,x,y)

end

local getItems = function(self)
  return self.items
end


inventory.create = function()
  local inst = {}

    inst.items = {}

    inst.addItem = addItem
    inst.removeItem = removeItem
    inst.getItems = getItems

  return inst
end

return inventory
