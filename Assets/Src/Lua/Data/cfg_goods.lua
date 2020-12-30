
---@class cfg_goods
___cfg_goods = 
{
	id = 1,
	name = '金币',
	icon = 'ui://IconRes/coin1',
	replace_res = {
		
	},
	type = 1,
	typeID = 1,
	waceIcon = 'ui://CommonComponent/unit_coin',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
}

---@field public instance cfg_goods
---@type table<string,cfg_goods>
cfg_goods =  {
instance = function(key)
    return cfg_goods[key]
end,

    [1] = 
{
	id = 1,
	name = '金币',
	icon = 'ui://IconRes/coin1',
	replace_res = {
		
	},
	type = 1,
	typeID = 1,
	waceIcon = 'ui://CommonComponent/unit_coin',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [2] = 
{
	id = 2,
	name = '鱼币',
	icon = 'ui://IconRes/coin1',
	replace_res = {
		
	},
	type = 2,
	typeID = 1,
	waceIcon = 'ui://CommonComponent/unit_coin',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [3] = 
{
	id = 3,
	name = '经验',
	icon = '',
	replace_res = {
		
	},
	type = 3,
	typeID = 1,
	waceIcon = '',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [4] = 
{
	id = 4,
	name = '钻石',
	icon = 'ui://IconRes/diamond1',
	replace_res = {
		
	},
	type = 4,
	typeID = 1,
	waceIcon = 'ui://CommonComponent/unit_diamond',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [5] = 
{
	id = 5,
	name = '人民币',
	icon = 'ui://IconRes/unit_rmb',
	replace_res = {
		
	},
	type = 5,
	typeID = 1,
	waceIcon = 'ui://CommonComponent/unit_rmb',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [8] = 
{
	id = 8,
	name = 'VIP经验',
	icon = '',
	replace_res = {
		
	},
	type = 8,
	typeID = 1,
	waceIcon = '',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [10] = 
{
	id = 10,
	name = '绑定金币',
	icon = 'ui://IconRes/coin1',
	replace_res = {
		
	},
	type = 10,
	typeID = 1,
	waceIcon = 'ui://CommonComponent/unit_coin',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [21] = 
{
	id = 21,
	name = '冰冻',
	icon = 'ui://IconRes/bingdong',
	replace_res = {
		4,
		5
	},
	type = 6,
	typeID = 1,
	waceIcon = 'ui://IconRes/bingdong',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 102,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '在渔场内使用后，使渔场内已有的鱼静止一段时间。'
},

    [22] = 
{
	id = 22,
	name = '锁定',
	icon = 'ui://IconRes/suoding',
	replace_res = {
		4,
		5
	},
	type = 6,
	typeID = 2,
	waceIcon = 'ui://IconRes/suoding',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 103,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '在渔场内使用后，可以选择一条鱼进行锁定，弹无虚发。'
},

    [23] = 
{
	id = 23,
	name = '召唤',
	icon = 'ui://IconRes/zhaohuan',
	replace_res = {
		4,
		5
	},
	type = 6,
	typeID = 3,
	waceIcon = 'ui://IconRes/zhaohuan',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '在渔场内使用后，随机召唤出一条大鱼。'
},

    [24] = 
{
	id = 24,
	name = '狂暴',
	icon = 'ui://IconRes/kuangbao',
	replace_res = {
		4,
		20
	},
	type = 6,
	typeID = 4,
	waceIcon = 'ui://IconRes/kuangbao',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 105,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '在渔场内使用后，发射子弹速度更快，更刺激。'
},

    [51] = 
{
	id = 51,
	name = '自动',
	icon = 'ui://IconRes/zidong',
	replace_res = {
		4,
		20
	},
	type = 6,
	typeID = 11,
	waceIcon = 'ui://IconRes/zidong',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 106,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '在渔场内每使用一个自动道具，可自动发炮两分钟。'
},

    [25] = 
{
	id = 25,
	name = '绿色鱼雷',
	icon = 'ui://IconRes/yulei1',
	replace_res = {
		
	},
	type = 6,
	typeID = 6,
	waceIcon = 'ui://IconRes/yulei1',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 1,
	pack_index = 112,
	can_use = 1,
	use_param = 0,
	is_gift = 1,
	is_alive = 0,
	desc = '绿色鱼雷，使用可能获得3000金币。'
},

    [26] = 
{
	id = 26,
	name = '蓝色鱼雷',
	icon = 'ui://IconRes/yulei2',
	replace_res = {
		
	},
	type = 6,
	typeID = 7,
	waceIcon = 'ui://IconRes/yulei2',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 1,
	pack_index = 113,
	can_use = 1,
	use_param = 0,
	is_gift = 1,
	is_alive = 0,
	desc = '蓝色鱼雷，使用可能获得50000金币。'
},

    [27] = 
{
	id = 27,
	name = '紫色鱼雷',
	icon = 'ui://IconRes/yulei3',
	replace_res = {
		
	},
	type = 6,
	typeID = 8,
	waceIcon = 'ui://IconRes/yulei3',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 1,
	pack_index = 114,
	can_use = 1,
	use_param = 0,
	is_gift = 1,
	is_alive = 0,
	desc = '紫色鱼雷，使用可能获得500000金币。'
},

    [28] = 
{
	id = 28,
	name = '橙色鱼雷',
	icon = 'ui://IconRes/yulei4',
	replace_res = {
		
	},
	type = 6,
	typeID = 9,
	waceIcon = 'ui://IconRes/yulei4',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 1,
	pack_index = 115,
	can_use = 1,
	use_param = 0,
	is_gift = 1,
	is_alive = 0,
	desc = '橙色鱼雷，使用可能获得3000000金币。'
},

    [29] = 
{
	id = 29,
	name = '金色鱼雷',
	icon = 'ui://IconRes/yulei5',
	replace_res = {
		
	},
	type = 6,
	typeID = 10,
	waceIcon = 'ui://IconRes/yulei5',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 1,
	pack_index = 116,
	can_use = 1,
	use_param = 0,
	is_gift = 1,
	is_alive = 0,
	desc = '金色鱼雷，使用可能获得10000000金币。'
},

    [20] = 
{
	id = 20,
	name = '鱼雷',
	icon = 'ui://IconRes/zhadan',
	replace_res = {
		
	},
	type = 6,
	typeID = 5,
	waceIcon = 'ui://IconRes/zhadan',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [12] = 
{
	id = 12,
	name = '金币1',
	icon = 'ui://IconRes/coin1',
	replace_res = {
		
	},
	type = 1,
	typeID = 2,
	waceIcon = 'ui://IconRes/coin1',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [13] = 
{
	id = 13,
	name = '金币2',
	icon = 'ui://IconRes/coin2',
	replace_res = {
		
	},
	type = 1,
	typeID = 3,
	waceIcon = 'ui://IconRes/coin2',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [14] = 
{
	id = 14,
	name = '金币3',
	icon = 'ui://IconRes/coin3',
	replace_res = {
		
	},
	type = 1,
	typeID = 4,
	waceIcon = 'ui://IconRes/coin3',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [15] = 
{
	id = 15,
	name = '金币4',
	icon = 'ui://IconRes/coin4',
	replace_res = {
		
	},
	type = 1,
	typeID = 5,
	waceIcon = 'ui://IconRes/coin4',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [16] = 
{
	id = 16,
	name = '金币5',
	icon = 'ui://IconRes/coin5',
	replace_res = {
		
	},
	type = 1,
	typeID = 6,
	waceIcon = 'ui://IconRes/coin5',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [17] = 
{
	id = 17,
	name = '金币6',
	icon = 'ui://IconRes/coin6',
	replace_res = {
		
	},
	type = 1,
	typeID = 7,
	waceIcon = 'ui://IconRes/coin6',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [18] = 
{
	id = 18,
	name = '金币7',
	icon = 'ui://IconRes/coin7',
	replace_res = {
		
	},
	type = 1,
	typeID = 8,
	waceIcon = 'ui://IconRes/coin7',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [19] = 
{
	id = 19,
	name = '金币8',
	icon = 'ui://IconRes/coin8',
	replace_res = {
		
	},
	type = 1,
	typeID = 9,
	waceIcon = 'ui://IconRes/coin8',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [42] = 
{
	id = 42,
	name = '钻石1',
	icon = 'ui://IconRes/diamond1',
	replace_res = {
		
	},
	type = 4,
	typeID = 2,
	waceIcon = 'ui://IconRes/diamond1',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [43] = 
{
	id = 43,
	name = '钻石2',
	icon = 'ui://IconRes/diamond2',
	replace_res = {
		
	},
	type = 4,
	typeID = 3,
	waceIcon = 'ui://IconRes/diamond2',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [44] = 
{
	id = 44,
	name = '钻石3',
	icon = 'ui://IconRes/diamond3',
	replace_res = {
		
	},
	type = 4,
	typeID = 4,
	waceIcon = 'ui://IconRes/diamond3',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [45] = 
{
	id = 45,
	name = '钻石4',
	icon = 'ui://IconRes/diamond4',
	replace_res = {
		
	},
	type = 4,
	typeID = 5,
	waceIcon = 'ui://IconRes/diamond4',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [46] = 
{
	id = 46,
	name = '钻石5',
	icon = 'ui://IconRes/diamond5',
	replace_res = {
		
	},
	type = 4,
	typeID = 6,
	waceIcon = 'ui://IconRes/diamond5',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [47] = 
{
	id = 47,
	name = '钻石6',
	icon = 'ui://IconRes/diamond6',
	replace_res = {
		
	},
	type = 4,
	typeID = 7,
	waceIcon = 'ui://IconRes/diamond6',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [48] = 
{
	id = 48,
	name = '钻石7',
	icon = 'ui://IconRes/diamond7',
	replace_res = {
		
	},
	type = 4,
	typeID = 8,
	waceIcon = 'ui://IconRes/diamond7',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [49] = 
{
	id = 49,
	name = '钻石8',
	icon = 'ui://IconRes/diamond8',
	replace_res = {
		
	},
	type = 4,
	typeID = 9,
	waceIcon = 'ui://IconRes/diamond8',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [30] = 
{
	id = 30,
	name = '普通炮',
	icon = 'ui://IconRes/b1',
	replace_res = {
		
	},
	type = 7,
	typeID = 1,
	waceIcon = 'ui://IconRes/b1',
	replace_reward_id = 1,
	replace_reward_count = 1000,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [31] = 
{
	id = 31,
	name = '高级炮',
	icon = 'ui://IconRes/b2',
	replace_res = {
		
	},
	type = 7,
	typeID = 2,
	waceIcon = 'ui://IconRes/b2',
	replace_reward_id = 1,
	replace_reward_count = 1000,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [32] = 
{
	id = 32,
	name = '速射炮',
	icon = 'ui://IconRes/b5',
	replace_res = {
		
	},
	type = 7,
	typeID = 7,
	waceIcon = 'ui://IconRes/b5',
	replace_reward_id = 1,
	replace_reward_count = 1000,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [33] = 
{
	id = 33,
	name = '急速炮',
	icon = 'ui://IconRes/b6',
	replace_res = {
		
	},
	type = 7,
	typeID = 8,
	waceIcon = 'ui://IconRes/b6',
	replace_reward_id = 1,
	replace_reward_count = 1000,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [34] = 
{
	id = 34,
	name = '穿透炮',
	icon = 'ui://IconRes/b7',
	replace_res = {
		
	},
	type = 7,
	typeID = 3,
	waceIcon = 'ui://IconRes/b7',
	replace_reward_id = 17,
	replace_reward_count = 2000000,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [35] = 
{
	id = 35,
	name = '透射炮',
	icon = 'ui://IconRes/b8',
	replace_res = {
		
	},
	type = 7,
	typeID = 4,
	waceIcon = 'ui://IconRes/b8',
	replace_reward_id = 1,
	replace_reward_count = 1000,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [36] = 
{
	id = 36,
	name = '散射炮',
	icon = 'ui://IconRes/b4',
	replace_res = {
		
	},
	type = 7,
	typeID = 5,
	waceIcon = 'ui://IconRes/b4',
	replace_reward_id = 1,
	replace_reward_count = 1000,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [37] = 
{
	id = 37,
	name = '散弹炮',
	icon = 'ui://IconRes/b5',
	replace_res = {
		
	},
	type = 7,
	typeID = 6,
	waceIcon = 'ui://IconRes/b5',
	replace_reward_id = 1,
	replace_reward_count = 1000,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [38] = 
{
	id = 38,
	name = '大力神炮',
	icon = 'ui://IconRes/b9',
	replace_res = {
		
	},
	type = 7,
	typeID = 9,
	waceIcon = 'ui://IconRes/b9',
	replace_reward_id = 1,
	replace_reward_count = 1000,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [60] = 
{
	id = 60,
	name = '喇叭',
	icon = 'ui://IconRes/exchange',
	replace_res = {
		
	},
	type = 8,
	typeID = 1,
	waceIcon = 'ui://IconRes/exchange',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 1,
	pack_index = 101,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '喇叭送福活动期间游戏获得可在兑换界面换取话费、游戏内道具。'
},

    [61] = 
{
	id = 61,
	name = '10元话费',
	icon = 'ui://exchange/k1',
	replace_res = {
		
	},
	type = 9,
	typeID = 1,
	waceIcon = 'ui://IconRes/b8',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [62] = 
{
	id = 62,
	name = '50元话费',
	icon = 'ui://exchange/k2',
	replace_res = {
		
	},
	type = 9,
	typeID = 2,
	waceIcon = 'ui://IconRes/b8',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [63] = 
{
	id = 63,
	name = '100元话费',
	icon = 'ui://exchange/k3',
	replace_res = {
		
	},
	type = 9,
	typeID = 2,
	waceIcon = 'ui://IconRes/b8',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [64] = 
{
	id = 64,
	name = '活动券',
	icon = 'ui://IconRes/huodongqu1',
	replace_res = {
		
	},
	type = 11,
	typeID = 1,
	waceIcon = 'ui://IconRes/huodongqu1',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '获得喇叭，可在活动期间换取游戏内道具。'
},

    [65] = 
{
	id = 65,
	name = '足球',
	icon = 'ui://IconRes/zha',
	replace_res = {
		
	},
	type = 13,
	typeID = 1,
	waceIcon = 'ui://IconRes/zha',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 80,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '足球道具，可在活动期间进行冠军预测，兑换道具。'
},

    [70] = 
{
	id = 70,
	name = '月卡',
	icon = 'ui://IconRes/month',
	replace_res = {
		
	},
	type = 12,
	typeID = 1,
	waceIcon = 'ui://IconRes/month',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 1,
	pack_index = 90,
	can_use = 1,
	use_param = 40,
	is_gift = 1,
	is_alive = 0,
	desc = '使用月卡立即获得180000金币，30天内每天额外领取12000金币。'
},

    [71] = 
{
	id = 71,
	name = '周卡',
	icon = 'ui://IconRes/week',
	replace_res = {
		
	},
	type = 12,
	typeID = 2,
	waceIcon = 'ui://IconRes/week',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 1,
	pack_index = 93,
	can_use = 1,
	use_param = 41,
	is_gift = 1,
	is_alive = 0,
	desc = '使用周卡立即获得96000金币，7天内每天额外领取12000金币。'
},

    [100] = 
{
	id = 100,
	name = '集结币',
	icon = 'ui://IconRes/yuanbao1',
	replace_res = {
		
	},
	type = 100,
	typeID = 1,
	waceIcon = 'ui://IconRes/yuanbao1',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [201] = 
{
	id = 201,
	name = '积分1',
	icon = 'ui://IconRes/jifen',
	replace_res = {
		
	},
	type = 201,
	typeID = 1,
	waceIcon = 'ui://IconRes/jifen',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [202] = 
{
	id = 202,
	name = '积分2',
	icon = 'ui://IconRes/jifen',
	replace_res = {
		
	},
	type = 201,
	typeID = 2,
	waceIcon = 'ui://IconRes/jifen',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [203] = 
{
	id = 203,
	name = '积分3',
	icon = 'ui://IconRes/jifen',
	replace_res = {
		
	},
	type = 201,
	typeID = 3,
	waceIcon = 'ui://IconRes/jifen',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [301] = 
{
	id = 301,
	name = '月卡(3天)',
	icon = 'ui://IconRes/day',
	replace_res = {
		
	},
	type = 15,
	typeID = 1,
	waceIcon = 'ui://IconRes/day',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 1,
	pack_index = 95,
	can_use = 1,
	use_param = 40,
	is_gift = 0,
	is_alive = 3,
	desc = '使用后延长当前激活的月卡或周卡3天。'
},

    [302] = 
{
	id = 302,
	name = '散弹炮(15天)',
	icon = 'ui://IconRes/b8',
	replace_res = {
		
	},
	type = 7,
	typeID = 6,
	waceIcon = 'ui://IconRes/b8',
	replace_reward_id = 1,
	replace_reward_count = 1000,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 15,
	desc = '15天散射炮'
},

    [303] = 
{
	id = 303,
	name = '透射炮(3天)',
	icon = 'ui://IconRes/b6',
	replace_res = {
		
	},
	type = 7,
	typeID = 4,
	waceIcon = 'ui://IconRes/b6',
	replace_reward_id = 1,
	replace_reward_count = 1000,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 3,
	desc = '3天透射炮'
},

    [304] = 
{
	id = 304,
	name = '急速炮(3天)',
	icon = 'ui://IconRes/b4',
	replace_res = {
		
	},
	type = 7,
	typeID = 8,
	waceIcon = 'ui://IconRes/b4',
	replace_reward_id = 1,
	replace_reward_count = 1000,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 3,
	desc = '3天急速炮'
},

    [305] = 
{
	id = 305,
	name = '大力神炮(3天)',
	icon = 'ui://IconRes/b9',
	replace_res = {
		
	},
	type = 7,
	typeID = 9,
	waceIcon = 'ui://IconRes/b92',
	replace_reward_id = 1,
	replace_reward_count = 1000,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 3,
	desc = '3天大力神炮'
},

    [306] = 
{
	id = 306,
	name = '大力神炮(15天)',
	icon = 'ui://IconRes/b9',
	replace_res = {
		
	},
	type = 7,
	typeID = 9,
	waceIcon = 'ui://IconRes/b92',
	replace_reward_id = 1,
	replace_reward_count = 1000,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 15,
	desc = '15天大力神炮'
},

    [401] = 
{
	id = 401,
	name = '青铜鱼雷',
	icon = 'ui://IconRes/icon_yulei_01',
	replace_res = {
		
	},
	type = 6,
	typeID = 12,
	waceIcon = 'ui://IconRes/icon_yulei_01',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 1,
	pack_index = 107,
	can_use = 0,
	use_param = 0,
	is_gift = 1,
	is_alive = 0,
	desc = '黄铜打造的普通鱼雷；游戏中使用可以获得少量金币。'
},

    [402] = 
{
	id = 402,
	name = '白银鱼雷',
	icon = 'ui://IconRes/icon_yulei_02',
	replace_res = {
		
	},
	type = 6,
	typeID = 13,
	waceIcon = 'ui://IconRes/icon_yulei_02',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 1,
	pack_index = 108,
	can_use = 0,
	use_param = 0,
	is_gift = 1,
	is_alive = 0,
	desc = '白银制作的中级鱼雷；游戏中使用可以获得一些金币。'
},

    [403] = 
{
	id = 403,
	name = '黄金鱼雷',
	icon = 'ui://IconRes/icon_yulei_03',
	replace_res = {
		
	},
	type = 6,
	typeID = 14,
	waceIcon = 'ui://IconRes/icon_yulei_03',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 1,
	pack_index = 109,
	can_use = 0,
	use_param = 0,
	is_gift = 1,
	is_alive = 0,
	desc = '黄金打造价值昂贵的高级鱼雷；游戏中使用可以获得很多金币。'
},

    [404] = 
{
	id = 404,
	name = '紫金鱼雷',
	icon = 'ui://IconRes/icon_yulei_04',
	replace_res = {
		
	},
	type = 6,
	typeID = 15,
	waceIcon = 'ui://IconRes/icon_yulei_04',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 1,
	pack_index = 110,
	can_use = 0,
	use_param = 0,
	is_gift = 1,
	is_alive = 0,
	desc = '紫金铸造非常罕见的稀有鱼雷；游戏中使用可以获得大量金币。'
},

    [405] = 
{
	id = 405,
	name = '七彩鱼雷',
	icon = 'ui://IconRes/icon_yulei_05',
	replace_res = {
		
	},
	type = 6,
	typeID = 16,
	waceIcon = 'ui://IconRes/icon_yulei_05',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 1,
	pack_index = 111,
	can_use = 0,
	use_param = 0,
	is_gift = 1,
	is_alive = 0,
	desc = '七彩陨石铸造的传说级鱼雷；游戏中使用可以获得超多金币。'
},

    [81] = 
{
	id = 81,
	name = '金活动卡',
	icon = 'ui://IconRes/yulei5',
	replace_res = {
		
	},
	type = 80,
	typeID = 1,
	waceIcon = 'ui://IconRes/yulei5',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [82] = 
{
	id = 82,
	name = '橙活动卡',
	icon = 'ui://IconRes/yulei4',
	replace_res = {
		
	},
	type = 80,
	typeID = 2,
	waceIcon = 'ui://IconRes/yulei4',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [83] = 
{
	id = 83,
	name = '蓝活动卡',
	icon = 'ui://IconRes/yulei3',
	replace_res = {
		
	},
	type = 80,
	typeID = 3,
	waceIcon = 'ui://IconRes/yulei3',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [91] = 
{
	id = 91,
	name = '任务活力',
	icon = 'ui://IconRes/icon_huoli',
	replace_res = {
		
	},
	type = 16,
	typeID = 1,
	waceIcon = 'ui://IconRes/icon_huoli',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [92] = 
{
	id = 92,
	name = '抽奖券',
	icon = 'ui://IconRes/icon_choujiangquan',
	replace_res = {
		
	},
	type = 17,
	typeID = 1,
	waceIcon = 'ui://IconRes/icon_choujiangquan',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [93] = 
{
	id = 93,
	name = '抽奖能量',
	icon = 'ui://IconRes/icon_huoli',
	replace_res = {
		
	},
	type = 18,
	typeID = 3,
	waceIcon = 'ui://IconRes/icon_huoli',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [110] = 
{
	id = 110,
	name = '激光炮',
	icon = 'ui://IconRes/b92',
	replace_res = {
		
	},
	type = 19,
	typeID = 100,
	waceIcon = 'ui://ChangeSkin/b10',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},

    [111] = 
{
	id = 111,
	name = '钻头炮',
	icon = 'ui://IconRes/b92',
	replace_res = {
		
	},
	type = 19,
	typeID = 101,
	waceIcon = 'ui://ChangeSkin/b9',
	replace_reward_id = 0,
	replace_reward_count = 0,
	packed = 0,
	pack_index = 0,
	can_use = 0,
	use_param = 0,
	is_gift = 0,
	is_alive = 0,
	desc = '0'
},


}

return cfg_goods