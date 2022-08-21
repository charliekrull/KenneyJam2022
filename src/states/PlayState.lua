--[[
    The state wherein we are actually playing the game 

]]
PlayState = Class{__inclues = BaseState}

function PlayState:enter()
    player = PlayerTank(VIRTUAL_WIDTH / 2, GROUND_LEVEL * 64 - 93, 'green', 1)
    table.insert(gTanks, player)
    for k, color in pairs({'desert', 'gray', 'blue'}) do
        local x = math.random(0, VIRTUAL_WIDTH - 100)
        local y = GROUND_LEVEL * 64 - 93
        local type = math.random(1, 5)
        local t = Tank(x, y, color, type)
        table.insert(gTanks, t)
    end

    

    currentTurn = 1
    canInput = true
    randomizeStarts()
    gBullets = {}
    gGround, background = LevelMaker:generateLevel(LevelMaker:getLandType()) --make a random level

end

function PlayState:update(dt)
    if love.keyboard.keysPressed['escape'] then
        love.event.quit()

    elseif love.keyboard.wasPressed('g') then
        for k, tank in pairs(gTanks) do
            tank:grow()
        end
    end

    if love.keyboard.keysPressed['space'] then
        player:fireTurret()
        table.insert(gBullets, b)
    end

    if canInput then --it's the player's turn
        player:control(dt)

    else --another tank's turn
        gTanks[currentTurn]:control()
    end

    for k, tank in pairs(gTanks) do
        tank:update(dt)
    end
    
    for b, bullet in pairs(gBullets) do
       
        bullet:update(dt)
        if bullet.x > VIRTUAL_WIDTH or bullet.x < -bullet.width or bullet.y < 0 then
            gBullets[b] = nil
        end
        
    end

    local collisions = self:getBulletCollisions() --calculate collisions with all the bullets

    if collisions then
        local collider = collisions[1]


        if table.contains(gTanks, collider) then
            collider:takeDamage(1)
            collider:grow()
        end
        
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

function PlayState:advanceTurn()
    currentTurn = (currentTurn % #gTanks) + 1

    if currentTurn == 1 then
        canInput = true

    else
        canInput = false
    end 

end


function PlayState:getBulletCollisions()
    for k, bullet in pairs(gBullets) do
        for l, tile in pairs(gGround) do
            if bullet:collides(tile) then
                gBullets[k] = nil
                return {'tile', bullet.x, bullet.y}
            end
        end

        for m, tank in pairs(gTanks) do
            if bullet:collides(tank) then
                gBullets[k] = nil
                return {tank, bullet.x, bullet.y}
            end
        end

        return false
    end
end

function randomizeStarts() 
    for k, tank in pairs(gTanks) do
        tank.x = math.random(0, VIRTUAL_WIDTH - tank.width)
    end
end
