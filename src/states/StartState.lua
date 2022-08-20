--[[
    The state we start the game in. Time permitting, we'll be able to choose tanks and prepare for battle
]]
StartState = Class{__includes = BaseState}

function StartState:update(dt)
    if love.keyboard.keysPressed['escape'] then
        love.event.quit()
    end
    if love.keyboard.keysPressed['enter'] or love.keyboard.keysPressed['return'] then
    gStateMachine:change('play')

   end 
end

function StartState:render()
    love.graphics.setFont(gFonts['title'])
    love.graphics.printf("Pop Tanks", 0, VIRTUAL_HEIGHT / 4, VIRTUAL_WIDTH, 'center')

end