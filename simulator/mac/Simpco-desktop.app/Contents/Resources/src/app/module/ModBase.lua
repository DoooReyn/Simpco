local ModBase = class('ModBase')

function ModBase:ctor(child)
    self._identifier = child.__cname or 'Unknown'
    self:mount()
end

function ModBase:getID()
    return self._identifier
end

function ModBase:mount()
    Game.Modules[self._identifier] = self
end

function ModBase:unmount()
    self:cleanup()
    Game.Modules[self._identifier] = nil
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
