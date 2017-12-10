local SrcMod = class('SrcMod', require('app.module.ModBase'))

function SrcMod:ctor()
    SrcMod.super:ctor(self)
end

return SrcMod
