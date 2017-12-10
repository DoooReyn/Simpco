local SrcMgr = class('SrcMgr', require('app.manager.MgrBase'))

function SrcMgr:ctor()
    SrcMgr.super:ctor(self)
end

return SrcMgr
