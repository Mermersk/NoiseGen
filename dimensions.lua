--Dimensions class for the dimension popup

local class = require("middleclass")

local Dimensions = class("Dimensions")

function Dimensions:initialize()

  self.canvas_width = 300
  self.canvas_height = 50

  self.info_text_x = 10
  self.info_text_y = 5

  self.w_text_x = 10
  self.w_text_y = 25
  self.w_input_box_x = self.w_text_x + 45 --Inputbox for the widht of the image, w = width
  self.w_input_box_y = self.w_text_y
  self.w_input_box_widht = 40
  self.w_input_box_height = 15

  self.h_text_x = 100
  self.h_text_y = 25
  self.h_input_box_x = self.h_text_x + 55 --Inputbox for the height of the image, h = heigth
  self.h_input_box_y = self.h_text_y
  self.h_input_box_widht = 40
  self.h_input_box_height = 15

  self.save_button_text_x = 250
  self.save_button_text_y = 25
  self.save_color = {0, 0.75, 0, 1}
  self.save_button_x = self.save_button_text_x - 10
  self.save_button_y = self.save_button_text_y - 5
  self.save_button_width = 50
  self.save_button_height = 25

  self.active = false

  self.w_box_active = false --The widht input box boolean
  self.h_box_active = false --The height input box boolean

  self.canvas = love.graphics.newCanvas(canvas_width, canvas_height)

end

function Dimensions:setActive(boolean)
  self.active = boolean
end

function Dimensions:getActive()
  return self.active
end

function Dimensions:setWBoxActive(boolean)
  self.w_box_active = boolean
end

function Dimensions:setHBoxActive(boolean)
  self.h_box_active = boolean
end

function Dimensions:getWBoxActive()
  return self.w_box_active
end

function Dimensions:getHBoxActive()
  return self.h_box_active
end

function Dimensions:print()
  return self.canvas_width
end

function Dimensions:draw(x, y)

  if self.active == true then
    love.graphics.setCanvas(self.canvas)
      love.graphics.setColor(0, 0, 0.5, 1)
      love.graphics.rectangle("fill", 0, 0, self.canvas_width, self.canvas_height)
      love.graphics.setColor(1, 1, 1, 1)

      love.graphics.print("Input new Dimensions for your image:", self.info_text_x, self.info_text_y)

      love.graphics.print("Width: ", self.w_text_x, self.w_text_y)
      love.graphics.rectangle("line", self.w_input_box_x, self.w_input_box_y, self.w_input_box_widht, self.w_input_box_height)

      love.graphics.print("Height: ", self.h_text_x, self.h_text_y)
      love.graphics.rectangle("line", self.h_input_box_x, self.h_input_box_y, self.h_input_box_widht, self.h_input_box_height)

      love.graphics.setColor(self.save_color)
      love.graphics.rectangle("fill", self.save_button_x, self.save_button_y, self.save_button_width, self.save_button_height)
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.print("Save", self.save_button_text_x, self.save_button_text_y)

    love.graphics.setCanvas()


    love.graphics.draw(self.canvas, x, y)
  end



end

return Dimensions --To have the class in seperate files we return the object at the bottom, then you only have to
                  -- do "local Dimensions = require("dimensions")" at the top of where you want to call this class in some other file like main.lua
