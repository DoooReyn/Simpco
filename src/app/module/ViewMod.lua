local ViewMod = class('ViewMod', require('app.module.ModBase'))

function ViewMod:ctor()
    ViewMod.super:ctor(self)
end

return ViewMod
