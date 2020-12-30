
---@class cfg_skill
___cfg_skill = 
{
	id = 1,
	name = '冰冻',
	icon = 'ui/common_ex/bingdong.png',
	skill_type = 1,
	cd = 10,
	lasttime = 10,
	coin_range = {
		1,
		1
	},
	need_prop = 21,
	firing_rate = 1.0,
	speed_rate = 1.0,
	sound = 'music/bingdong.mp3',
	show = 'ui://common_ex/bingdong',
	income = 0
}

---@field public instance cfg_skill
---@type table<string,cfg_skill>
cfg_skill =  {
instance = function(key)
    return cfg_skill[key]
end,

    [1] = 
{
	id = 1,
	name = '冰冻',
	icon = 'ui/common_ex/bingdong.png',
	skill_type = 1,
	cd = 10,
	lasttime = 10,
	coin_range = {
		1,
		1
	},
	need_prop = 21,
	firing_rate = 1.0,
	speed_rate = 1.0,
	sound = 'music/bingdong.mp3',
	show = 'ui://common_ex/bingdong',
	income = 0
},

    [2] = 
{
	id = 2,
	name = '锁定',
	icon = 'ui/common_ex/suoding.png',
	skill_type = 2,
	cd = 10,
	lasttime = 10,
	coin_range = {
		1,
		1
	},
	need_prop = 22,
	firing_rate = 1.0,
	speed_rate = 1.0,
	sound = 'music/suoding.mp3',
	show = 'ui://common_ex/suoding',
	income = 0
},

    [301] = 
{
	id = 301,
	name = '召唤',
	icon = 'ui/common_ex/zhaohuan.png',
	skill_type = 3,
	cd = 10,
	lasttime = 10,
	coin_range = {
		1,
		1
	},
	need_prop = 23,
	firing_rate = 1.0,
	speed_rate = 1.0,
	sound = 'music/zhaohuan.mp3',
	show = 'ui://common_ex/zhaohuan',
	income = 0
},

    [302] = 
{
	id = 302,
	name = '召唤',
	icon = 'ui/common_ex/zhaohuan.png',
	skill_type = 3,
	cd = 10,
	lasttime = 10,
	coin_range = {
		1,
		1
	},
	need_prop = 23,
	firing_rate = 1.0,
	speed_rate = 1.0,
	sound = 'music/zhaohuan.mp3',
	show = 'ui://common_ex/zhaohuan',
	income = 0
},

    [303] = 
{
	id = 303,
	name = '召唤',
	icon = 'ui/common_ex/zhaohuan.png',
	skill_type = 3,
	cd = 10,
	lasttime = 10,
	coin_range = {
		1,
		1
	},
	need_prop = 23,
	firing_rate = 1.0,
	speed_rate = 1.0,
	sound = 'music/zhaohuan.mp3',
	show = 'ui://common_ex/zhaohuan',
	income = 0
},

    [4] = 
{
	id = 4,
	name = '狂暴',
	icon = 'ui/common_ex/kuangbao.png',
	skill_type = 4,
	cd = 20,
	lasttime = 20,
	coin_range = {
		1,
		1
	},
	need_prop = 24,
	firing_rate = 1.5,
	speed_rate = 1.5,
	sound = 'music/kuangbao.mp3',
	show = 'ui://common_ex/kuangbao',
	income = 0
},

    [5] = 
{
	id = 5,
	name = '鱼雷',
	icon = 'ui/common_ex/zhadan',
	skill_type = 5,
	cd = 5,
	lasttime = 5,
	coin_range = {
		1,
		1
	},
	need_prop = 20,
	firing_rate = 1.0,
	speed_rate = 1.0,
	sound = 'music/yulei.mp3',
	show = 'ui://common_ex/zhadan',
	income = 0
},

    [6] = 
{
	id = 6,
	name = '普通鱼雷',
	icon = 'ui/common/yulei1.png',
	skill_type = 5,
	cd = 5,
	lasttime = 5,
	coin_range = {
		2850,
		3150
	},
	need_prop = 25,
	firing_rate = 1.0,
	speed_rate = 1.0,
	sound = 'music/yulei.mp3',
	show = 'ui://Fish/yulei1',
	income = 3000
},

    [7] = 
{
	id = 7,
	name = '白银鱼雷',
	icon = 'ui/common/yulei2.png',
	skill_type = 5,
	cd = 5,
	lasttime = 5,
	coin_range = {
		47500,
		52500
	},
	need_prop = 26,
	firing_rate = 1.0,
	speed_rate = 1.0,
	sound = 'music/yulei.mp3',
	show = 'ui://Fish/yulei2',
	income = 50000
},

    [8] = 
{
	id = 8,
	name = '黄金鱼雷',
	icon = 'ui/common/yulei3.png',
	skill_type = 5,
	cd = 5,
	lasttime = 5,
	coin_range = {
		475000,
		525000
	},
	need_prop = 27,
	firing_rate = 1.0,
	speed_rate = 1.0,
	sound = 'music/yulei.mp3',
	show = 'ui://Fish/yulei3',
	income = 500000
},

    [9] = 
{
	id = 9,
	name = '紫金鱼雷',
	icon = 'ui/common/yulei4.png',
	skill_type = 5,
	cd = 5,
	lasttime = 5,
	coin_range = {
		2850000,
		3150000
	},
	need_prop = 28,
	firing_rate = 1.0,
	speed_rate = 1.0,
	sound = 'music/yulei.mp3',
	show = 'ui://Fish/yulei4',
	income = 3000000
},

    [10] = 
{
	id = 10,
	name = '七彩鱼雷',
	icon = 'ui/common/yulei5.png',
	skill_type = 5,
	cd = 5,
	lasttime = 5,
	coin_range = {
		9500000,
		10500000
	},
	need_prop = 29,
	firing_rate = 1.0,
	speed_rate = 1.0,
	sound = 'music/yulei.mp3',
	show = 'ui://Fish/yulei5',
	income = 10000000
},

    [11] = 
{
	id = 11,
	name = '自动',
	icon = 'ui/common_ex/zidong.png',
	skill_type = 6,
	cd = 1,
	lasttime = 120,
	coin_range = {
		1,
		1
	},
	need_prop = 51,
	firing_rate = 1.0,
	speed_rate = 1.0,
	sound = 'music/suoding.mp3',
	show = 'ui://common_ex/zidong',
	income = 0
},

    [12] = 
{
	id = 12,
	name = '普通鱼雷',
	icon = 'ui/common/icon_yulei_01.png',
	skill_type = 5,
	cd = 5,
	lasttime = 5,
	coin_range = {
		49000,
		51000
	},
	need_prop = 401,
	firing_rate = 1.0,
	speed_rate = 1.0,
	sound = 'music/yulei.mp3',
	show = 'ui://Fish/icon_yulei_01',
	income = 50000
},

    [13] = 
{
	id = 13,
	name = '白银鱼雷',
	icon = 'ui/common/icon_yulei_02.png',
	skill_type = 5,
	cd = 5,
	lasttime = 5,
	coin_range = {
		98000,
		102000
	},
	need_prop = 402,
	firing_rate = 1.0,
	speed_rate = 1.0,
	sound = 'music/yulei.mp3',
	show = 'ui://Fish/icon_yulei_02',
	income = 100000
},

    [14] = 
{
	id = 14,
	name = '黄金鱼雷',
	icon = 'ui/common/icon_yulei_03.png',
	skill_type = 5,
	cd = 5,
	lasttime = 5,
	coin_range = {
		196000,
		204000
	},
	need_prop = 403,
	firing_rate = 1.0,
	speed_rate = 1.0,
	sound = 'music/yulei.mp3',
	show = 'ui://Fish/icon_yulei_03',
	income = 200000
},

    [15] = 
{
	id = 15,
	name = '紫金鱼雷',
	icon = 'ui/common/icon_yulei_04.png',
	skill_type = 5,
	cd = 5,
	lasttime = 5,
	coin_range = {
		490000,
		510000
	},
	need_prop = 404,
	firing_rate = 1.0,
	speed_rate = 1.0,
	sound = 'music/yulei.mp3',
	show = 'ui://Fish/icon_yulei_04',
	income = 500000
},

    [16] = 
{
	id = 16,
	name = '七彩鱼雷',
	icon = 'ui/common/icon_yulei_05.png',
	skill_type = 5,
	cd = 5,
	lasttime = 5,
	coin_range = {
		980000,
		1020000
	},
	need_prop = 405,
	firing_rate = 1.0,
	speed_rate = 1.0,
	sound = 'music/yulei.mp3',
	show = 'ui://Fish/icon_yulei_05',
	income = 1000000
},


}

return cfg_skill