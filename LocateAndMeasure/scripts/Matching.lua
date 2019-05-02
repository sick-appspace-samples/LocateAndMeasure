-- Teach the shape of the object
--@teachShape(refImage:Image, imageID:string)
function teachShape(refImage, imageID)
  -- Adding "Reference" text overlay
  viewer:addText("Reference", textDeco, nil, imageID)
  
  -- Defining teach region
  local teachRectCenter = Point.create(310,100)
  local teachRect = Shape.createRectangle(teachRectCenter, 170, 125, 0)
  local teachRegion = teachRect:toPixelRegion(refImage)
  viewer:addShape(teachRect, decoRegion, nil, imageID)
  
  -- Teaching edge matcher
  matcher = Image.Matching.EdgeMatcher.create()
  matcher:setEdgeThreshold(50)
  matcher:setDownsampleFactor(2)
  teachPose = matcher:teach(refImage, teachRegion)
  
  -- Show model points overlayed over teach image
  modelPoints = matcher:getEdgePoints()   -- Model points in model's local coord syst
  teachPoints = Point.transform(modelPoints, teachPose)
  for _, point in ipairs(teachPoints) do
    viewer:addShape(point, decoTeach, nil, imageID)
  end
  viewer:present()
end

-- Match the shape of the object
--@matchShape(refImage:Image, imageID:string)
function matchShape(refImage, imageID)
  poses, scores = matcher:match(refImage)
  
  -- Show model points as overlay
  livePoints = Point.transform(modelPoints, poses[1]) 
  for _, point in ipairs(livePoints) do
    viewer:addShape(point, decoFeature, nil, imageID)
  end
end