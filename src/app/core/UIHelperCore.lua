
------------------------------------------------------------------------------------------
---- Name   : UIHelperCore
---- Desc   : UI辅助工具核心类
---- Date   : 2017/12/18
---- Author : Reyn - jl88744653@gmail.com
------------------------------------------------------------------------------------------

---------------------------------------------------------
-- @desc: Class UIHelperCore
-- 
local UIHelperCore = class('UIHelperCore')

function UIHelperCore:ctor()
    self:initNativeUI()
    self:initColorify()
end

function UIHelperCore:initNativeUI()
    require('app.uihelper.nativeui.UIWidgetExt')
end

function UIHelperCore:initColorify()
    cc.exports.Colorify = require('app.uihelper.color.Colorify')
    Colorify:testcase()
end

---------------------------------------------------------
-- @desc: 核心加载
-- 
function UIHelperCore:load()
    
end

---------------------------------------------------------
-- @desc: 核心卸载
-- 
function UIHelperCore:unload()

end

return UIHelperCore
