------------------------------------------------------------------------------------------
---- Name   : TableExt
---- Desc   : lua表扩展
---- Date   : 2017/12/09
---- Author : Reyn - jl88744653@gmail.com
------------------------------------------------------------------------------------------

----------------------------------------------------
-- @desc : 完整遍历执行表
-- @param : t - 表
-- @param : func - 遍历子项回调
--
function table.foreach(t, func)
    for k,v in pairs(t) do
        func(v, k)
    end
end

----------------------------------------------------
-- @desc : 可打断遍历执行表
-- @param : t - 表
-- @param : func - 遍历子项回调，根据func返回值决定是否打断
--
function table.excute(t, func)
    for k,v in pairs(t) do
        if func(v, k) then
            return true
        end
    end
    return false
end

----------------------------------------------------
-- @desc : 求表长度
-- @param : t - 表
--
function table.size(t)
    local l = 0
    table.foreach(t, function()
        l = l + 1
    end)
    return l
end

----------------------------------------------------
-- @desc : 表中是否有对应值
-- @param : t - 表
-- @param : val - 对应值
--
function table.has(t, val)
    return table.excute(t, function(v)
        return v == val
    end)
end

----------------------------------------------------
-- @desc : 随机表中的一个数值
-- @param : t - 表
--
local mrandom = math.random
function table.irandom(t)
    return t[mrandom(1, #t)]
end
function table.random(t)
    local keys = table.keys(t)
    local key1 = keys[mrandom(1, #keys)]
    return t[key1]
end

----------------------------------------------------
-- @desc : 移除表中的第一个元素
-- @param : t - 表
--
function table.shift(t)
    return table.remove(t, 1)
end

----------------------------------------------------
-- @desc : 移除表中的最后一个元素
-- @param : t - 表
--
function table.pop(t)
    return table.remove(t, #t)
end

----------------------------------------------------
-- @desc : 移动第一个元素到最后
-- @param : t - 表
--
function table.tail(t)
    local h = table.remove(t, 1)
    table.insert(t, h)
    return h
end

----------------------------------------------------
-- @desc : 移动表元素位置
-- @param : t - 表
-- @param : s - 起始位置
-- @param : s - 插入位置
--
function table.move(t, s, d)
    local h = table.remove(t, 1)
    table.insert(t, d, h)
    return h
end

function table.range(from, to, step)
    if from > to then 
        from, to = to, from
    end
    if step == nil or step <= 0 then 
        step = 1 
    end
    local t = {}
    for i=from, to, step do
        table.insert(t, i)
    end
    return t
end