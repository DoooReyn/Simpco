local MgrBase = class('MgrBase')

function MgrBase:ctor(identifier)
    self._identifier = identifier
    self:registerApp()
end

function MgrBase:getID()
    return self._identifier
end

function MgrBase:mount()
    sApp:mountModule(self)
end

function MgrBase:unmount()
    -- do cleanup work
end

function MgrBase:console()
    -- do console work
end

return MgrBase
