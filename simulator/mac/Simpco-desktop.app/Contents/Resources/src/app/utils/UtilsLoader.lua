local UtilsLoader = {}

function UtilsLoader:load()
    self:loadExtend()
    self:loadEventCenter()
    self:loadLibs()
end

function UtilsLoader:loadExtend()
end

function UtilsLoader:addVar(varName, varVal)
    self[varName] = varVal
end

function UtilsLoader:getVar(varName)
    return self[varName]
end

function UtilsLoader:loadEventCenter()

end

function UtilsLoader:loadLibs()
    
end

return UtilsLoader
