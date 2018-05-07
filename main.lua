
lovenoise = require("lovenoise")
modules = lovenoise.modules
-- 2, 0.02, 0.1, math.random(1, 3000), 0.5
require("simple-slider")

function love.load()

	map = mapgen(2, 0.02, 0.1, math.random(1, 3000), 0.5, 255, 255, 255, 255, modules.Fractal:new())  -- Eitthvað öðruvisi með love.graphics.points núna, koma skrýtnar linur --lagað með +0.5 var ekki ceneterað

	octaves_s = newSlider(1300, 50, 150, 50, 1, 100)
	lacunarity_s = newSlider(1300, 100, 150, 0.5, 0, 5)
	persistence_s = newSlider(1300, 150, 150, 0.5, 0, 1)
	seed_s = newSlider(1300, 200, 150, 100, 1, 200)
	frequency_s = newSlider(1300, 250, 150, 0.5, 0, 1)

	r_s = newSlider(1300, 300, 150, 255, 1, 255) --RGBA inputs
	g_s = newSlider(1300, 350, 150, 255, 1, 255)
	b_s = newSlider(1300, 400, 150, 255, 1, 255)
	a_s = newSlider(1300, 450, 150, 255, 1, 255)

	--suc, err = file:write("skrift")

	--file:close()


	noise_types = {"Fractal", "Billow", "Ridged Multi"}
	i = 1;
	noise_selected = noise_types[i]
	noise = modules.Fractal:new()


end

function love.update(dt)

	mx, my = love.mouse.getPosition()


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


end

function love.mousepressed(x, y, button, istouch)

	if button == 1 and x > 1205 and x < 1235 and y > 475 and y < 500 and i ~= 1 then
		i = i - 1
	end

	if button == 1 and x > 1200 + 160 and x < 1230 + 160 and y > 475 and y < 500 and i ~= 3 then
		i = i + 1
	end

	noise_selected = noise_types[i]
	if noise_types[1] == noise_selected then
		noise =  modules.Fractal:new()
	end
	if noise_types[2] == noise_selected then
		noise = modules.Billow:new()
	end

	if noise_types[3] == noise_selected then
		noise = modules.RidgedMulti:new()
	end


end

function love.keypressed(key)
   if key == "space" then
      map = mapgen(octaves, lacunarity, persistence, seed, frequency, r, g, b, a, noise)
   end
end


function love.draw()

	love.graphics.draw(map)
	love.graphics.rectangle("fill", 15, 15, 35, 25)
	love.graphics.setColor(0, 0, 0)
	--love.graphics.print(map_r, 20, 20)
	love.graphics.setColor(255, 255, 255, 255)

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



end

function mapgen(octaves, lacunarity, persistence, seed, frequency, r, g, b, a, noise)  --function til að setja stuff á góðu noise mappið okkar, eins og snjó og tré.....

	file = love.filesystem.newFile("data.txt")
	file:open("w")
	-- /home/isak/.local/share/love/Lovenoise-new-version/   Slóðin til þar sem fællinn vistast

	tuncoords = {}
	snowcoords = {}  --40, 0.8, 0.99, love.math.random(1, 3000), 1
	noise_values = {octaves, lacunarity, persistence, seed, frequency} --octaves, lacunarity, persistence, seed, frequency

	--noise = noise --:new(octaves, lacunarity, persistence, seed, frequency)
	noise:setSeed(seed)
	noise:setFrequency(frequency)--0 til 1 = smooth values, yfir 1 gives pseudo-random white noise
	noise:setOctaves(octaves)--1 og uppúr
	noise:setLacunarity(lacunarity)--0 til 1
	noise:setPersistence(persistence)--0 til 1																	--:new(1 til endalaust, 0 til 1, 0 til 1, veit ekki)

	Mapdata = love.image.newImageData(1201, 801)



	for x = 1, 1200 do
	for y = 1, 800 do
		info = noise:getValue(x, y)
		Mapdata:setPixel(x, y, r*info, g*info, b*info, a) --255 , 100, 45, 255
		--suc, err = file:write(info .. "\n")
		---------

		--rm, gm, bm, am = Mapdata:getPixel(x, y)
	    --if rm >= 1 and rm < 40 then  --Setja x og y coords innni töflu sem geymir x og y-hnitinn
	      --  table.insert(tuncoords, {x = x, y = y}) --Hér set ég inn í töfluna treecords x og y hnitin á pixlum þar sem bláliturinn er á milli 5 og 20 úr x (frá 1 til 1200) og y(frá 1 til 800)
	    --end
		--if rm > 40 and rm < 255 then
		  --  table.insert(snowcoords, {x = x, y = y}) --Ná í hnitinn fyrir hver pixel snjór, set hnitinn í töflu
		--end

	end
	end

	Map = love.graphics.newImage(Mapdata)


  --Mapready = love.graphics.newCanvas(1201, 801)
	--love.graphics.setCanvas(Mapready)
	--love.graphics.clear()
	   -- love.graphics.draw(Map)

		--for lykill, gildi in pairs(tuncoords) do
			--love.graphics.setColor(34, 139, 34, 175)  --Grænn litur, fyrir skóg  --0, 30, 0
			--love.graphics.points(0.5 + gildi.x, 0.5 + gildi.y)
			--love.graphics.setColor(255, 255, 255, 255)
		--end
		--for lykill, gildi in pairs(snowcoords) do
		  --love.graphics.setColor(255, 255, 255)  --Snjórinn
			--love.graphics.points(0.5 + gildi.x, 0.5 + gildi.y)
			--love.graphics.setColor(255, 255, 255)
		--end


    --love.graphics.setCanvas()

	return Map

end
