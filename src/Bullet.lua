Bullet = Class{}

function Bullet:init(x, y, size)
    
    self.x = x
    self.y = y
    self.size = size

    self.dx = 700
    self.dy = 0
    self.gravity = 10

    self.image = love.graphics.newImage('graphics/tanks/tank_bullet5.png')
    self.width = self.image:getWidth() * self.size
    self.height = self.image:getHeight() * self.size

end

function Bullet:collides(target)
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end

    return true
end

function Bullet:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end