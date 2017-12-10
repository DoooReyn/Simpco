local ModBase = class('ModBase')

function ModBase:ctor()
    self:mount()
end

function ModBase:getID()
    return self.__cname
end

function ModBase:mount()
    local mod = Game.Modules[self.__cname]
    if mod then 
        mod:unmount() 
    end
    Game.Modules[self.__cname] = self
end

function ModBase:unmount()
    self:cleanup()
    Game.Modules[self.__cname] = nil
end

function ModBase:load()

end

function ModBase:reload()

end

function ModBase:cleaunp()
    -- do cleanup work
end

function ModBase:console()
    -- do console work
end

return ModBase
