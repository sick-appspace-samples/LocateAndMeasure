-- Setup text attributes
textDeco = View.TextDecoration.create()  -- Large text, top left corner
textDeco:setSize(40)
textDeco:setPosition(20, 40)

resultTextSize = 20

resultTextD1 = View.TextDecoration.create()  -- Distance 1 result overlay
resultTextD1:setSize(resultTextSize)

resultTextD2 = View.TextDecoration.create() -- Distance 2 result overlay
resultTextD2:setSize(resultTextSize)

resultTextR = View.TextDecoration.create()  -- Radius result overlay
resultTextR:setSize(resultTextSize)

resultTextA = View.TextDecoration.create()  -- Angle result overlay
resultTextA:setSize(resultTextSize)

resultTextI = View.TextDecoration.create()  -- Intersection overlay
resultTextI:setSize(resultTextSize)

-- Setup of shape decorations
decoTeach = View.ShapeDecoration.create()
decoTeach:setPointSize(5)
decoTeach:setLineColor(0, 0, 230) -- Blue color scheme for "Teach" mode
decoTeach:setPointType("DOT")
decoTeach:setLineWidth(3)

decoRegion = View.ShapeDecoration.create()
decoRegion:setLineColor(230, 230, 0)     -- Yellow
decoRegion:setLineWidth(3)

decoFeature = View.ShapeDecoration.create()
decoFeature:setLineColor(75, 75, 255)    -- Blue
decoFeature:setLineWidth(4)

decoDot = View.ShapeDecoration.create()
decoDot:setLineColor(0, 230, 0)          -- Red
decoDot:setPointType("DOT")
decoDot:setPointSize(10)

decoPass = View.ShapeDecoration.create()
decoPass:setPointSize(5)
decoPass:setLineColor(0, 230, 0) -- Green color scheme for "Pass" mode
decoPass:setPointType("DOT")
decoPass:setLineWidth(3)

decoFail = View.ShapeDecoration.create()
decoFail:setPointSize(5)
decoFail:setLineColor(230, 0, 0) -- Red color scheme for "Fail" results
decoFail:setPointType("DOT")
decoFail:setLineWidth(3)