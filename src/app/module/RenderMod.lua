local RenderMgr = class('RenderMgr', require('app.manager.MgrBase'))

function RenderMgr:ctor()
    RenderMgr.super:ctor(self)
end

return RenderMgr
