Credits = Class{__includes = BaseState}

function Credits:update()
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start')
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function Credits:render()
    love.graphics.setFont(gFonts['credits'])
    love.graphics.printf(
        'Music: \n'..'"Impact Prelude" Kevin MacLeod (incompetech.com) Licensed under Creative Commons: By Attribution 4.0 License http://creativecommons.org/licenses/by/4.0/',
        0, 0, VIRTUAL_WIDTH, 'center'
    )
    love.graphics.printf('Fonts: \n'..'Title font by Remi Lagast https://www.1001fonts.com/gasalt-font.html\nCredits font by Rasmus Andersson https://fonts.google.com/specimen/Inter',
    0, 140, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Art Assets by Kenney:\n'..'https://kenney.nl/assets/tanks\nhttps://kenney.nl/assets/platformer-pack-redux',
    0, 300, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Game design and programming by Charlie Krull\nhttps://charliek.itch.io/', 0, 450, VIRTUAL_WIDTH, 'center')
end