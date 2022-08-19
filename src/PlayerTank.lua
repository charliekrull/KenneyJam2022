PlayerTank = Class{__includes = Tank}

function PlayerTank:control(dt)
    if love.keyboard.isDown('left') then
        self.x = self.x - self.speed * dt

    elseif love.keyboard.isDown('right') then
        self.x = self.x + self.speed * dt
    end
end