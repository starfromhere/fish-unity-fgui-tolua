
---@class cfg_onLine
___cfg_onLine = 
{
	id = 1,
	rewardID = 10,
	receiveTime = 60,
	rewardCount = 500,
	vipRank = 1,
	vipTimes = '1'
}

---@field public instance cfg_onLine
---@type table<string,cfg_onLine>
cfg_onLine =  {
instance = function(key)
    return cfg_onLine[key]
end,

    [1] = 
{
	id = 1,
	rewardID = 10,
	receiveTime = 60,
	rewardCount = 500,
	vipRank = 1,
	vipTimes = '1'
},

    [2] = 
{
	id = 2,
	rewardID = 10,
	receiveTime = 120,
	rewardCount = 600,
	vipRank = 2,
	vipTimes = '1'
},

    [3] = 
{
	id = 3,
	rewardID = 10,
	receiveTime = 180,
	rewardCount = 800,
	vipRank = 3,
	vipTimes = '1'
},

    [4] = 
{
	id = 4,
	rewardID = 10,
	receiveTime = 300,
	rewardCount = 1000,
	vipRank = 4,
	vipTimes = '1'
},

    [5] = 
{
	id = 5,
	rewardID = 10,
	receiveTime = 420,
	rewardCount = 1500,
	vipRank = 5,
	vipTimes = '1'
},

    [6] = 
{
	id = 6,
	rewardID = 10,
	receiveTime = 600,
	rewardCount = 2000,
	vipRank = 6,
	vipTimes = '1'
},


}

return cfg_onLine