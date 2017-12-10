local ResMod = class('ResMod', require('app.module.ModBase'))

function ResMod:ctor()
    ResMod.super:ctor(self)
end

return ResMod
