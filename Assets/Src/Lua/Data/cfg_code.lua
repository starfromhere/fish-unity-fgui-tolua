
---@class cfg_code
___cfg_code = 
{
	id = 800,
	txtContent = '绑定账号不存在，请确认账号是否正确'
}

---@field public instance cfg_code
---@type table<string,cfg_code>
cfg_code =  {
instance = function(key)
    return cfg_code[key]
end,

    [800] = 
{
	id = 800,
	txtContent = '绑定账号不存在，请确认账号是否正确'
},

    [801] = 
{
	id = 801,
	txtContent = '绑定账号银行密码错误，请重试'
},

    [802] = 
{
	id = 802,
	txtContent = '绑定账号银行内金豆不足'
},

    [803] = 
{
	id = 803,
	txtContent = '绑定账号已被封停，如有问题请联系客服'
},

    [804] = 
{
	id = 804,
	txtContent = '绑定账号在其他地方登陆，请退出登陆后重试'
},

    [810] = 
{
	id = 810,
	txtContent = '银行当日存取超出限制，请明日再来'
},

    [998] = 
{
	id = 998,
	txtContent = '操作失败'
},

    [999] = 
{
	id = 999,
	txtContent = '操作失败'
},


}

return cfg_code