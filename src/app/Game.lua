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
local strfmt = string.format

------------------------------------------
-- Class Game
--
local Game = class('Game')

function Game:ctor()
    mkseed(ostime())
    cc.Director:getInstance():setDisplayStats(CC_SHOW_FPS)
    self:updateFPS(28)
end

------------------------------------------
-- @desc : initialize Game Enviroment
--
function Game:initialize()
    self.enterFGAt = 0
    self.enterBGAt = 0
    self:initCores()
end

------------------------------------------
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

------------------------------------------
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
    self:registerSystemEvent()
    
    Game.ViewCore:loadView('LoginView')
end

------------------------------------------
-- @desc: register game system event
-- 
function Game:registerSystemEvent()    
    local Events = Game.DataCore:findConstant('EventConst')
    cc.exports.SystemEvent  = Events.System
    cc.exports.CustomEvent  = Events.Custom
    cc.exports.NetworkEvent = Events.Network
    Game.EventCore:on(SystemEvent.GameEnterBackGroundSys, handler(self, self.onEnterBackGround))
    Game.EventCore:on(SystemEvent.GameEnterForeGroundSys, handler(self, self.onEnterForeGround))
end


function Game:updateFPS(fps)
    cc.Director:getInstance():setAnimationInterval(1.0/fps)
end

------------------------------------------
-- @desc: Control Game Running State -> pause
-- 
function Game:pause()

end

------------------------------------------
-- @desc: Control Game Running State -> stop
-- 
function Game:stop()
    -- Game.UtilCore:unload()
    -- Game.DataCore:unload()  
    Game.AudioCore:unload()
    -- Game.EventCore:unload()
    -- Game.NetCore:unload() 
    -- Game.RenderCore:unload()
    -- Game.ViewCore:unload()
    -- Game.TimerCore:unload()
end

-------------------------------------------
-- @desc: Control Game Running State -> restart
-- 
function Game:restart()

end

-------------------------------------------
-- @desc: Control Game Speed -> speedUp
-- 
function Game:speedUp()

end

-------------------------------------------
-- @desc: Control Game Speed -> speedDown
-- 
function Game:speedDown()

end

-------------------------------------------
-- @desc: Control Game Speed -> speedNormal
-- 
function Game:speedNormal()

end

-------------------------------------------
-- @desc: Listen Game Enter FG Event -> onEnterForeGround
-- 
function Game:onEnterForeGround()
    self.enterFGAt = ostime()
    print(strfmt('[Game] Game Enter Foreground at : %s', tostring(self.enterFGAt)))
    print(strfmt('[Game] Game Leave Time : %ds', self:getLeaveTime()))
end

-------------------------------------------
-- @desc: Listen Game Enter BG Event -> onEnterBackGround
-- 
function Game:onEnterBackGround()
    self.enterBGAt = ostime()
    print(strfmt('[Game] Game Enter Background at : %s', tostring(self.enterBGAt)))
end

-------------------------------------------
-- @desc: get leave time (from background to foreground)
-- 
function Game:getLeaveTime()
    return self.enterFGAt - self.enterBGAt
end

return Game