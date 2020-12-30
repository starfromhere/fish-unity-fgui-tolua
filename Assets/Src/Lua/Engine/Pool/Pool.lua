---@class Pool
Pool = class("Pool")

Pool._cache_pool = {}
Pool.POOLSIGN = "__InPool"
Pool._max_count_dic = {}

---
---根据传入的对象类型标识字符，获取对象池中此类型标识的一个对象实例
---@param sign 对象类型标识字符。
---@param clazz 用于创建该类型对象的类。
---@return 此类型标识的一个对象。
function Pool.getItemByClass(sign, clazz)
    local pool = Pool.getPoolBySign(sign)
    local rst = nil
    if #pool >= 1 then
        rst = table.remove(pool, #pool)
        rst[Pool.POOLSIGN] = false
    else
        rst = clazz.new()
    end
    return rst
end

---
---根据类名创建类的实例
---@param clazz 用于创建该类型对象的类。
---@return 此类型标识的一个对象。
function Pool.createByClass(clazz)
    local ret = nil
    local sign = Pool._getClassSign(clazz)
    if sign then
        ret = Pool.getItemByClass(sign, clazz)
    end
    return ret
end

---
---据传入的对象类型标识字符，获取对象池中此类型标识的一个对象实例
---当对象池中无此类型标识的对象时，则使用传入的创建此类型对象的函数，新建一个对象返回。
---@param sign 对象类型标识字符
---@param createFun 创建对象的函数
---@param caller 创建对象函数的上下文
---@return 此类型标识的一个对象。
function Pool.getItemByCreateFun(sign, createFun, caller)
    local ret = nil
    local pool = Pool.getPoolBySign(sign)
    if #pool >= 1 then
        ret = table.remove(pool, #pool)
    else
        ret = createFun(caller)
    end
    ret[Pool.POOLSIGN] = false
    return ret
end

---
---返回类的唯一标识
---@param clazz 用于创建该类型对象的类。
---@return 对象类型标识字符
function Pool._getClassSign(clazz)
    local className = clazz.__cname
    return className
end

function Pool.getMaxCount(sign)
    -- 默认不限制,返回-1
    local maxCount = Pool._max_count_dic[sign] or -1
    return maxCount
end

function Pool.setMaxCount(sign, maxCount)
    Pool._max_count_dic[sign] = maxCount
end

function Pool.addToPool(sign, item)
    local maxCount = Pool.getMaxCount(sign)
    local list = Pool.getPoolBySign(sign)
    -- 小于0代表不限制
    if maxCount < 0 or #list < maxCount then
        item[Pool.POOLSIGN] = true
        table.insert(list, item)
    else
        -- TODO 超过限制时暂时不处理
    end
end

---将对象放到对应类型标识的对象池中。
---@param sign 对象类型标识字符。
---@param item 对象。
function Pool.recover(sign, item)
    if item[Pool.POOLSIGN] == true then
        return
    end
    Pool.addToPool(sign, item)
end

---根据类名进行回收，如果类有类名才进行回收，没有则不回收
---@param item 对象。
function Pool.recoverByClass(item)
    local sign = item.__cname
    if sign then
        Pool.recover(sign, item)
    end
end

---根据对象类型标识字符，获取对象池。
---@param sign 对象类型标识字符
---@return table 对象池
function Pool.getPoolBySign(sign)
    if not Pool._cache_pool[sign] then
        Pool._cache_pool[sign] = {}
    end
    return Pool._cache_pool[sign]
end

---清除对象池的对象。
---@param sign 对象类型标识字符
function Pool.clearBySign(sign)
    if Pool._cache_pool[sign] and #Pool._cache_pool[sign] > 0 then
        Pool._cache_pool[sign] = nil
        Pool._cache_pool[sign] = {}
    end    
end

---清除对象池的对象。
---@param item 对象。
function Pool.clearByClass(item)
    local sign = item.__cname
    if sign then
        Pool.clearBySign(sign)
    end
end

