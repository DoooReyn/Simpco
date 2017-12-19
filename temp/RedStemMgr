local RedStemMgr = class('RedStemMgr')
local RedStem    = require('app.uihelper.redmark.RedStem')

function RedStemMgr:ctor()
    self.redRoot = RedStem:create(1)
end

function RedStemMgr:newStem(stemID)
    if self:getStem(stemId) then
        return nil
    end
    return RedStem:create(stemID)
end

function RedStemMgr:getStem(stemID)
    return self.redRoot:findChild(stemID)
end

function RedStemMgr:update()
    self.redRoot:update()
end

return RedStemMgr
