------------------------------------------------------------------------------------------
---- Name   : AudioCore
---- Desc   : 音效核心类
---- Date   : 2017/12/17
---- Author : Reyn - jl88744653@gmail.com
------------------------------------------------------------------------------------------

------------------------------------------
-- local variables
--
local UserConfig = cc.UserDefault:getInstance()
local strfmt     = string.format
local kEffectKey = 'effect_enable'
local kMusicKey  = 'music_enable'
local kEffectVol = 'effect_volume'
local kMusicVol  = 'music_volume'

------------------------------------------
-- Class AudioCore
--
local AudioCore  = class('AudioCore')

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

------------------------------------------
-- @desc : first load AudioCore
--
function AudioCore:load()
    self:playMusicInSet(table.range(1,3))
end

------------------------------------------
-- @desc : unload AudioCore
--
function AudioCore:unload()
    ccexp.AudioEngine:uncacheAll()
end

------------------------------------------
-- @desc : set music volume
-- @param : vol - music volume
--
function AudioCore:setMusicVolume(vol)
    if self.musicVol == vol then return end
    self.musicVol = min(100, max(0, vol))
    UserConfig:setIntegerForKey(kMusicVol, self.musicVol)
    print('[AudioCore] setMusicVolume : ' .. vol)
end

------------------------------------------
-- @desc : set effect volume
-- @param : vol - effect volume
--
function AudioCore:setEffectVolume(vol)
    if self.effectVol == vol then return end
    self.effectVol = min(100, max(0, vol))
    UserConfig:setIntegerForKey(kEffectVol, self.effectVol)
    print('[AudioCore] setEffectVolume : ' .. vol)
end

------------------------------------------
-- @desc : set volume for target audioID
-- @param : atype - music or effect
-- @param : playAudioId - the audio ID which is playing
--
function AudioCore:setVolume(atype, playAudioId)
    if atype == 'music' then
        ccexp.AudioEngine:setVolume(playAudioId, self.musicVol * 0.01)
    elseif atype == 'effect' then
        ccexp.AudioEngine:setVolume(playAudioId, self.effectVol * 0.01)
    end
end

------------------------------------------
-- @desc : get audio path by audio ID
-- @param : audioId - audio ID
--
function AudioCore:getAudioPath(audioId)
    local path = strfmt('audio/%s.mp3', audioId)
    if not cc.FileUtils:getInstance():isFileExist(path) then
        print(strfmt('[AudioCore] %s not found.', path))
        return nil
    end
    return path
end

------------------------------------------
-- @desc : preload audio by audio ID
-- @param : audioId - audio ID
--
function AudioCore:preload(audioId)
    local path = self:getAudioPath(audioId)
    if not path then return end
    ccexp.AudioEngine:preload(path) 
    print('[AudioCore] preload : ' .. path)
end

------------------------------------------
-- @desc : record audio ID which is playing
-- @param : atype - music or effect
-- @param : playAudioId - the audio ID which is playing
--
function AudioCore:setPlayAudioId(atype, playAudioId)
    if atype == 'music' then
        self.musicId = playAudioId
    elseif atype == 'effect' then
        self.effectId = playAudioId
    end
end

------------------------------------------
-- @desc : play audio 
-- @param : audioId - audio ID
-- @param : atype - music or effect
-- @param : callfn - audio finish callback
--
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

------------------------------------------
-- @desc : stop effect audio which is playing 
--
function AudioCore:stopEffect()
    if not self.effectId then return end
    ccexp.AudioEngine:stop(self.effectId)
    self.effectId = -1
end

------------------------------------------
-- @desc : stop music audio which is playing 
--
function AudioCore:stopMusic()
    if not self.musicId then return end
    ccexp.AudioEngine:stop(self.musicId)
    self.musicId = -1
end

------------------------------------------
-- @desc : play effect by id
-- @param : audioId - effect id
-- @param : callfn - effect finish callback
--
function AudioCore:playEffect(audioId, callfn)
    self:play(strfmt('eff%03d', audioId), 'effect', callfn)
end

------------------------------------------
-- @desc : play music by id
-- @param : audioId - music id
-- @param : callfn - music finish callback
--
function AudioCore:playMusic(audioId, callfn)
    self:play(strfmt('bkg%03d', audioId), 'music', callfn)
end

------------------------------------------
-- @desc : play music in set
-- @param : bkgset - set of music
--
function AudioCore:playMusicInSet(bkgset)
    if bkgset and #bkgset > 0 then 
        local head = table.tail(bkgset)
        self:playMusic(head, function()
            self:playMusicInSet(bkgset)
        end)
    end
end

------------------------------------------
-- @desc : enable effect player
-- @param : isenable - enable / disable
--
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

------------------------------------------
-- @desc : enable music player
-- @param : isenable - enable / disable
--
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
