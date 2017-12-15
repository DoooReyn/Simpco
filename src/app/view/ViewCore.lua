
local strfmt = string.format
local ViewConst  = Game.DataCore:findConstant('ViewConst')

local _M = class('ViewCore')

function _M:ctor()
    self._views = {}
end

function _M:load()
    self:loadGlobalNodes()
end

function _M:loadGlobalNodes()
    print('[ViewCore] loadGlobalNodes')
    GameScene:removeAllChildren()
    self.mapRoot    = cc.Node:create()
    self.objectRoot = cc.Node:create()
    self.uiRoot     = cc.Node:create()
    self.msgRoot    = cc.Node:create()
    self.guideRoot  = cc.Node:create()
    GameScene:addChild(self.mapRoot,    ViewConst.SceneZOrder.Map)
    GameScene:addChild(self.objectRoot, ViewConst.SceneZOrder.Object)
    GameScene:addChild(self.uiRoot,     ViewConst.SceneZOrder.UI)
    GameScene:addChild(self.msgRoot,    ViewConst.SceneZOrder.Msg)
    GameScene:addChild(self.guideRoot,  ViewConst.SceneZOrder.Guide)
end

function _M:loadView(vtag, ...)
    if not vtag then return nil end
    if not self._views[vtag] then
        local uiargs = ViewConst.UIArgs[vtag]
        self._views[vtag] = require(strfmt('app.view.%s', vtag)):create(...)
        self._views[vtag]:maskTouch(uiargs.swallow)
        self.uiRoot:addChild(self._views[vtag], uiargs.zorder)
        print(strfmt('[ViewCore] %s has loaded.', vtag))
    end
    return self._views[vtag]
end

function _M:releaseView(vtag)
    if not self._views[vtag] then
        prinf('[ViewCore] Sorry, we can not locate this view : ' .. tostring(vtag))
        return
    end
    local view = self._views[vtag]
    view:removeFromParent()
    self._views[vtag] = nil
end

function _M:findView(vtag)
    return self._views[vtag]
end

function _M:refreshViews()
    
end

-- function _M:pushRootViews()

-- end

-- function _M:popToRootViews()

-- end

-- function _M:cleanRootViews()

-- end

return _M
