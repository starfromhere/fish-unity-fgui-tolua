
---@class cfg_battery_skin
___cfg_battery_skin = 
{
	id = 100,
	prefab_path = 'Forts/diancipao',
	ani_stand_doudong = 'daiji',
	ani_stand_action = 'daiji',
	ani_attack_action = 'animation',
	batteryImg = 'ui://ChangeSkin/b9',
	itemLabel = '电磁炮',
	name_down = 'zidan11',
	web_down = 'H5_baozha6',
	action = 'H5_ssp1',
	follow = '0',
	catch_count = 60,
	multi = 1,
	speed = 1300.0,
	speed_down = 900.0,
	shootInterval = 0.16,
	shootIntervalMin = 0.2,
	shootIntervalMax = 1.0,
	shootIntervalMinViolent = 0.16,
	shootIntervalMaxViolent = 0.16,
	offLen = {
		120.0,
		120.0,
		120.0
	},
	offX = {
		0.0,
		0.0,
		0.0
	},
	offAngle = {
		0.0,
		0.0,
		0.0
	},
	desc = '2018世界杯活动奖励\n来源：活动',
	channel = {
		1
	},
	tip_id_down = 0,
	more_change = -1,
	less_change = -1,
	toskin = -1,
	isShowInList = 0,
	limit_t = {
		15,
		20,
		5
	},
	base_award_rate = 40,
	is_one_time = 1,
	is3d = 0
}

---@field public instance cfg_battery_skin
---@type table<string,cfg_battery_skin>
cfg_battery_skin =  {
instance = function(key)
    return cfg_battery_skin[key]
end,

    [100] = 
{
	id = 100,
	prefab_path = 'Forts/diancipao',
	ani_stand_doudong = 'daiji',
	ani_stand_action = 'daiji',
	ani_attack_action = 'animation',
	batteryImg = 'ui://ChangeSkin/b9',
	itemLabel = '电磁炮',
	name_down = 'zidan11',
	web_down = 'H5_baozha6',
	action = 'H5_ssp1',
	follow = '0',
	catch_count = 60,
	multi = 1,
	speed = 1300.0,
	speed_down = 900.0,
	shootInterval = 0.16,
	shootIntervalMin = 0.2,
	shootIntervalMax = 1.0,
	shootIntervalMinViolent = 0.16,
	shootIntervalMaxViolent = 0.16,
	offLen = {
		120.0,
		120.0,
		120.0
	},
	offX = {
		0.0,
		0.0,
		0.0
	},
	offAngle = {
		0.0,
		0.0,
		0.0
	},
	desc = '2018世界杯活动奖励\n来源：活动',
	channel = {
		1
	},
	tip_id_down = 0,
	more_change = -1,
	less_change = -1,
	toskin = -1,
	isShowInList = 0,
	limit_t = {
		15,
		20,
		5
	},
	base_award_rate = 40,
	is_one_time = 1,
	is3d = 0
},

    [101] = 
{
	id = 101,
	prefab_path = 'Forts/zuantoupao',
	ani_stand_doudong = 'idle',
	ani_stand_action = 'idle',
	ani_attack_action = 'attack',
	batteryImg = 'ui://ChangeSkin/b9',
	itemLabel = '钻头炮',
	name_down = 'zidan10',
	web_down = 'H5_baozha6',
	action = 'H5_ssp1',
	follow = '0',
	catch_count = 60,
	multi = 1,
	speed = 1300.0,
	speed_down = 1350.0,
	shootInterval = 0.16,
	shootIntervalMin = 0.2,
	shootIntervalMax = 1.0,
	shootIntervalMinViolent = 0.16,
	shootIntervalMaxViolent = 0.16,
	offLen = {
		120.0,
		120.0,
		120.0
	},
	offX = {
		0.0,
		0.0,
		0.0
	},
	offAngle = {
		0.0,
		0.0,
		0.0
	},
	desc = '2018世界杯活动奖励\n来源：活动',
	channel = {
		1
	},
	tip_id_down = 0,
	more_change = -1,
	less_change = -1,
	toskin = -1,
	isShowInList = 0,
	limit_t = {
		15,
		20,
		40
	},
	base_award_rate = 40,
	is_one_time = 1,
	is3d = 0
},

    [3] = 
{
	id = 3,
	prefab_path = 'Forts/pao_normal',
	ani_stand_doudong = 'hit',
	ani_stand_action = 'idle',
	ani_attack_action = 'attack',
	batteryImg = 'ui://ChangeSkin/b8',
	itemLabel = '普通炮',
	name_down = 'zidan2',
	web_down = 'H5_baozha2',
	action = 'H5_ptp1',
	follow = '0',
	catch_count = 1,
	multi = 1,
	speed = 1040.0,
	speed_down = 900.0,
	shootInterval = 0.2,
	shootIntervalMin = 0.2,
	shootIntervalMax = 1.0,
	shootIntervalMinViolent = 0.16,
	shootIntervalMaxViolent = 0.16,
	offLen = {
		160.0,
		160.0,
		160.0
	},
	offX = {
		0.0,
		0.0,
		0.0
	},
	offAngle = {
		0.0,
		0.0,
		0.0
	},
	desc = '子弹威力大\n来源：默认炮台',
	channel = {
		1
	},
	tip_id_down = 0,
	more_change = 100,
	less_change = -1,
	toskin = 1,
	isShowInList = 1,
	limit_t = {
		
	},
	base_award_rate = 0,
	is_one_time = 0,
	is3d = 1
},

    [5] = 
{
	id = 5,
	prefab_path = 'Forts/pao_branch',
	ani_stand_doudong = 'hit',
	ani_stand_action = 'idle',
	ani_attack_action = 'attack',
	batteryImg = 'ui://ChangeSkin/b4',
	itemLabel = '散射炮',
	name_down = 'zidan3',
	web_down = 'H5_baozha3',
	action = 'H5_fsp0',
	follow = '0',
	catch_count = 1,
	multi = 3,
	speed = 780.0,
	speed_down = 900.0,
	shootInterval = 0.33,
	shootIntervalMin = 0.2,
	shootIntervalMax = 1.0,
	shootIntervalMinViolent = 0.16,
	shootIntervalMaxViolent = 0.16,
	offLen = {
		160.0,
		200.0,
		200.0
	},
	offX = {
		0.0,
		25.0,
		-25.0
	},
	offAngle = {
		0.0,
		30.0,
		-30.0
	},
	desc = '同时发射三颗子弹\n来源：签到',
	channel = {
		2
	},
	tip_id_down = 33,
	more_change = 1000,
	less_change = -1,
	toskin = 6,
	isShowInList = 1,
	limit_t = {
		
	},
	base_award_rate = 0,
	is_one_time = 0,
	is3d = 1
},

    [7] = 
{
	id = 7,
	prefab_path = 'Forts/pao_quick',
	ani_stand_doudong = 'hit',
	ani_stand_action = 'idle',
	ani_attack_action = 'attack',
	batteryImg = 'ui://ChangeSkin/b6',
	itemLabel = '速射炮',
	name_down = 'zidan5',
	web_down = 'H5_baozha5',
	action = 'H5_ssp0',
	follow = '0',
	catch_count = 1,
	multi = 1,
	speed = 1040.0,
	speed_down = 900.0,
	shootInterval = 0.2,
	shootIntervalMin = 0.2,
	shootIntervalMax = 1.0,
	shootIntervalMinViolent = 0.16,
	shootIntervalMaxViolent = 0.16,
	offLen = {
		160.0,
		160.0,
		160.0
	},
	offX = {
		0.0,
		0.0,
		0.0
	},
	offAngle = {
		0.0,
		0.0,
		0.0
	},
	desc = '发射速度快\n来源：首充',
	channel = {
		4
	},
	tip_id_down = 0,
	more_change = 2000,
	less_change = -1,
	toskin = 8,
	isShowInList = 1,
	limit_t = {
		
	},
	base_award_rate = 0,
	is_one_time = 0,
	is3d = 1
},

    [9] = 
{
	id = 9,
	prefab_path = 'Forts/pao_lock',
	ani_stand_doudong = 'hit',
	ani_stand_action = 'idle',
	ani_attack_action = 'attack',
	batteryImg = 'ui://ChangeSkin/b7',
	itemLabel = '锁定炮',
	name_down = 'zidan12',
	web_down = 'H5_baozha6',
	action = 'H5_ssp1',
	follow = '0',
	catch_count = 1,
	multi = 1,
	speed = 1040.0,
	speed_down = 900.0,
	shootInterval = 0.5,
	shootIntervalMin = 0.5,
	shootIntervalMax = 1.0,
	shootIntervalMinViolent = 0.16,
	shootIntervalMaxViolent = 0.16,
	offLen = {
		160.0,
		160.0,
		161.0
	},
	offX = {
		0.0,
		0.0,
		0.0
	},
	offAngle = {
		0.0,
		0.0,
		0.0
	},
	desc = '发射速度快\n来源：默认',
	channel = {
		1
	},
	tip_id_down = 0,
	more_change = 2001,
	less_change = -1,
	toskin = 8,
	isShowInList = 1,
	limit_t = {
		
	},
	base_award_rate = 0,
	is_one_time = 0,
	is3d = 1
},


}

return cfg_battery_skin