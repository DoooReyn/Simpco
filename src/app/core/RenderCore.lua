
------------------------------------------
-- @desc : Class RenderCore
--
local _M = class('RenderCore')

function _M:ctor()
    self.renders = {}
end

------------------------------------------
-- @desc : 核心加载
--
function _M:load()

end

------------------------------------------
-- @desc : 核心卸载
--
function _M:unload()

end

------------------------------------------
-- @desc : 加载渲染器
-- @param : rtag - 渲染器名称
--
function _M:loadRender(rtag)
    if not rtag then return nil end
    local r = self.renders[rtag]
    if not r then 
        r = require('app.render.' .. string.gsub(rtag, 'View', 'Render')):create()
        self.renders[rtag] = r
    end
    return r
end

------------------------------------------
-- @desc : 卸载渲染器
-- @param : rtag - 渲染器名称
--
function _M:unloadRender(rtag)
    if not rtag or not self.renders[rtag] then 
        return 
    end
    self.renders[rtag]:onCleanup()
    self.renders[rtag] = nil
end

------------------------------------------
-- @desc : 获取渲染器
-- @param : rtag - 渲染器名称
--
function _M:findRender(rtag)
    if not rtag or not self.renders[rtag] then 
        return  nil
    end
    return self.renders[rtag]
end

return _M
