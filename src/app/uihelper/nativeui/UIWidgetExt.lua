local Widget = ccui.Widget

function Widget:onTouchEx(name, callback)
    self:onTouch(function(event)
        if event.name == name then
            callback()
        end
    end)
    return self
end
