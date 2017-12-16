local AudioCore  = class('AudioCore')
local UserConfig = cc.UserDefault:getInstance()

function AudioCore:ctor()
    self.bgm    = {}
    self.effect = {}
    self.isPlayEffect = UserConfig:getBoolForKey('effect_enable', true)
    self.isPlayMusic  = UserConfig:getBoolForKey('music_enable', true)
    self.effectId  = 0
    self.musicId   = 0
end

function AudioCore:load()
    
end

function AudioCore:playEffect(audioId)
    
end

function AudioCore:playMusic(audioId)

end

function AudioCore:playMusicInRandom()

end

function AudioCore:enableEffect(isenable)
    if isenable == self.isPlayEffect then
        return
    end
    if not isenable then
        self:stopEffect()
    end
    self.isPlayEffect = isenable
    UserConfig:setBoolForKey('effect_enable', self.isPlayEffect)
end

function AudioCore:enableMusic(isenable)
    if isenable == self.isPlayMusic then
        return
    end
    if not isenable then
        self:stopMusic()
    end
    self.isPlayMusic = isenable
    UserConfig:setBoolForKey('music_enable', self.isPlayMusic)
end

return AudioCore
