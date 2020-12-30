
---@class cfg_shareLottery_rule
___cfg_shareLottery_rule = 
{
	id = 1,
	rewardId = 27,
	lottry_goods = '紫色鱼雷',
	lottry_probability = '2.1%',
	lottry_description = '400次必中1次',
	lottry_id = 1
}

---@field public instance cfg_shareLottery_rule
---@type table<string,cfg_shareLottery_rule>
cfg_shareLottery_rule =  {
instance = function(key)
    return cfg_shareLottery_rule[key]
end,

    [1] = 
{
	id = 1,
	rewardId = 27,
	lottry_goods = '紫色鱼雷',
	lottry_probability = '2.1%',
	lottry_description = '400次必中1次',
	lottry_id = 1
},

    [2] = 
{
	id = 2,
	rewardId = 26,
	lottry_goods = '绿色鱼雷',
	lottry_probability = '33.5%',
	lottry_description = '',
	lottry_id = 1
},

    [3] = 
{
	id = 3,
	rewardId = 29,
	lottry_goods = '金色鱼雷',
	lottry_probability = '0.5%',
	lottry_description = '400次必中1次',
	lottry_id = 2
},

    [4] = 
{
	id = 4,
	rewardId = 28,
	lottry_goods = '橙色鱼雷',
	lottry_probability = '4.6%',
	lottry_description = '400次必中1次',
	lottry_id = 2
},

    [5] = 
{
	id = 5,
	rewardId = 27,
	lottry_goods = '紫色鱼雷',
	lottry_probability = '30.8%',
	lottry_description = '',
	lottry_id = 2
},


}

return cfg_shareLottery_rule