local ViewMgr = class('ViewMgr', require('app.manager.MgrBase'))

function ViewMgr:ctor()
    ViewMgr.super:ctor(self)
end

return ViewMgr
