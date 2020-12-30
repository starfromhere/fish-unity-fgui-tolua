
---@class cfg_content
___cfg_content = 
{
	id = 1,
	mainContent = '是否要退出游戏',
	timeContent = 10,
	topContent = '退出游戏',
	state = 1
}

---@field public instance cfg_content
---@type table<string,cfg_content>
cfg_content =  {
instance = function(key)
    return cfg_content[key]
end,

    [1] = 
{
	id = 1,
	mainContent = '是否要退出游戏',
	timeContent = 10,
	topContent = '退出游戏',
	state = 1
},

    [2] = 
{
	id = 2,
	mainContent = '是否使用钻石释放该技能',
	timeContent = 10,
	topContent = '',
	state = 1
},


}

return cfg_content