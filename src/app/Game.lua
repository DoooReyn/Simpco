------------------------------------------------------------------------------------------
---- Name   : Game
---- Desc   : 游戏管理类
---- Date   : 2017/12/16
---- Author : Reyn - jl88744653@gmail.com
------------------------------------------------------------------------------------------

------------------------------------------
-- local variables
--
local mkseed = math.randomseed
local ostime = os.time

------------------------------------------
-- Class Game
--
local Game = class('Game')

---------------------------------------------------------
-- @desc: initialize work
-- 
function Game:ctor()
    mkseed(ostime())
end

function Game:initialize()
    self:initCores()
end

---------------------------------------------------------
-- @desc: Load Game Core Module -> start
-- 
function Game:initCores()
    Game.UtilCore    = require('app.utils.UtilCore'):create()
    Game.DataCore    = require('app.data.DataCore'):create()
    Game.AudioCore   = require('app.audio.AudioCore'):create()
    Game.EventCore   = require('app.event.EventCore'):create()
    Game.NetCore     = require('app.network.NetCore'):create()
    Game.RenderCore  = require('app.render.RenderCore'):create()
    Game.ViewCore    = require('app.view.ViewCore'):create()
    Game.TimerCore   = require('app.timer.TimerCore'):create()
end

---------------------------------------------------------
-- @desc: Control Game Running State -> start
-- 
function Game:start()
    Game.UtilCore:load()
    Game.DataCore:load()  
    Game.AudioCore:load()
    Game.EventCore:load()
    Game.NetCore:load() 
    Game.RenderCore:load()
    Game.ViewCore:load()
    Game.TimerCore:load()
    
    Game.ViewCore:loadView('LoginView')
end

---------------------------------------------------------
-- @desc: Control Game Running State -> pause
-- 
function Game:pause()

end

---------------------------------------------------------
-- @desc: Control Game Running State -> stop
-- 
function Game:stop()

end

---------------------------------------------------------
-- @desc: Control Game Running State -> restart
-- 
function Game:restart()

end

---------------------------------------------------------
-- @desc: Control Game Speed -> speedUp
-- 
function Game:speedUp()

end

---------------------------------------------------------
-- @desc: Control Game Speed -> speedDown
-- 
function Game:speedDown()

end

---------------------------------------------------------
-- @desc: Control Game Speed -> speedNormal
-- 
function Game:speedNormal()

end

---------------------------------------------------------
-- @desc: Listen Game Back To FG Event -> onReturnForeGround
-- 
function Game:onReturnForeGround()

end

---------------------------------------------------------
-- @desc: Control Enter BG Event -> onEnterBackGround
-- 
function Game:onEnterBackGround()

end

return Game