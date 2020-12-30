---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by abner.
--- DateTime: 2020/6/18 2:31 下午
---

local SoundCompoent = Arthas.GameEntry.Sound
local ResLoad = libx.Assets.LoadAsset

---@class SoundManager
SoundManager = class("SoundManager")

---@field private effectAudioState boolean  音效状态
---@field private effectPool table          音效池
---@field private clipPool table            音效资源池

--默认音效开关关闭
SoundManager.effectAudioState = false;
SoundManager.effectPool = {}
SoundManager.clipPool = {}
SoundManager.effectUrlDic = {}

---SetMusicVoulum  调节背景音乐音量 0.0~1.0
---@public
---@param value number
---@return void
function SoundManager.SetMusicVolume(value)
    SoundCompoent.Audio.volume = value;
end

---SetEffectVoulum 调节所有音效的音量 0.0~1.0
---@public
---@param value number
---@return void
function SoundManager.SetEffectVolume(value)
    GRoot.inst.soundVolume = value;
    if #SoundManager.effectPool <= 0 then return end
    for _, v in ipairs(SoundManager.effectPool) do
        v.volume = value
    end
end

---MusicMute 设置背景音乐 false：静音  true：非静音
---@public
---@param isMute boolean
---@return void
function SoundManager.MusicMute(isMute)
    SoundCompoent.Audio.mute = isMute;
end

---EffectMute 设置所有音效 false：静音  true：非静音
---@public
---@param isMute boolean
---@return void
function SoundManager.EffectMute(isMute)
    SoundManager.effectAudioState = isMute;
    if #SoundManager.effectPool <= 0 then return end
    for _, v in ipairs(SoundManager.effectPool) do
        v.mute =isMute
    end
end

---PlayMusic 播放背景音乐
---@public
---@param loop boolean
---@return void
function SoundManager.PlayMusic(url,loop)
    if SoundManager.GetMusicAudioState() then return end
    --if not SoundCompoent.Audio.clip then
    local BgUrl = "Assets/Res/"..url
    SoundCompoent.Audio.clip = ResLoad(BgUrl, typeof(UnityEngine.Object)).asset
    --end
    loop = loop or true;
    SoundCompoent.Audio.loop = loop
    SoundCompoent.Audio:Play();
end

---PlayEffect 播放音效
---@public
---@param effectPath string
---@param loop boolean
---@return void
function SoundManager.PlayEffect(effectPath, loop)
    if SoundManager.GetEffectAudioState() then return end
    effectPath = "Assets/Res/"..effectPath
    -- 添加一个默认音效后缀
    if not string.find(effectPath,"[.]") then
        effectPath = effectPath..".mp3"
    end
    if not SoundManager.clipPool[effectPath] then
        SoundManager.clipPool[effectPath] = ResLoad(effectPath, typeof(UnityEngine.Object)).asset
    end
    ---@type AudioSource
    local audioCompoent = SoundCompoent:AddEffectAudio()
    table.insert(SoundManager.effectPool, audioCompoent)
    SoundManager.effectUrlDic[effectPath] = audioCompoent
    
    audioCompoent.clip = SoundManager.clipPool[effectPath]
    audioCompoent.mute = SoundManager.GetEffectAudioState()
    loop = loop or false
    audioCompoent.loop = loop
    audioCompoent:Play()
    return audioCompoent
end

---StopMusic 关闭音乐
---@public
---@return void
function SoundManager.StopMusic()
    SoundCompoent.Audio:Stop()
end

---StopEffect 关闭音乐
---@public
---@return void
function SoundManager.StopEffect()
    if #SoundManager.effectPool <= 0 then return end
    for _, v in ipairs(SoundManager.effectPool) do
        v:Stop()
    end
end

---StopEffect 关闭音乐
---@public
---@return void
function SoundManager.StopEffectByUrl(effectPath)
    effectPath = "Assets/Res/"..effectPath
    -- 添加一个默认音效后缀
    if not string.find(effectPath,"[.]") then
        effectPath = effectPath..".mp3"
    end
    local audioCompoent = SoundManager.effectUrlDic[effectPath]
    if audioCompoent and not Arthas.Tools.IsNull(audioCompoent) then
        audioCompoent:Stop()
    end
end

---GetMusicAudioState 获取背景音乐静音状态
---@public
---@return boolean
function SoundManager.GetMusicAudioState()
    return SoundCompoent.Audio.mute
end

---GetEffectAudioState 获取音效静音状态
---@public
---@return boolean
function SoundManager.GetEffectAudioState()
    return SoundManager.effectAudioState
end


------------------------------------- SoundManager 静态类初始化-------------------------------------
function SoundManager:update(delta)
    if #SoundManager.effectPool <= 0 then
        return
    end
    
    -- 还可以优化
    for i = #SoundManager.effectPool, 1, -1 do
        local v = SoundManager.effectPool[i]
        if not v.isPlaying then
            ---@type AudioSource
            local audioCompoent = table.remove(SoundManager.effectPool, i)
            -- 移除引用
            for k, v in pairs(SoundManager.effectUrlDic) do
                if v == audioCompoent then
                    SoundManager.effectUrlDic[k] = nil
                    break
                end
            end
            audioCompoent:Destroy()
        end
    end
end
GameTimer.frameLoop(1, SoundManager, SoundManager.update, {Time.deltaTime})