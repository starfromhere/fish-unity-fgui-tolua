---@class MatchM
---@field public instance MatchM
MatchM = class("MatchM")
function MatchM:ctor()
	self.isMatchStart = 0
	self.hostSeat = -1
	self.prepareState = {[1]=0,[2]=0,[3]=0,[4]=0}
	self.countDownTime = -1
	self._startTime=false
	self.tManSeat = -1
	self.roomName = -1
	self.theRoomNumber = -1
	self.prepareNum = -1
	self.resultMsg = nil
	self.findRoomData = nil
end

function MatchM:initMatchingGameData(againGame)
	self._startTime = false
	self.isMatchStart = 0
	if not againGame then
		self.tManSeat = -1
		self.countDownTime = -1
		self.prepareState = {[1]=0,[2]=0,[3]=0,[4]=0}
		self.theRoomNumber = -1
		self.roomName = -1
		self.prepareNum = -1
		self.hostSeat = -1
	end
end

function MatchM:matchContestTimeSub()
	if self.countDownTime > 0 then
		self.countDownTime = self.countDownTime - 1
		if self.countDownTime < 0 then
			self.countDownTime = 0
		end
	end
end

function MatchM:matchCountDown(end_time,element)
	local now = TimeTools:getCurMill()
	local now_time = Math:floor(( now / 1000))
	local diff_time = end_time
	if diff_time < 0 then
		diff_time = 0
	end

	--local minutesleft = math.floor(((diff_time) % 3600) / 60)
	--local secondsleft = (diff_time) % 60
	--if minutesleft < 10 then
	--	minutesleft = tostring(minutesleft)
	--end
	--if secondsleft < 10 then
	--	secondsleft = tostring(secondsleft)
	--end
	element.text="准备倒计时："..os.date("%H:%M:%S", diff_time)
end

function MatchM:isMatchSettleShow()
	local ret=false
	local uiLayer = nil
	--TODO 业务需要重写
	--for i,value in TODO do
	--	uiLayer=Laya.stage:getChildAt(i)
	--	if uiLayer and uiLayer.visible and uiLayer.name.length>0 then
	--		if uiLayer.name=="MatchSettle" then
	--			ret=true
	--			break
	--		end
	--	end
	--end
	return ret
end

function MatchM:isRoomHost(seatNum)
	if FightM.instance:isMatchingGame() then
		local hostSeatId = SeatRouter.instance:getShowSeatId(self.hostSeat)
		if seatNum == hostSeatId and hostSeatId > 0 then
			return true
		end
	end
	return false
end

function MatchM:setPrepareState(stateArr)
	local prepareNum = 0
	for i,value in pairs(stateArr) do
		local seatId = MirrorMapper.getMirrorFlagBySeatId(i)
		self.prepareState[seatId] = stateArr[i]
		if self.prepareState[seatId] == 1 then
			prepareNum = prepareNum + 1
		end
	end
	self.prepareNum = prepareNum
end

--[[
	TODO: get and set method
	
	 public function get isMatchSart():Number
        {
            return isMatchStart;
        }

        public function set isMatchSart(value:Number):void
        {
            isMatchStart = value;
        }

        public function get hostSeat():Number
        {
            return hostSeat;
        }

        public function set hostSeat(value:Number):void
        {
            hostSeat = value;
        }

	public function get prepareState():Object
        {
            return prepareState;
        }

        public function get countDownTime():Number
        {
            return countDownTime;
        }

        public function set countDownTime(value:Number):void
        {
            countDownTime = value;
        }

        public function get tManSeat():Number
        {
            return tManSeat;
        }

        public function set tManSeat(value:Number):void
        {
            tManSeat = value;
        }

        public function get roomName():Number
        {
            return roomName;
        }

        public function set roomName(value:Number):void
        {
            roomName = value;
        }

        public function get theRoomNumber():Number
        {
            return theRoomNumber;
        }

        public function set theRoomNumber(value:Number):void
        {
            theRoomNumber = value;
        }

        public function get prepareNum():Number
        {
            return prepareNum;
        }

        public function get startTime():Boolean
        {
            return _startTime;
        }

        public function set startTime(value:Boolean):void
        {
            _startTime = value;
        }

        public function get resultMsg():Object
        {
            return resultMsg;
        }

        public function set resultMsg(value:Object):void
        {
            resultMsg = value;
        }

        public function get findRoomData():Object
        {
            return findRoomData;
        }

        public function set findRoomData(value:Object):void
        {
            findRoomData = value;
        }
]]