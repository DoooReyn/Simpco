local RedMarkNode = class('RedMarkNode', cc.Sprite)
local kTickTag = 1001
local defFP = 'image/icon/redmark/redmark01.png'

function RedMarkNode:ctor(fp)
    fp = fp or defFP
    self:setTexture(fp)
end

function RedMarkNode:startTick(interval)
    self:stopTick()
    interval = interval or 2
    local dlt  = cc.DelayTime:create(interval*0.4)
    local sca1 = cc.ScaleBy:create(interval*0.3, 1.15)
    local sca2 = sca1:reverse()
    local seq  = cc.Sequence:create(dlt, sca1, sca2, seq)
    local tick = cc.RepeatForever:create(seq)
    tick:setTag(kTickTag)
    self:runAction(tick)
end

function RedMarkNode:stopTick()
    self:stopActionByTag(kTickTag)
end

return RedMarkNode
