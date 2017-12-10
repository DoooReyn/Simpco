local mrondom = math.rondom
local trondom = table.irandom

local function isSecurity(var) 
	return iskindof(var, 'SecurityNumber')
end 

local SecurityNumber = class('SecurityNumber')

function SecurityNumber.__add(a,b) 
	if type(b) == 'number' then 
		local v = a:get() + b 
        return SecurityNumber.new(v)
        
	elseif isSecurity(b)  then 
		local v = a:get() + b:get()
		return SecurityNumber.new(v)
    end
    
	assert(1<0,'unVaild argv #2')
end 

function SecurityNumber.__sub(a,b) 
	if type(b) == 'number' then 
		local v = a:get() - b 
		return SecurityNumber.new(v)

	elseif isSecurity(b) then 
		local v = a:get() - b:get()
		return SecurityNumber.new(v)
    end 
    
	assert(1<0,'unVaild argv #2')
end 


function SecurityNumber.__mul(a,b) 
	if type(b) == 'number' then 
		local v = a:get() * b 
		return SecurityNumber.new(v)

	elseif isSecurity(b)  then 
		local v = a:get() * b:get()
		return SecurityNumber.new(v)
    end 
    
	assert(1<0,'unVaild argv #2')
end 


function SecurityNumber.__div(a,b)
	if type(b) == 'number' then 
		local v = a:get() / b 
		return SecurityNumber.new(v)

	elseif isSecurity(b)  then 
		local v = a:get() / b:get()
		return SecurityNumber.new(v)
    end 
    
	assert(1<0,'unVaild argv #2')
end 

function SecurityNumber.__pow(a,b)
	if type(b) == 'number' then 
		local v = a:get() ^ b  
		return SecurityNumber.new(v)
    end 
    
	assert(1<0,'unVaild argv #2')
end

function SecurityNumber.__unm(a) 
	local v = a:get() * -1  
	return SecurityNumber.new(v)
end

function SecurityNumber.__eq(a,b) 
	if type(b) == 'number' then 
        return a:get() == b 
        
	elseif isSecurity(b)  then 
		return a:get() == b:get()
    end 
    
	assert(1<0,'unVaild argv #2')
end

function SecurityNumber.__lt(a,b) 
	if type(b) == 'number' then 
        return a:get() < b 
        
	elseif isSecurity(b)  then 
		return a:get() < b:get()
    end 
    
	assert(1<0,'unVaild argv #2')
end

function SecurityNumber.__le(a,b) 
	if type(b) == 'number' then 
        return a:get() <= b 
        
	elseif isSecurity(b)  then 
		return a:get() <= b:get()
    end 
    
	assert(1<0,'unVaild argv #2')
end    

function SecurityNumber:ctor(var)
    local mt = getmetatable(self)
    mt.__add = self.__add
    mt.__sub = self.__sub
    mt.__mul = self.__mul
    mt.__div = self.__div
    mt.__pow = self.__pow
    mt.__unm = self.__unm
    mt.__eq  = self.__eq
    mt.__lt  = self.__lt
    mt.__le  = self.__le

    var = type(var) == 'number' and var or 0
    self.publicVar  = 0
    self.privateVar = 0
    self.randomVar1 = 0
    self.randomVar2 = 0
    
	self:set(var)
end 

function SecurityNumber:isValid()
    if self.privateVar * -1 ~= self.publicVar then 
		--TODO 将通知游戏用户已修改数据
		print('请勿修改游戏数据!!!')
		return false
    end 
    return true
end

function SecurityNumber:get()
    if self:isValid() then 
        return (self.publicVar - self.randomVar2)  / self.randomVar1
    end
    return 0
end

function SecurityNumber:set(var)
	if not self:isValid() then 
		return 
	end 

    local realValue = var 
    if isSecurity(var) then 
        realValue = var:get()
    end 

	self.randomVar1 = mrandom(7,47)
    self.randomVar2 = mrandom(53,983)
    self.publicVar  = realValue * self.randomVar1 + self.randomVar2
    self.privateVar = -1 * self.publicVar
end

return SecurityNumber
