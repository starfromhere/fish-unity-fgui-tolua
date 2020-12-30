
---@class cfg_battery
___cfg_battery = 
{
	id = 1,
	need_diamond = 2,
	cast_diamond = 2,
	maxDegree = 23,
	degree = 1,
	comsume = 1,
	award = {
		1,
		50
	},
	buff = {
		0
	},
	prize = 0,
	min_battery = 1
}

---@field public instance cfg_battery
---@type table<string,cfg_battery>
cfg_battery =  {
instance = function(key)
    return cfg_battery[key]
end,

    [1] = 
{
	id = 1,
	need_diamond = 2,
	cast_diamond = 2,
	maxDegree = 23,
	degree = 1,
	comsume = 1,
	award = {
		1,
		50
	},
	buff = {
		0
	},
	prize = 0,
	min_battery = 1
},

    [2] = 
{
	id = 2,
	need_diamond = 3,
	cast_diamond = 3,
	maxDegree = 23,
	degree = 2,
	comsume = 2,
	award = {
		1,
		60
	},
	buff = {
		0
	},
	prize = 0,
	min_battery = 1
},

    [3] = 
{
	id = 3,
	need_diamond = 4,
	cast_diamond = 4,
	maxDegree = 23,
	degree = 3,
	comsume = 3,
	award = {
		1,
		70
	},
	buff = {
		0
	},
	prize = 0,
	min_battery = 1
},

    [4] = 
{
	id = 4,
	need_diamond = 5,
	cast_diamond = 5,
	maxDegree = 23,
	degree = 4,
	comsume = 5,
	award = {
		1,
		80
	},
	buff = {
		0
	},
	prize = 0,
	min_battery = 1
},

    [5] = 
{
	id = 5,
	need_diamond = 6,
	cast_diamond = 6,
	maxDegree = 23,
	degree = 5,
	comsume = 10,
	award = {
		1,
		90
	},
	buff = {
		0
	},
	prize = 0,
	min_battery = 1
},

    [6] = 
{
	id = 6,
	need_diamond = 7,
	cast_diamond = 7,
	maxDegree = 23,
	degree = 6,
	comsume = 20,
	award = {
		1,
		100
	},
	buff = {
		0
	},
	prize = 0,
	min_battery = 1
},

    [7] = 
{
	id = 7,
	need_diamond = 8,
	cast_diamond = 8,
	maxDegree = 23,
	degree = 7,
	comsume = 50,
	award = {
		1,
		200
	},
	buff = {
		0
	},
	prize = 0,
	min_battery = 1
},

    [8] = 
{
	id = 8,
	need_diamond = 9,
	cast_diamond = 9,
	maxDegree = 23,
	degree = 8,
	comsume = 100,
	award = {
		1,
		400
	},
	buff = {
		0
	},
	prize = 0,
	min_battery = 1
},

    [9] = 
{
	id = 9,
	need_diamond = 10,
	cast_diamond = 10,
	maxDegree = 23,
	degree = 9,
	comsume = 200,
	award = {
		1,
		600
	},
	buff = {
		0
	},
	prize = 0,
	min_battery = 1
},

    [10] = 
{
	id = 10,
	need_diamond = 20,
	cast_diamond = 20,
	maxDegree = 23,
	degree = 10,
	comsume = 300,
	award = {
		1,
		800
	},
	buff = {
		0
	},
	prize = 0,
	min_battery = 1
},

    [11] = 
{
	id = 11,
	need_diamond = 30,
	cast_diamond = 30,
	maxDegree = 23,
	degree = 11,
	comsume = 400,
	award = {
		1,
		1000
	},
	buff = {
		0
	},
	prize = 0,
	min_battery = 2
},

    [12] = 
{
	id = 12,
	need_diamond = 40,
	cast_diamond = 40,
	maxDegree = 23,
	degree = 12,
	comsume = 500,
	award = {
		1,
		1200
	},
	buff = {
		0
	},
	prize = 0,
	min_battery = 3
},

    [13] = 
{
	id = 13,
	need_diamond = 50,
	cast_diamond = 50,
	maxDegree = 23,
	degree = 13,
	comsume = 600,
	award = {
		1,
		1400
	},
	buff = {
		0
	},
	prize = 6,
	min_battery = 4
},

    [14] = 
{
	id = 14,
	need_diamond = 100,
	cast_diamond = 100,
	maxDegree = 23,
	degree = 14,
	comsume = 800,
	award = {
		1,
		1700
	},
	buff = {
		0
	},
	prize = 8,
	min_battery = 5
},

    [15] = 
{
	id = 15,
	need_diamond = 150,
	cast_diamond = 150,
	maxDegree = 23,
	degree = 15,
	comsume = 1000,
	award = {
		1,
		2000
	},
	buff = {
		0
	},
	prize = 10,
	min_battery = 6
},

    [16] = 
{
	id = 16,
	need_diamond = 200,
	cast_diamond = 200,
	maxDegree = 23,
	degree = 16,
	comsume = 1500,
	award = {
		1,
		2300
	},
	buff = {
		0
	},
	prize = 15,
	min_battery = 7
},

    [17] = 
{
	id = 17,
	need_diamond = 250,
	cast_diamond = 250,
	maxDegree = 23,
	degree = 17,
	comsume = 2000,
	award = {
		1,
		2600
	},
	buff = {
		0
	},
	prize = 20,
	min_battery = 8
},

    [18] = 
{
	id = 18,
	need_diamond = 300,
	cast_diamond = 300,
	maxDegree = 23,
	degree = 18,
	comsume = 2500,
	award = {
		1,
		3000
	},
	buff = {
		0
	},
	prize = 25,
	min_battery = 9
},

    [19] = 
{
	id = 19,
	need_diamond = 350,
	cast_diamond = 350,
	maxDegree = 23,
	degree = 19,
	comsume = 3000,
	award = {
		1,
		3400
	},
	buff = {
		0
	},
	prize = 30,
	min_battery = 10
},

    [20] = 
{
	id = 20,
	need_diamond = 400,
	cast_diamond = 400,
	maxDegree = 23,
	degree = 20,
	comsume = 4000,
	award = {
		1,
		3800
	},
	buff = {
		0
	},
	prize = 40,
	min_battery = 11
},

    [21] = 
{
	id = 21,
	need_diamond = 450,
	cast_diamond = 450,
	maxDegree = 23,
	degree = 21,
	comsume = 5000,
	award = {
		1,
		4200
	},
	buff = {
		0
	},
	prize = 50,
	min_battery = 12
},

    [22] = 
{
	id = 22,
	need_diamond = 500,
	cast_diamond = 500,
	maxDegree = 23,
	degree = 22,
	comsume = 6000,
	award = {
		1,
		4600
	},
	buff = {
		0
	},
	prize = 60,
	min_battery = 13
},

    [23] = 
{
	id = 23,
	need_diamond = 600,
	cast_diamond = 600,
	maxDegree = 23,
	degree = 23,
	comsume = 8000,
	award = {
		1,
		5000
	},
	buff = {
		0
	},
	prize = 80,
	min_battery = 14
},

    [24] = 
{
	id = 24,
	need_diamond = 700,
	cast_diamond = 700,
	maxDegree = 23,
	degree = 24,
	comsume = 10000,
	award = {
		1,
		5500
	},
	buff = {
		0
	},
	prize = 100,
	min_battery = 15
},

    [25] = 
{
	id = 25,
	need_diamond = 800,
	cast_diamond = 800,
	maxDegree = 23,
	degree = 25,
	comsume = 15000,
	award = {
		1,
		6000
	},
	buff = {
		0
	},
	prize = 150,
	min_battery = 16
},

    [26] = 
{
	id = 26,
	need_diamond = 1000,
	cast_diamond = 1000,
	maxDegree = 23,
	degree = 26,
	comsume = 20000,
	award = {
		1,
		6500
	},
	buff = {
		0
	},
	prize = 200,
	min_battery = 17
},


}

return cfg_battery