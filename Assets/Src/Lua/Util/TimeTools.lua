TimeTools = class("TimeTools")


--获取当前毫秒数
function TimeTools.getCurMill()
    local t = Arthas.Tools.GetTimeStamp(false)
    return tonumber(t)
end

function TimeTools.getCurSec()
    return os.time()
end


