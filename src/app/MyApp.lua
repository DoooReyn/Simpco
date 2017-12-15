

------------------------------------------
-- local variables
--
local strfmt = string.format
local mkseed = math.randomseed
local ostime = os.time


local MyApp  = class("MyApp")

function MyApp:ctor()
    mkseed(ostime())
end

function MyApp:console()
    self.Environment:console()
end

function MyApp:loadAppVars()
    self.AppVars = {}

end

function MyApp:loadUtils()
    -- extend
    require('app.utils.extend.TableExt')
    -- require('app.utils.extend.NumberExt')
    -- require('app.utils.extend.StringExt')
    self.SecurityNumber = require('app.utils.extend.SecurityNumber')

    -- Console
    self.Environment = require('app.utils.console.Environment')
    self.Console     = require('app.utils.console.Console')
    
    -- eventcenter
    self.EventCenter = require('app.utils.event.EventCenter').new()
    
    -- libs

end

function MyApp:loadModules()
    self.Modules = {}
    require('app.module.ResMod'):create()
    require('app.module.SrcMod'):create()
    require('app.module.DataMod'):create()
    require('app.module.RenderMod'):create()
    require('app.module.ViewMod'):create()
    require('app.module.SoundMod'):create()
end

function MyApp:console()
    table.foreach(self.Modules, function(_,k)
        print('[Game] module : ' .. k)
    end)
end

function MyApp:run()
    self:console()
end

function MyApp:reset()

end

return MyApp
