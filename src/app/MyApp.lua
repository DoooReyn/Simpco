
local MyApp  = class("MyApp")
local strfmt = string.format
local mkseed = math.randomseed
local ostime = os.time
local tloop  = table.foreach

function MyApp:ctor()
    mkseed(ostime())
    self._appvars = {}
    self._modules = {}
    self:init()
end

function MyApp:init()
    print('aaa')
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
