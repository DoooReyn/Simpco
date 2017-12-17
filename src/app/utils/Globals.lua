cc.exports.unpack = unpack or table.unpack

cc.exports.max = function(a,b,...)
    local t = {a,b,unpack({...})}
    table.sort(t, function(v1,v2)
        return v1 > v2
    end)
    return t[1]
end

cc.exports.min = function(a,b,...)
    local t = {a,b,unpack({...})}
    table.sort(t, function(v1,v2)
        return v1 < v2
    end)
    return t[1]
end

cc.exports.sandbox = function(block)
    -- get the try function
    local try = block.try
    assert(try)
    print('[sandbox] try : ' .. tostring(try))

    --get catch and finnally functions
    local catch, finnally = block.catch, block.finnally

    -- try to call 'block.try'
    local ok, err = pcall(try)
    
    -- run the 'block.catch'
    if not ok and catch then
        print('[sandbox] catch error')
        catch(err)
        -- dump error message
        if block.dumpmsg then 
            print(err) 
        end
    end

    -- run the 'block.finnally'
    print('[sandbox] finnally : ' .. tostring(ok))
    if finnally then
        finnally(ok, err)
    end
    
    return ok
end