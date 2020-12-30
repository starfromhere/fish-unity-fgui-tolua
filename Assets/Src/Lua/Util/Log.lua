local upper = string.upper
local format = string.format

local disable = false
local log, logf, lazylog, lazylogf = {__tag = ""}, {__tag = ""}, {__tag = ""}, {__tag = ""}

local _M = {}
_M.log, _M.logf, _M.lazylog, _M.lazylogf = log, logf, lazylog, lazylogf

-- custom ignore by youself  格式: true--表示不显示该类型打印信息
-- tag 需要分比较细的粒度, 可以方便自由控制显示,
-- 如: log.battle.view.preload('sssss') 不要只写 log.battle('xxxxx')
-- 按层次缩进写, 表示作用域控制范围, 大的层级可以控制自己下面的层级的整体显示与否
-- 注意不要重名, 且大小写不敏感 log.battle = log.BaTTle
local ignoreTags = {
--    需要关闭的打开注释
--    debug   = false,
--    info    = false,
--    warning = false,
--    error   = false,
--    fatal   = false,
}
local tmp = {}
for k, v in pairs(ignoreTags) do
    tmp[upper(k)] = true
end
ignoreTags = tmp

local nulltb = {}
setmetatable(nulltb, {
    __index = function(t, k)
        rawset(log, k, nulltb)
        return nulltb
    end,
    __call = function(...)
    end
})

local function logDisable()
    disable = true
    local mods = {log, logf, lazylog, lazylogf}
    for _, l in ipairs(mods) do
        for k, v in pairs(l) do
            l[k] = nil
        end
    end
    for _, l in ipairs(mods) do
        setmetatable(l, {__index = function(t, k)
            rawset(l, k, nulltb)
            return nulltb
        end})
    end
end
log.disable, logf.disable, lazylog.disable, lazylogf.disable = logDisable, logDisable, logDisable, logDisable

-- lazy dumps(v), help some cost-heavy string cast
local lazytb = {__lazydumps = true}
function _M.lazydumps(v, f)
    if disable then return "" end
    f = f or dumps
    return setmetatable(lazytb, {__tostring = function()
        return f(v)
    end})
end

local function logIndex(setmeta)
    return function(t, k)
        local tag = upper(k)
        local tagPath = tag
        if #t.__tag > 0 then
            tagPath = format("%s %s", t.__tag, tag)
        end
        local taglog = setmeta({__tag = tagPath})
        if ignoreTags[tag] ~= nil then
            taglog = nulltb
        end
        rawset(t, tag, taglog)
        return taglog
    end
end

local function setLogMeta(t)
    return setmetatable(t, {
        __index = logIndex(setLogMeta),
        __call = function(t, ...)
            print(format("<%s>", t.__tag), ...)
        end
    })
end

local extensionLog = {
    DEBUG   = "#FFFACD",
    INFO    = "#FFFAF0",
    WARNING = "#FFFF00",
    ERROR   = "#ff0000",
    FATAL   = "#ff0000",
}

local function setLogfMeta(t)
    return setmetatable(t, {
        __index = logIndex(setLogfMeta),
        __call = function(t, fmt, ...)
             --local vargs = {...}
             --for i, v in ipairs(vargs) do
             --	if type(v) == "table" and v.__lazydumps then
             --		vargs[i] = tostring(v)
             --	end
             --end
             --print(format("<%s> %s", t.__tag, format(fmt, unpack(vargs))))

            -- luajit支持format("%s", {}), lua不支持

            if extensionLog[t.__tag] then
                local vargs = {...}
                local strfmt = "%s "
                for i, v in ipairs(vargs) do
                    vargs[i] = tostring(v)
                    strfmt = strfmt .. "%s "
                end

                if t.__tag == "ERROR" or t.__tag == "FATAL" then
                    print(debug.traceback(format("<color=%s><%s> %s</color>",
                            extensionLog[t.__tag], t.__tag, format(strfmt, tostring(fmt), unpack(vargs))), 0))
                elseif t.__tag == "FATAL" then
                    error(format("<color=%s><%s> %s</color>",
                            extensionLog[t.__tag], t.__tag, format(strfmt, tostring(fmt), unpack(vargs))), 3)
                else
                    print(format("<color=%s><%s> %s</color>",
                            extensionLog[t.__tag], t.__tag, format(strfmt, tostring(fmt), unpack(vargs))))
                end
            else
                print(format("<%s> %s", t.__tag, format(fmt, ...)))
                --print(format("<%s> %s", t.__tag, format(fmt, unpack(vargs))))
            end
        end
    })
end

local function setLazyLogMeta(t)
    return setmetatable(t, {
        __index = logIndex(setLazyLogMeta),
        __call = function(t, ...)
            local vargs = {...}
            for i, v in ipairs(vargs) do
                if type(v) == "function" then
                    vargs[i] = v()
                end
            end
            print(format("<%s>", t.__tag), unpack(vargs))
        end
    })
end

local function setLazyLogfMeta(t)
    return setmetatable(t, {
        __index = logIndex(setLazyLogfMeta),
        __call = function(t, fmt, ...)
            local vargs = {...}
            for i, v in ipairs(vargs) do
                if type(v) == "function" then
                    vargs[i] = v()
                end
            end
            print(format("<%s> %s", t.__tag, format(fmt, unpack(vargs))))
        end
    })
end

setLogMeta(log)
setLogfMeta(logf)
setLazyLogMeta(lazylog)
setLazyLogfMeta(lazylogf)

---@class Log
Log = {}
Log.debug   = _M.logf.debug
Log.info    = _M.logf.info
Log.warning = _M.logf.warning
Log.error   = _M.logf.error
Log.fatal   = _M.logf.fatal