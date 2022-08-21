GameOverState = Class{__includes = BaseState}

function GameOverState:enter(params)
    gSounds['music']:stop()
    if params.playerWon then
        gSounds['win-music']:play()
    

    else
        gSounds['lose-music']:play()
        
    end

    self.playerWon = params.playerWon

    
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start')
    end
end

function GameOverState:render()
    love.graphics.draw(background, 0, 0, 0, 1.25, 0.71)
    love.graphics.setFont(gFonts['title'])
    if self.playerWon then
        love.graphics.printf('You win!', 0, VIRTUAL_HEIGHT/4, VIRTUAL_WIDTH, 'center')

    else
        love.graphics.printf('You lost', 0, VIRTUAL_HEIGHT/4, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setFont(gFonts['thin'])
    love.graphics.printf('Press Enter to return to main menu', 0, VIRTUAL_HEIGHT * 0.75, VIRTUAL_WIDTH, 'center')
end

