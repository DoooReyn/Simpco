local _M = class('UtilCore')

function _M:ctor()
    self:initGlobals()
end

function _M:initGlobals()
    require('app.utils.extend.TableExt')
    require('app.utils.extend.UIWidgetExt')
    require('app.utils.Globals')
end

function _M:load()

end

return _M
