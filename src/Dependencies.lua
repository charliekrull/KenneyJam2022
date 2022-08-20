--[[
    Everything needed to make the game

]]

--allows us to draw at virtual resoluation

push = require 'lib/push'

Class = require 'lib/class' --allows for object oriented programming

Timer = require 'lib/knife/timer'


require 'src/Util'

require 'src/StateMachine'
require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/PlayState'

require 'src/Tank'
require'src/PlayerTank'
require 'src/Bullet'



WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720