
---@class cfg_hourse
___cfg_hourse = 
{
	id = 1,
	txt1 = 1,
	txt2 = 2,
	txt3 = 3,
	txt4 = 7,
	txt5 = 4,
	txt6 = 5,
	txt7 = 6,
	delay = 0
}

---@field public instance cfg_hourse
---@type table<string,cfg_hourse>
cfg_hourse =  {
instance = function(key)
    return cfg_hourse[key]
end,

    [1] = 
{
	id = 1,
	txt1 = 1,
	txt2 = 2,
	txt3 = 3,
	txt4 = 7,
	txt5 = 4,
	txt6 = 5,
	txt7 = 6,
	delay = 0
},

    [2] = 
{
	id = 2,
	txt1 = 1,
	txt2 = 2,
	txt3 = 3,
	txt4 = 8,
	txt5 = 4,
	txt6 = 5,
	txt7 = 6,
	delay = 0
},

    [3] = 
{
	id = 3,
	txt1 = 1,
	txt2 = 2,
	txt3 = 3,
	txt4 = 10,
	txt5 = 4,
	txt6 = 5,
	txt7 = 6,
	delay = 5
},

    [4] = 
{
	id = 4,
	txt1 = 1,
	txt2 = 2,
	txt3 = 3,
	txt4 = 9,
	txt5 = 4,
	txt6 = 5,
	txt7 = 6,
	delay = 0
},

    [5] = 
{
	id = 5,
	txt1 = 11,
	txt2 = 13,
	txt3 = 15,
	txt4 = 14,
	txt5 = 12,
	txt6 = 0,
	txt7 = 0,
	delay = 0
},

    [6] = 
{
	id = 6,
	txt1 = 24,
	txt2 = 0,
	txt3 = 0,
	txt4 = 0,
	txt5 = 0,
	txt6 = 0,
	txt7 = 0,
	delay = 0
},

    [7] = 
{
	id = 7,
	txt1 = 25,
	txt2 = 0,
	txt3 = 0,
	txt4 = 0,
	txt5 = 0,
	txt6 = 0,
	txt7 = 0,
	delay = 0
},


}

return cfg_hourse