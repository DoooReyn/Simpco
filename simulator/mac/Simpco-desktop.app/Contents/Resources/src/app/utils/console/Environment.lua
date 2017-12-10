local Environment = {}
local strfmt = string.format
local __EnvParams__ = require('app.data.const.EnvConst')

function Environment:isDebug()
    return DEBUG ~= 0
end

function Environment:isRelease()
    return DEBUG == 0
end

function Environment:getEnviroment()
    return self:isDebug() and 'debug' or 'release'
end

function Environment:console()
    local env = self:getEnviroment()
    table.foreach(__EnvParams__, function(v, k)
        print(strfmt('[Environment] %s : %s', k, tostring(v[env])))
    end)
end

function Environment:get(key)
    if not __EnvParams__[key] then
        return nil
    end
    return __EnvParams__[key][self:getEnviroment()]
end

return Environment
