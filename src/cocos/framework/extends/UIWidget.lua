--[[

Copyright (c) 2014-2017 Chukong Technologies Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

]]

local Widget = ccui.Widget
local kScaleTag  = 2046
local kScaleTime = 0.03
local kScaleFact = 0.95

function Widget:onTouch(callback)
    local function scale_began()
        if not self.disableScale then
            self:stopActionByTag(kScaleTag)
            self._bs = self:getScale()
            local act = cc.ScaleTo:create(kScaleTime, self._bs*kScaleFact)
            act:setTag(kScaleTag)
            self:runAction(act)
        end
    end

    local function scale_ended()
        if not self.disableScale then
            self:stopActionByTag(kScaleTag)
            local act = cc.ScaleTo:create(kScaleTime, self._bs)
            act:setTag(kScaleTag)
            self:runAction(act)
        end
    end
    
    self:addTouchEventListener(function(sender, state)
        local event = {x = 0, y = 0}
        if state == 0 then
            event.name = "began"
            scale_began()
        elseif state == 1 then
            event.name = "moved"
        elseif state == 2 then
            event.name = "ended"
            if not self.disableAudio then
                local effectId = sender.effectId or 1
                Game.AudioCore:playEffect(effectId)
            end
            scale_ended()
        else
            event.name = "cancelled"
            scale_ended()
        end
        event.target = sender
        callback(event)
    end)
    return self
end
