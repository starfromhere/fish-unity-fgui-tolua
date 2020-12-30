
---@class cfg_loadtip
___cfg_loadtip = 
{
	id = 1,
	txtContent = '抽奖获得的鱼雷，发射可获得大量金币哦'
}

---@field public instance cfg_loadtip
---@type table<string,cfg_loadtip>
cfg_loadtip =  {
instance = function(key)
    return cfg_loadtip[key]
end,

    [1] = 
{
	id = 1,
	txtContent = '抽奖获得的鱼雷，发射可获得大量金币哦'
},

    [2] = 
{
	id = 2,
	txtContent = '可以在背包里把炸弹送给其他渔友'
},

    [3] = 
{
	id = 3,
	txtContent = '每个关卡都有独特的玩法，快去升级炮台，解锁关卡吧'
},

    [4] = 
{
	id = 4,
	txtContent = '每次攻击深海巨鲸，都有可能掉落道具哦'
},

    [5] = 
{
	id = 5,
	txtContent = '铁钳蟹王捕获后会留下一个黑洞，抓住路过的鱼'
},

    [6] = 
{
	id = 6,
	txtContent = '万年巨鳄会收集所有在渔场中的子弹，并每隔1小时分给幸运的玩家'
},


}

return cfg_loadtip