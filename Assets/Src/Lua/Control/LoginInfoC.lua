---@class LoginInfoC
---@field public instance LoginInfoC
LoginInfoC = class("LoginInfoC")
function LoginInfoC:ctor()
    GameEventDispatch.instance:On(tostring(10002), self, self.roleCreateRet)
end
function LoginInfoC:roleCreateRet(data)
    local protoData = data
    if protoData.code == 0 then
        --10003 服务端没有了
        --WebSocketManager.instance:send(10003, null)
        NetSender.QuickEnterRoom()
    end
end
