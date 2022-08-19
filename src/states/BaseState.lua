--[[
    Basis for all the states of our state machine
]]

BaseState = Class{}
function BaseState:init() end
function BaseState:enter() end
function BaseState:exit() end
function BaseState:update(dt) end
function BaseState:render() end