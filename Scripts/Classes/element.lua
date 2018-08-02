local class = require("third-party/middleclass")

local element = class("element")

--This is a class for one element in the toolbar. For example a slider.

function element:initialize()

  self.label = "Slider"
  self.x = 200
  self.y = 100
  self.canvas = love.graphics.newCanvas(self.x, self.y)

  self.initial_value = 50
  self.min_value = 1
  self.max_value = 100
  self.slider_length = 150

end

return element
