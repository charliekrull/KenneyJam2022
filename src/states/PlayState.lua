--[[
    The state wherein we are actually playing the game 

]]
PlayState = Class{__inclues = BaseState}

function PlayState:enter()
    player = PlayerTank(VIRTUAL_WIDTH / 2, GROUND_LEVEL * 64 - 93, 'green', 1)
    for k, color in pairs({'desert', 'gray', 'blue'}) do
        local x = math.random(0, VIRTUAL_WIDTH - 100)
        local y = GROUND_LEVEL * 64 - 93
        local type = math.random(1, 5)
        local t = Tank(x, y, color, type)
        table.insert(gTanks, t)
    end

    table.insert(gTanks, player)
    randomizeStarts()
    gBullets = {}
    gGround, background = LevelMaker:generateLevel(LevelMaker:getLandType()) --make a random level

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
        if bullet.x > VIRTUAL_WIDTH then
            gBullets[b] = nil
        end
        bullet:update(dt)
    end
end

function PlayState:render()

    love.graphics.draw(background, 0, 0, 0, 1.25, 0.71)

    for k, tank in pairs(gTanks) do
        tank:render()
    end

    for k, bullet in pairs(gBullets) do
        bullet:render()
    end

    for k, tile in pairs(gGround) do
        tile:render()
    end


end


function randomizeStarts() 
    for k, tank in pairs(gTanks) do
        tank.x = math.random(0, VIRTUAL_WIDTH - tank.width)
    end
end