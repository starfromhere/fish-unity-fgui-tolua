
---@class cfg_task_red_reward
___cfg_task_red_reward = 
{
	id = 1,
	taskNum = 800000,
	reward_money_1 = 0.2,
	reward_money_2 = 0.5,
	reward_money_3 = 1.0,
	reward_ratio_1 = 2.0,
	reward_ratio_2 = 3.0,
	reward_ratio_3 = 1.0
}

---@field public instance cfg_task_red_reward
---@type table<string,cfg_task_red_reward>
cfg_task_red_reward =  {
instance = function(key)
    return cfg_task_red_reward[key]
end,

    [1] = 
{
	id = 1,
	taskNum = 800000,
	reward_money_1 = 0.2,
	reward_money_2 = 0.5,
	reward_money_3 = 1.0,
	reward_ratio_1 = 2.0,
	reward_ratio_2 = 3.0,
	reward_ratio_3 = 1.0
},

    [2] = 
{
	id = 2,
	taskNum = 2800000,
	reward_money_1 = 1.0,
	reward_money_2 = 2.0,
	reward_money_3 = 4.0,
	reward_ratio_1 = 2.0,
	reward_ratio_2 = 3.0,
	reward_ratio_3 = 1.0
},

    [3] = 
{
	id = 3,
	taskNum = 13000000,
	reward_money_1 = 5.0,
	reward_money_2 = 10.0,
	reward_money_3 = 20.0,
	reward_ratio_1 = 2.0,
	reward_ratio_2 = 3.0,
	reward_ratio_3 = 1.0
},

    [4] = 
{
	id = 4,
	taskNum = 60000000,
	reward_money_1 = 25.0,
	reward_money_2 = 50.0,
	reward_money_3 = 100.0,
	reward_ratio_1 = 2.0,
	reward_ratio_2 = 3.0,
	reward_ratio_3 = 1.0
},


}

return cfg_task_red_reward