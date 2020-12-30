---@class LoginM
---@field public instance LoginM
LoginM = class("LoginM")
function LoginM:ctor()
	self._resArr = nil
	self._loginState=nil
	self._spineArr = nil
	self._sceneId=nil
	self._contestId=0
	self.roomId = -1
	self.pageId = nil
	self._IsfirstEntryGame=true
	self._preLoadFishIds = nil
	self._preLoadBullet=false
	self._isCompleteCertification=0
	self._popupCertificationTimes=0
	self._preLoadFishIds={}

	self._isCompleteCertification = 0
	self._popupCertificationTimes = 0
	self._isNovicePlayer = 1--1是新手玩家  0不是新手玩家
	self._replaceRankName = "***"--1是新手玩家  0不是新手玩家

	self.provider_tel = "" -- 客服电话

	self._loginNew = false
	
	---@type table
	self._versionList={}

end

function LoginM:setFishIdPreload(fishId)
	self.preLoadFishIds[fishId]=1
end

function LoginM:isFishIdPreload(fishId)
	if self.preLoadFishIds[fishId] then
		return true
	end
	return false
end

function LoginM:loginNew(value)
	if value == nil then
		return self._loginNew
	else
		self._loginNew = value
	end
end

function LoginM:isCompleteCertification(value)
	if value == nil then
		return self._isCompleteCertification
	else
		self._isCompleteCertification = value
	end
end

function LoginM:setBulletPreload()
	self.preLoadBullet=true
end

function LoginM:isBulletPreload()
	return self.preLoadBullet
end

function LoginM:getMapUrl(url)
    --local dic=Laya.loader:getRes("manifest.json")
    --if dic[url] then
    --	return dic[url]
    --end
    return url
end

function LoginM:getContestId()
	return self.contestId
end

function LoginM:setContestId(contestId,sceneId)
	self.contestId = contestId
	self.sceneId = sceneId
end

--[[
	TODO: get and set method
	
	 public static function get instance():LoginM
        {
            return _instance || (_instance = new LoginM());
        }

        public function get IsfirstEntryGame():Boolean
        {
            return IsfirstEntryGame
        }

        public function set IsfirstEntryGame(isFirst:Boolean):void
        {
            IsfirstEntryGame = isFirst;
        }

        public function get pageId():String
        {
            return pageId;
        }

        public function set pageId(id:String):void
        {
            pageId = id;
        }
	public function get sceneId():Number
        {
            return sceneId;
        }

        public function set sceneId(id:Number):void
        {
            contestId = 0;
            sceneId = id;
            roomId = -1;
        }
	public function set resArr(res:Array):void
        {
            resArr = res;
        }

        public function get resArr():Array
        {
            return resArr;
        }

        public function set loginState(state:Number):void
        {
            loginState = state;
        }

        public function get loginState():Number
        {
            return loginState;
        }

        public function get spineArr():Array
        {
            return spineArr
        }

        public function set spineArr(arr:Array):void
        {
            spineArr = arr;
        }


        public function get roomId():int
        {
            return roomId;
        }

        public function set roomId(value:int):void
        {
            roomId = value;
        }
]]

---@return number 是否完成身份认证
function LoginM:getIsCompleteCertification()
    return self._isCompleteCertification
end

---@param value number
function LoginM:setIsCompleteCertification(value)
    self._isCompleteCertification = value
end
---@return number
function LoginM:getPopupCertificationTimes()
    return self._popupCertificationTimes
end

---@param value number
function LoginM:setPopupCertificationTimes(value)
    self._popupCertificationTimes = value
end

---@return number
function LoginM:getIsNovicePlayer()
    return self._isNovicePlayer
end

---@param value number
function LoginM:setIsNovicePlayer(value)
    self._isNovicePlayer = value
end

function LoginM:getReplaceRankName()
    return self._replaceRankName
end

        