
local strfmt, mkseed, ostime = string.format, math.randomseed, os.time
local MyApp  = class("MyApp")

function MyApp:ctor()
    mkseed(ostime())
    cc.exports.Game = {}
    self:init()
end

function MyApp:init()
    self:loadAppVars()
    self:loadUtils()
    self:loadModules()
    self:console()
end

function MyApp:console()
    Game.Environment:console()
end

function MyApp:loadUtils()
    -- extend
    require('app.utils.extend.TableExt')
    -- require('app.utils.extend.NumberExt')
    -- require('app.utils.extend.StringExt')

    -- Console
    Game.Environment = require('app.utils.console.Environment')
    Game.Console     = require('app.utils.console.Console')
    
    -- eventcenter
    Game.EventCenter = require('app.utils.event.EventCenter').new()
    
    -- libs

end

function MyApp:loadModules()

end

function MyApp:loadAppVars()
    
end

function MyApp:console()
    tloop(self._appvars, function(v,k)
        print(strfmt('[App] appvar : %s => %s', k, tostring(v)))
    end)
    tloop(self._modules, function(_,k)
        print('[App] module : ' .. k)
    end)
end

function MyApp:mountModule(mod)
    self._modules[mod:getID()] = mod
end

function MyApp:fetchModule(modId)
    return self._modules[modId]
end

function MyApp:unmountModule(modId)
    self._modules[modId]:unmount()
    self._modules[modId] = nil
end

function MyApp:run()
    
end

function MyApp:reset()

end

return MyApp
