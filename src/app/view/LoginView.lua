local LoginView = class('LoginView', require('app.view.ViewBase'))

function LoginView:init()

end

function LoginView:onLoad()
    local emitter = require('app.uihelper.emitter.Emitter'):create()
    emitter:setPosition(cc.p(display.cx, 0))
    emitter:addTo(self, 20)
    emitter:start()
        
    local text = ccui.Text:create()
    text:setString("点我开始")
    text:setFontSize(48)
    text:setPosition(display.center)
    text:addTo(self, 10)
    text:setTouchEnabled(true)
    text:onTouchEx('ended', function()
        -- Game.ViewCore:loadView()
        -- self:close()
        print('开始游戏')
        -- text:removeFromParent()
        emitter:makeAtom(5)
    end)
end

return LoginView
