Explosion = Class{}

function Explosion:init(x, y, size, creationTime)
    self.x = x
    self.y = y
    self.size = size
    self.creationTime = creationTime
    self.image = love.graphics.newImage('graphics/tanks/tank_explosion4.png')
    self.width = self.image:getWidth() * size
    self.height = self.image:getHeight() * size

end

function Explosion:collides(target)
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end

    return true
end

function Explosion:render()
    love.graphics.draw(self.image, self.x, self.y)
    
end