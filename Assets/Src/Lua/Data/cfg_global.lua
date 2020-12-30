
---@class cfg_global
___cfg_global = 
{
	id = 1,
	bomb_collision_count = 3,
	bomb_scale_width = 3.1,
	bomb_scale_height = 3.1,
	award_effect_time = 1.5,
	award_effect_scale_min = 0.3,
	gold_stay_time = 0.2,
	gold_sound1_value = 20,
	gold_sound_play_interval = 0.2,
	bullet_interval = 0.15,
	normalFishTime = 3.0,
	bezierRate = 2.0,
	bezierRateTime = 1.0,
	server_model = 'fish-local',
	form_interval = 420,
	clear_up_time = 4,
	form_born_inverval = 4.2,
	form_end_born = 0.0,
	sta_data_time = {
		1,
		3
	},
	db_max = 3,
	db_buff = {
		1,
		2
	},
	db_num = 2000,
	award_group = 200,
	max_bullet_num = 30,
	max_call_num = 10,
	boss_delay_form_born = 10,
	click_sound = 'music/click.mp3',
	get_coin_sound = 'music/getcoin.mp3',
	hit_sound = 'music/hit.mp3',
	battery_unlock_sound = 'music/batteryup.mp3',
	shoot_sound = 'music/shoot.mp3',
	level_up_sound = 'music/levelup.mp3',
	tide_sound = 'music/tide.mp3',
	bingo_sound = 'music/bingo.mp3',
	extra_drop_sound = 'music/get.mp3',
	get_sound = 'music/reward.mp3',
	cost_coin_max = 20000000,
	min_level = 1,
	min_battery = 7,
	mini_battery = 7,
	camera_shot = 'music/jieping.mp3',
	double_coin_battery = 24,
	double_chance_battery = 17,
	maxWatchADTimes
 = 2,
	watchAdRewardIds
 = {
		10
	},
	watchAdRewardNums
 = {
		1000
	},
	route_of_entry_reward_ids = {
		21,
		22,
		24,
		4
	},
	route_of_entry_reward_nums = {
		2,
		2,
		1,
		1
	},
	sign_days = 15,
	rech_days = 365,
	upgrade_days = 30,
	raffle_config = 
	{
		cost1 = 
		{
			ids = {
				1
			},
			nums = {
				2000
			}
		},
		cost2 = 
		{
			ids = {
				92
			},
			nums = {
				1
			}
		},
		daily_free_times = 2,
		energy_reset_week = 4,
		free_interval_hour = 3,
		raffle_increased = 1,
		raffle_show_rate = {
			{
				5,
				5
			},
			{
				20,
				3
			},
			{
				40,
				2
			}
		},
		mini_raffle = 10
	}
}

---@field public instance cfg_global
---@type table<string,cfg_global>
cfg_global =  {
instance = function(key)
    return cfg_global[key]
end,

    [1] = 
{
	id = 1,
	bomb_collision_count = 3,
	bomb_scale_width = 3.1,
	bomb_scale_height = 3.1,
	award_effect_time = 1.5,
	award_effect_scale_min = 0.3,
	gold_stay_time = 0.2,
	gold_sound1_value = 20,
	gold_sound_play_interval = 0.2,
	bullet_interval = 0.15,
	normalFishTime = 3.0,
	bezierRate = 2.0,
	bezierRateTime = 1.0,
	server_model = 'fish-local',
	form_interval = 420,
	clear_up_time = 4,
	form_born_inverval = 4.2,
	form_end_born = 0.0,
	sta_data_time = {
		1,
		3
	},
	db_max = 3,
	db_buff = {
		1,
		2
	},
	db_num = 2000,
	award_group = 200,
	max_bullet_num = 30,
	max_call_num = 10,
	boss_delay_form_born = 10,
	click_sound = 'music/click.mp3',
	get_coin_sound = 'music/getcoin.mp3',
	hit_sound = 'music/hit.mp3',
	battery_unlock_sound = 'music/batteryup.mp3',
	shoot_sound = 'music/shoot.mp3',
	level_up_sound = 'music/levelup.mp3',
	tide_sound = 'music/tide.mp3',
	bingo_sound = 'music/bingo.mp3',
	extra_drop_sound = 'music/get.mp3',
	get_sound = 'music/reward.mp3',
	cost_coin_max = 20000000,
	min_level = 1,
	min_battery = 7,
	mini_battery = 7,
	camera_shot = 'music/jieping.mp3',
	double_coin_battery = 24,
	double_chance_battery = 17,
	maxWatchADTimes
 = 2,
	watchAdRewardIds
 = {
		10
	},
	watchAdRewardNums
 = {
		1000
	},
	route_of_entry_reward_ids = {
		21,
		22,
		24,
		4
	},
	route_of_entry_reward_nums = {
		2,
		2,
		1,
		1
	},
	sign_days = 15,
	rech_days = 365,
	upgrade_days = 30,
	raffle_config = 
	{
		cost1 = 
		{
			ids = {
				1
			},
			nums = {
				2000
			}
		},
		cost2 = 
		{
			ids = {
				92
			},
			nums = {
				1
			}
		},
		daily_free_times = 2,
		energy_reset_week = 4,
		free_interval_hour = 3,
		raffle_increased = 1,
		raffle_show_rate = {
			{
				5,
				5
			},
			{
				20,
				3
			},
			{
				40,
				2
			}
		},
		mini_raffle = 10
	}
},


}

return cfg_global