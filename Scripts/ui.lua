
--require("dimensions")
--class = require("middleclass")
--Dimensions = class("Dimensions")
local dimensions = require("Scripts/Classes/dimensions") --Loads in the Dimensions class and creates object Dimensions wich we initalize in love.load()

function uiLoad()

  Dimensions = dimensions:new()

  local octaves_s_x = 1300 --X-positon
  local octaves_s_y = 50 --Y-position
  local octaves_s_initial_value = 50 --Initial value for the sliders
  local octaves_s_min = 1 --Minimun value for sliders
  local octaves_s_max = 100 --Maximum value for slider

  local lacunarity_s_x = 1300 --X-positon
  local lacunarity_s_y = 100 --Y-position
  local lacunarity_s_initial_value = 0.5 --Initial value for the sliders
  local lacunarity_s_min = 0 --Minimun value for sliders
  local lacunarity_s_max = 5 --Maximum value for slider

  local persistance_s_x = 1300 --X-positon
  local persistance_s_y = 150 --Y-position
  local persistance_s_initial_value = 0.5 --Initial value for the sliders
  local persistance_s_min = 0 --Minimun value for sliders
  local persistance_s_max = 1 --Maximum value for slider

  local seed_s_x = 1300 --X-positon
  local seed_s_y = 200 --Y-position
  local seed_s_initial_value = 100 --Initial value for the sliders
  local seed_s_min = 1 --Minimun value for sliders
  local seed_s_max = 200 --Maximum value for slider

  local frequency_s_x = 1300 --X-positon
  local frequency_s_y = 250 --Y-position
  local frequency_s_initial_value = 0.5 --Initial value for the sliders
  local frequency_s_min = 0 --Minimun value for sliders
  local frequency_s_max = 1 --Maximum value for slider

  local sliders_length = 150 --Lenght of sliders(in pixels), All sliders have same length!

  octaves_s = newSlider(octaves_s_x, octaves_s_y, sliders_length, octaves_s_initial_value, octaves_s_min, octaves_s_max)
	lacunarity_s = newSlider(lacunarity_s_x, lacunarity_s_y, sliders_length, lacunarity_s_initial_value, lacunarity_s_min, lacunarity_s_max)
	persistence_s = newSlider(persistance_s_x, persistance_s_y, sliders_length, persistance_s_initial_value, persistance_s_min, persistance_s_max)
	seed_s = newSlider(seed_s_x, seed_s_y, sliders_length, seed_s_initial_value, seed_s_min, seed_s_max)
	frequency_s = newSlider(frequency_s_x, frequency_s_y, sliders_length, frequency_s_initial_value, frequency_s_min, frequency_s_max)

  local rgb_s_values = {}
  local y_increment = 300
  for i = 1, 4 do
    table.insert(rgb_s_values, {x = 1300, y = y_increment, s_length = 150, initial_value = 1, min = 0, max = 1})
    y_increment = y_increment + 50 --Each slider is 50 pixels down from the prevoius
  end

	r_s = newSlider(rgb_s_values[1].x, rgb_s_values[1].y, rgb_s_values[1].s_length, rgb_s_values[1].initial_value, rgb_s_values[1].min, rgb_s_values[1].max) --RGBA inputs
	g_s = newSlider(rgb_s_values[2].x, rgb_s_values[2].y, rgb_s_values[2].s_length, rgb_s_values[2].initial_value, rgb_s_values[2].min, rgb_s_values[2].max)
	b_s = newSlider(rgb_s_values[3].x, rgb_s_values[3].y, rgb_s_values[3].s_length, rgb_s_values[3].initial_value, rgb_s_values[3].min, rgb_s_values[3].max)
	a_s = newSlider(rgb_s_values[4].x, rgb_s_values[4].y, rgb_s_values[4].s_length, rgb_s_values[4].initial_value, rgb_s_values[4].min, rgb_s_values[4].max)

  noise_types = {"Fractal", "Billow", "Ridged Multi"}
  noise_selector_index = 1;
  noise_selected = noise_types[noise_selector_index]
  noise = modules.Fractal:new()

  include_alpha = false

  msg = ""

  c_x = 900 --Canvas x for the savePopUp
  c_y = 55

  save = false

  save_button_x = 1220
  save_button_y = 575
  save_button_width = 50
  save_button_height = 25

  dimensions_button_x = 1285
  dimensions_button_y = 575
  dimensions_button_width = 90
  dimensions_button_height = 25

  dimensions = false

  dimension_widht = ""
  dimension_height = ""

  Dimensions:initialize()

  dimensions_canvas_x = 900 --x, y of the dimension Panel-popup
  dimensions_canvas_y = 5

  i_beam_cursor = love.mouse.getSystemCursor("ibeam")

end

function uiUpdate(dt)

  	octaves_s:update()
  	lacunarity_s:update()
  	persistence_s:update()
  	seed_s:update()
  	frequency_s:update()

  	r_s:update()
  	g_s:update()
  	b_s:update()
  	a_s:update()

  	r = r_s:getValue()
  	g = g_s:getValue()
  	b = b_s:getValue()
  	a = a_s:getValue()

  	octaves = octaves_s:getValue()
  	lacunarity = lacunarity_s:getValue()
  	persistence = persistence_s:getValue()
  	seed = seed_s:getValue()
  	frequency = frequency_s:getValue()

    mx, my = love.mouse.getPosition()

    if (mx > Dimensions.w_input_box_x + dimensions_canvas_x and mx < Dimensions.w_input_box_x + dimensions_canvas_x + Dimensions.w_input_box_widht and my > Dimensions.w_input_box_y  + dimensions_canvas_y and my < Dimensions.w_input_box_y + dimensions_canvas_y + Dimensions.w_input_box_height) or
    (mx > Dimensions.h_input_box_x + dimensions_canvas_x and mx < Dimensions.h_input_box_x + dimensions_canvas_x + Dimensions.h_input_box_widht and my > Dimensions.h_input_box_y  + dimensions_canvas_y and my < Dimensions.h_input_box_y + dimensions_canvas_y + Dimensions.h_input_box_height) then
      love.mouse.setCursor(i_beam_cursor)
    else
      love.mouse.setCursor()
    end



end

function uiDraw()

  	octaves_s:draw()
  	love.graphics.print("Octaves", 1265, 25)
  	love.graphics.print(octaves, 1325, 25)

  	lacunarity_s:draw()
  	love.graphics.print("Lacunarity", 1265, 75)
  	love.graphics.print(lacunarity, 1340, 75)

  	persistence_s:draw()
  	love.graphics.print("Persistence", 1265, 125)
  	love.graphics.print(persistence, 1345, 125)

  	seed_s:draw()
  	love.graphics.print("Seed", 1265, 175)
  	love.graphics.print(seed, 1320, 175)

  	frequency_s:draw()
  	love.graphics.print("frequency", 1265, 225)
  	love.graphics.print(frequency, 1340, 225)

  	love.graphics.print("Red", 1290, 275)
  	love.graphics.print(r, 1320, 275)
  	r_s:draw()

  	love.graphics.print("Green", 1290, 325)
  	love.graphics.print(g, 1340, 325)
  	g_s:draw()

  	love.graphics.print("Blue", 1290, 375)
  	love.graphics.print(b, 1320, 375)
  	b_s:draw()

  	love.graphics.print("Alpha", 1290, 425)
  	love.graphics.print(a, 1340, 425)
  	a_s:draw()

  	love.graphics.print(noise_selected, 1270, 480)
  	love.graphics.polygon("fill", 1235, 475, 1235, 500, 1205, 485)
  	love.graphics.polygon("fill", 1200+160, 475, 1200+160, 500, 1230+160, 485)

  	love.graphics.print("Include Alpha: ", 1250, 525)
  	if include_alpha == false then
  		love.graphics.rectangle("line", 1350, 525, 20, 20)
  	else
  		love.graphics.rectangle("fill", 1350, 525, 20, 20)
  	end

    love.graphics.rectangle("line", save_button_x, save_button_y, save_button_width, save_button_height)
    love.graphics.print("Save", save_button_x + 10, save_button_y + 5)

    love.graphics.rectangle("line", dimensions_button_x, dimensions_button_y, dimensions_button_width, dimensions_button_height)
    love.graphics.print("Dimensions", dimensions_button_x + 10, dimensions_button_y + 5)

    if save == true then
      savePopUp("Type in name for your image: " .. msg .. ".png", c_x, c_y)
    end

    Dimensions:draw(dimensions_canvas_x, dimensions_canvas_y)


    if Dimensions:getWBoxActive() == true or Dimensions:getHBoxActive() == true then
      love.graphics.print(dimension_widht, Dimensions.w_input_box_x + dimensions_canvas_x, Dimensions.w_input_box_y + dimensions_canvas_y)
      love.graphics.print(dimension_height, Dimensions.h_input_box_x + dimensions_canvas_x, Dimensions.h_input_box_y + dimensions_canvas_y)
    end

    --love.graphics.print(tostring(Dimensions:getActive()), 1100, 700)

end

function uiMouse(x, y, button, istouch)

  if button == 1 and x > 1205 and x < 1235 and y > 475 and y < 500 and noise_selector_index ~= 1 then
		noise_selector_index = noise_selector_index - 1
	end

	if button == 1 and x > 1200 + 160 and x < 1230 + 160 and y > 475 and y < 500 and noise_selector_index ~= 3 then
		noise_selector_index = noise_selector_index + 1
	end

	noise_selected = noise_types[noise_selector_index]
	if noise_types[1] == noise_selected then
		noise =  modules.Fractal:new()
	end
	if noise_types[2] == noise_selected then
		noise = modules.Billow:new()
	end

	if noise_types[3] == noise_selected then
		noise = modules.RidgedMulti:new()
	end

	if button == 1 and x > 1350 and x < 1350 + 20 and y > 525 and y < 525 + 20 then
		if include_alpha == true then
			include_alpha = false
		else
			include_alpha = true
		end

	end

	if button == 1 and x > save_button_x and x < save_button_x + save_button_width and y > save_button_y and y < save_button_y + save_button_height then --Initial save button
    save = true
	end

  if button == 1 and x > dimensions_button_x and x < dimensions_button_x + dimensions_button_width and y > dimensions_button_y and y < dimensions_button_y + dimensions_button_height then
    Dimensions:setActive(true)
	end

  if button == 1 and x > c_x + 85 and x < c_x + 85 + 50 and y > c_y + 25 and y < c_y + 25 + 25 then --THis is the save button detection in savePopUp
    Mapdata:encode("png", msg .. ".png")
    save = false
    msg = ""
  end


  if button == 1 and (x > Dimensions.w_input_box_x + dimensions_canvas_x and x < Dimensions.w_input_box_x + dimensions_canvas_x + Dimensions.w_input_box_widht and y > Dimensions.w_input_box_y  + dimensions_canvas_y and y < Dimensions.w_input_box_y + dimensions_canvas_y + Dimensions.w_input_box_height) then
    Dimensions:setWBoxActive(true)
  else
    Dimensions:setWBoxActive(false)
  end

  if button == 1 and (x > Dimensions.h_input_box_x + dimensions_canvas_x and x < Dimensions.h_input_box_x + dimensions_canvas_x + Dimensions.h_input_box_widht and y > Dimensions.h_input_box_y  + dimensions_canvas_y and y < Dimensions.h_input_box_y + dimensions_canvas_y + Dimensions.h_input_box_height) then
    Dimensions:setHBoxActive(true)
  else
    Dimensions:setHBoxActive(false)
  end

  if button == 1 and (x > Dimensions.save_button_x + dimensions_canvas_x and x < Dimensions.save_button_x + dimensions_canvas_x + Dimensions.save_button_width and y > Dimensions.save_button_y  + dimensions_canvas_y and y < Dimensions.save_button_y + dimensions_canvas_y + Dimensions.save_button_height) then
    Dimensions:setActive(false)
    dimension_widht_number = tonumber(dimension_widht)
    dimension_height_number = tonumber(dimension_height)

  end


end


function uiKeypressed(key)

  	 if key == "backspace" then
  			 msg = string.sub(msg, 1, #msg - 1)
  	 end

  	 if key == "backspace" and Dimensions:getWBoxActive() == true then
  			 dimension_widht = string.sub(dimension_widht, 1, #dimension_widht - 1)
  	 end

  	 if key == "backspace" and Dimensions:getHBoxActive() == true then
  			 dimension_height = string.sub(dimension_height, 1, #dimension_height - 1)
  	 end

end

function love.textinput(t)
    if Dimensions:getActive() ~= true then
      msg = msg .. t
    end

    if Dimensions:getWBoxActive() == true and #dimension_widht < 4 then
      dimension_widht = dimension_widht .. t
    end

    if Dimensions:getHBoxActive() == true and #dimension_height < 4 then
      dimension_height = dimension_height .. t
    end
end

function savePopUp(msg, x, y)

  if #msg > 0 then
    string_length = string.len(msg)
  end


  local resize = string_length * 7
  local string_canvas = love.graphics.newCanvas(resize, 60)
  love.graphics.setCanvas(string_canvas)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 0, 0, resize, 60)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.print(msg, 7, 5)

    love.graphics.setColor(0, 0.75, 0, 1)
    love.graphics.rectangle("fill", 85, 25, 50, 25)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Save", 95, 30)

  love.graphics.setCanvas()

  love.graphics.draw(string_canvas, x, y)


end
