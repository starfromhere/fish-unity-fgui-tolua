---@class MsgM
---@field public instance MsgM
MsgM = class("MsgM")
function MsgM:ctor()
	self._msgX=nil
	self._msgY=nil
	self._content = nil
	self._isShow=false

end
function MsgM:setContentInfo(msgConent)
	self._content=msgConent
	self._isShow=true

end


--[[
	TODO: get and set method
	
	public function get msgX():Number
        {
            return _msgX;
        }

        public function get msgY():Number
        {
            return _msgY;
        }

        public function get content():String
        {
            return _content;

        }

        public function get isShow():Boolean
        {
            return _isShow
        }

        public function set isShow(isShow:Boolean):void
        {
            _isShow = isShow;
        }

]]
        