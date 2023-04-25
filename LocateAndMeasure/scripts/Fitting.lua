---@alias Features {circleCenter: Point, outerRadius: number, outerCircle: Shape, edgeRect1: Shape, edgeRect2: Shape, edgeRect3: Shape, edgeRect4: Shape, edgeRect5: Shape, angle1: number, angle2: number, angle3: number, angle4: number, angle5: number}
---@alias Fitted {foundCircle: Shape, edge1segm: Shape, line1: Shape, edge2segm: Shape, line2: Shape, edge3segm: Shape, line3: Shape, edge4segm: Shape, line4: Shape, edge5segm: Shape, line5: Shape}

local deco = require('GraphicsSetup')

---@type Image.ShapeFitter
local fitter

---Define shapes in teach object
---@param viewer View
---@return Features
local function defineFeatures(viewer)
  -- Common fitter object for all features
  fitter = Image.ShapeFitter.create()
  fitter:setProbeCount(25)

  -- Circle
  local circleCenter = Point.create(312, 307)
  local outerRadius = 40
  local outerCircle = Shape.createCircle(circleCenter, outerRadius)
  viewer:addShape(outerCircle, deco.decoRegion)
  viewer:addShape(circleCenter, deco.decoDot)

  -- Edge1 (left)
  local edgeCenter1 = Point.create(113, 260)
  local edgeRect1 = Shape.createRectangle(edgeCenter1, 40, 80, 0)
  local angle1 = 0
  viewer:addShape(edgeRect1, deco.decoRegion)

  -- Edge2 (right)
  local edgeCenter2 = Point.create(515, 260)
  local edgeRect2 = Shape.createRectangle(edgeCenter2, 40, 80, 0)
  local angle2 = math.pi -- pi rad = 180 deg
  viewer:addShape(edgeRect2, deco.decoRegion)

  -- Edge3 (bottom)
  local edgeCenter3 = Point.create(312, 396)
  local edgeRect3 = Shape.createRectangle(edgeCenter3, 250, 40, 0)
  local angle3 = -math.pi / 2 --  -pi/2 rad = -90 deg
  viewer:addShape(edgeRect3, deco.decoRegion)

  -- Edge4 (top left)
  local edgeCenter4 = Point.create(173, 172)
  local edgeRect4 = Shape.createRectangle(edgeCenter4, 70, 40, math.rad(-25))
  local angle4 = math.rad(90 - 25)
  viewer:addShape(edgeRect4, deco.decoRegion)

  -- Edge5 (top right)
  local edgeCenter5 = Point.create(450, 170)
  local edgeRect5 = Shape.createRectangle(edgeCenter5, 70, 40, math.rad(25))
  local angle5 = math.rad(-90 + 25)
  viewer:addShape(edgeRect5, deco.decoRegion)
  viewer:present()
  return {
    circleCenter = circleCenter,
    outerRadius = outerRadius,
    outerCircle = outerCircle,
    edgeRect1 = edgeRect1,
    edgeRect2 = edgeRect2,
    edgeRect3 = edgeRect3,
    edgeRect4 = edgeRect4,
    edgeRect5 = edgeRect5,
    angle1 = angle1,
    angle2 = angle2,
    angle3 = angle3,
    angle4 = angle4,
    angle5 = angle5
  }
end

--- Fitting features in image (both teach and live image)
---@param img Image
---@param viewer View
---@param features Features
---@return Fitted
local function fitFeatures(img, viewer, features)
  -- Fit circle
  local innerRadius = 10
  local foundCircle, _ = fitter:fitCircle(img, features.outerCircle, innerRadius)
  viewer:addShape(foundCircle, deco.decoFeature)
  viewer:addShape(foundCircle:getCenterOfGravity(), deco.decoDot)

  -- Fit edge1 (left)
  local edge1segm, _ = fitter:fitLine(img, features.edgeRect1:toPixelRegion(img), features.angle1)
  local line1 = edge1segm:toLine()
  viewer:addShape(edge1segm, deco.decoFeature)

  -- Fit edge2 (right)
  local edge2segm, _ = fitter:fitLine(img, features.edgeRect2:toPixelRegion(img), features.angle2)
  local line2 = edge2segm:toLine()
  viewer:addShape(edge2segm, deco.decoFeature)

  -- Fit edge3 (bottom)
  local edge3segm, _ = fitter:fitLine(img, features.edgeRect3:toPixelRegion(img), features.angle3)
  local line3 = edge3segm:toLine()
  viewer:addShape(edge3segm, deco.decoFeature)

  -- Fit edge4 (top left)
  local edge4segm, _ = fitter:fitLine(img, features.edgeRect4:toPixelRegion(img), features.angle4)
  local line4 = edge4segm:toLine()
  viewer:addShape(edge4segm, deco.decoFeature)

  -- Fit edge5 (top right)
  local edge5segm, _ = fitter:fitLine(img, features.edgeRect5:toPixelRegion(img), features.angle5)
  local line5 = edge5segm:toLine()
  viewer:addShape(edge5segm, deco.decoFeature)
  viewer:present()

  return {
    foundCircle = foundCircle,
    edge1segm = edge1segm,
    line1 = line1,
    edge2segm = edge2segm,
    line2 = line2,
    edge3segm = edge3segm,
    line3 = line3,
    edge4segm = edge4segm,
    line4 = line4,
    edge5segm = edge5segm,
    line5 = line5
  }
end

return {defineFeatures = defineFeatures, fitFeatures = fitFeatures}
