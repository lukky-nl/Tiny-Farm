local settingsMenu = {}

local titleFont = love.graphics.newFont("assets/fonts/pixel.ttf", 30)
local menuFont = love.graphics.newFont("assets/fonts/pixel.ttf", 12)

local topOffset = love.graphics.getHeight()/2-120

local cursor = 0

local returning = false

local resolutions = {800,600,1280,720,1440,900,1920,1080}
local resolutionOption = 3

local fullscreenSetting = false
local vsyncSetting = true

settingsMenu.update = function()
  function love.keypressed( key )
    if key == "w" then
      if cursor > 0 then
        cursor = cursor - 1
      end
    end
    if key == "s" then
     if cursor < 4 then
       cursor = cursor + 1
     end
    end
    if key == "d" then
      if cursor == 0 then
        if resolutionOption < 7 then
          resolutionOption = resolutionOption + 2
        end
      end
      if cursor == 1 then
        fullscreenSetting = true
      end
      if cursor == 2 then
        vsyncSetting = true
      end
    end
    if key == "a" then
      if cursor == 0 then
        if resolutionOption > 1 then
          resolutionOption = resolutionOption - 2
        end
      end
      if cursor == 1 then
        fullscreenSetting = false
      end
      if cursor == 2 then
        vsyncSetting = false
      end
    end
    if key == "space" then
      returning = true
      if cursor == 3 then
        love.window.setMode( resolutions[resolutionOption], resolutions[resolutionOption+1], {fullscreen = fullscreenSetting, vsync = vsyncSetting} )
        if math.floor(love.graphics.getHeight()/16) % 2 == 0 then
          tileSize = math.floor(love.graphics.getHeight()/tileScale)
        else
          tileSize = math.floor(love.graphics.getHeight()/tileScale)+1
        end
      end
    end
  end
  if returning then
    returning = false
    return cursor+10
  end
end

settingsMenu.draw = function()
  topOffset = love.graphics.getHeight()/2-120

  love.graphics.setFont(titleFont)
  love.graphics.printf("Settings",0, topOffset, 300,"center")
  love.graphics.setFont(menuFont)
  if fullscreenSetting == false then love.graphics.printf("Resolution :".. tostring(resolutions[resolutionOption]) .."x".. tostring(resolutions[resolutionOption+1]),0,topOffset+100, 300,"center") end
  love.graphics.printf("Fullscreen : "..tostring(fullscreenSetting),0, topOffset+130, 300,"center")
  love.graphics.printf("Vsync : "..tostring(vsyncSetting),0, topOffset+160, 300,"center")
  love.graphics.printf("Apply",0, topOffset+190, 300,"center")
  love.graphics.printf("Back",0, topOffset+220, 300,"center")

  love.graphics.printf(">                     <",0, (topOffset+100)+cursor*30, 300,"center")
end

return settingsMenu
