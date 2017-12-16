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