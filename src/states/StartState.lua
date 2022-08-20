--[[
    The state we start the game in. Time permitting, we'll be able to choose tanks and prepare for battle
]]
StartState = Class{__includes = BaseState}



function StartState:enter()
    local bg = math.random(1, 4)
    background = gBackgrounds[bg]
    self.highlighted = 1
end

function StartState:update(dt)
    if love.keyboard.keysPressed['escape'] then
        love.event.quit()
    end
    if love.keyboard.keysPressed['enter'] or love.keyboard.keysPressed['return'] then
        if self.highlighted == 1 then
            gStateMachine:change('play')

        elseif self.highlighted == 2 then
            
            gStateMachine:change('credits')
        end

    end

    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        if self.highlighted == 1 then
            self.highlighted = 2

        elseif self.highlighted == 2 then
            self.highlighted = 1
        end
    end



   
end

function StartState:render()
    love.graphics.draw(background, 0, 0, 0, 1.25, 0.71) --draw background layer
    

    love.graphics.setFont(gFonts['title']) --show title
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf("Pop Tanks", 0, VIRTUAL_HEIGHT / 4, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['thin']) --print menu options
    if self.highlighted == 1 then
        love.graphics.setColor(1, 0, 0, 1)
    else
        love.graphics.setColor(0, 0, 0, 1)
    end
    love.graphics.printf("Start Match", 0, VIRTUAL_HEIGHT * 0.75, VIRTUAL_WIDTH, 'center')

    if self.highlighted == 2 then
        love.graphics.setColor(1, 0, 0, 1)
    else
        love.graphics.setColor(0, 0, 0, 1)
    end
    love.graphics.printf("Credits", 0, VIRTUAL_HEIGHT * 0.75 + 60, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf("Press Enter to select", 0, VIRTUAL_HEIGHT - 60, VIRTUAL_WIDTH, 'center')




end