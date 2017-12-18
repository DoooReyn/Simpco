------------------------------------------------------------------------------------------
---- Name   : TimerCore
---- Desc   : 定时器核心类
---- Date   : 2017/12/16
---- Author : Reyn - jl88744653@gmail.com
------------------------------------------------------------------------------------------

------------------------------------------
-- local variables
--
local strfmt    = string.format

------------------------------------------
-- @desc : Class TimerCore
--
local TimerCore = class('TimerCore')

function TimerCore:ctor()
    self.timers = {}
    self.scheduler = cc.Director:getInstance():getScheduler()
end

------------------------------------------
-- @desc : 核心加载
--
function TimerCore:load()

end

------------------------------------------
-- @desc : 核心卸载
--
function TimerCore:unload()
    self:stopAllTimer()
end

------------------------------------------
-- @desc : 获取定时器
-- @param : timer - timer name
--
function TimerCore:findTimer(timer)
    if self.timers[timer] then
        return true
    end
    return false
end

------------------------------------------
-- @desc : 开启定时器
-- @param : timer - timer name
-- @param : callfn - timer callback
-- @param : interval - timer interval
-- @param : isonce - call timer once or not 
--
function TimerCore:startTimer(timer, callfn, interval, isonce)
    if self:findTimer(timer) then
        self:stopTimer(timer)
    end
    local function oncefn(dt)
        callfn(dt) 
        self:stopTimer(timer)
    end
    local packfn  = isonce and oncefn or callfn
    local timerId = self.scheduler:scheduleScriptFunc(packfn, interval, false)
    self.timers[timer] = timerId
    print(strfmt('[TimerCore] %s is running.', timer))
end

------------------------------------------
-- @desc : 停止定时器
-- @param : timerId - timer ID
--
function TimerCore:unscheduleTimerById(timerId)
    self.scheduler:unscheduleScriptEntry(timerId)
end

------------------------------------------
-- @desc : 停止定时器
-- @param : timer - timer name
--
function TimerCore:stopTimer(timer)
    if not self:findTimer(timer) then return end
    self:unscheduleTimerById(self.timers[timer])
    self.timers[timer] = nil
    print(strfmt('[TimerCore] %s is stop.', timer))
end

------------------------------------------
-- @desc : 停止所有定时器
--
function TimerCore:stopAllTimer()
    table.foreach(self.timers, function(timerId, timer)
        self:unscheduleTimerById(timerId)
        self.timers[timer] = nil
    end)
    print('[TimerCore] All timer is stop.')
end

return TimerCore
