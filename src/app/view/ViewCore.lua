------------------------------------------------------------------------------------------
---- Name   : ViewCore
---- Desc   : 视图核心类
---- Date   : 2017/12/16
---- Author : Reyn - jl88744653@gmail.com
------------------------------------------------------------------------------------------

------------------------------------------
-- local variables
--
local strfmt    = string.format
local ViewConst = Game.DataCore:findConstant('ViewConst')

---------------------------------------------------------
-- @desc: Class ViewCore
-- 
local _M = class('ViewCore')

function _M:ctor()
    self._views = {}
end

---------------------------------------------------------
-- @desc: Core load function
-- 
function _M:load()
    self:loadRootNodes()
end

---------------------------------------------------------
-- @desc: Core unload function
-- 
function _M:unload()

end

---------------------------------------------------------
-- @desc: 加载根节点
-- 
function _M:loadRootNodes()
    print('[ViewCore] loadRootNodes')
    GameScene:removeAllChildren()
    self.mapRoot    = cc.Node:create()
    self.objectRoot = cc.Node:create()
    self.uiRoot     = cc.Node:create()
    self.msgRoot    = cc.Node:create()
    self.guideRoot  = cc.Node:create()
    self.actionRoot = cc.Node:create()
    GameScene:addChild(self.mapRoot,    ViewConst.SceneZOrder.Map)
    GameScene:addChild(self.objectRoot, ViewConst.SceneZOrder.Object)
    GameScene:addChild(self.uiRoot,     ViewConst.SceneZOrder.UI)
    GameScene:addChild(self.msgRoot,    ViewConst.SceneZOrder.Msg)
    GameScene:addChild(self.guideRoot,  ViewConst.SceneZOrder.Guide)
    GameScene:addChild(self.actionRoot, ViewConst.SceneZOrder.Action)
end

---------------------------------------------------------
-- @desc: 加载视图
-- 
function _M:loadView(vtag, ...)
    if not vtag then return nil end
    if not self._views[vtag] then
        local uiargs = ViewConst.UIArgs[vtag]
        self._views[vtag] = require(strfmt('app.view.%s', vtag)):create(...)
        self._views[vtag]:maskTouch(uiargs.swallow)
        self.uiRoot:addChild(self._views[vtag])
    end
    print(strfmt('[ViewCore] %s has loaded.', vtag))
    return self._views[vtag]
end

---------------------------------------------------------
-- @desc: 释放视图
-- 
function _M:releaseView(vtag)
    if not self._views[vtag] then
        prinf('[ViewCore] Sorry, we can not locate this view : ' .. tostring(vtag))
        return
    end
    local view = self._views[vtag]
    view:removeFromParent()
    self._views[vtag] = nil
    print(strfmt('[ViewCore] %s has released.', vtag))
end

---------------------------------------------------------
-- @desc: 获取视图
-- 
function _M:findView(vtag)
    return self._views[vtag]
end

---------------------------------------------------------
-- @desc: 刷新所有视图
-- 
function _M:refreshViews()
    
end

return _M
