---@class HeartbeatC
---@field public instance HeartbeatC
HeartbeatC = class("HeartbeatC")
function HeartbeatC:ctor()
	self.unreceiveTime=nil
	self.unreceiveMaxTime=nil
	self.unsendTime=nil
	self.sendTime=nil
	self.handshake=false
	self.maxReconnectCount=3
	self.reconnectCount=0
	self.reconnectInterval=nil
	self.reconnectType=0
	self.reconnectContent=""
	self.unreceiveTime=0
	self.unsendTime=0
	self.unreceiveMaxTime=15
	self.sendTime=3
	self.handshake=false
	GameEventDispatch.instance:on(tostring(10000),self,self.receiveHandshake)
	GameEventDispatch.instance:on(tostring(11002),self,self.receiveHeartbeat)
	GameEventDispatch.instance:on(tostring(10010),self,self.accountReplace)
	GameEventDispatch.instance:on(tostring(10014),self,self.server_error)
	GameEventDispatch.instance:on(tostring(10016),self,self.user_check_error)
	GameEventDispatch.instance:on(tostring(10017),self,self.network_error)
	GameEventDispatch.instance:on(tostring(10018),self,self.kicked)
	GameEventDispatch.instance:on("WsClose",self,self.wsClose)
	GameEventDispatch.instance:on("WsError",self,self.wsError)
	Laya.timer:loop(1000,self,self.timeTick)

end
function HeartbeatC:kicked(data)
	self.reconnectType=7
	self.handshake=false
	self.reconnectContent=data["reason"]
	WebSocketManager.instance:close()

end
function HeartbeatC:network_error()
	self.reconnectType=6
	self.handshake=false
	WebSocketManager.instance:close()

end
function HeartbeatC:user_check_error()
	self.reconnectType=5
	self.handshake=false
	WebSocketManager.instance:close()

end
function HeartbeatC:server_error()
	self.reconnectType=4
	self.handshake=false
	WebSocketManager.instance:close()

end
function HeartbeatC:accountReplace()
	self.reconnectType=1
	self.handshake=false
	WebSocketManager.instance:close()

end
function HeartbeatC:handleSocketClose()
	self.handshake=false
	self.unsendTime=0
	self.reconnectInterval=0
	self.reconnectCount=0
	GameEventDispatch.instance:event("SystemReset")
	UiManager.instance:loadView("BrokePage")


end
function HeartbeatC:wsClose()
	self:handleSocketClose()

end
function HeartbeatC:wsError()
	self:handleSocketClose()

end
function HeartbeatC:timeTick()
	if WebSocketManager.instance:isConnected() then
		self.unreceiveTime =nil --[TODO]+= 1
		self.unsendTime =nil --[TODO]+= 1
		if self.unreceiveTime>self.unreceiveMaxTime then
			WebSocketManager.instance:close()
			self.unsendTime=0

		end
		if self.unsendTime>self.sendTime then
			self.unsendTime=0
			NetSender.HeartBeat()
		end

	end
	ActivityM.instance:countDownLoop()

end
function HeartbeatC:receiveHeartbeat(data)
	RuleM.instance:setTime(data.time)
	self.unreceiveTime=0

end
function HeartbeatC:receiveHandshake(data)
	self.unreceiveTime=0
	self.unsendTime=0
	self.reconnectInterval=0
	self.reconnectCount=0
	self.reconnectType=0
	self.handshake=true

end
function HeartbeatC:isHandshakeReceive()
	return self.handshake

end