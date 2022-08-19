--[[
    A 2D tank game where every time a tank takes damage, it gets bigger!
]]

require 'src/Dependencies'

function love.load() --called once when the game StartState
    love.window.setTitle("Tank Battle")

    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true,
        canvas = true
    })

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