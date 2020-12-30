---@class CompenM
---@field public instance CompenM

CompenM = class("CompenM")
function CompenM:ctor()
    self._rewardName="我开始中奖了啊"
    self._compenArr = nil
    self._currentTimes=1
    self._rewardFrom=-1
    self._comenList = nil
    self._totalTimes=nil
end

function CompenM:getUrl(id)
    local cfg=cfg_goods.instance(id)
    return cfg.icon
end

--[[
	TODO: get and set method
	//补偿奖励的名字
        public function get rewardName():String
        {
            var compro:ComPro = compenArr[0] as ComPro
            return compro.tip;
        }

        public function set rewardName(name:String):void
        {
            _rewardName = name;
        }

        //当前领取的奖励的次数
        public function get currentTimes():Number
        {
            return _currentTimes;
        }

        public function set currentTimes(times:Number)
        {
            _currentTimes = times;
        }

        public function get compenArr():Array
        {
            return _compenArr;
        }

        public function set compenArr(arr:Array):void
        {
            _compenArr = arr;
        }

        public function get compenList():Array
        {
            var comList:Array = [];
            for (var i:int = 0; i < compenArr.length; i++)
            {
                var compro:ComPro = compenArr[i] as ComPro;
                var pro:MakePro = new MakePro();
                pro.count = ActivityM.instance.exchangeConversion(compro.id,compro.num);
                pro.icon = getUrl(compro.id + "");
                comList.push(pro);
            }
            return comList;
        }


        //需要领取的总共的次数
        public function get totalTimes():Number
        {
            if (compenList != null)
            {
                var len:Number = compenList.length;
                return Math.ceil(len / 4);
            } else
            {
                return 0;
            }
        }

        //刷新数据列表
        public function get refreshList():Array
        {
            var startIndex:Number = (currentTimes - 1) * 4;
            var endIndex:Number = startIndex + addIndex;
            return compenList.slice(startIndex, endIndex);
        }

        public function get showRefeshList():Array
        {
            var showlist:Array = [];
            for (var i:int = 0; i < refreshList.length; i++)
            {
                var pro:MakePro = refreshList[i];
                showlist.push({icon: {skin: pro.icon}, count: {text: pro.count}});
            }
            return showlist;
        }

        public function get addIndex():Number
        {
            var index:Number = 0;
            if (currentTimes == totalTimes)
            {
                index = compenList.length - (currentTimes - 1) * 4;
            } else
            {
                index = 4;
            }
            return index;
        }

        public function get rewardFrom():Number
        {
            return _rewardFrom;
        }

        public function set rewardFrom(value:Number):void
        {
            _rewardFrom = value;
        }
]]