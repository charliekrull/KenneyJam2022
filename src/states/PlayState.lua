--[[
    The state wherein we are actually playing the game 

]]
PlayState = Class{__inclues = BaseState}

function PlayState:enter()
    player = Tank(VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2, 'green')
end

function PlayState:update(dt)
    if love.keyboard.keysPressed['escape'] then
        love.event.quit()
    end
end

function PlayState:render()

    player:render()

end