local AudioCore  = class('AudioCore')
local UserConfig = cc.UserDefault:getInstance()
local strfmt     = string.format
local kEffectKey = 'effect_enable'
local kMusicKey  = 'music_enable'
local kEffectVol = 'effect_volume'
local kMusicVol  = 'music_volume'

function AudioCore:ctor()
    self.bgm          = {}
    self.effect       = {}
    self.effectId     = -1
    self.musicId      = -1
    self.musicVol     = UserConfig:getIntegerForKey(kMusicVol,  60)
    self.effectVol    = UserConfig:getIntegerForKey(kEffectVol, 60)
    self.isPlayMusic  = UserConfig:getBoolForKey(kMusicKey,  true)
    self.isPlayEffect = UserConfig:getBoolForKey(kEffectKey, true)
end

function AudioCore:load()
    self:playMusicInSet(table.range(1,3))
end

function AudioCore:unload()
    ccexp.AudioEngine['end']()
end

function AudioCore:setMusicVolume(vol)
    if self.musicVol == vol then return end
    self.musicVol = min(100, max(0, vol))
    UserConfig:setIntegerForKey(kMusicVol, self.musicVol)
    print('[AudioCore] setMusicVolume : ' .. vol)
end

function AudioCore:setEffectVolume(vol)
    if self.effectVol == vol then return end
    self.effectVol = min(100, max(0, vol))
    UserConfig:setIntegerForKey(kEffectVol, self.effectVol)
    print('[AudioCore] setEffectVolume : ' .. vol)
end

function AudioCore:setVolume(atype, playAudioId)
    if atype == 'music' then
        ccexp.AudioEngine:setVolume(playAudioId, self.musicVol * 0.01)
    elseif atype == 'effect' then
        ccexp.AudioEngine:setVolume(playAudioId, self.effectVol * 0.01)
    end
end

function AudioCore:getAudioPath(audioId)
    local path = strfmt('audio/%s.mp3', audioId)
    if not cc.FileUtils:getInstance():isFileExist(path) then
        print(strfmt('[AudioCore] %s not found.', path))
        return nil
    end
    return path
end

function AudioCore:preload(audioId)
    local path = self:getAudioPath(audioId)
    if not path then return end
    ccexp.AudioEngine:preload(path) 
    print('[AudioCore] preload : ' .. path)
end

function AudioCore:setPlayAudioId(atype, playAudioId)
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
        print(strfmt('[AudioCore] music on playing : %s', audioId))
        return
    end
    if atype == 'effect' and self.effectId ~= -1 then
        self:stopEffect()
    end
    
    local path = self:getAudioPath(audioId)
    if not path then return end
    
    local playAudioId = ccexp.AudioEngine:play2d(path)
    self:setPlayAudioId(atype, playAudioId)
    self:setVolume(atype, playAudioId)
    print(strfmt('[AudioCore] play %s audio : %s', atype, audioId))
    
    local function audioStopFn(aId, path)
        print(strfmt('[AudioCore] stop %s audio : %s', atype, audioId))
        self:setPlayAudioId(atype, -1)
        if callfn then callfn(aId, path) end
    end
    ccexp.AudioEngine:setFinishCallback(playAudioId, audioStopFn) 
end

function AudioCore:stopEffect()
    if not self.effectId then return end
    ccexp.AudioEngine:stop(self.effectId)
    self.effectId = -1
end

function AudioCore:stopMusic()
    if not self.musicId then return end
    ccexp.AudioEngine:stop(self.musicId)
    self.musicId = -1
end

function AudioCore:playEffect(audioId, callfn)
    self:play(strfmt('eff%03d', audioId), 'effect', callfn)
end

function AudioCore:playMusic(audioId, callfn)
    self:play(strfmt('bkg%03d', audioId), 'music', callfn)
end

function AudioCore:playMusicInSet(bkgset)
    if bkgset and #bkgset > 0 then 
        local head = table.tail(bkgset)
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
    print('[AudioCore] enableEffect : ' .. tostring(self.isPlayEffect))
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
    print('[AudioCore] enableMusic : ' .. tostring(self.isPlayMusic))
end

return AudioCore
