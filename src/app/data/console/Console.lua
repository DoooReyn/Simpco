------------------------------------------------------------
-- 标准输出
--
local __strfmt     = string.format
local __print      = print
local __dump       = dump
local __printLog   = printLog
local __printInfo  = printInfo
local __printError = printError

local __stdout = function() 
    return Game.Environment:get('console')
end

cc.exports.print = function(...)
    if __stdout() then
        __print(...)
    end
end

cc.exports.printf = function(fmt, ...)
    if __stdout() then
        if select('#', ...) > 0 then
            __print(__strfmt(fmt, ...))
        else
            __print(fmt)
        end
    end
end

cc.exports.dump = function(t, d, n)
    if __stdout() then
        __dump(t, d, m)
    end
end

cc.exports.printLog = function(tag, fmt, ...)
    if __stdout() then
        __printLog(tag, fmt, ...)
    end    
end

cc.exports.printInfo = function(fmt, ...)
    if __stdout() then
        __printInfo(fmt, ...)
    end
end

cc.exports.printError = function(fmt, ...)
    if __stdout() then
        __printError(fmt, ...)
    end
end

-- local log = require('app.utils.console.Log')
local function console()
    local st = {}
    return {
        add = function(fmt, ...)
            if select('#', ...) > 0 then
                table.insert(st, __strfmt(fmt, ...))
            else
                table.insert(st, fmt)
            end
        end,
        console = function()
            local s = table.concat(st, '\n')
            print(s)
            return s
        end
    }
end

local Log = require('app.utils.console.Log')

return {
    log  = function(fmt, ...)
        local c = console()
        c.add('\n++++ Console.Log ++++')
        c.add(os.date('%Y-%m-%d %H:%M:%S', os.time()))
        c.add('  '..fmt, ...)
        c.add('---- Console.Log ----\n')
        Log.save(c.console())
    end,
    err  = function(fmt, ...)
        local c = console()
        c.add('\n++++ Console.Err ++++')
        c.add(os.date('%Y-%m-%d %H:%M:%S', os.time()))
        c.add('  '..fmt, ...)
        c.add('---- Console.Err ----\n')
        Log.save(c.console())
    end,
    warn = function(fmt, ...)
        local c = console()
        c.add('\n++++ Console.Warn ++++')
        c.add(os.date('%Y-%m-%d %H:%M:%S', os.time()))
        c.add('  '..fmt, ...)
        c.add('---- Console.Warn ----\n')
        Log.save(c.console())
    end
}