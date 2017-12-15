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
    self:loadCores()
end

---------------------------------------------------------
-- @desc: Load Game Core Module -> start
-- 
function Game:loadCores()
    Game.UtilCore    = require('app.utils.UtilCore'):create()
    Game.DataCore    = require('app.data.DataCore'):create()
    Game.EventCore   = require('app.event.EventCore'):create()
    Game.NetCore     = require('app.network.NetCore'):create()
    Game.RenderCore  = require('app.render.RenderCore'):create()
    Game.ViewCore    = require('app.view.ViewCore'):create()
end

---------------------------------------------------------
-- @desc: Control Game Running State -> start
-- 
function Game:start()
    Game.ViewCore:loadView()
    Game.ViewCore:reloadView()
    Game.ViewCore:releaseView()
    Game.ViewCore:findView()
    Game.ViewCore:refreshView()
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