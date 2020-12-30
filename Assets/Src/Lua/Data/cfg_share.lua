
---@class cfg_share
___cfg_share = 
{
	id = 1,
	txt = '帮我点一下，我能玩一天',
	image = 'https://cdn-byh5.jjhgame.com/wxminiby/appshare.png'
}

---@field public instance cfg_share
---@type table<string,cfg_share>
cfg_share =  {
instance = function(key)
    return cfg_share[key]
end,

    [1] = 
{
	id = 1,
	txt = '帮我点一下，我能玩一天',
	image = 'https://cdn-byh5.jjhgame.com/wxminiby/appshare.png'
},

    [2] = 
{
	id = 2,
	txt = '我在等你，信收到了吗？',
	image = 'https://cdn-byh5.jjhgame.com/wxminiby/appshare.png'
},


}

return cfg_share