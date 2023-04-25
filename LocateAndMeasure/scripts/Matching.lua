---@alias Pose {teachPose: Transform, modelPoints: Point[]}

local deco = require('GraphicsSetup')

local matcher

--- Teach the shape of the object
---@param refImage Image
---@param viewer View
---@return Pose
local function teachShape(refImage, viewer)
  -- Adding "Reference" text overlay
  viewer:addText('Reference', deco.textDeco)

  -- Defining teach region
  local teachRectCenter = Point.create(310, 100)
  local teachRect = Shape.createRectangle(teachRectCenter, 170, 125, 0)
  local teachRegion = teachRect:toPixelRegion(refImage)
  viewer:addShape(teachRect, deco.decoRegion)

  -- Teaching edge matcher
  matcher = Image.Matching.EdgeMatcher.create()
  matcher:setEdgeThreshold(50)
  local wantedDownsampleFactor = 2
  -- Check if wanted downsample factor is supported by device
  minDsf,_ = matcher:getDownsampleFactorLimits(refImage)
  if (minDsf > wantedDownsampleFactor) then
    print("Cannot use downsample factor " .. wantedDownsampleFactor .. " will use " .. minDsf .. " instead") 
    wantedDownsampleFactor = minDsf
  end
  matcher:setDownsampleFactor(wantedDownsampleFactor)

  local teachPose = matcher:teach(refImage, teachRegion)

  -- Show model points overlayed over teach image
  local modelPoints = matcher:getEdgePoints() -- Model points in model's local coord syst
  local teachPoints = Point.transform(modelPoints, teachPose)
  viewer:addShape(teachPoints, deco.decoTeach)
  viewer:present()

  return {
    teachPose = teachPose,
    modelPoints = modelPoints
  }
end

--- Match the shape of the object
---@param refImage Image
---@param viewer View
---@param pose Pose
---@return {poses: Transform[]}
local function matchShape(refImage, viewer, pose)
  local poses, _ = matcher:match(refImage)

  -- Show model points as overlay
  local livePoints = Point.transform(pose.modelPoints, poses[1])
  viewer:addShape(livePoints, deco.decoFeature)
  return {
    poses = poses
  }
end

return {teach = teachShape, match = matchShape}
