local DataMod = class('DataMod', require('app.module.ModBase'))

function DataMod:ctor()
    DataMod.super:ctor(self)
end

return DataMod
