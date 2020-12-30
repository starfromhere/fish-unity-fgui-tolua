
---@class cfg_loadtip_weixin
___cfg_loadtip_weixin = 
{
	id = 1,
	txtContent = '鱼雷发射后可获得大量金币'
}

---@field public instance cfg_loadtip_weixin
---@type table<string,cfg_loadtip_weixin>
cfg_loadtip_weixin =  {
instance = function(key)
    return cfg_loadtip_weixin[key]
end,

    [1] = 
{
	id = 1,
	txtContent = '鱼雷发射后可获得大量金币'
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

    [7] = 
{
	id = 7,
	txtContent = '点击主界面复制按钮可以将自己的ID复制并发送给好友'
},

    [8] = 
{
	id = 8,
	txtContent = '在鱼场内使用后冰冻，可以使渔场内已有的鱼静止一段时间。'
},

    [9] = 
{
	id = 9,
	txtContent = '在鱼场内使用锁定道具可以选择的一条鱼进行锁定，弹无虚发。'
},

    [10] = 
{
	id = 10,
	txtContent = '在鱼场内使用狂暴道具，发射子弹速度更快，更刺激'
},

    [11] = 
{
	id = 11,
	txtContent = '在鱼场内每使用一个自动道具，可自动发炮两分钟。'
},

    [12] = 
{
	id = 12,
	txtContent = '获得喇叭，可在兑换界面换取话费或游戏内道具。'
},


}

return cfg_loadtip_weixin