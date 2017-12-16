local strfmt = string.format

local RenderBase = class('RenderBase')

function RenderBase:ctor()
    print(strfmt('[RenderBase] %s ctor', self.__cname))
    self.timers = {}
    self:init()
end

function RenderBase:initialize()
    self:addUIEvents()
    self:addTextures()
end

function RenderBase:onCleanup()
    print(strfmt('[RenderBase] %s onCleanup', self.__cname))
    self:stopAllTimers()
    self:removeAllUIEvents()
    self:removeAllTextures()
end

----------------------------------------------------
-- @desc : Timer
--
function RenderBase:startTimer(timer, callfn, interval, isonce)
    Game.TimerCore:startTimer(timer, callfn, interval, isonce)
    self.timers[timer] = true
end

function RenderBase:stopTimer(timer)
    Game.TimerCore:stopTimer(timer)
    self.timers[timer] = nil
end

function RenderBase:stopAllTimers()
    table.foreach(self.timers, function(timer)
        self:stopTimer(timer)
    end)
end

----------------------------------------------------
-- @desc : Texture
--
function RenderBase:addTextures()
    if not self.textures or #self.textures == 0 then return end
    table.foreach(self.textures, function(tex)
        display.loadSpriteFrames(tex)
    end)
end

function RenderBase:removeTexture(tex)
    display.removeSpriteFrames(tex)
end

function RenderBase:removeAllTextures()
    if not self.textures or #self.textures == 0 then return end
    table.foreach(self.textures, function(tex)
        self:removeTexture(tex)
    end)
end

----------------------------------------------------
-- @desc : UIEvent
--
function RenderBase:addUIEvents()
    if not self.events or #self.events == 0 then return end
    table.foreach(self.events, function(eventName, eventHandler)
        Game.EventCore:on(eventName, eventHandler)
    end)
end

function RenderBase:removeUIEvent(eventName)
    Game.EventCore:off(eventName)
end

function RenderBase:removeAllUIEvents()
    if not self.events or #self.events == 0 then return end
    table.foreach(self.events, function(eventName)
        self:removeUIEvent(eventName)
    end)
end

return RenderBase
