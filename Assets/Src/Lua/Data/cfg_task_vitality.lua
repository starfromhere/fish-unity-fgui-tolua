
---@class cfg_task_vitality
___cfg_task_vitality = 
{
	id = 1,
	need_vitality = 50,
	reward_item_ids = {
		92
	},
	reward_item_nums = {
		1
	}
}

---@field public instance cfg_task_vitality
---@type table<string,cfg_task_vitality>
cfg_task_vitality =  {
instance = function(key)
    return cfg_task_vitality[key]
end,

    [1] = 
{
	id = 1,
	need_vitality = 50,
	reward_item_ids = {
		92
	},
	reward_item_nums = {
		1
	}
},

    [2] = 
{
	id = 2,
	need_vitality = 100,
	reward_item_ids = {
		92
	},
	reward_item_nums = {
		1
	}
},

    [3] = 
{
	id = 3,
	need_vitality = 200,
	reward_item_ids = {
		92
	},
	reward_item_nums = {
		1
	}
},

    [4] = 
{
	id = 4,
	need_vitality = 300,
	reward_item_ids = {
		92
	},
	reward_item_nums = {
		1
	}
},

    [5] = 
{
	id = 5,
	need_vitality = 400,
	reward_item_ids = {
		92
	},
	reward_item_nums = {
		2
	}
},

    [6] = 
{
	id = 6,
	need_vitality = 500,
	reward_item_ids = {
		92
	},
	reward_item_nums = {
		2
	}
},

    [7] = 
{
	id = 7,
	need_vitality = 660,
	reward_item_ids = {
		92
	},
	reward_item_nums = {
		3
	}
},


}

return cfg_task_vitality