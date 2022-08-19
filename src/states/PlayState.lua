--[[
    The state wherein we are actually playing the game 

]]
PlayState = Class{__inclues = BaseState}

function PlayState:update(dt)
    if love.keyboard.keysPressed['escape'] then
        love.event.quit()
    end
end