Tank = Class{}

function Tank:init(x, y, color, tread, turret) 
    self.x = x
    self.y = y
    self.color = color
    self.alive = true
    
    self.type = 2

    self.body = gTankBodies['green'][self.type]
    self.track = gTankTracks[self.type]
    self.turret = gTankTurrets[self.type]
    self.width = self.body:getWidth()
    self.height = self.body:getHeight()
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

function Tank:render()

    if self.type == 1 then
        love.graphics.draw(self.track, self.x + 2, self.y + (self.height - self.track:getHeight() * 0.75 + 3)) --draw tracks 
        love.graphics.draw(self.turret, self.x + self.width / 2 + 5, self.y + 2) --draw turret
        love.graphics.draw(self.body, self.x, self.y) --draw body
    
    elseif self.type == 2 then
        love.graphics.draw(self.track, self.x + 4, self.y + (self.height - self.track:getHeight() * 0.75 + 3)) --draw tracks 
        love.graphics.draw(self.turret, self.x + self.width / 2 + 5, self.y + 2) --draw turret
        love.graphics.draw(self.body, self.x, self.y) --draw body

    elseif self.type == 3 then
        love.graphics.draw(self.track, self.x + 4, self.y + (self.height - self.track:getHeight() * 0.75 + 3)) --draw tracks 
        love.graphics.draw(self.turret, self.x + self.width / 2 + 5, self.y + 2) --draw turret
        love.graphics.draw(self.body, self.x, self.y) --draw body
        
    elseif self.type == 4 then
        love.graphics.draw(self.track, self.x + 4, self.y + (self.height - self.track:getHeight() * 0.75 + 3)) --draw tracks 
        love.graphics.draw(self.turret, self.x + self.width / 2 + 5, self.y + 2) --draw turret
        love.graphics.draw(self.body, self.x, self.y) --draw body
    end
end