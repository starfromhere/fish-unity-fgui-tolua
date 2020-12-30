---@class FightSoundManager
FightSoundManager = class("FightSoundManager")
function FightSoundManager:ctor()

end
function FightSoundManager:getPlaySoundInterval(url)
    return 0

end

function FightSoundManager.playSound(url)

    Log.debug("TODO播放声音:", url)
    --if StartParam.instance:getParam("stopAllSound") == 2 then
    --    SoundManager:stopMusic()
    --    return
    --
    --end
    --
    --local date = nil--[TODO] new Date()
    --if ~FightSoundManager.playInfo[url] then
    --    SoundManager:playSound(url)
    --    FightSoundManager.playInfo[url] = date:getTime()
    --
    --
    --else
    --    if date:getTime() - FightSoundManager.playInfo[url] >= FightSoundManager:getPlaySoundInterval(url) then
    --        SoundManager:playSound(url)
    --        FightSoundManager.playInfo[url] = date:getTime()
    --
    --
    --    else
    --        console:log("skip sound ", FightSoundManager.playInfo[url], date:getTime(), FightSoundManager:getPlaySoundInterval(url))
    --    end
    --end
end
