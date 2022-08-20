--[[
    The state wherein we are actually playing the game 

]]
PlayState = Class{__inclues = BaseState}

function PlayState:enter()
    player = PlayerTank(VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2, 'green', 1)
    table.insert(gTanks, player)
    gBullets = {}
end

function PlayState:update(dt)
    if love.keyboard.keysPressed['escape'] then
        love.event.quit()

    elseif love.keyboard.keysPressed['space'] then
        for k, tank in pairs(gTanks) do
            tank:setSize(tank.size + 0.5)
        end
    end

    if love.keyboard.keysPressed['b'] then
        local b = Bullet(player.x + 5, player.y - 5, player.size)
        table.insert(gBullets, b)
    end

    
    player:control(dt)
    for k, tank in pairs(gTanks) do
        tank:update(dt)
    end
    
    for b, bullet in pairs(gBullets) do
        bullet:update(dt)
    end
end

function PlayState:render()

    for k, tank in pairs(gTanks) do
        tank:render()
    end

    for k, bullet in pairs(gBullets) do
        bullet:render()
    end


end
