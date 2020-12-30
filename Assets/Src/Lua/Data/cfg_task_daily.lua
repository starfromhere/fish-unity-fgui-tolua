
---@class cfg_task_daily
___cfg_task_daily = 
{
	id = 1
}

---@field public instance cfg_task_daily
---@type table<string,cfg_task_daily>
cfg_task_daily =  {
instance = function(key)
    return cfg_task_daily[key]
end,

    [1] = 
{
	id = 1
},


}

return cfg_task_daily