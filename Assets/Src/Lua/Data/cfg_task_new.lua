
---@class cfg_task_new
___cfg_task_new = 
{
	id = 1,
	title = '第一天',
	task_ids = {
		1,
		9,
		28,
		38,
		62,
		65
	},
	reward_item_ids = {
		1,
		24
	},
	reward_item_nums = {
		500,
		1
	}
}

---@field public instance cfg_task_new
---@type table<string,cfg_task_new>
cfg_task_new =  {
instance = function(key)
    return cfg_task_new[key]
end,

    [1] = 
{
	id = 1,
	title = '第一天',
	task_ids = {
		1,
		9,
		28,
		38,
		62,
		65
	},
	reward_item_ids = {
		1,
		24
	},
	reward_item_nums = {
		500,
		1
	}
},

    [2] = 
{
	id = 2,
	title = '第二天',
	task_ids = {
		2,
		11,
		68,
		39,
		87,
		88
	},
	reward_item_ids = {
		1,
		4
	},
	reward_item_nums = {
		600,
		40
	}
},

    [3] = 
{
	id = 3,
	title = '第三天',
	task_ids = {
		3,
		13,
		29,
		40,
		63,
		66
	},
	reward_item_ids = {
		1,
		4
	},
	reward_item_nums = {
		700,
		50
	}
},

    [4] = 
{
	id = 4,
	title = '第四天',
	task_ids = {
		4,
		15,
		69,
		41,
		89,
		90
	},
	reward_item_ids = {
		1,
		4
	},
	reward_item_nums = {
		800,
		50
	}
},

    [5] = 
{
	id = 5,
	title = '第五天',
	task_ids = {
		5,
		19,
		30,
		103,
		64,
		67
	},
	reward_item_ids = {
		1,
		4
	},
	reward_item_nums = {
		900,
		50
	}
},

    [6] = 
{
	id = 6,
	title = '第六天',
	task_ids = {
		6,
		23,
		70,
		104,
		91,
		105
	},
	reward_item_ids = {
		1,
		4
	},
	reward_item_nums = {
		1000,
		60
	}
},

    [7] = 
{
	id = 7,
	title = '第七天',
	task_ids = {
		7,
		27,
		71,
		111,
		92,
		112
	},
	reward_item_ids = {
		1,
		4
	},
	reward_item_nums = {
		2000,
		60
	}
},


}

return cfg_task_new