-- Add overlays, color schemes depending on result
--@passFailGraphics(imageID:string)
function passFailGraphics(imageID)
  overallResult = "Pass" -- Default until some tolerance isn't fulfilled
  resultDeco = decoPass  -- Default

  -- Distance 1 pass/fail
  if (distance1<405 and distance1>402) then
    viewer:addShape(distLine1, decoPass, nil, imageID)
    else
    viewer:addShape(distLine1, decoFail, nil, imageID)
    overallResult = "Fail"
  end
  
  -- Distance 2 pass/fail
  if (distance2<89 and distance2>85) then
    viewer:addShape(distLine2, decoPass, nil, imageID)
    else
    viewer:addShape(distLine2, decoFail, nil, imageID)
    overallResult = "Fail"
  end
  
  -- Angle pass/fail
  if ((180-math.deg(angle)<133) and (180-math.deg(angle)>130)) then
    viewer:addShape(lineSegm4, decoPass, nil, imageID)
    viewer:addShape(lineSegm5, decoPass, nil, imageID)
    for _, point in ipairs(intersection) do
      viewer:addShape(point, decoFail, nil, imageID)
    end
    else
    viewer:addShape(lineSegm4, decoFail, nil, imageID)
    viewer:addShape(lineSegm5, decoFail, nil, imageID)
    for _, point in ipairs(intersection) do
      viewer:addShape(point, decoFail, nil, imageID)
    end
    overallResult = "Fail"
  end
  
  -- Radius pass/fail
  if (radius<23 and radius>21) then
    viewer:addShape(foundCircle, decoPass, nil, imageID)
    viewer:addShape(foundCircleCenter, decoPass, nil, imageID)
    else
    viewer:addShape(foundCircle, decoFail, nil, imageID)
    viewer:addShape(foundCircleCenter, decoFail, nil, imageID)
    overallResult = "Fail"
  end  
  
  -- Overall pass/fail
  if overallResult == "Pass" then
    viewer:addText("Pass", textDeco, nil, imageID)
    else
    viewer:addText("Fail", textDeco, nil, imageID)
  end 
  viewer:present()
  print("Distance 1: " .. distance1 .. " Distance 2: " .. distance2 ..
        " Angle: " .. angle .. " Radius: " .. radius .. " Result: " .. overallResult)
end