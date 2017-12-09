------------------------------------------------------------------------------------------
---- Name   : ViewBase
---- Desc   : 视图基类
---- Date   : 2017/12/09
---- Author : Reyn - jl88744653@gmail.com
------------------------------------------------------------------------------------------

local ViewBase = class('ViewBase', cc.Node)

----------------------------------------------------
-- @desc : 构造
-- @param : identifier - 唯一标识符
--
function ViewBase:ctor(identifier)
    self._identifier = identifier
    self:enableNodeEvents()
    self:initViewBase()
    self:bindRender()
    self:addUIEvents()
end

----------------------------------------------------
-- @desc : 添加UI事件
--
function ViewBase:addUIEvents()
    if not self.events then
        return
    end
    table.foreach(self.events, function(eventName, eventHandler)
        CGEvent:on(eventName, eventHandler)
    end)
end

----------------------------------------------------
-- @desc : 移除UI事件
--
function ViewBase:removeUIEvents()
    table.foreach(self.events, function(eventName)
        CGEvent:off(eventName)
    end)
end

----------------------------------------------------

function ViewBase:onEnter()
    self:initViewBase()
end

function ViewBase:onEnterTransitionFinish()
    if not self.loadView then
        return
    end
    self:loadView()
end

function ViewBase:onExitTransitionStart()

end

function ViewBase:onExit()

end

function ViewBase:onCleanup()
    self:removeUIEvents()
end

----------------------------------------------------
-- @desc : 初始化视图
--
function ViewBase:initViewBase()

end

----------------------------------------------------
-- @desc : 绑定视图渲染器
--
function ViewBase:bindRender()

end

----------------------------------------------------
-- @desc : 获取视图渲染器
--
function ViewBase:getRender()

end

----------------------------------------------------
-- @desc : 开始加载视图
--
function ViewBase:loadView()

end

----------------------------------------------------
-- @desc : 重新加载视图
--
function ViewBase:reloadView()

end

return ViewBase
