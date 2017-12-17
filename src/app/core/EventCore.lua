------------------------------------------------------------------------------------------
---- Name   : EventCore
---- Desc   : 事件核心类
---- Date   : 2017/12/09
---- Author : Reyn - jl88744653@gmail.com
------------------------------------------------------------------------------------------

local EventCore  = class('EventCore')
local Dispatcher = cc.Director:getInstance():getEventDispatcher()

function EventCore:ctor()
    self.listenerRecords = {}
end

----------------------------------------------------
-- @desc : 核心加载
--
function EventCore:load()
    
end

----------------------------------------------------
-- @desc : 核心卸载
--
function EventCore:unload()
    self:cleanup()
end

----------------------------------------------------
-- @desc : 添加事件监听
-- @param : eventName - 事件名称
-- @param : eventHandler - 事件处理回调
--
function EventCore:on(eventName, eventHandler)
    if self.listenerRecords[eventName] then
        self:off(eventName)
    end
    local listener = cc.EventListenerCustom:create(eventName, eventHandler)
    Dispatcher:addEventListenerWithFixedPriority(listener, 1)
    self.listenerRecords[eventName] = listener
end

----------------------------------------------------
-- @desc : 解除事件监听
-- @param : eventName - 事件名称
--
function EventCore:off(eventName)
    local listener = self.listenerRecords[eventName]
    if not listener then return end
    Dispatcher:removeEventListener(listener)
    slef.listenerRecords[eventName] = nil
end

----------------------------------------------------
-- @desc : 发送事件数据
-- @param : eventName - 事件名称
-- @param : eventHandler - 事件数据
--
function EventCore:send(eventName, userData)
    local event = cc.EventCustom:new(eventName)
    event._usedata = userData
    Dispatcher:dispatchEvent(event)
end

----------------------------------------------------
-- @desc : 清理事件池子
--
function EventCore:cleanup()
    table.foreach(self.listenerRecords, handler(self, self.off))
end

return EventCore
