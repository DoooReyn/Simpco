local DataMgr = class('DataMgr', require('app.manager.MgrBase'))

function DataMgr:ctor()
    DataMgr.super:ctor(self)
end

return DataMgr
