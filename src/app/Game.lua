------------------------------------------------------------------------------------------
---- Name   : Game
---- Desc   : 游戏管理类
---- Date   : 2017/12/16
---- Author : Reyn - jl88744653@gmail.com
------------------------------------------------------------------------------------------

------------------------------------------
-- local variables
--
local mkseed   = math.randomseed
local ostime   = os.time
local strfmt   = string.format
local director = cc.Director:getInstance()

------------------------------------------
-- Class Game
--
local Game = class('Game')

function Game:ctor()
    mkseed(ostime())
    self:showFPS(CC_SHOW_FPS)
    self:updateFPS(60)
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
-- @desc: 初始化核心
-- 
function Game:initCores()
    Game.UtilCore   = require('app.core.UtilCore'):create()
    Game.DataCore   = require('app.core.DataCore'):create()
    Game.AudioCore  = require('app.core.AudioCore'):create()
    Game.EventCore  = require('app.core.EventCore'):create()
    Game.NetCore    = require('app.core.NetCore'):create()
    Game.RenderCore = require('app.core.RenderCore'):create()
    Game.ViewCore   = require('app.core.ViewCore'):create()
    Game.TimerCore  = require('app.core.TimerCore'):create()
end

------------------------------------------
-- @desc: Control Game Running State -> start
-- 
function Game:start()
    -- 启动核心加载程序
    Game.UtilCore:load()
    Game.DataCore:load()  
    Game.AudioCore:load()
    Game.EventCore:load()
    Game.NetCore:load() 
    Game.RenderCore:load()
    Game.ViewCore:load()
    Game.TimerCore:load()
    
    --注册系统事件
    self:registerSystemEvent()
    
    --挂载第一个视图
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
    director:setAnimationInterval(1.0/fps)
end

function Game:showFPS(isshow)
    director:setDisplayStats(isshow)
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