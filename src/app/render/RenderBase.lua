local strfmt = string.format

local RenderBase = class('RenderBase')

function RenderBase:ctor()
    print(strfmt('[RenderBase] %s ctor', self.__cname))
end

function RenderBase:init()

end

return RenderBase
