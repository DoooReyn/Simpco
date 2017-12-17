local _M = class('RenderCore')

function _M:ctor()
    self.renders = {}
end

function _M:load()

end

function _M:unload()

end

function _M:loadRender(rtag)
    if not rtag then return nil end
    local r = self.renders[rtag]
    if not r then 
        r = require('app.render.' .. string.gsub(rtag, 'View', 'Render')):create()
        self.renders[rtag] = r
    end
    return r
end

function _M:unloadRender(rtag)
    if not rtag or not self.renders[rtag] then 
        return 
    end
    self.renders[rtag]:onCleanup()
    self.renders[rtag] = nil
end

function _M:findRender(rtag)
    if not rtag or not self.renders[rtag] then 
        return  nil
    end
    return self.renders[rtag]
end

return _M
