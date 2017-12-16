------------------------------------------------------------------------------------------
---- Name   : ViewBase
---- Desc   : 视图基类
---- Date   : 2017/12/09
---- Author : Reyn - jl88744653@gmail.com
------------------------------------------------------------------------------------------
local strfmt   = string.format
local ViewBase = class('ViewBase', cc.Node)

----------------------------------------------------
-- @desc : 构造
-- @param : identifier - 唯一标识符
--
function ViewBase:ctor(vars)
    if vars and type(vars) == 'table' then 
        self._vars = vars 
    end
    print(strfmt('[ViewBase] %s ctor', self.__cname))
    self:init()
    self:loadViewBase()
end

----------------------------------------------------
-- @desc : 获取传入视图的参数
--
function ViewBase:getVar(var)
    if not self._vars then
        return nil
    end
    return self._vars[var]
end

----------------------------------------------------
-- @desc : 加载视图基础
--
function ViewBase:loadViewBase()
    self:enableNodeEvents()
    self:addTextures()
    self:addUIEvents()
    self:bindRender()
end

----------------------------------------------------
-- @desc : 添加UI事件
--
function ViewBase:addUIEvents()
    if not self.events then return end
    table.foreach(self.events, function(eventName, eventHandler)
        sEvent:on(eventName, eventHandler)
    end)
end

----------------------------------------------------
-- @desc : 移除UI事件
--
function ViewBase:removeUIEvents()
    if not self.events then return end
    table.foreach(self.events, function(eventName)
        sEvent:off(eventName)
    end)
end

----------------------------------------------------
-- @desc : 添加UI用纹理
--
function ViewBase:addTextures()
    if not self.textures then return end
    table.foreach(self.textures, function(v)
        display.loadSpriteFrames(sResMgr:get(v))
    end)
end

----------------------------------------------------
-- @desc : 移除UI用纹理
--
function ViewBase:removeTextures()
    if not self.textures then return end
    table.foreach(self.textures, function(v)
        display.removeSpriteFrames(sResMgr:get(v))
    end)
end

----------------------------------------------------

function ViewBase:onEnter_()
    print(strfmt('[ViewBase] %s onEnter', self.__cname))
    self:loadCsbNode()
end

function ViewBase:onEnterTransitionFinish_()
    print(strfmt('[ViewBase] %s onEnterTransitionFinish', self.__cname))
    if not self.onLoad then
        return
    end
    self:onLoad()
    print(strfmt('[ViewBase] %s onLoad', self.__cname))
end

function ViewBase:onExitTransitionStart_()
    print(strfmt('[ViewBase] %s onExitTransitionStart', self.__cname))
end

function ViewBase:onExit_()
    print(strfmt('[ViewBase] %s onExit', self.__cname))
end

function ViewBase:onCleanup_()
    self:removeUIEvents()
end

----------------------------------------------------
-- @desc : 初始化视图
--
function ViewBase:loadCsbNode()
    print(strfmt('[ViewBase] %s loadCsbNode', self.__cname))
    -- self.rootNode = Game.CacheMod.CsbCache:get(self.__cname, true)
    -- self:addChild(self.rootNode)
end

----------------------------------------------------
-- @desc : 绑定视图渲染器
--
function ViewBase:bindRender()
    Game.RenderCore:loadRender(self.__cname)
end

----------------------------------------------------
-- @desc : 获取视图渲染器
--
function ViewBase:getRender()
    return Game.RenderCore:findRender(self.__cname)
end

----------------------------------------------------
-- @desc : 重新加载视图
--
function ViewBase:onReload()

end

----------------------------------------------------
-- @desc : 加载UI屏蔽层，默认屏蔽下层
--
function ViewBase:maskTouch(isSwallow)
    isSwallow = isSwallow ~= nil and isSwallow or false
    
    local function onTouchBegan(touch, event)
        print(strfmt('[ViewBase] %s isSwallow : %s', self.__cname, tostring(isSwallow)))
        if self.onTouchBegan then
            self:onTouchBegan(touch, event)
        end
        return true
    end

    local function onTouchMoved(touch,event)
        if self.onTouchMoved then
            self:onTouchMoved(touch,event)
        end
    end

    local function onTouchEnded(touch,event)
        if self.onTouchEnded then
            self:onTouchEnded(touch,event)
        end
    end

    local function onTouchCancelled(touch,event)
        if self.onTouchCancelled then
            self:onTouchCancelled(touch,event)
        end
    end

    self.touchListener = cc.EventListenerTouchOneByOne:create()
    self.touchListener:setSwallowTouches(isSwallow)
    self.touchListener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    self.touchListener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    self.touchListener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    self.touchListener:registerScriptHandler(onTouchCancelled,cc.Handler.EVENT_TOUCH_CANCELLED)
    self:getEventDispatcher():addEventListenerWithSceneGraphPriority(self.touchListener, self)
end

----------------------------------------------------
-- @desc : 关闭
--
function ViewBase:close()
    Game.ViewCore:releaseView(self.__cname)
end

return ViewBase
