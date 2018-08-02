
lovenoise = require("third-party/lovenoise")
modules = lovenoise.modules

require("third-party/simple-slider")
require("Scripts/ui")
--require("middleclass")

function love.load()
	noises = {}
	noises_index = 1

	dimension_widht_number = 1200
	dimension_height_number = 800

	map = mapgen(2, 0.02, 0.1, math.random(1, 3000), 0.5, 1, 1, 1, 1, modules.Fractal:new(), dimension_widht_number, dimension_height_number)  -- Eitthvað öðruvisi með love.graphics.points núna, koma skrýtnar linur --lagað með +0.5 var ekki ceneterað
	table.insert(noises, map)
	uiLoad()

end

function love.update(dt)

	mx, my = love.mouse.getPosition()
	uiUpdate(dt)

	w_width, w_height = love.graphics.getDimensions()

end

function love.mousepressed(x, y, button, istouch)

	uiMouse(x, y, button, istouch)

end

function love.keypressed(key)
   if key == "space" then
      map = mapgen(octaves, lacunarity, persistence, seed, frequency, r, g, b, a, noise, dimension_widht_number, dimension_height_number)
			table.insert(noises, map)
			noises_index = noises_index + 1
   end

	 if key == "left" and noises_index > 1 then
		 noises_index = noises_index - 1
	 end
	 if key == "right" and noises_index < #noises then
		 noises_index = noises_index + 1
	 end


	 uiKeypressed(key)
end


function love.draw()

	love.graphics.draw(noises[noises_index])
	uiDraw()
	love.graphics.printf("Your image will be saved to: " .. love.filesystem.getSaveDirectory(), 1210, 630, 175, "center")
	--popUp("Name of Image file: ", 500, 500)
	love.graphics.printf("Spacebar: Generate new Image. Left and right Arrows: cycle through previous images.", 1210, 700, 175, "center")
	love.graphics.print(w_width, 0, 0)
	love.graphics.print(w_height, 0, 30)
end

function mapgen(octaves, lacunarity, persistence, seed, frequency, r, g, b, a, noise, widht, height)  --function til að setja stuff á góðu noise mappið okkar, eins og snjó og tré.....

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

	Mapdata = love.image.newImageData(widht, height)

	for x = 1, widht-1 do
	for y = 1, height-1 do
		info = math.abs(noise:getValue(x, y))
		if include_alpha == true then
			Mapdata:setPixel(x, y, r*info, g*info, b*info, a*info) --255 , 100, 45, 255
		else
			Mapdata:setPixel(x, y, r*info, g*info, b*info, a)
		end
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
