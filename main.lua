--[[
    A 2D tank game where every time a tank takes damage, it gets bigger!
]]

require 'src/Dependencies'

function love.load() --called once when the game StartState
end

function love.update(dt) --called every frame

end

function love.draw() --what to display, called every frame

end

function love.resize(w, h)

    push:resize(w, h)

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end