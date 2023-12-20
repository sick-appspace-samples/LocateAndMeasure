-- Setup text attributes
local textDeco = View.TextDecoration.create() -- Large text, top left corner
textDeco:setSize(40):setPosition(20, 40)

local resultTextSize = 20

local resultTextD1 = View.TextDecoration.create() -- Distance 1 result overlay
resultTextD1:setSize(resultTextSize)

local resultTextD2 = View.TextDecoration.create() -- Distance 2 result overlay
resultTextD2:setSize(resultTextSize)

local resultTextR = View.TextDecoration.create() -- Radius result overlay
resultTextR:setSize(resultTextSize)

local resultTextA = View.TextDecoration.create() -- Angle result overlay
resultTextA:setSize(resultTextSize)

local resultTextI = View.TextDecoration.create() -- Intersection overlay
resultTextI:setSize(resultTextSize)

-- Setup of shape decorations
local decoTeach = View.ShapeDecoration.create():setPointSize(5):setLineWidth(3)
decoTeach:setPointType('DOT'):setLineColor(0, 0, 230) -- Blue color scheme for "Teach" mode

local decoRegion = View.ShapeDecoration.create():setLineWidth(3)
decoRegion:setLineColor(230, 230, 0) -- Yellow

local decoFeature = View.ShapeDecoration.create():setLineWidth(4)
decoFeature:setLineColor(75, 75, 255) -- Blue

local decoDot = View.ShapeDecoration.create():setPointSize(10)
decoDot:setPointType('DOT'):setLineColor(0, 230, 0) -- Red

local decoPass = View.ShapeDecoration.create():setLineWidth(3)
decoPass:setPointSize(5):setLineColor(0, 230, 0) -- Green color scheme for "Pass" mode
decoPass:setPointType('DOT')

local decoFail = View.ShapeDecoration.create():setLineWidth(3)
decoFail:setPointSize(5):setLineColor(230, 0, 0) -- Red color scheme for "Fail" results
decoFail:setPointType('DOT')

return {
  textDeco = textDeco,
  resultTextSize = resultTextSize,
  resultTextD1 = resultTextD1,
  resultTextD2 = resultTextD2,
  resultTextR = resultTextR,
  resultTextA = resultTextA,
  resultTextI = resultTextI,
  decoTeach = decoTeach,
  decoRegion = decoRegion,
  decoFeature = decoFeature,
  decoDot = decoDot,
  decoPass = decoPass,
  decoFail = decoFail
}
