
------------------------------------------------------------------------------------------
---- Name   : Colorify
---- Desc   : 色值转换工具
---- Date   : 2017/12/18
---- Author : Reyn - jl88744653@gmail.com
------------------------------------------------------------------------------------------

---------------------------------------------------------
-- @desc : 局域变量
-- 
local rgb      = cc.c3b
local rgba     = cc.c4b
local strupper = string.upper
local strsub   = string.sub
local strlen   = string.len
local strfmt   = string.format
local defRGB   = cc.c3b(255,255,255)
local defRGBA  = cc.c4b(255,255,255,255)
local foreach  = table.foreach


---------------------------------------------------------
-- @desc : Colorify
-- 
local Colorify = {}

---------------------------------------------------------
-- @desc : 检查十六进制色值是否有效
-- @param : hex - 十六进制色值
-- @param : num - 6/8 bit
-- 
local function checkHex(hex, num)
    hex = strupper(hex)
    local len = strlen(hex)
    if len ~= num then 
        return false, nil
    end
    local c = {}
    c.r = strfmt('%i', '0x'..strsub(hex, 1, 2))
    c.g = strfmt('%i', '0x'..strsub(hex, 3, 4))
    c.b = strfmt('%i', '0x'..strsub(hex, 5, 6))
    if len == 8 then
        c.a = strfmt('%i', '0x'..strsub(hex, 7, 8))
    end
    return true, c
end

---------------------------------------------------------
-- @desc : 十六进制色值转RGB
-- @param : hex - 十六进制色值
-- 
function Colorify:hex2c3b(hex)
    local ok, ct = checkHex(hex, 6)
    if not ok then 
        return defRGB 
    end   
    return ct
end

---------------------------------------------------------
-- @desc : 十六进制色值转RGBA
-- @param : hex - 十六进制色值
-- 
function Colorify:hex2c4b(hex)
    local ok, ct = checkHex(hex, 8)
    if not ok then 
        return defRGBA
    end  
    return ct
end

---------------------------------------------------------
-- @desc : 十六进制色值转RGBA浮点数
-- @param : hex - 十六进制色值
-- 
function Colorify:hex2c4f(hex)
    local c4b = self:hex2c4b(hex)
    foreach(c4b, function(v, k)
        c4b[k]= tonumber(strfmt("%.2f", v * 1.0 / 255))
    end)
    return c4b
end

---------------------------------------------------------
-- @desc : RGB(A)转十六进制色值
-- @param : color - RGB(A)色值
-- 
function Colorify:color2hex(color)
    color.r = color.r or 255
    color.g = color.g or 255
    color.b = color.b or 255
    local c = strfmt('%X%X%X', color.r, color.g, color.b)
    if color.a then
        c = c .. strfmt('%X', color.a)
    end
    return c
end

return Colorify
