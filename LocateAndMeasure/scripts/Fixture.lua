---@alias Fixture {outerCircle: Shape, edgeRect1: Shape, edgeRect2: Shape, edgeRect3: Shape, edgeRect4: Shape, edgeRect5: Shape, angle1: number, angle2: number, angle3: number, angle4: number, angle5: number, textPosRadius: Point, textPosDist1: Point, textPosDist2: Point, textPosIntersection: Point, textPosAngle: Point}

---@type Image.Fixture
local fixt

---Defining fixture for automatic pose adjustment
---@param pose Pose
---@param features Features
---@param positions MeasuredValues
local function setFixture(pose, features, positions)
  fixt = Image.Fixture.create()
  fixt:setReferencePose(pose.teachPose)
  fixt:appendShape('outerCircle', features.outerCircle)
  fixt:appendShape('edgeRect1', features.edgeRect1)
  fixt:appendShape('edgeRect2', features.edgeRect2)
  fixt:appendShape('edgeRect3', features.edgeRect3)
  fixt:appendShape('edgeRect4', features.edgeRect4)
  fixt:appendShape('edgeRect5', features.edgeRect5)
  fixt:appendAngle('angle1', features.angle1)
  fixt:appendAngle('angle2', features.angle2)
  fixt:appendAngle('angle3', features.angle3)
  fixt:appendAngle('angle4', features.angle4)
  fixt:appendAngle('angle5', features.angle5)
  fixt:appendPoint('textPosRadius', positions.textPosRadius)
  fixt:appendPoint('textPosDist1', positions.textPosDist1)
  fixt:appendPoint('textPosDist2', positions.textPosDist2)
  fixt:appendPoint('textPosIntersection', positions.textPosIntersection)
  fixt:appendPoint('textPosAngle', positions.textPosAngle)
end

---Retrieving the pose-transformed shapes, angles and points
---@param matchPoses {poses: Transform[]}
---@return Fixture
local function getFixture(matchPoses)
  fixt:transform(matchPoses.poses[1])
  local outerCircle = fixt:getShape('outerCircle')
  local edgeRect1 = fixt:getShape('edgeRect1')
  local edgeRect2 = fixt:getShape('edgeRect2')
  local edgeRect3 = fixt:getShape('edgeRect3')
  local edgeRect4 = fixt:getShape('edgeRect4')
  local edgeRect5 = fixt:getShape('edgeRect5')
  local angle1 = fixt:getAngle('angle1')
  local angle2 = fixt:getAngle('angle2')
  local angle3 = fixt:getAngle('angle3')
  local angle4 = fixt:getAngle('angle4')
  local angle5 = fixt:getAngle('angle5')
  local textPosRadius = fixt:getPoint('textPosRadius')
  local textPosDist1 = fixt:getPoint('textPosDist1')
  local textPosDist2 = fixt:getPoint('textPosDist2')
  local textPosIntersection = fixt:getPoint('textPosIntersection')
  local textPosAngle = fixt:getPoint('textPosAngle')
  return {
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
    angle5 = angle5,
    textPosRadius = textPosRadius,
    textPosDist1 = textPosDist1,
    textPosDist2 = textPosDist2,
    textPosIntersection = textPosIntersection,
    textPosAngle = textPosAngle
  }
end

return {
  setFixture = setFixture,
  getFixture = getFixture
}
