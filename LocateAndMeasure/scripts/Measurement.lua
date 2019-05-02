-- Measuring distance and radius
--@measure(imageID:string)
function measure(imageID)
  -- Radius
  radius = math.floor(foundCircle:getRadius()*10)/10
  
  textPosRadius = Point.create(circleCenter:getX()+outerRadius+10, circleCenter:getY()-13)
  resultTextR:setPosition(textPosRadius:getX(), textPosRadius:getY())
  viewer:addText("r = "..radius, resultTextR, nil, imageID)

  -- Shortest edge-to-edge distance (orthogonal point-to-line)
  midpoint = edge1segm:getCenterOfGravity()
  closestPoint1 = line2:getClosestContourPoint(midpoint)
  distance1 = math.floor(midpoint:getDistance(closestPoint1)*10)/10
  distLine1 = Shape.createLineSegment(midpoint,closestPoint1)
  
  viewer:addShape(distLine1, decoPass, nil, imageID)
  textPosDist1 = Point.create(247,230)
  resultTextD1:setPosition(textPosDist1:getX(), textPosDist1:getY())
  viewer:addText("d1 = "..distance1, resultTextD1, nil, imageID)
  
  -- Circle center to bottom line distance (orthogonal point-to-line)
  foundCircleCenter = foundCircle:getCenterOfGravity()
  closestPoint2 = line3:getClosestContourPoint(foundCircleCenter)
  distance2 = math.floor(foundCircleCenter:getDistance(closestPoint2)*10)/10
  distLine2 = Shape.createLineSegment(foundCircleCenter, closestPoint2)
  
  viewer:addShape(distLine2, decoPass, nil, imageID)
  textPosDist2 = Point.create(330, 350)
  resultTextD2:setPosition(textPosDist2:getX(), textPosDist2:getY())
  viewer:addText("d2 = "..distance2, resultTextD2, nil, imageID)

  -- Angle
  angle = line4:getIntersectionAngle(line5)
  intersection = line4:getIntersectionPoints(line5)
  endpoints4 = edge4segm:getContourPoints()
  endpoints5 = edge5segm:getContourPoints()
  lineSegm4 = Shape.createLineSegment(endpoints4[1],intersection[1])
  lineSegm5 = Shape.createLineSegment(endpoints5[1],intersection[1])
  
  viewer:addShape(lineSegm4, decoPass, nil, imageID)
  viewer:addShape(lineSegm5, decoPass, nil, imageID)
  for _, point in ipairs(intersection) do
    viewer:addShape(point, decoDot, nil, imageID)
  end
  textPosAngle = Point.create(255, 133)
  resultTextA:setPosition(textPosAngle:getX(), textPosAngle:getY())
  viewer:addText("a = "..(180-math.floor(10*math.deg(angle))/10), resultTextA, nil, imageID)
  
  -- Intersection
  x = math.floor(intersection[1]:getX()*10)/10
  y = math.floor(intersection[1]:getY()*10)/10
  
  textPosIntersection = Point.create(285,75)
  resultTextI:setPosition(textPosIntersection:getX(),textPosIntersection:getY())
  viewer:addText("(x,y) = "..x..","..y, resultTextI, nil, imageID)
  viewer:present()
end
  
 
