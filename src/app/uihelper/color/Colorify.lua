
local rgb      = cc.c3b
local rgba     = cc.c4b
local strupper = string.upper
local strsub   = string.sub
local strlen   = string.len
local strfmt   = string.format
local defRGB   = rgb(255,255,255)
local defRGBA  = rgba(255,255,255,255)
local convert  = cc.convertColor
local mround   = math.round


local Colorify = {}

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

--[[十六进制颜色值转换为RGB格式]]--
function Colorify:hex2c3b(hex)
    local ok, ct = checkHex(hex, 6)
    if not ok then 
        return defRGB 
    end   
    return ct
end

--[[十六进制颜色值转换为RGBA格式]]--
function Colorify:hex2c4b(hex)
    local ok, ct = checkHex(hex, 8)
    if not ok then 
        return defRGBA
    end  
    return ct
end

--[[十六进制颜色值转换为RGBA浮点数格式]]--
function Colorify:hex2c4f(hex)
    local c4b = self:hex2c4b(hex)
    table.foreach(c4b, function(v, k)
        c4b[k]= tonumber(strfmt("%.2f", v * 1.0 / 255))
    end)
    return c4b
end

--[[十进制颜色值转换为十六进制格式]]--
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

function Colorify:testcase()
    print('[Colorify] c3b')
    dump(Colorify:hex2c3b('987654'),  '987654')
    dump(Colorify:hex2c3b('abcdf1'),  'abcdf1')
    
    print('[Colorify] c4b')
    dump(Colorify:hex2c4b('12345678'),  '12345678')
    dump(Colorify:hex2c4b('abcdf123'),  'abcdf123')

    print('[Colorify] c4f')
    dump(Colorify:hex2c4f('12345678'),  '12345678')
    dump(Colorify:hex2c4f('abcdf123'),  'abcdf123')

    print('[Colorify] hex')
    print('100,120,144', Colorify:color2hex(cc.c3b(100,120,144)))
    print('200,220,244,188', Colorify:color2hex(cc.c4b(200,220,244,254)))
end

return Colorify
