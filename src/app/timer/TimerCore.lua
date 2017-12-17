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
-- Class TimerCore
--
local TimerCore = class('TimerCore')

function TimerCore:ctor()
    self.timers = {}
    self.scheduler = cc.Director:getInstance():getScheduler()
end

------------------------------------------
-- @desc : load TimerCore
--
function TimerCore:load()

end

------------------------------------------
-- @desc : unload TimerCore
--
function TimerCore:unload()
    self:stopAllTimer()
end

------------------------------------------
-- @desc : find timer
-- @param : timer - timer name
--
function TimerCore:findTimer(timer)
    if self.timers[timer] then
        return true
    end
    return false
end

------------------------------------------
-- @desc : start timer
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
-- @desc : stop timer
-- @param : timer - timer name
--
function TimerCore:stopTimer(timer)
    if not self:findTimer(timer) then return end
    self.scheduler:unscheduleScriptEntry(self.timers[timer])
    self.timers[timer] = nil
    print(strfmt('[TimerCore] %s is stop.', timer))
end

------------------------------------------
-- @desc : stop all timer
--
function TimerCore:stopAllTimer()
    table.foreach(self.timers, function(timerId, timer)
        self.scheduler:unscheduleScriptEntry(timerId)
        self.timers[timer] = nil
    end)
end

return TimerCore
