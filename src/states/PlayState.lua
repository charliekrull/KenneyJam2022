--[[
    The state wherein we are actually playing the game 

]]
PlayState = Class{__inclues = BaseState}

function PlayState:enter()
    player = PlayerTank(VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2, 'green', 1)
    table.insert(gTanks, player)
end

function PlayState:update(dt)
    if love.keyboard.keysPressed['escape'] then
        love.event.quit()

    elseif love.keyboard.keysPressed['space'] then
        for k, tank in pairs(gTanks) do
            tank:setSize(tank.size + 0.5)
        end
    end

    player:update(dt)
    player:control(dt)
end

function PlayState:render()

    for k, tank in pairs(gTanks) do
        tank:render()
    end

end
