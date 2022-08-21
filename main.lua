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

    gSounds = {['music'] = love.audio.newSource('sounds/Impact Prelude.mp3', 'stream'),
        ['lose-music'] = love.audio.newSource('sounds/failfare-86009.mp3', 'static'),
        ['win-music'] = love.audio.newSource('sounds/victory.mp3', 'static')} 
    --[["Impact Prelude" Kevin MacLeod (incompetech.com)
    Licensed under Creative Commons: By Attribution 4.0 License
    http://creativecommons.org/licenses/by/4.0/]]

    gSounds['music']:setLooping(true)
    gSounds['music']:play()

    gFonts = {['title'] = love.graphics.newFont('fonts/Gasalt-Black.ttf', 80), --Title font by Remi Lagast https://www.1001fonts.com/gasalt-font.html
    ['thin'] = love.graphics.newFont('fonts/Gasalt-Thin.ttf', 64),
    ['credits'] = love.graphics.newFont('fonts/Inter-regular.ttf', 32)} --credits font by Rasmus Andersson https://fonts.google.com/specimen/Inter

     
    gBackgrounds = {[1] = love.graphics.newImage('graphics/backgrounds/colored_desert.png'),
    [2] = love.graphics.newImage('graphics/backgrounds/colored_grass.png'),
    [3] = love.graphics.newImage('graphics/backgrounds/colored_land.png'),
    [4] = love.graphics.newImage('graphics/backgrounds/colored_shroom.png')
    }

    --ground tiles
    gGroundTiles = {[1] = {['flat'] = love.graphics.newImage('graphics/groundtiles/grassMid.png'), ['left'] = love.graphics.newImage('graphics/groundtiles/grassHill_left.png'),
        ['right'] = love.graphics.newImage('graphics/groundtiles/grassHill_right.png'), ['center'] = love.graphics.newImage('graphics/groundtiles/grassCenter.png')},

        [2] = {['flat'] = love.graphics.newImage('graphics/groundtiles/sandMid.png'), ['left'] = love.graphics.newImage('graphics/groundtiles/sandHill_left.png'),
        ['right'] = love.graphics.newImage('graphics/groundtiles/sandHill_right.png'), ['center'] = love.graphics.newImage('graphics/groundtiles/sandCenter.png')},

        [3] = {['flat'] = love.graphics.newImage('graphics/groundtiles/planetMid.png'), ['left'] = love.graphics.newImage('graphics/groundtiles/planetHill_left.png'),
        ['right'] = love.graphics.newImage('graphics/groundtiles/planetHill_right.png'), ['center'] = love.graphics.newImage('graphics/groundtiles/planetCenter.png')}
    
        }

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
    


    gStateMachine = StateMachine{
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end,
        ['credits'] = function() return Credits() end,
        ['game-over'] = function() return GameOverState() end
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