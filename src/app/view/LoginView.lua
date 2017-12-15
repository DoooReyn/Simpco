local LoginView = class('LoginView', require('app.view.ViewBase'))

function LoginView:init()

end

function LoginView:onLoad()
    local sp = cc.Sprite:create('HelloWorld.png')
    sp:setPosition(display.center)
    sp:addTo(self)
end

return LoginView
