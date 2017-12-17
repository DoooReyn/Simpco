
local rgb      = cc.c3b
local rgba     = cc.c4b
local strupper = string.upper
local strsub   = string.sub
local strlen   = string.len
local defRGB   = rgb(255,255,255)
local defRGBA  = rgba(255,255,255,255)
local convert  = cc.convertColor


local Colorify = {}

local function checkHex(hex, num)
    hex = strupper(hex)
    local len = strlen(hex)
    if len < num then 
        return false, nil
    end
    local ct = {}
    for i=1, len, 2 do
        local n = tonumber(strsub(hex,i,i+1), 16)
        if n == nil or n < 0 or n > 255 then
            return false, nil
        end
        table.insert(ct, n)
    end
    return true, ct
end

--[[十六进制颜色值转换为RGB格式]]--
function Colorify:hex2c3b(hex)
    local ok, ct = checkHex(hex, 6)
    if not ok then 
        return defRGB 
    end   
    return rgb(unpack(ct))
end

--[[十六进制颜色值转换为RGBA格式]]--
function Colorify:hex2c4b(hex)
    local ok, ct = checkHex(hex, 8)
    if not ok then 
        return defRGBA
    end  
    return rgba(unpack(ct))
end

function Colorify:hex2c4f(hex)
    return convert(self:hex2c4b(hex), '4f')
end

function Colorify:testcase()
    print('[Colorify] c3b')
    dump(Colorify:hex2c3b('12345'),   '12345')
    dump(Colorify:hex2c3b('987654'),  '987654')
    dump(Colorify:hex2c3b('9876542'), '9876542')
    dump(Colorify:hex2c3b('abcdf1'),  'abcdf1')
    dump(Colorify:hex2c3b('abcdfg'),  'abcdfg')
    
    print('[Colorify] c4b')
    dump(Colorify:hex2c4b('1234567'),   '1234567')
    dump(Colorify:hex2c4b('12345678'),  '12345678')
    dump(Colorify:hex2c4b('123456789'), '123456789')
    dump(Colorify:hex2c4b('abcdf123'),  'abcdf123')
    dump(Colorify:hex2c4b('abcdfghi'),  'abcdfghi')

    print('[Colorify] c4f')
    dump(Colorify:hex2c4f('1234567'),   '1234567')
    dump(Colorify:hex2c4f('12345678'),  '12345678')
    dump(Colorify:hex2c4f('123456789'), '123456789')
    dump(Colorify:hex2c4f('abcdf123'),  'abcdf123')
    dump(Colorify:hex2c4f('abcdfghi'),  'abcdfghi')
end

return Colorify
