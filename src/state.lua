local state = {}

state.create = function (stateData,passVar)
  local inst = {}
    inst.load = stateData.load
    inst.update = stateData.update
    inst.draw = stateData.draw
    inst:load(passVar)
  return inst
end

return state
