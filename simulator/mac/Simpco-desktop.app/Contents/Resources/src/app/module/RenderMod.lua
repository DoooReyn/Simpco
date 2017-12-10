local RenderMod = class('RenderMod', require('app.module.ModBase'))

function RenderMod:ctor()
    RenderMod.super:ctor(self)
end

return RenderMod
