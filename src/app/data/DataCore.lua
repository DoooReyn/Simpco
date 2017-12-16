------------------------------------------------------------------------------------------
---- Name   : DataCore
---- Desc   : 数据管理类
---- Date   : 2017/12/16
---- Author : Reyn - jl88744653@gmail.com
------------------------------------------------------------------------------------------

---------------------------------------------------------
-- @desc: Class DataCore
-- 
local _M = class('DataCore')

function _M:ctor()
    self.Caches    = {}
    self.Constants = {}
    self.Configs   = {}
end

---------------------------------------------------------
-- @desc: 核心加载
-- 
function _M:load()
    self:initConstants()
    self:initConfigs()
    self:initCaches()
    self:initConsole()
end

---------------------------------------------------------
-- @desc: 初始化常量数据
-- 
function _M:initConstants()
    self.Constants.ViewConst = require('app.data.const.ViewConst')
end

---------------------------------------------------------
-- @desc: 初始化配置
-- 
function _M:initConfigs()
    -- self.Configs.ViewConst = require('app.data.const.ViewConst')
end

---------------------------------------------------------
-- @desc: 初始化缓存
-- 
function _M:initCaches()
    -- self.Caches.ViewConst = require('app.data.const.ViewConst')
end

---------------------------------------------------------
-- @desc: 初始化输出
-- 
function _M:initConsole()

end

---------------------------------------------------------
-- @desc: 获取常量数据
-- 
function _M:findConstant(tag)
    local c = self.Constants[tag]
    if c then return c end
    c = require('app.data.const.' .. tag)
    self.Constants[tag] = c
    return c
end

---------------------------------------------------------
-- @desc: 获取缓存
-- 
function _M:findCache(tag)
    local c = self.Caches[tag]
    if c then return c end
    c = require('app.data.cache.' .. tag)
    self.Caches[tag] = c
    return c
end

---------------------------------------------------------
-- @desc: 获取配置
-- 
function _M:findConfig(tag)
    local c = self.Configs[tag]
    if c then return c end
    c = require('app.data.config.' .. tag)
    self.Configs[tag] = c
    return c
end

---------------------------------------------------------
-- @desc: 缓存清理
-- 
function _M:clearCache()

end

---------------------------------------------------------
-- @desc: 输出
-- 
function _M:console()

end

return _M
