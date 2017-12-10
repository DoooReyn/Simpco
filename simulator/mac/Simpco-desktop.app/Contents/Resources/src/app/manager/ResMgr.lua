local ResMgr = class('ResMgr', require('app.manager.MgrBase'))

function ResMgr:ctor()
    ResMgr.super:ctor(self)
end

return ResMgr
