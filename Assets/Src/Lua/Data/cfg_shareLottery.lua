
---@class cfg_shareLottery
___cfg_shareLottery = 
{
	id = 1,
	rewardId = 1,
	rewardCount = 500,
	weight = 100,
	rewardId_Junior = 60,
	rewardCount_Junior = 10,
	rewardId_Medium = 27,
	rewardCount_Medium = 3,
	activity_rewardId = 1,
	activity_rewardCount = 500,
	activity_weight = 100,
	probability_junior = '0.1',
	description_junior = '十次中一次',
	probability_medium = '0.1',
	description_medium = '十次中一次'
}

---@field public instance cfg_shareLottery
---@type table<string,cfg_shareLottery>
cfg_shareLottery =  {
instance = function(key)
    return cfg_shareLottery[key]
end,

    [1] = 
{
	id = 1,
	rewardId = 1,
	rewardCount = 500,
	weight = 100,
	rewardId_Junior = 60,
	rewardCount_Junior = 10,
	rewardId_Medium = 27,
	rewardCount_Medium = 3,
	activity_rewardId = 1,
	activity_rewardCount = 500,
	activity_weight = 100,
	probability_junior = '0.1',
	description_junior = '十次中一次',
	probability_medium = '0.1',
	description_medium = '十次中一次'
},

    [2] = 
{
	id = 2,
	rewardId = 26,
	rewardCount = 1,
	weight = 2,
	rewardId_Junior = 27,
	rewardCount_Junior = 1,
	rewardId_Medium = 60,
	rewardCount_Medium = 300,
	activity_rewardId = 82,
	activity_rewardCount = 2,
	activity_weight = 2,
	probability_junior = '0.1',
	description_junior = '十次中一次',
	probability_medium = '0.1',
	description_medium = '十次中一次'
},

    [3] = 
{
	id = 3,
	rewardId = 1,
	rewardCount = 1000,
	weight = 100,
	rewardId_Junior = 26,
	rewardCount_Junior = 1,
	rewardId_Medium = 28,
	rewardCount_Medium = 1,
	activity_rewardId = 1,
	activity_rewardCount = 1000,
	activity_weight = 100,
	probability_junior = '0.1',
	description_junior = '十次中一次',
	probability_medium = '0.1',
	description_medium = '十次中一次'
},

    [4] = 
{
	id = 4,
	rewardId = 60,
	rewardCount = 10,
	weight = 20,
	rewardId_Junior = 60,
	rewardCount_Junior = 30,
	rewardId_Medium = 26,
	rewardCount_Medium = 3,
	activity_rewardId = 83,
	activity_rewardCount = 1,
	activity_weight = 20,
	probability_junior = '0.1',
	description_junior = '十次中一次',
	probability_medium = '0.1',
	description_medium = '十次中一次'
},

    [5] = 
{
	id = 5,
	rewardId = 1,
	rewardCount = 2000,
	weight = 100,
	rewardId_Junior = 26,
	rewardCount_Junior = 3,
	rewardId_Medium = 27,
	rewardCount_Medium = 1,
	activity_rewardId = 1,
	activity_rewardCount = 2000,
	activity_weight = 100,
	probability_junior = '0.1',
	description_junior = '十次中一次',
	probability_medium = '0.1',
	description_medium = '十次中一次'
},

    [6] = 
{
	id = 6,
	rewardId = 25,
	rewardCount = 1,
	weight = 70,
	rewardId_Junior = 25,
	rewardCount_Junior = 3,
	rewardId_Medium = 26,
	rewardCount_Medium = 5,
	activity_rewardId = 25,
	activity_rewardCount = 1,
	activity_weight = 70,
	probability_junior = '0.1',
	description_junior = '十次中一次',
	probability_medium = '0.1',
	description_medium = '十次中一次'
},

    [7] = 
{
	id = 7,
	rewardId = 1,
	rewardCount = 10000,
	weight = 8,
	rewardId_Junior = 60,
	rewardCount_Junior = 100,
	rewardId_Medium = 29,
	rewardCount_Medium = 1,
	activity_rewardId = 82,
	activity_rewardCount = 1,
	activity_weight = 8,
	probability_junior = '0.1',
	description_junior = '十次中一次',
	probability_medium = '0.1',
	description_medium = '十次中一次'
},

    [8] = 
{
	id = 8,
	rewardId = 24,
	rewardCount = 2,
	weight = 100,
	rewardId_Junior = 25,
	rewardCount_Junior = 5,
	rewardId_Medium = 60,
	rewardCount_Medium = 100,
	activity_rewardId = 24,
	activity_rewardCount = 2,
	activity_weight = 100,
	probability_junior = '0.1',
	description_junior = '十次中一次',
	probability_medium = '0.1',
	description_medium = '十次中一次'
},


}

return cfg_shareLottery