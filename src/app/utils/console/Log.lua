------------------------------------------------------------
-- 日志管理
--
local __log__ = cc.FileUtils:getInstance():getWritablePath() .. 'log.txt'
local issave = Game.Environment:get('savelog')
print('@ log file is located at : ' .. __log__)

return {
    save = function(log)
        if not issave then
            return
        end
        local f = io.open(__log__, 'a+')
        if not f then return end
        f:write(log)
        f:close()
    end
}
