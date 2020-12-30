
---@class cfg_fishform
___cfg_fishform = 
{
	id = 1
}

---@field public instance cfg_fishform
---@type table<string,cfg_fishform>
cfg_fishform =  {
instance = function(key)
    return cfg_fishform[key]
end,

    [1] = 
{
	id = 1
},

    [2] = 
{
	id = 2
},

    [3] = 
{
	id = 3
},

    [4] = 
{
	id = 4
},

    [5] = 
{
	id = 5
},

    [6] = 
{
	id = 6
},


}

return cfg_fishform