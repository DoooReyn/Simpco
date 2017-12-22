local Emitter  = class('Emitter', cc.Node)
local AtomNode = require('app.uihelper.emitter.Atom')

function Emitter:ctor()
    self:enableNodeEvents()
end

function Emitter:onEnter()

end

function Emitter:onExit()
    self:cleanup()
end

function Emitter:cleanup()
    self:unscheduleUpdate()
    self:removeAllChildren()
end

function Emitter:start()
    self:scheduleUpdateWithPriorityLua(handler(self, self.onFrameUpdate), 0)
end

function Emitter:makeAtom(num)
    for i=1, num do
        local atom = AtomNode:create()
        atom:setPosition(0,0)
        self:addChild(atom, 1)
    end
end

function Emitter:onFrameUpdate(dt)
    -- self:setPositionY(self:getPositionY()+1)
    local children = self:getChildren()
    print('num:' .. #children)
    for _,v in ipairs(children) do
        v:update(dt)
        local pos_atom = cc.p(v:getPosition())
        local pos_emit = cc.p(self:getPosition())
        if (pos_atom.x < -display.width*0.5 or pos_atom.x > display.width*0.5)
        or (pos_atom.y - pos_emit.y > display.height) then
            print('remove')
            v:removeFromParent()
        end
    end
end

return Emitter
