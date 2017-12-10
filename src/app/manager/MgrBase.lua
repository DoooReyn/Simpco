local MgrBase = class('MgrBase')

function MgrBase:ctor(child)
    self._identifier = child.__cname or 'Unknown'
    self:mount()
end

function MgrBase:getID()
    return self._identifier
end

function MgrBase:mount()
    Game.Modules[self._identifier] = self
end

function MgrBase:unmount()
    self:cleanup()
    Game.Modules[self._identifier] = nil
end

function MgrBase:load()

end

function MgrBase:reload()

end

function MgrBase:cleaunp()
    -- do cleanup work
end

function MgrBase:console()
    -- do console work
end

return MgrBase
