--[[
  (c) 2021 marc2o
--]]

canvas = nil
image = nil
shader = nil

function love.load()
  love.window.setMode(640, 480, {
    fullscreen = false,
    vsync = 1,
    resizable = false,
    centered = true }
  )
  love.window.setTitle("composite shader with scanlines")

  canvas = love.graphics.newCanvas(320, 240)
  canvas:setFilter("nearest", "nearest")

  love.graphics.setLineStyle("rough")

  image = love.graphics.newImage("Assets/Images/SMPTE_Color_Bars.png")

  shader = require("Assets.Filters.compositeScanlines")
  shader:send("screen", {
    canvas:getWidth(),
    canvas:getHeight()
  })

end

function love.update(dt)

  if dt < 1/60 then
    love.timer.sleep(1/60 - dt)
  end

end

function love.draw()
  love.graphics.setBlendMode("alpha", "alphamultiply")
  canvas:renderTo(
    function()
      
      love.graphics.setColor(1, 1, 1)
      
      love.graphics.draw(image, 0, 0)

    end
  )
  

  local buffer = nil
  buffer = love.graphics.newCanvas(canvas:getDimensions())
  buffer:setFilter("nearest", "nearest")
  buffer:renderTo(
    function()
      love.graphics.setShader(shader)
      love.graphics.draw(canvas, 0, 0)
      love.graphics.setShader()
    end
  )
  
  love.graphics.setColor(1, 1, 1)
  love.graphics.setBlendMode("replace", "premultiplied")
  love.graphics.push()
  love.graphics.translate(0, 0)
  love.graphics.scale(
    love.graphics.getWidth() / canvas:getWidth(),
    love.graphics.getHeight() / canvas:getHeight()
  )
  love.graphics.draw(buffer, 0, 0)
  love.graphics.pop()

  --love.graphics.captureScreenshot( "screenshot.png" )
end

function love.quit()
end
