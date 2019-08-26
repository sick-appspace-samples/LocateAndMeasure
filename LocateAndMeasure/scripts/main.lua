--[[----------------------------------------------------------------------------

  Application Name:
  LocateAndMeasure
                                                                                             
  Summary:
  Measuring part dimensions, independent on rotation and translation
  
  Description:
  Teaching the shape of a ”golden part”, measuring edge-to-edge distance,
  circle radius etc. Matching new, identical objects with full rotation
  in the image and measuring the same dimensions.
  
  How to Run:
  Starting this sample is possible either by running the app (F5) or
  debugging (F7+F10). Setting breakpoint on the first row inside the 'main'
  function allows debugging step-by-step after 'Engine.OnStarted' event.
  Results can be seen in the image viewer on the DevicePage.
  Restarting the Sample may be necessary to show images after loading the webpage.
  To run this Sample a device with SICK Algorithm API and AppEngine >= V2.5.0 is
  required. For example SIM4000 with latest firmware. Alternatively the Emulator
  in AppStudio 2.3 or higher can be used.
       
  More Information:
  Tutorial "Algorithms - Fitting and Measurement".

------------------------------------------------------------------------------]]
--Start of Global Scope---------------------------------------------------------

print('AppEngine Version: ' .. Engine.getVersion())

local DELAY = 2000 -- ms between visualization steps for demonstration purpose

-- Creating global v
local v = View.create()

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
