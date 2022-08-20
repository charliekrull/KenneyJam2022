Tile = Class{}

function Tile:init(x, y, skin)
    self.gridX = x
    self.gridY = y
    self.skin = skin

    self.width = 64
    self.height = 64

    self.x = (self.gridX - 1) * self.width
    self.y = (self.gridY - 1) * self.height

    

end

function Tile:render()
    love.graphics.draw(self.skin, self.x, self.y, 0, 0.5, 0.5)
end