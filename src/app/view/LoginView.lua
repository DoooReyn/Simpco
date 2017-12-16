local LoginView = class('LoginView', require('app.view.ViewBase'))

function LoginView:init()

end

function LoginView:onLoad()
    local sp = ccui.ImageView:create('HelloWorld.png')
    sp:setPosition(display.center)
    sp:addTo(self, 10)
    sp:setTouchEnabled(true)
    sp:onTouchEx('ended', function()
        -- self:close()
        self.Render:stopTimer('LoginTimer1')
        Game.AudioCore:playMusic(3)
    end)

    self:initTimers()
end

function LoginView:initTimers()
    self.Render:startTimer('LoginTimer1', function(dt)
        print('LoginTimer1', dt)
    end, 0.5, false)
    
    self.Render:startTimer('LoginTimer2', function(dt)
        print('LoginTimer2', dt)
        self.Render:stopAllTimers()
    end, 5, true)
end

return LoginView
