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

print("AppEngine Version: ".. Engine.getVersion())

DELAY = 2000    -- ms between visualization steps for demonstration purpose

-- Creating global viewer
viewer = View.create()
viewer:setID("viewer2D")

-- Loading necessary Scripts
require("GraphicsSetup") -- Setup of graphical overlay attributes
require("Matching")      -- Functions for teaching and matching object shape
require("Fitting")       -- Functions for feature fitting
require("Measurement")   -- Functions for measuring
require("Fixture")       -- Functions for pose-adjustment of regions in live images
require("PassFail")      -- Functions for pass fail result handling, e.g. graphics

--End of Global Scope----------------------------------------------------------- 


--Start of Function and Event Scope---------------------------------------------

function main()
  -- Teaching
  local refImage = Image.load("resources/Teach.bmp")
  viewer:clear()
  local imageID = viewer:addImage(refImage)
  viewer:present()
  
  teachShape(refImage, imageID)
  defineFeatures(imageID)
  fitFeatures(refImage, imageID)
  measure(imageID)
  setFixture()
  
  Script.sleep(DELAY) -- for demonstration purpose only
  
  -- Live
  for i = 1, 3 do
    liveImage = Image.load("resources/"..i..".bmp")
    viewer:clear()
    local imageID = viewer:addImage(liveImage)
    viewer:present()
    
    matchShape(liveImage, imageID)
    getFixture()
    fitFeatures(liveImage, imageID)
    measure(imageID)
    passFailGraphics(imageID)
    
    Script.sleep(DELAY) -- for demonstration purpose only
  end
  
  print("App finished.")
end
--The following registration is part of the global scope which runs once after startup
--Registration of the 'main' function to the 'Engine.OnStarted' event 
Script.register("Engine.OnStarted", main)

--End of Function and Event Scope-----------------