local _M = class('ViewCore')

function _M:ctor()
    self._views = {}
end

function _M:load()

end

function _M:loadView(vtag, ...)
    if not self._views[vtag] then
        self._views[vtag] = require(strfmt('app.views.%s'), vtag):create(...)
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
