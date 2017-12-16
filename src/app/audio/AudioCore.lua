local AudioCore  = class('AudioCore')
local UserConfig = cc.UserDefault:getInstance()
local strfmt     = string.format
local kEffectKey = 'effect_enable'
local kMusicKey  = 'music_enable'

function AudioCore:ctor()
    self.bgm    = {}
    self.effect = {}
    self.effectId  = -1
    self.musicId   = -1
    self.isPlayMusic  = UserConfig:getBoolForKey(kMusicKey,  true)
    self.isPlayEffect = UserConfig:getBoolForKey(kEffectKey, true)
end

function AudioCore:load()
    
end

function AidioCore:getAudioPath(audioId)
    local path = strfmt('audio/%s.mp3', audioId)
    if not cc.FileUtils:getInstance():isFileExist(path) then
        print(strfmt('[AidioCore] %s not found.', path))
        return nil
    end
    return path
end

function AudioCore:preload(audioId)
    local path = self:getAudioPath(audioId)
    if not path then return end
    ccexp.AudioEngine:preload(path) 
end

function AidioCore:setPlayAudioId(atype, playAudioId)
    if atype == 'music' then
        self.musicId = playAudioId
    elseif atype == 'effect' then
        self.effectId = playAudioId
    end
end

function AudioCore:play(audioId, atype, callfn)
    if not self.isPlayMusic  and atype == 'music'  then return end
    if not self.isPlayEffect and atype == 'effect' then return end
    if atype == 'music' and self.musicId ~= -1 then
        print('[AudioCore] There is a music on playing : ', self.musicId)
        return
    end
    if atype == 'effect' and self.effectId ~= -1 then
        self:stopEffect()
    end
    
    local path = self:getAudioPath(audioId)
    if not path then return end
    
    local playAudioId = ccexp.AudioEngine:play2d(path)
    self:setPlayAudioId(atype, playAudioId)
    
    local function audioEndFn(audioId, filePath)
        print('[AudioCore] audioEndFn : ', audioId, filePath)
        self:setPlayAudioId(atype, -1)
        if callfn then callfn() end
    end
    ccexp.AudioEngine:setFinishCallback(playAudioId, audioEndFn) 
end

function AidioCore:stopEffect()
    if not self.effectId then return end
    ccexp.AudioEngine:stop(self.effectId)
    self.effectId = -1
end

function AidioCore:stopMusic()
    if not self.musicId then return end
    ccexp.AudioEngine:stop(self.musicId)
    self.musicId = -1
end

function AudioCore:playEffect(audioId, callfn)
    self:play(strfmt('eff%3d', audioId), 'effect', callfn)
end

function AudioCore:playMusic(audioId, callfn)
    self:play(strfmt('bkg%3d', audioId), 'music', callfn)
end

function AudioCore:playMusicInSet(bkgset)
    if bkgset and #bkgset > 0 then 
        local head = table.shift(bkgset)
        self:playMusic(head, function()
            self:playMusicInSet(bkgset)
        end)
    end
end

function AudioCore:enableEffect(isenable)
    if isenable == self.isPlayEffect then
        return
    end
    if not isenable then
        self:stopEffect()
    end
    self.isPlayEffect = isenable
    UserConfig:setBoolForKey(kEffectKey, self.isPlayEffect)
end

function AudioCore:enableMusic(isenable)
    if isenable == self.isPlayMusic then
        return
    end
    if not isenable then
        self:stopMusic()
    end
    self.isPlayMusic = isenable
    UserConfig:setBoolForKey(kMusicKey, self.isPlayMusic)
end

return AudioCore
