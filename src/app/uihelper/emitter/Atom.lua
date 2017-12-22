local Atom  = class('Atom', ccui.ImageView)
local defFP = 'image/icon/redmark/redmark01.png'
local rand  = math.random

local function randVel()
    return cc.p(rand(-2,2), rand(0,2))
end

local function randAcc()
    return cc.p(rand(-1.3,1.3), rand(-2.1,2.1))
end

function Atom:ctor(fp)
    fp = fp or defFP
    self:loadTexture(fp)

    self.vel = randVel()    -- 初速度
    self.acc = randAcc()    -- 加速度
end

function Atom:update(t)
    local ori = cc.p(self:getPosition())
    local cur = cc.pAdd(ori, cc.pMidpoint(randVel(), randAcc()))
    self:setPosition(cur)
end


return Atom
