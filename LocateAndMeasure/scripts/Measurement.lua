---@alias MeasuredValues {radius: number, textPosRadius: Point, textPosDist1: Point, textPosDist2: Point, textPosIntersection: Point, textPosAngle: Point, distance1: number, distance2: number, distLine1: Shape, distLine2: Shape, angle: number, intersection: Point, endpoints4: Point[], endpoints5: Point[], lineSegm4: Shape, lineSegm5: Shape, foundCircle: Shape, foundCircleCenter: Point}

local deco = require('GraphicsSetup')

--- Measuring distance and radius
---@param viewer View
---@param fitted Fitted
---@param features Features
---@return MeasuredValues
local function measure(viewer, fitted, features)
  -- Radius
  local radius = math.floor(fitted.foundCircle:getRadius() * 10) / 10

  local textPosRadius = Point.create(features.circleCenter:getX() + features.outerRadius + 10,
                                     features.circleCenter:getY() - 13)
  deco.resultTextR:setPosition(textPosRadius:getX(), textPosRadius:getY())
  viewer:addText('r = ' .. radius, deco.resultTextR)

  -- Shortest edge-to-edge distance (orthogonal point-to-line)
  local midpoint = fitted.edge1segm:getCenterOfGravity()
  local closestPoint1 = fitted.line2:getClosestContourPoint(midpoint)
  local distance1 = math.floor(midpoint:getDistance(closestPoint1) * 10) / 10
  local distLine1 = Shape.createLineSegment(midpoint, closestPoint1)

  viewer:addShape(distLine1, deco.decoPass)
  local textPosDist1 = Point.create(247, 230)
  deco.resultTextD1:setPosition(textPosDist1:getX(), textPosDist1:getY())
  viewer:addText('d1 = ' .. distance1, deco.resultTextD1)

  -- Circle center to bottom line distance (orthogonal point-to-line)
  local foundCircleCenter = fitted.foundCircle:getCenterOfGravity()
  local closestPoint2 = fitted.line3:getClosestContourPoint(foundCircleCenter)
  local distance2 = math.floor(foundCircleCenter:getDistance(closestPoint2) * 10) / 10
  local distLine2 = Shape.createLineSegment(foundCircleCenter, closestPoint2)

  viewer:addShape(distLine2, deco.decoPass)
  local textPosDist2 = Point.create(330, 350)
  deco.resultTextD2:setPosition(textPosDist2:getX(), textPosDist2:getY())
  viewer:addText('d2 = ' .. distance2, deco.resultTextD2)

  -- Angle
  local angle = fitted.line4:getIntersectionAngle(fitted.line5)
  local intersection = fitted.line4:getIntersectionPoints(fitted.line5)
  local endpoints4 = fitted.edge4segm:getContourPoints()
  local endpoints5 = fitted.edge5segm:getContourPoints()
  local lineSegm4 = Shape.createLineSegment(endpoints4[1], intersection[1])
  local lineSegm5 = Shape.createLineSegment(endpoints5[1], intersection[1])

  viewer:addShape(lineSegm4, deco.decoPass)
  viewer:addShape(lineSegm5, deco.decoPass)
  viewer:addShape(intersection, deco.decoDot)
  local textPosAngle = Point.create(255, 133)
  deco.resultTextA:setPosition(textPosAngle:getX(), textPosAngle:getY())
  viewer:addText('a = ' .. (180 - math.floor(10 * math.deg(angle)) / 10),
                 deco.resultTextA)

  -- Intersection
  local x = math.floor(intersection[1]:getX() * 10) / 10
  local y = math.floor(intersection[1]:getY() * 10) / 10

  local textPosIntersection = Point.create(285, 75)
  deco.resultTextI:setPosition(textPosIntersection:getX(), textPosIntersection:getY())
  viewer:addText('(x,y) = ' .. x .. ',' .. y, deco.resultTextI)
  viewer:present()

  return {
    radius = radius,
    textPosRadius = textPosRadius,
    textPosDist1 = textPosDist1,
    textPosDist2 = textPosDist2,
    textPosIntersection = textPosIntersection,
    textPosAngle = textPosAngle,
    distance1 = distance1,
    distance2 = distance2,
    distLine1 = distLine1,
    distLine2 = distLine2,
    angle = angle,
    intersection = intersection,
    endpoints4 = endpoints4,
    endpoints5 = endpoints5,
    lineSegm4 = lineSegm4,
    lineSegm5 = lineSegm5,
    foundCircle = fitted.foundCircle,
    foundCircleCenter = foundCircleCenter
  }
end

return measure
