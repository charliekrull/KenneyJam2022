PlayerTank = Class{__includes = Tank}

function PlayerTank:control(dt) --take input from player
    if love.keyboard.isDown('left') then
        self.x = self.x - self.speed * dt
        self.direction = -1
    end

    if love.keyboard.isDown('right') then
        self.x = self.x + self.speed * dt
        self.direction = 1       
    end

    if love.keyboard.isDown('up') then
        self.turretRotation = self.direction == 1 and math.max(-math.pi/2, self.turretRotation - self.turretSpeed * dt) or math.min(-math.pi/2, self.turretRotation + self.turretSpeed * dt)
    end

    if love.keyboard.isDown('down') then
        self.turretRotation = self.direction == 1 and math.min(0, self.turretRotation + self.turretSpeed * dt) or math.max(-math.pi, self.turretRotation - self.turretSpeed * dt)
    end

    if love.keyboard.wasPressed('f') then
        print(self.turretRotation)
    end
end