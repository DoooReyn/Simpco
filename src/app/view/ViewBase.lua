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
    self:bindRender()
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
end

function ViewBase:onExitTransitionStart_()
    print(strfmt('[ViewBase] %s onExitTransitionStart', self.__cname))
end

function ViewBase:onExit_()
    print(strfmt('[ViewBase] %s onExit', self.__cname))
end

function ViewBase:onCleanup_()
    print(strfmt('[ViewBase] %s onCleanup', self.__cname))
    self:disableFrameUpdate()
    self.Render:onCleanup()
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
    self.Render = Game.RenderCore:loadRender(self.__cname)
    pcall(function() self.Render:initialize() end)
end

function ViewBase:enableFrameUpdate()
    if not self.onFrameUpdate then 
        return 
    end
    self:scheduleUpdateWithPriorityLua(handler(self, self.onFrameUpdate), 0)
end

function ViewBase:disableFrameUpdate()
    if not self.onFrameUpdate then 
        return 
    end
    self:unscheduleUpdate()
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
