LevelMaker = Class{}

--[[function LevelMaker:init()
    self.directions = {['ascend'] = true, ['descend'] = true, ['stay'] = true} --which way to go after generating a whole column...shorter, longer, or the same
    
end]]


function LevelMaker:getLandType()
    local choice = math.random(1, 4)

    if choice == 2 or choice == 3 then
        self.bg = gBackgrounds[choice]
        return 1

    elseif choice == 1 then
        self.bg = gBackgrounds[choice]
        return 2
    
    elseif choice == 4 then
        self.bg = gBackgrounds[choice]
        return 3
    end



end

function LevelMaker:generateLevel(type)

    local tileset = gGroundTiles[type]
    
    local results = {}
    local skin = 0
    
    for x = 1, 20 do

        for y = 13, GROUND_LEVEL, -1 do       
            
            if y == GROUND_LEVEL then
                skin = tileset['flat']
            
                
            else
                skin = tileset['center']
            end

            local t = Tile(x, y, skin)
        
            table.insert(results, t)
 
        end


    end

    return results, self.bg

end

