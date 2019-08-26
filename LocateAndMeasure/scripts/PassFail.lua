local deco = require('GraphicsSetup')

-- Add overlays, color schemes depending on result
--@passFailGraphics(imageID:string)
local function passFailGraphics(imageID, viewer, val)
  local overallResult = 'Pass' -- Default until some tolerance isn't fulfilled

  -- Distance 1 pass/fail
  if (val.distance1 < 405 and val.distance1 > 402) then
    viewer:addShape(val.distLine1, deco.decoPass, nil, imageID)
  else
    viewer:addShape(val.distLine1, deco.decoFail, nil, imageID)
    overallResult = 'Fail'
  end

  -- Distance 2 pass/fail
  if (val.distance2 < 89 and val.distance2 > 85) then
    viewer:addShape(val.distLine2, deco.decoPass, nil, imageID)
  else
    viewer:addShape(val.distLine2, deco.decoFail, nil, imageID)
    overallResult = 'Fail'
  end

  -- Angle pass/fail
  if ((180 - math.deg(val.angle) < 133) and (180 - math.deg(val.angle) > 130)) then
    viewer:addShape(val.lineSegm4, deco.decoPass, nil, imageID)
    viewer:addShape(val.lineSegm5, deco.decoPass, nil, imageID)
    for _, point in ipairs(val.intersection) do
      viewer:addShape(point, deco.decoFail, nil, imageID)
    end
  else
    viewer:addShape(val.lineSegm4, deco.decoFail, nil, imageID)
    viewer:addShape(val.lineSegm5, deco.decoFail, nil, imageID)
    for _, point in ipairs(val.intersection) do
      viewer:addShape(point, deco.decoFail, nil, imageID)
    end
    overallResult = 'Fail'
  end

  -- Radius pass/fail
  if (val.radius < 23 and val.radius > 21) then
    viewer:addShape(val.foundCircle, deco.decoPass, nil, imageID)
    viewer:addShape(val.foundCircleCenter, deco.decoPass, nil, imageID)
  else
    viewer:addShape(val.foundCircle, deco.decoFail, nil, imageID)
    viewer:addShape(val.foundCircleCenter, deco.decoFail, nil, imageID)
    overallResult = 'Fail'
  end

  -- Overall pass/fail
  if overallResult == 'Pass' then
    viewer:addText('Pass', deco.textDeco, nil, imageID)
  else
    viewer:addText('Fail', deco.textDeco, nil, imageID)
  end
  viewer:present()
  print('Distance 1: ' .. val.distance1 .. ' Distance 2: ' .. val.distance2 ..
        ' Angle: ' .. val.angle .. ' Radius: ' .. val.radius .. ' Result: ' .. overallResult)
end

return passFailGraphics
