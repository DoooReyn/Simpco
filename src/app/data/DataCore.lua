local _M = class('DataCore')

function _M:ctor()
    self.Constants = {}
end

function _M:load()
    self:loadConstant()
    self:loadConfig()
    self:loadCache()
    self:loadConsole()
end

function _M:loadConstant()
    self.Constants.ViewConst = require('app.data.const.ViewConst')
end

function _M:loadConfig()

end

function _M:loadCache()

end

function _M:loadConsole()

end

function _M:clearCache()

end

function _M:findConstant(tag)
    local c = self.Constants[tag]
    if c then return c end
    c = require('app.data.const.' .. tag)
    self.Constants[tag] = c
    return c
end

function _M:console()

end

function _M:findCache()

end

function _M:findConfig()

end

return _M
