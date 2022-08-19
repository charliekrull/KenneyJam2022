Tank = Class{}

function Tank:init(x, y, color) 
    self.x = x
    self.y = y
    self.name = color
    self.alive = true

    self.image = gTankImages[color]
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function Tank:collides(target)
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end

    return true
end

