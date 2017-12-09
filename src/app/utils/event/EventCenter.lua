------------------------------------------------------------------------------------------
---- Name   : EventCenter
---- Desc   : 事件中心
---- Date   : 2017/12/09
---- Author : Reyn - jl88744653@gmail.com
------------------------------------------------------------------------------------------

local EventCenter = class('EventCenter')
local __dispatcher = cc.Director:getInstance():getEventDispatcher()

function EventCenter:ctor()
    self.listenerRecords = {}
end

----------------------------------------------------
-- @desc : 添加事件监听
-- @param : eventName - 事件名称
-- @param : eventHandler - 事件处理回调
--
function EventCenter:on(eventName, eventHandler)
    if self.listenerRecords[eventName] then
        self:off(eventName)
    end
    local listener = cc.EventListenerCustom:create(eventName, eventHandler)
    __dispatcher:addEventListenerWithFixedPriority(listener, 1)
    self.listenerRecords[eventName] = listener
end

----------------------------------------------------
-- @desc : 解除事件监听
-- @param : eventName - 事件名称
--
function EventCenter:off(eventName)
    local listener = self.listenerRecords[eventName]
    if not listener then return end
    __dispatcher:removeEventListener(listener)
    slef.listenerRecords[eventName] = nil
end

----------------------------------------------------
-- @desc : 发送事件数据
-- @param : eventName - 事件名称
-- @param : eventHandler - 事件数据
--
function EventCenter:send(eventName, userData)
    local event = cc.EventCustom:new(eventName)
    event._usedata = userData
    __dispatcher:dispatchEvent(event)
end

----------------------------------------------------
-- @desc : 清理事件池子
--
function EventCenter:cleanup()
    table.foreach(self.listenerRecords, handler(self, self.off))
end

return EventCenter
