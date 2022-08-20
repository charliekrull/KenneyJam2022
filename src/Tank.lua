Tank = Class{}

function Tank:init(x, y, color, type) 
    self.x = x
    self.y = y
    self.color = color
    self.type = type
    

    self.alive = true
    self.speed = 200
    self.size = 0.5
    self.health = 4
    self.direction = 1

    self.body = gTankBodies[self.color][self.type]
    self.track = gTankTracks[self.type]
    self.turret = gTankTurrets[self.type] or gTankTurrets[4]
    self.turretRotation = 0
    self.turretSpeed = math.pi/4

    self.turretOffsetX = 0
    self.turretOffsetY = self.turret:getHeight() / 2


    self.width = self.body:getWidth() * self.size
    self.height = self.body:getHeight() * self.size

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

function Tank:update(dt)
    if self.direction == 1 and self.turretRotation < -math.pi / 2 then
        self:flipTurret()


    elseif self.direction == -1 and self.turretRotation > -math.pi/2 then
        self:flipTurret()
        
    end
    

end

function Tank:render()

    if self.type == 1 then
        love.graphics.draw(self.track, self.x + 2 * self.size * self.direction, self.y + (self.height - self.track:getHeight() * 0.75 * self.size + 3 * self.size), 0, self.size * self.direction, self.size) --draw tracks 
        love.graphics.draw(self.turret, self.x + self.width / 2 * self.direction + 5 * self.size * self.direction, self.y + 8 * self.size, self.turretRotation, self.size, self.size, self.turretOffsetX, self.turretOffsetY) --draw turret
        love.graphics.draw(self.body, self.x, self.y, 0, self.size * self.direction, self.size) --draw body
    
    elseif self.type == 2 then
        love.graphics.draw(self.track, self.x + 4 * self.size * self.direction, self.y + (self.height - self.track:getHeight() * 0.75 * self.size + 3 * self.size), 0, self.size * self.direction, self.size) --draw tracks 
        love.graphics.draw(self.turret, self.x + self.width / 2 * self.direction + 10 * self.size * self. direction, self.y + 8 * self.size, self.turretRotation, self.size, self.size, self.turretOffsetX, self.turretOffsetY) --draw turret
        love.graphics.draw(self.body, self.x, self.y, 0, self.size * self.direction, self.size) --draw body

    elseif self.type == 3 then
        love.graphics.draw(self.track, self.x + 4 * self.size * self.direction, self.y + (self.height - self.track:getHeight() * 0.75 * self.size + 3 * self.size), 0, self.size * self.direction, self.size) --draw tracks 
        love.graphics.draw(self.turret, self.x + self.width / 2 * self.direction + 5 * self.size * self.direction, self.y + 8 * self.size, self.turretRotation, self.size, self.size, self.turretOffsetX, self.turretOffsetY) --draw turret
        love.graphics.draw(self.body, self.x, self.y, 0, self.size * self.direction, self.size) --draw body
        
    elseif self.type == 4 then
        love.graphics.draw(self.turret, self.x + self.width / 2 * self.direction + 5 * self.size * self.direction, self.y + 8 * self.size, self.turretRotation, self.size, self.size, self.turretOffsetX, self.turretOffsetY) --draw turret
        love.graphics.draw(self.body, self.x, self.y, 0, self.size * self.direction, self.size) --draw body
        love.graphics.draw(self.track, self.x + 4 * self.size * self.direction, self.y + (self.height - self.track:getHeight() * 0.75 * self.size + 3 * self.size), 0, self.size * self.direction, self.size) --draw tracks
        love.graphics.draw(self.track, self.x + 45 * self.size * self.direction, self.y + (self.height - self.track:getHeight()*0.75 * self.size + 3 * self.size), 0, self.size * self.direction, self.size)

    elseif self.type == 5 then
        love.graphics.draw(self.turret, self.x + self.width / 2 * self.direction + 5 * self.size * self.direction, self.y + 8 * self.size, self.turretRotation, self.size, self.size, self.turretOffsetX, self.turretOffsetY) --draw turret
        love.graphics.draw(self.body, self.x, self.y, 0, self.size * self.direction, self.size) --draw body
        love.graphics.draw(self.track, self.x - 8 * self.size * self.direction, self.y + self.height - 18 * self.size, 0, self.size * self.direction, self.size) --draw tracks 
    end

    --love.graphics.rectangle('line', self.x, self.y, self.width, self.height) --draw Hitboxes
end

function Tank:takeDamage(amt)

    self.health = self.health - amt
    if self.health <= 0 then
        self.alive = false
    end
   

end

function Tank:setSize(size)
    self.size = size
    self.width = self.body:getWidth() * self.size
    self.height = self.body:getHeight() * self.size
end

function Tank:control() --use AI to do stuff

end

function Tank:flipTurret()
    self.turretRotation = -math.pi - self.turretRotation
end