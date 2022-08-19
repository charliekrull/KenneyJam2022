--[[
    Everything needed to make the game

]]

--allows us to draw at virtual resoluation

push = require 'lib/push'

Class = require 'lib/class' --allows for object oriented programming

require 'src/constants'

require 'src/StateMachine'


gTankImages = {
    ['green'] = love.graphics.load('graphics/tanks/tanks_tankGreen1.png'),
    ['desert'] = love.graphics.load('graphics/tanks/tanks_tankDesert1.png'),
    ['gray'] = love.graphics.load('graphics/tanks/tanks_tankGrey1.png'),
    ['navy'] = love.graphics.load('graphics/tanks/taanks_tankNavy1.png')
}

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720