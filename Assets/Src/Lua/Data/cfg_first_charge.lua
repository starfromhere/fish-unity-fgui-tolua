
---@class cfg_first_charge
___cfg_first_charge = 
{
	id = 1,
	level = 1,
	reward_item_ids = {
		1,
		4,
		22,
		21
	},
	reward_item_nums = {
		15000,
		200,
		2,
		2
	},
	reward_skin_id = 32
}

---@field public instance cfg_first_charge
---@type table<string,cfg_first_charge>
cfg_first_charge =  {
instance = function(key)
    return cfg_first_charge[key]
end,

    [1] = 
{
	id = 1,
	level = 1,
	reward_item_ids = {
		1,
		4,
		22,
		21
	},
	reward_item_nums = {
		15000,
		200,
		2,
		2
	},
	reward_skin_id = 32
},


}

return cfg_first_charge