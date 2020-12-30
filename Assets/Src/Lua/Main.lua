require "Base.Load"
local PreLoadComplete = Arthas.GameEntry.PreLoadComplete


--主入口函数。从这里开始lua逻辑
function Main()
    -- TODO  delte
    Log.debug("系统信息：" ..
            "\n 设备类型：".. UnityEngine.SystemInfo.deviceType:ToString() ..
            "\n 设备名称：".. UnityEngine.SystemInfo.deviceName ..
            "\n 设备型号：".. UnityEngine.SystemInfo.deviceModel ..
            "\n 设备id：".. UnityEngine.SystemInfo.deviceUniqueIdentifier
    )
    Game.instance:init()
    PreLoadComplete()
end


--场景切换通知
function OnLevelWasLoaded(level)
    collectgarbage("collect")
    Time.timeSinceLevelLoad = 0
end

--[[
    Home出   hasFocus     false
    Home进   hasFocus     true
]]
function OnApplicationFocus(hasFocus)

end

--[[
    Home出   pauseStatus     true
    Home进   pauseStatus     false
]]
function OnApplicationPause(pauseStatus)
    if not pauseStatus then
        NetSender.SyncTick()
    end
end

function OnApplicationQuit()
end