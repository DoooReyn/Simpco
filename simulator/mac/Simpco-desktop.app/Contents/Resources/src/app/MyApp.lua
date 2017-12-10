
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
    Game.Modules = {}
    require('app.module.ResMod').new()
    require('app.module.SrcMod').new()
    require('app.module.DataMod').new()
    require('app.module.RenderMod').new()
    require('app.module.ViewMod').new()
end

function MyApp:loadAppVars()
    
end

function MyApp:console()
    table.foreach(Game.Modules, function(_,k)
        print('[Game] module : ' .. k)
    end)
end

function MyApp:run()
    self:console()
end

function MyApp:reset()

end

return MyApp
