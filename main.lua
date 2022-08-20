--[[
    A 2D tank game where every time a tank takes damage, it gets bigger!
]]

require 'src/Dependencies'

function love.load() --called once when the game StartState
    love.window.setTitle("Pop Tanks")

    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true,
        canvas = true
    })

    gFonts = {['title'] = love.graphics.newFont('fonts/Gasalt-Black.ttf', 80), --Title font by Remi Lagast https://www.1001fonts.com/gasalt-font.html
     ['thin'] = love.graphics.newFont('fonts/Gasalt-Thin.ttf', 64)}

     --load up the tank graphics

    gTankBodies = { --the various tank bodies, which will be combined with treads and turrets to make tanks
        ['green'] = {[1] = love.graphics.newImage('graphics/tanks/tanks_tankGreen_body1.png'),
            [2] = love.graphics.newImage('graphics/tanks/tanks_tankGreen_body2.png'),
            [3] = love.graphics.newImage('graphics/tanks/tanks_tankGreen_body3.png'),
            [4] = love.graphics.newImage('graphics/tanks/tanks_tankGreen_body4.png'),
            [5] = love.graphics.newImage('graphics/tanks/tanks_tankGreen_body5.png')},

        ['desert'] = {[1] = love.graphics.newImage('graphics/tanks/tanks_tankDesert_body1.png'),
        [2] = love.graphics.newImage('graphics/tanks/tanks_tankDesert_body2.png'),
        [3] = love.graphics.newImage('graphics/tanks/tanks_tankDesert_body3.png'),
        [4] = love.graphics.newImage('graphics/tanks/tanks_tankDesert_body4.png'),
        [5] = love.graphics.newImage('graphics/tanks/tanks_tankDesert_body5.png')},

        ['gray'] = {[1] = love.graphics.newImage('graphics/tanks/tanks_tankGrey_body1.png'),
        [2] = love.graphics.newImage('graphics/tanks/tanks_tankGrey_body2.png'),
        [3] = love.graphics.newImage('graphics/tanks/tanks_tankGrey_body3.png'),
        [4] = love.graphics.newImage('graphics/tanks/tanks_tankGrey_body4.png'),
        [5] = love.graphics.newImage('graphics/tanks/tanks_tankGrey_body5.png')},

        ['blue'] = {[1] = love.graphics.newImage('graphics/tanks/tanks_tankNavy_body1.png'),
        [2] = love.graphics.newImage('graphics/tanks/tanks_tankNavy_body2.png'),
        [3] = love.graphics.newImage('graphics/tanks/tanks_tankNavy_body3.png'),
        [4] = love.graphics.newImage('graphics/tanks/tanks_tankNavy_body4.png'),
        [5] = love.graphics.newImage('graphics/tanks/tanks_tankNavy_body5.png')} }

    gTankTracks = {[1] = love.graphics.newImage('graphics/tanks/tanks_tankTracks1.png'),
    [2] = love.graphics.newImage('graphics/tanks/tanks_tankTracks2.png'),
    [3] = love.graphics.newImage('graphics/tanks/tanks_tankTracks3.png'),
    [4] = love.graphics.newImage('graphics/tanks/tanks_tankTracks5.png'), --different from file name
    [5] = love.graphics.newImage('graphics/tanks/tanks_tankTracks6.png')}--is not the same as file name

    gTankTurrets = {[1] = love.graphics.newImage('graphics/tanks/tanks_turret1.png'),
    [2] = love.graphics.newImage('graphics/tanks/tanks_turret3.png'), --does not match file name
    [3] = love.graphics.newImage('graphics/tanks/tanks_turret2.png'), --does not match file name
    [4] = love.graphics.newImage('graphics/tanks/tanks_turret4.png')}

    gTanks = {}
    for k, color in pairs({'desert', 'gray', 'blue'}) do
        local x = math.random(0, VIRTUAL_WIDTH - 100)
        local y = VIRTUAL_HEIGHT - 100
        local type = math.random(1, 5)
        local t = Tank(x, y, color, type)
        table.insert(gTanks, t)
    end


    gStateMachine = StateMachine{
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end
    }

    gStateMachine:change('start')

    love.keyboard.keysPressed = {}
end

function love.update(dt) --called every frame
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw() --what to display, called every frame
    push:start() --start drawing at virtual resolution
    love.graphics.setColor(1, 1, 1, 1)

    gStateMachine:render()
    push:finish()
end

function love.resize(w, h)

    push:resize(w, h)

end

function love.keypressed(key) --input handler
    --add to table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
    
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key] --return true or false, whether the key was pressed this frame
end