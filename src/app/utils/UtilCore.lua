local _M = class('UtilCore')

function _M:ctor()
    self:initGlobals()
end

function _M:initGlobals()
    require('app.utils.Globals')
    require('app.utils.extend.UIWidgetExt')
end

function _M:load()

end

return _M
