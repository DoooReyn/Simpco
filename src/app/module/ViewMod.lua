local ViewMod = class('ViewMod', require('app.module.ModBase'))

local saveViews = {}

function ViewMod:load()
    
end

function ViewMod:reload()

end

function ViewMod:cleaunp()
    -- do cleanup work
end

function ViewMod:console()
    -- do console work
end

function ViewMod:loadView(viewName)
    local view = saveViews[viewName]
    if not view then
        view = self:createView(viewName)
    end
    return view
end

function ViewMod:createView(viewName,vars)
    return require('app.views.'..viewName):create(vars)
end

return ViewMod
