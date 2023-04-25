local deco = require('GraphicsSetup')

--- Add overlays, color schemes depending on result
---@param viewer View
---@param val MeasuredValues
local function passFailGraphics(viewer, val)
  local overallResult = 'Pass' -- Default until some tolerance isn't fulfilled

  -- Distance 1 pass/fail
  if (val.distance1 < 405 and val.distance1 > 402) then
    viewer:addShape(val.distLine1, deco.decoPass)
  else
    viewer:addShape(val.distLine1, deco.decoFail)
    overallResult = 'Fail'
  end

  -- Distance 2 pass/fail
  if (val.distance2 < 89 and val.distance2 > 85) then
    viewer:addShape(val.distLine2, deco.decoPass)
  else
    viewer:addShape(val.distLine2, deco.decoFail)
    overallResult = 'Fail'
  end

  -- Angle pass/fail
  if ((180 - math.deg(val.angle) < 133) and (180 - math.deg(val.angle) > 130)) then
    viewer:addShape(val.lineSegm4, deco.decoPass)
    viewer:addShape(val.lineSegm5, deco.decoPass)
    for _, point in ipairs(val.intersection) do
      viewer:addShape(point, deco.decoFail)
    end
  else
    viewer:addShape(val.lineSegm4, deco.decoFail)
    viewer:addShape(val.lineSegm5, deco.decoFail)
    for _, point in ipairs(val.intersection) do
      viewer:addShape(point, deco.decoFail)
    end
    overallResult = 'Fail'
  end

  -- Radius pass/fail
  if (val.radius < 23 and val.radius > 21) then
    viewer:addShape(val.foundCircle, deco.decoPass)
    viewer:addShape(val.foundCircleCenter, deco.decoPass)
  else
    viewer:addShape(val.foundCircle, deco.decoFail)
    viewer:addShape(val.foundCircleCenter, deco.decoFail)
    overallResult = 'Fail'
  end

  -- Overall pass/fail
  if overallResult == 'Pass' then
    viewer:addText('Pass', deco.textDeco)
  else
    viewer:addText('Fail', deco.textDeco)
  end
  viewer:present()
  print('Distance 1: ' .. val.distance1 .. ' Distance 2: ' .. val.distance2 ..
        ' Angle: ' .. val.angle .. ' Radius: ' .. val.radius .. ' Result: ' .. overallResult)
end

return passFailGraphics
