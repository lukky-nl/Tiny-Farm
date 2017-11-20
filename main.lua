
local state = require("src.state")
local menuState = require("src.states.menuState")
local gameState = require("src.states.gameState")
local inventoryState = require("src.states.inventoryState")
local splashScreenState = require("src.states.splashScreenState")

local currentState

local Game
local Menu

local paused = false

function love.load()

  love.graphics.setBackgroundColor( 53/2 , 99/2 ,33/2)
  currentState = state.create(splashScreenState,false)

  Game = state.create(gameState)
  Inv = state.create(inventoryState)

end

function love.update()

  local stateReturn

  if currentState == Inv then
    stateReturn = currentState:update(Game)
  else
    stateReturn = currentState:update()
  end

  if stateReturn == 1 then
    currentState = Game
    paused = false
  end

  if stateReturn == 2 then
    currentState = state.create(menuState,false)
    paused = false
  end


  if love.keyboard.isDown( "escape" ) and currentState == Game then
     currentState = state.create(menuState,true)
     paused = true
  end

  if love.keyboard.isDown( "tab" ) and currentState == Game and stateReturn ~= 1 then
     currentState = Inv
     paused = true
  end
end

function love.draw()
  if paused then
    Game:draw()
  end
  currentState:draw()
end
