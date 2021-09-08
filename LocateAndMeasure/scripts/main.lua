
--Start of Global Scope---------------------------------------------------------

print('AppEngine Version: ' .. Engine.getVersion())

local DELAY = 2000 -- ms between visualization steps for demonstration purpose

-- Creating global viewer
local v = View.create("viewer2D1")

-- Loading necessary Scripts
require('GraphicsSetup')                     -- Setup of graphical overlay attributes
local matching = require('Matching')         -- Functions for teaching and matching object shape
local featuresFunc = require('Fitting')      -- Functions for feature fitting
local measure = require('Measurement')       -- Functions for measuring
local fixture = require('Fixture')           -- Functions for pose-adjustment of regions in live images
local passFailGraphics = require('PassFail') -- Functions for pass fail result handling, e.g. graphics

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

local function main()
  -- Teaching
  local refImage = Image.load('resources/Teach.bmp')
  v:clear()
  local imageID = v:addImage(refImage)
  v:present()

  local teachPose = matching.teach(refImage, imageID, v)
  local features = featuresFunc.defineFeatures(imageID, v)
  local fitted = featuresFunc.fitFeatures(refImage, imageID, v, features)
  local positions = measure(imageID, v, fitted, features)
  fixture.setFixture(teachPose, features, positions)

  Script.sleep(DELAY) -- for demonstration purpose only

  -- Live
  for i = 1, 3 do
    local liveImage = Image.load('resources/' .. i .. '.bmp')
    v:clear()
    imageID = v:addImage(liveImage)
    v:present()

    local matchPose = matching.match(liveImage, imageID, v, teachPose)
    local fixt = fixture.getFixture(matchPose)
    fitted = featuresFunc.fitFeatures(liveImage, imageID, v, fixt)
    local measuredValues = measure(imageID, v, fitted, features)
    passFailGraphics(imageID, v, measuredValues)

    Script.sleep(DELAY) -- for demonstration purpose only
  end

  print('App finished.')
end
--The following registration is part of the global scope which runs once after startup
--Registration of the 'main' function to the 'Engine.OnStarted' event
Script.register('Engine.OnStarted', main)

--End of Function and Event Scope-----------------
