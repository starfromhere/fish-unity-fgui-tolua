---@class GameEventDispatch
local _M = {
    _dic = {}
}

---On 注册监听事件
---@public
---@param self GameEventDispatch
---@param eventType string or int       注册事件名称
---@param caller table                  调用域
---@param func function                 回掉方法
---@return void
function _M.On(self, eventType, caller, func)
    if eventType == nil or func == nil then
        --Log.error('在_M.On中eventType或func为空'.. tostring(eventType))
        return
    end

    --Log.info("注册事件：", eventType)
    if (_M._dic[eventType] == nil) then
        local a = {}
        table.insert(a, { func, caller })
        _M._dic[eventType] = a
    else
        table.insert(_M._dic[eventType], { func, caller })
    end
end
---on 兼容大小写
_M.on = _M.On

---Once 注册一次性监听事件
---@public
---@param self GameEventDispatch
---@param eventType string or int       注册事件名称
---@param caller table                  调用域
---@param func function                 回掉方法
---@return void
function _M.Once(self, eventType, caller, func)
    if eventType == nil or func == nil then
        --Log.error('在_M.On中eventType或func为空')
        return
    end

    Log.info("注册事件：", eventType)
    if (_M._dic[eventType] == nil) then
        local a = {}
        table.insert(a, { func, caller, true })                          -- 简单的添加一个标识，一次性事件
        _M._dic[eventType] = a
    else
        table.insert(_M._dic[eventType], { func, caller, true })
    end
end
---once 兼容大小写
_M.once = _M.Once

---Off 移除监听事件
---@public
---@param self GameEventDispatch
---@param eventType string or int       注册事件名称
---@param caller table                  调用域
---@param func function                 回掉方法
---@return void
function _M.Off(self, eventType, caller, func)
    if (eventType == nil or func == nil) then
        --Log.error('在_M.Off中eventType或func为空')
        return
    end
    local a = _M._dic[eventType]
    if (a ~= nil) then
        for k, v in pairs(a) do
            if (v[1] == func and v[2] == caller) then
                a[k] = nil
            end
        end
    end
end
---off 兼容大小写
_M.off = _M.Off

---Off 派发监听事件
---@public
---@param self GameEventDispatch
---@param eventType string or int       注册事件名称
---@param caller table                  调用域
---@param func function                 回掉方法
---@return void
function _M.Event(self, eventType, ...)
    --Log.debug("event: "..eventType.."    【Data】", ...)
    --Log.debug("参数个数 : ", select("#",...), type(...))

    if (eventType ~= nil) then
        local data = { ... };

        local a = _M._dic[eventType]
        if (a ~= nil) then
            local func;
            local caller;
            local isOnce;
            for k, v in pairs(a) do
                func = v[1];
                caller = v[2];
                isOnce = v[3];
                --Log.debug(k, type(v), ...)
                if caller == nil then
                    --Log.debug("[1]响应事件：", eventType)
                    func(unpack(data))
                else
                    --Log.debug("[2]响应事件", eventType, func, caller)
                    func(caller, unpack(data))
                end

                -- 一次响应事件，响应完成关闭！
                if isOnce then
                    a[k] = nil;
                end
            end
        end
    else
        Log.error("没有注册事件：", eventType);
    end
end
---event 兼容大小写
_M.event = _M.Event

GameEventDispatch = {}
GameEventDispatch.instance = _M