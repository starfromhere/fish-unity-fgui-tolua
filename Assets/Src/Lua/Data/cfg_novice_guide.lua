
---@class cfg_novice_guide
___cfg_novice_guide = 
{
	id = 1,
	type = 'classicInto',
	click_name = 'click',
	click_event = 'view',
	step_box_name = 'step_into',
	step_list_name = 'steps1',
	effect_name1 = 'click'
}

---@field public instance cfg_novice_guide
---@type table<string,cfg_novice_guide>
cfg_novice_guide =  {
instance = function(key)
    return cfg_novice_guide[key]
end,

    [1] = 
{
	id = 1,
	type = 'classicInto',
	click_name = 'click',
	click_event = 'view',
	step_box_name = 'step_into',
	step_list_name = 'steps1',
	effect_name1 = 'click'
},

    [2] = 
{
	id = 2,
	type = 'fight',
	click_name = 'click',
	click_event = 'name',
	step_box_name = 'step_fight',
	step_list_name = 'steps1',
	effect_name1 = 'click'
},

    [3] = 
{
	id = 3,
	type = 'click',
	click_name = 'step_click1',
	click_event = 'view',
	step_box_name = 'step_click1',
	step_list_name = 'steps1',
	effect_name1 = ''
},

    [4] = 
{
	id = 4,
	type = 'click',
	click_name = 'step_click2',
	click_event = 'view',
	step_box_name = 'step_click2',
	step_list_name = 'steps1',
	effect_name1 = ''
},

    [5] = 
{
	id = 5,
	type = 'shoot',
	click_name = 'step_click3',
	click_event = 'view',
	step_box_name = 'step_click3',
	step_list_name = 'steps1',
	effect_name1 = ''
},

    [6] = 
{
	id = 6,
	type = 'click',
	click_name = 'click',
	click_event = 'name',
	step_box_name = 'yzcb',
	step_list_name = 'steps1',
	effect_name1 = 'click'
},

    [7] = 
{
	id = 7,
	type = 'click',
	click_name = 'xsyd1',
	click_event = 'view',
	step_box_name = 'step_xsyd1',
	step_list_name = 'steps1',
	effect_name1 = ''
},

    [8] = 
{
	id = 8,
	type = 'daily',
	click_name = 'click',
	click_event = 'name',
	step_box_name = 'step_task1',
	step_list_name = 'steps1',
	effect_name1 = 'click'
},

    [9] = 
{
	id = 9,
	type = 'dailyGo',
	click_name = 'click',
	click_event = 'name',
	step_box_name = 'step_task2',
	step_list_name = 'steps1',
	effect_name1 = 'click'
},

    [10] = 
{
	id = 10,
	type = 'dailyUseProp',
	click_name = 'click',
	click_event = 'name',
	step_box_name = 'step_task3',
	step_list_name = 'steps1',
	effect_name1 = 'click'
},

    [11] = 
{
	id = 11,
	type = 'acceptDaily',
	click_name = 'click',
	click_event = 'name',
	step_box_name = 'step_task4',
	step_list_name = 'steps1',
	effect_name1 = 'click'
},

    [12] = 
{
	id = 12,
	type = 'unlockBattery',
	click_name = 'click',
	click_event = 'name',
	step_box_name = 'step_up',
	step_list_name = 'steps1',
	effect_name1 = 'click'
},

    [13] = 
{
	id = 13,
	type = 'changeBattery',
	click_name = 'click',
	click_event = 'name',
	step_box_name = 'step_change',
	step_list_name = 'steps1',
	effect_name1 = 'click'
},

    [14] = 
{
	id = 14,
	type = 'click',
	click_name = 'xsyd2',
	click_event = 'view',
	step_box_name = 'step_xsyd2',
	step_list_name = 'steps1',
	effect_name1 = ''
},

    [15] = 
{
	id = 15,
	type = 'quitFight',
	click_name = 'click',
	click_event = 'name',
	step_box_name = 'step_quitfight',
	step_list_name = 'steps1',
	effect_name1 = ''
},

    [16] = 
{
	id = 16,
	type = 'rank',
	click_name = 'click',
	click_event = 'name',
	step_box_name = 'step_rank',
	step_list_name = 'steps3',
	effect_name1 = 'click'
},

    [17] = 
{
	id = 17,
	type = 'rankQuit',
	click_name = 'click',
	click_event = 'name',
	step_box_name = 'step_quit_rank',
	step_list_name = 'steps3',
	effect_name1 = 'click'
},

    [18] = 
{
	id = 18,
	type = 'openFollow',
	click_name = 'click',
	click_event = 'name',
	step_box_name = 'step_follow',
	step_list_name = 'steps1',
	effect_name1 = 'click'
},

    [19] = 
{
	id = 19,
	type = 'click',
	click_name = 'xsyd1',
	click_event = 'view',
	step_box_name = 'step_xsyd3',
	step_list_name = 'steps1',
	effect_name1 = ''
},

    [100] = 
{
	id = 100,
	type = 'click',
	click_name = 'xsyd4',
	click_event = 'view',
	step_box_name = 'step_xsyd4',
	step_list_name = 'steps2',
	effect_name1 = ''
},

    [101] = 
{
	id = 101,
	type = 'back',
	click_name = 'click',
	click_event = 'name',
	step_box_name = 'step_back',
	step_list_name = 'steps2',
	effect_name1 = ''
},

    [102] = 
{
	id = 102,
	type = 'open_contest_icon',
	click_name = 'click',
	click_event = 'name',
	step_box_name = 'step_open',
	step_list_name = 'steps2',
	effect_name1 = 'click'
},

    [103] = 
{
	id = 103,
	type = 'sign_contest',
	click_name = 'click',
	click_event = 'name',
	step_box_name = 'step_contest',
	step_list_name = 'steps2',
	effect_name1 = 'click'
},

    [104] = 
{
	id = 104,
	type = 'sign_contest_confirm',
	click_name = 'click',
	click_event = 'name',
	step_box_name = 'step_confirm',
	step_list_name = 'steps2',
	effect_name1 = 'click'
},

    [105] = 
{
	id = 105,
	type = 'click',
	click_name = 'xsyd5',
	click_event = 'view',
	step_box_name = 'step_xsyd5',
	step_list_name = 'steps2',
	effect_name1 = ''
},

    [106] = 
{
	id = 106,
	type = 'click',
	click_name = 'step_click4',
	click_event = 'view',
	step_box_name = 'step_click4',
	step_list_name = 'steps2',
	effect_name1 = ''
},

    [107] = 
{
	id = 107,
	type = 'click',
	click_name = 'step_click5',
	click_event = 'view',
	step_box_name = 'step_click5',
	step_list_name = 'steps2',
	effect_name1 = ''
},

    [108] = 
{
	id = 108,
	type = 'click',
	click_name = 'xsyd6',
	click_event = 'view',
	step_box_name = 'step_xsyd6',
	step_list_name = 'steps2',
	effect_name1 = ''
},


}

return cfg_novice_guide