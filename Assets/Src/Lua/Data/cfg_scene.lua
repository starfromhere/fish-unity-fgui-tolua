
---@class cfg_scene
___cfg_scene = 
{
	id = 1,
	play_id = 1,
	robot_time = {
		180000,
		300000
	},
	type = 0,
	stage = {
		
		{
			fish = {
				1001,
				1002,
				1003,
				1004,
				1005,
				1007,
				1008,
				1009,
				1010,
				1011,
				1012,
				1013,
				1019
			}
		}
	},
	crab = {
		1101,
		1102,
		1103,
		1104
	},
	fish_arr = {
		1001,
		1002,
		1003,
		1004,
		1005,
		1007,
		1008,
		1009,
		1010,
		1011,
		1012,
		1013,
		1019,
		1101,
		1102,
		1103,
		1104
	},
	skills = {
		1,
		2,
		-1,
		4,
		5,
		12,
		13,
		14,
		15,
		16,
		11
	},
	smallfish_arr = {
		116
	},
	bigfish_arr = {
		1019,
		1013,
		1012,
		1011,
		1010,
		1009,
		1008,
		1007,
		1005,
		1004,
		1003,
		1002,
		1001
	},
	unlock = 1,
	robot_mag = {
		10,
		9,
		8,
		7,
		6,
		5,
		4
	},
	max_mag = 10,
	min_mag = 1,
	pri = 1,
	is_basic = 1,
	form = 0,
	form_arr = {
		9,
		10,
		11
	},
	form_arr_down = {
		9,
		10,
		11
	},
	play_group = 120,
	nextArea = 2,
	sceneBgImg_down = 'ui://FishScene1/scene1_bg',
	autoPlay = 0,
	sceneAniName = 'ui://FishScene1/GameBgAniScene1',
	backMusic = 'Music/BG2.wav',
	levelname = '关卡1',
	sceneType = 0,
	msgTip = '1倍炮解锁',
	unlockImage = '1倍炮解锁',
	web = 1.5,
	range = 1,
	msg_tip_id = 0,
	spine_name = 'shenhaijujing',
	spine_name_down = 'shenhaijujing_down',
	resource = 1,
	description = '',
	show_ani = 1,
	hidden_battery_level = 7,
	doubleRate = {
		0,
		0
	}
}

---@field public instance cfg_scene
---@type table<string,cfg_scene>
cfg_scene =  {
instance = function(key)
    return cfg_scene[key]
end,

    [1] = 
{
	id = 1,
	play_id = 1,
	robot_time = {
		180000,
		300000
	},
	type = 0,
	stage = {
		
		{
			fish = {
				1001,
				1002,
				1003,
				1004,
				1005,
				1007,
				1008,
				1009,
				1010,
				1011,
				1012,
				1013,
				1019
			}
		}
	},
	crab = {
		1101,
		1102,
		1103,
		1104
	},
	fish_arr = {
		1001,
		1002,
		1003,
		1004,
		1005,
		1007,
		1008,
		1009,
		1010,
		1011,
		1012,
		1013,
		1019,
		1101,
		1102,
		1103,
		1104
	},
	skills = {
		1,
		2,
		-1,
		4,
		5,
		12,
		13,
		14,
		15,
		16,
		11
	},
	smallfish_arr = {
		116
	},
	bigfish_arr = {
		1019,
		1013,
		1012,
		1011,
		1010,
		1009,
		1008,
		1007,
		1005,
		1004,
		1003,
		1002,
		1001
	},
	unlock = 1,
	robot_mag = {
		10,
		9,
		8,
		7,
		6,
		5,
		4
	},
	max_mag = 10,
	min_mag = 1,
	pri = 1,
	is_basic = 1,
	form = 0,
	form_arr = {
		9,
		10,
		11
	},
	form_arr_down = {
		9,
		10,
		11
	},
	play_group = 120,
	nextArea = 2,
	sceneBgImg_down = 'ui://FishScene1/scene1_bg',
	autoPlay = 0,
	sceneAniName = 'ui://FishScene1/GameBgAniScene1',
	backMusic = 'Music/BG2.wav',
	levelname = '关卡1',
	sceneType = 0,
	msgTip = '1倍炮解锁',
	unlockImage = '1倍炮解锁',
	web = 1.5,
	range = 1,
	msg_tip_id = 0,
	spine_name = 'shenhaijujing',
	spine_name_down = 'shenhaijujing_down',
	resource = 1,
	description = '',
	show_ani = 1,
	hidden_battery_level = 7,
	doubleRate = {
		0,
		0
	}
},

    [2] = 
{
	id = 2,
	play_id = 3,
	robot_time = {
		180000,
		300000
	},
	type = 0,
	stage = {
		
		{
			fishform = {
				1,
				2
			}
		},
		
		{
			t = 60,
			cleanOldFish = 1,
			boss = {
				{
					1302
				}
			},
			fish = {
				1001,
				1002,
				1003,
				1004,
				1005,
				1007,
				1008,
				1009,
				1010,
				1011,
				1012,
				1013,
				1014,
				1017
			}
		},
		
		{
			t = 120,
			boss = {
				{
					1202
				}
			},
			fish = {
				
			}
		}
	},
	crab = {
		1301,
		1101,
		1102,
		1103,
		1104
	},
	fish_arr = {
		1001,
		1002,
		1003,
		1004,
		1005,
		1007,
		1008,
		1009,
		1010,
		1011,
		1012,
		1013,
		1014,
		1017,
		1101,
		1102,
		1103,
		1104,
		1202
	},
	skills = {
		1,
		2,
		-1,
		4,
		5,
		12,
		13,
		14,
		15,
		16,
		11
	},
	smallfish_arr = {
		116
	},
	bigfish_arr = {
		1203,
		1201,
		1202,
		1104,
		1103,
		1102,
		1101,
		1019,
		1018,
		1017,
		1016,
		1015,
		1014,
		1013,
		1012,
		1011,
		1010,
		1009,
		1008,
		1007,
		1005,
		1004,
		1003,
		1002,
		1001
	},
	unlock = 7,
	robot_mag = {
		17,
		16,
		15,
		14,
		13,
		12,
		11,
		10
	},
	max_mag = 17,
	min_mag = 5,
	pri = 2,
	is_basic = 1,
	form = 0,
	form_arr = {
		3,
		4,
		12
	},
	form_arr_down = {
		3,
		4,
		12
	},
	play_group = 120,
	nextArea = 2,
	sceneBgImg_down = 'ui://FishScene2/scene2_bg',
	autoPlay = 0,
	sceneAniName = 'ui://FishScene2/GameBgAniScene2',
	backMusic = 'Music/BG3.wav',
	levelname = '关卡3',
	sceneType = 0,
	msgTip = '50倍炮解锁',
	unlockImage = '50倍炮解锁',
	web = 1.5,
	range = 1,
	msg_tip_id = 26,
	spine_name = 'tieqianxiewang',
	spine_name_down = 'tieqianxiewang_down',
	resource = 1,
	description = '',
	show_ani = 1,
	hidden_battery_level = 9999,
	doubleRate = {
		1,
		0
	}
},

    [3] = 
{
	id = 3,
	play_id = 2,
	robot_time = {
		180000,
		300000
	},
	type = 0,
	stage = {
		
		{
			fishform = {
				3,
				4
			}
		},
		
		{
			t = 60,
			cleanOldFish = 1,
			boss = {
				{
					1302
				}
			},
			fish = {
				1001,
				1002,
				1003,
				1004,
				1005,
				1007,
				1008,
				1009,
				1010,
				1011,
				1012,
				1013,
				1015,
				1018
			}
		},
		
		{
			t = 120,
			boss = {
				{
					1201
				}
			},
			fish = {
				
			}
		}
	},
	crab = {
		1301,
		1101,
		1102,
		1103,
		1104
	},
	fish_arr = {
		1001,
		1002,
		1003,
		1004,
		1005,
		1007,
		1008,
		1009,
		1010,
		1011,
		1012,
		1013,
		1015,
		1018,
		1101,
		1102,
		1103,
		1104,
		1201
	},
	skills = {
		1,
		2,
		-1,
		4,
		5,
		12,
		13,
		14,
		15,
		16,
		11
	},
	smallfish_arr = {
		116
	},
	bigfish_arr = {
		1203,
		1201,
		1202,
		1104,
		1103,
		1102,
		1101,
		1019,
		1018,
		1017,
		1016,
		1015,
		1014,
		1013,
		1012,
		1011,
		1010,
		1009,
		1008,
		1007,
		1005,
		1004,
		1003,
		1002,
		1001
	},
	unlock = 13,
	robot_mag = {
		20,
		19,
		18,
		17,
		16,
		15
	},
	max_mag = 20,
	min_mag = 13,
	pri = 3,
	is_basic = 1,
	form = 0,
	form_arr = {
		5,
		6,
		13
	},
	form_arr_down = {
		5,
		6,
		13
	},
	play_group = 120,
	nextArea = 3,
	sceneBgImg_down = 'ui://FishScene3/scene3_bg',
	autoPlay = 0,
	sceneAniName = 'ui://FishScene3/GameBgAniScene3',
	backMusic = 'Music/BG0.wav',
	levelname = '关卡2',
	sceneType = 0,
	msgTip = '600倍炮解锁',
	unlockImage = '600倍炮解锁',
	web = 1.5,
	range = 1,
	msg_tip_id = 27,
	spine_name = 'jixieyuwang',
	spine_name_down = 'jixieyuwang_down',
	resource = 1,
	description = '',
	show_ani = 1,
	hidden_battery_level = 9999,
	doubleRate = {
		1,
		1
	}
},

    [4] = 
{
	id = 4,
	play_id = 4,
	robot_time = {
		180000,
		300000
	},
	type = 0,
	stage = {
		
		{
			fishform = {
				5,
				6
			}
		},
		
		{
			t = 60,
			cleanOldFish = 1,
			boss = {
				{
					1302
				}
			},
			fish = {
				1001,
				1002,
				1003,
				1004,
				1005,
				1007,
				1008,
				1009,
				1010,
				1011,
				1012,
				1013,
				1016,
				1019
			}
		},
		
		{
			t = 120,
			boss = {
				{
					1203,
					1204,
					1205,
					1206
				}
			},
			fish = {
				
			}
		}
	},
	crab = {
		1301,
		1101,
		1102,
		1103,
		1104
	},
	fish_arr = {
		1001,
		1002,
		1003,
		1004,
		1005,
		1007,
		1008,
		1009,
		1010,
		1011,
		1012,
		1013,
		1016,
		1019,
		1101,
		1102,
		1103,
		1104,
		1203,
		1204,
		1205,
		1206
	},
	skills = {
		1,
		2,
		-1,
		4,
		5,
		12,
		13,
		14,
		15,
		16,
		11
	},
	smallfish_arr = {
		116
	},
	bigfish_arr = {
		1203,
		1201,
		1202,
		1104,
		1103,
		1102,
		1101,
		1019,
		1018,
		1017,
		1016,
		1015,
		1014,
		1013,
		1012,
		1011,
		1010,
		1009,
		1008,
		1007,
		1005,
		1004,
		1003,
		1002,
		1001
	},
	unlock = 17,
	robot_mag = {
		26,
		25,
		24,
		23,
		22,
		21,
		20
	},
	max_mag = 26,
	min_mag = 17,
	pri = 4,
	is_basic = 1,
	form = 0,
	form_arr = {
		7,
		8,
		14
	},
	form_arr_down = {
		7,
		8,
		14
	},
	play_group = 120,
	nextArea = 3,
	sceneBgImg_down = 'ui://FishScene4/scene4_bg',
	autoPlay = 1,
	sceneAniName = 'ui://FishScene4/GameBgAniScene4',
	backMusic = 'Music/BG4.wav',
	levelname = '关卡4',
	sceneType = 0,
	msgTip = '2000倍炮解锁',
	unlockImage = '2000倍炮解锁',
	web = 1.5,
	range = 1,
	msg_tip_id = 28,
	spine_name = 'wannianjue',
	spine_name_down = 'wannianjue_down',
	resource = 1,
	description = '',
	show_ani = 1,
	hidden_battery_level = 9999,
	doubleRate = {
		1,
		1
	}
},

    [5] = 
{
	id = 5,
	play_id = 5,
	robot_time = {
		0
	},
	type = 1,
	stage = {
		
		{
			fish = {
				1001,
				1002,
				1003,
				1004,
				1005,
				1007,
				1008,
				1009,
				1010,
				1011,
				1012,
				1013,
				1019
			}
		}
	},
	crab = {
		
	},
	fish_arr = {
		1001,
		1002,
		1003,
		1004,
		1005,
		1007,
		1008,
		1009,
		1010,
		1011,
		1012,
		1013,
		1019
	},
	skills = {
		1,
		2,
		-1,
		4,
		-1,
		-1,
		-1,
		-1,
		-1,
		-1,
		-1
	},
	smallfish_arr = {
		116
	},
	bigfish_arr = {
		1019,
		1013,
		1012,
		1011,
		1010,
		1009,
		1008,
		1007,
		1005,
		1004,
		1003,
		1002,
		1001
	},
	unlock = 8,
	robot_mag = {
		6
	},
	max_mag = 6,
	min_mag = 1,
	pri = 5,
	is_basic = 1,
	form = 0,
	form_arr = {
		1,
		2
	},
	form_arr_down = {
		1,
		2
	},
	play_group = 120,
	nextArea = 2,
	sceneBgImg_down = 'ui://FishScene1/scene1_bg',
	autoPlay = 0,
	sceneAniName = 'ui://FishScene1/GameBgAniScene1',
	backMusic = 'Music/BG1.wav',
	levelname = '日常赛',
	sceneType = 0,
	msgTip = '100倍炮解锁',
	unlockImage = '100倍炮解锁',
	web = 1.5,
	range = 1,
	msg_tip_id = 26,
	spine_name = 'shenhaijujing',
	spine_name_down = 'shenhaijujing_down',
	resource = 2,
	description = '在规定时间内发射子弹捕获屏幕中的鱼获得更多珍珠，每场比赛结束后将根据获得珍珠的最高数量进行排名，排名越高获得的比赛奖励越丰厚，每天零点比赛结算后，获得奖励的玩家可在竞技场内领取奖励。',
	show_ani = 0,
	hidden_battery_level = 9999,
	doubleRate = {
		0,
		0
	}
},

    [6] = 
{
	id = 6,
	play_id = 6,
	robot_time = {
		8000,
		18000
	},
	type = 1,
	stage = {
		
		{
			fish = {
				1001,
				1002,
				1003,
				1004,
				1005,
				1007,
				1008,
				1009,
				1010,
				1011,
				1012,
				1013,
				1019
			}
		}
	},
	crab = {
		
	},
	fish_arr = {
		1001,
		1002,
		1003,
		1004,
		1005,
		1007,
		1008,
		1009,
		1010,
		1011,
		1012,
		1013,
		1019
	},
	skills = {
		1,
		2,
		-1,
		4,
		-1,
		-1,
		-1,
		-1,
		-1,
		-1,
		-1
	},
	smallfish_arr = {
		116
	},
	bigfish_arr = {
		1019,
		1013,
		1012,
		1011,
		1010,
		1009,
		1008,
		1007,
		1005,
		1004,
		1003,
		1002,
		1001
	},
	unlock = 8,
	robot_mag = {
		6
	},
	max_mag = 6,
	min_mag = 1,
	pri = 6,
	is_basic = 1,
	form = 0,
	form_arr = {
		1,
		2
	},
	form_arr_down = {
		1,
		2
	},
	play_group = 120,
	nextArea = 2,
	sceneBgImg_down = 'ui://FishScene1/scene1_bg',
	autoPlay = 0,
	sceneAniName = 'ui://FishScene1/GameBgAniScene1',
	backMusic = 'Music/BG1.wav',
	levelname = '挑战赛',
	sceneType = 0,
	msgTip = '100倍炮解锁',
	unlockImage = '100倍炮解锁',
	web = 1.5,
	range = 1,
	msg_tip_id = 26,
	spine_name = 'tieqianxiewang',
	spine_name_down = 'tieqianxiewang_down',
	resource = 2,
	description = '挑战赛需连续进行比赛，每轮比赛由两名玩家进行比拼，在规定时间内发射子弹捕获屏幕中的鱼获得更多珍珠，获得珍珠多的玩家获得此轮比赛胜利，并晋级至下一轮，胜利轮次越多获得奖励越丰厚，比赛结束立即发放奖励。',
	show_ani = 0,
	hidden_battery_level = 9999,
	doubleRate = {
		0,
		0
	}
},

    [7] = 
{
	id = 7,
	play_id = 7,
	robot_time = {
		0
	},
	type = 1,
	stage = {
		
		{
			fish = {
				1001,
				1002,
				1003,
				1004,
				1005,
				1007,
				1008,
				1009,
				1010,
				1011,
				1012,
				1013,
				1019
			}
		}
	},
	crab = {
		
	},
	fish_arr = {
		1001,
		1002,
		1003,
		1004,
		1005,
		1007,
		1008,
		1009,
		1010,
		1011,
		1012,
		1013,
		1019
	},
	skills = {
		1,
		2,
		-1,
		4,
		-1,
		-1,
		-1,
		-1,
		-1,
		-1,
		-1
	},
	smallfish_arr = {
		116
	},
	bigfish_arr = {
		1019,
		1013,
		1012,
		1011,
		1010,
		1009,
		1008,
		1007,
		1005,
		1004,
		1003,
		1002,
		1001
	},
	unlock = 8,
	robot_mag = {
		6
	},
	max_mag = 6,
	min_mag = 1,
	pri = 7,
	is_basic = 1,
	form = 0,
	form_arr = {
		1,
		2
	},
	form_arr_down = {
		1,
		2
	},
	play_group = 120,
	nextArea = 3,
	sceneBgImg_down = 'ui://FishScene1/scene1_bg',
	autoPlay = 0,
	sceneAniName = 'ui://FishScene1/GameBgAniScene1',
	backMusic = 'Music/BG1.wav',
	levelname = '匹配赛',
	sceneType = 0,
	msgTip = '100倍炮解锁',
	unlockImage = '100倍炮解锁',
	web = 1.5,
	range = 1,
	msg_tip_id = 26,
	spine_name = 'jixieyuwang',
	spine_name_down = 'jixieyuwang_down',
	resource = 2,
	description = '房间内其他玩家都准备好后由房主点击按钮开始游戏，在规定时间内发射子弹捕获屏幕中的鱼获得更多珍珠，获得珍珠最多的玩家赢得比赛并获得本局比赛奖励，参与人数越多获得奖励越丰厚，比赛结束立即发放奖励。',
	show_ani = 0,
	hidden_battery_level = 9999,
	doubleRate = {
		0,
		0
	}
},

    [8] = 
{
	id = 8,
	play_id = 8,
	robot_time = {
		0
	},
	type = 1,
	stage = {
		
	},
	crab = {
		
	},
	fish_arr = {
		3001
	},
	skills = {
		-1,
		-1,
		-1,
		-1,
		-1,
		-1,
		-1,
		-1,
		-1,
		-1,
		-1
	},
	smallfish_arr = {
		3001
	},
	bigfish_arr = {
		3001
	},
	unlock = 20,
	robot_mag = {
		20
	},
	max_mag = 20,
	min_mag = 13,
	pri = 8,
	is_basic = 1,
	form = 0,
	form_arr = {
		1,
		2
	},
	form_arr_down = {
		1,
		2
	},
	play_group = 120,
	nextArea = 3,
	sceneBgImg_down = 'ui://FishScene1/scene1_bg',
	autoPlay = 0,
	sceneAniName = 'ui://FishScene1/GameBgAniScene1',
	backMusic = 'Music/BG1.wav',
	levelname = '抢夺赛',
	sceneType = 0,
	msgTip = '1000倍炮解锁',
	unlockImage = '1000倍炮解锁',
	web = 1.5,
	range = 1,
	msg_tip_id = 26,
	spine_name = 'wannianjue',
	spine_name_down = 'wannianjue_down',
	resource = 1,
	description = '抢夺赛',
	show_ani = 0,
	hidden_battery_level = 9999,
	doubleRate = {
		0,
		0
	}
},

    [9] = 
{
	id = 9,
	play_id = 9,
	robot_time = {
		180000,
		300000
	},
	type = 0,
	stage = {
		
	},
	crab = {
		
	},
	fish_arr = {
		4022,
		4021,
		4020,
		4019
	},
	skills = {
		1,
		2,
		-1,
		4,
		5,
		12,
		13,
		14,
		15,
		16,
		11
	},
	smallfish_arr = {
		116
	},
	bigfish_arr = {
		4022,
		4021,
		4020,
		4019,
		4018,
		4017,
		4016,
		4015,
		4014,
		4013,
		4012,
		4011,
		4010,
		4009,
		4008,
		4007,
		4006,
		4005,
		4004,
		4003,
		4002,
		4001,
		20001,
		20002,
		20003,
		20004,
		20005,
		20006
	},
	unlock = 17,
	robot_mag = {
		26,
		25,
		24,
		23,
		22,
		21,
		20
	},
	max_mag = 26,
	min_mag = 17,
	pri = 9,
	is_basic = 1,
	form = 0,
	form_arr = {
		7,
		8,
		14
	},
	form_arr_down = {
		7,
		8,
		14
	},
	play_group = 120,
	nextArea = 3,
	sceneBgImg_down = 'ui://FishScene4/scene4_bg',
	autoPlay = 1,
	sceneAniName = 'ui://FishScene4/GameBgAniScene4',
	backMusic = 'Music/BG1.wav',
	levelname = '关卡5',
	sceneType = 0,
	msgTip = '2000倍炮解锁',
	unlockImage = '2000倍炮解锁',
	web = 1.5,
	range = 1,
	msg_tip_id = 28,
	spine_name = 'wannianjue',
	spine_name_down = 'wannianjue_down',
	resource = 1,
	description = '',
	show_ani = 1,
	hidden_battery_level = 9999,
	doubleRate = {
		1,
		1
	}
},


}

return cfg_scene