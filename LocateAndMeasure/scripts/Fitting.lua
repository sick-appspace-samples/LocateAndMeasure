-- Define shapes in teach object
function defineFeatures(imageID)
  -- Common fitter object for all features
  fitter = Image.ShapeFitter.create()
  fitter:setProbeCount(25)
  
  -- Circle
  circleCenter = Point.create(312, 307)
  outerRadius = 40
  outerCircle = Shape.createCircle(circleCenter, outerRadius)
  innerRadius = 10
  viewer:addShape(outerCircle, decoRegion, nil, imageID)
  viewer:addShape(circleCenter, decoDot, nil, imageID)

  -- Edge1 (left)
  edgeCenter1 = Point.create(113, 260)
  edgeRect1 = Shape.createRectangle(edgeCenter1, 40, 80, 0)
  angle1 = 0
  viewer:addShape(edgeRect1, decoRegion, nil, imageID)

  -- Edge2 (right)
  edgeCenter2 = Point.create(515, 260)
  edgeRect2 = Shape.createRectangle(edgeCenter2, 40, 80, 0)
  angle2 = math.pi  -- pi rad = 180 deg
  viewer:addShape(edgeRect2, decoRegion, nil, imageID)
  
  -- Edge3 (bottom)
  edgeCenter3 = Point.create(312, 396)
  edgeRect3 = Shape.createRectangle(edgeCenter3, 250, 40, 0)
  angle3 = -math.pi/2    --  -pi/2 rad = -90 deg
  viewer:addShape(edgeRect3, decoRegion, nil, imageID)
  
  -- Edge4 (top left)
  edgeCenter4 = Point.create(173, 172)
  edgeRect4 = Shape.createRectangle(edgeCenter4, 70, 40, math.rad(-25))
  angle4 = math.rad(90-25)
  viewer:addShape(edgeRect4, decoRegion, nil, imageID)
    
  -- Edge5 (top right)
  edgeCenter5 = Point.create(450, 170)
  edgeRect5 = Shape.createRectangle(edgeCenter5, 70, 40, math.rad(25))
  angle5 = math.rad(-90+25)
  viewer:addShape(edgeRect5, decoRegion, nil, imageID)
  viewer:present()
end

-- Fitting features in image (both teach and live image)
--@fitFeatures(img:Image, imageID:string)
function fitFeatures(img, imageID)
-- Fit circle
  foundCircle, quality = fitter:fitCircle(img, outerCircle, innerRadius)
  viewer:addShape(foundCircle, decoFeature, nil, imageID)
  viewer:addShape(foundCircle:getCenterOfGravity(), decoDot, nil, imageID)

  -- Fit edge1 (left)
  edge1segm, quality1 = fitter:fitLine(img,edgeRect1:toPixelRegion(img), angle1)
  line1 = edge1segm:toLine()
  viewer:addShape(edge1segm, decoFeature, nil, imageID)
   
  -- Fit edge2 (right)
  edge2segm, quality2 = fitter:fitLine(img,edgeRect2:toPixelRegion(img), angle2)
  line2 = edge2segm:toLine()
  viewer:addShape(edge2segm, decoFeature, nil, imageID)
   
  -- Fit edge3 (bottom)
  edge3segm, quality3 = fitter:fitLine(img,edgeRect3:toPixelRegion(img), angle3)
  line3 = edge3segm:toLine()
  viewer:addShape(edge3segm, decoFeature, nil, imageID)
 
  -- Fit edge4 (top left)
  edge4segm, quality4 = fitter:fitLine(img,edgeRect4:toPixelRegion(img), angle4)
  line4 = edge4segm:toLine()
  viewer:addShape(edge4segm, decoFeature, nil, imageID)
   
  -- Fit edge5 (top right)
  edge5segm, quality5 = fitter:fitLine(img, edgeRect5:toPixelRegion(img), angle5)
  line5 = edge5segm:toLine()
  viewer:addShape(edge5segm, decoFeature, nil, imageID)
  viewer:present()
end