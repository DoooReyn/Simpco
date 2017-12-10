local UpdateUtil = class("UpdateUtil")

function UpdateUtil:ctor()
    self:initDownloader()
    self:showUpdateUI()
end

function UpdateUtil:initDownloader()
    self.downloader = require("hotupdate.Downloader"):new()
end

function UpdateUtil:showUpdateUI()
    cc.exports.sMainScene = cc.Scene:create()
    cc.Director:getInstance():runWithScene(sMainScene)
    local updateUI = require("hotupdate.UpdateUI"):new()
    sMainScene:addChild(updateUI)

    if false then
        self:checkUpdate()
    else
        self:lauchGame()
    end
end

function UpdateUtil:checkUpdate()
    
end

function UpdateUtil:onLauchUpdate()

end

function UpdateUtil:onUpdateProgress()

end

function UpdateUtil:onUpdateFail()

end

function UpdateUtil:onUpdatComplete()
    self:lauchGame()
    self:removeFromParent()
end

function UpdateUtil:lauchGame()
    require("app.MyApp"):create():run()
end

return UpdateUtil
