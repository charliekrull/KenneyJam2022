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
    self.active = player
    randomizeStarts()
    gBullets = {}
    gGround, background = LevelMaker:generateLevel(LevelMaker:getLandType()) --make a random level
    gExplosions = {}
    self.timer = 0

end

function PlayState:update(dt)
    self.timer = self.timer + dt
    

    if love.keyboard.wasPressed('d') then
        player.alive = false
    end
    
    for k, explosion in pairs(gExplosions) do
        if self.timer - explosion.creationTime >= 0.1 then
            gExplosions[k] = nil
        end
    end

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
        self.active:control()
        Timer.tween(0.5, {[self.active] = {turretRotation = self.active.targetAngle}}):finish(self.active:fireTurret())
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
        local collider = collisions['collider']


        local e = Explosion(collisions['x'], collisions['y'], collisions['size'], self.timer)
        e.x = e.x - e.width / 2
        e.y = e.y - e.height / 2
        table.insert(gExplosions, e)

        for k, exp in pairs(gExplosions) do
            for l, tank in pairs(gTanks) do
                if exp:collides(tank) then
                    tank:takeDamage(1)
                    tank:grow()
                end
            end
        end 
    end

    for k, tank in pairs(gTanks) do
        if not tank.alive then
            table.remove(gTanks, k)
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

    for k, explosion in pairs(gExplosions) do
        explosion:render()
    end


end

function PlayState:advanceTurn()

    --check if we have won/lost
    if #gTanks == 1 then
        if player.alive then
            gStateMachine:change('game-over', {playerWon = true})
        end

    elseif not player.alive then
        gStateMachine:change('game-over', {playerWon = false})   

    end

    currentTurn = (currentTurn % #gTanks) + 1

    if currentTurn == 1 then
        canInput = true
        self.active = player

    else
        canInput = false
        self.active = gTanks[currentTurn]
    end


end


function PlayState:getBulletCollisions()
    for k, bullet in pairs(gBullets) do
        for l, tile in pairs(gGround) do
            if bullet:collides(tile) then
                gBullets[k] = nil
                self:advanceTurn()
                return {['collider'] ='tile', ['x'] = bullet.x, ['y'] = bullet.y, ['size'] = bullet.size}
            end
        end

        for m, tank in pairs(gTanks) do
            if bullet:collides(tank) then
                gBullets[k] = nil
                self:advanceTurn()
                return {['collider'] = tank, ['x'] = bullet.x, ['y'] = bullet.y, ['size'] = bullet.size}
            end
        end

        return false
    end
end

function PlayState:exit()

end

function randomizeStarts() 
    for k, tank in pairs(gTanks) do
        tank.x = math.random(0, VIRTUAL_WIDTH - tank.width)
    end
end
