local UpdateUtil = class("UpdateUtil")

function UpdateUtil:ctor()
    self:initDownloader()
    self:showUpdateUI()
end

function UpdateUtil:initDownloader()

end

function UpdateUtil:showUpdateUI()
    cc.exports.sMainScene = cc.Scene:create()
    cc.Director:getInstance():runWithScene(sMainScene)
    local updateUI = require("hotupdate.UpdateUI"):new()
    sMainScene:addChild(updateUI)
end

function UpdateUtil:close()
    require("app.MyApp"):create():run()
end

return UpdateUtil
