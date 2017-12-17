local _M = class('UtilCore')

function _M:ctor()
    self:initGlobals()
end

function _M:initGlobals()
    require('app.utils.extend.TableExt')
    require('app.utils.Globals')
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

return _M
