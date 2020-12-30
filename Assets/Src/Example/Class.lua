local format = string.format
local tostring = tostring
local getmetatable = getmetatable
local setmetatable = setmetatable
local type = type
local pairs = pairs
local unpack = table.unpack
local assert = assert

local setmetatableindex_
setmetatableindex_ = function(t, index)
    local mt = getmetatable(t)
    if not mt then
        -- if mt is nil, and index is table
        if type(index) == "table" and index.__index then
            setmetatable(t, index)
            return
        end
        mt = {}
    end
end
setmetatableindex = setmetatableindex_

local function class_tostring(t)
    if t.__cname then
        return format("%s", t.__cname)
    end
    return tostring(t)
end

local function tostring_func(t)
    return format("%s: %s", class_tostring(t), tostring(t.__cid))
end

--function class(className, ...)
--    local cls = {
--        __cname = className,
--        __tostring = tostring_func,
--    }
--    local super = table.unpack({ ... }, 1, 1)
--    if super ~= nil then
--        local superType = type(super)
--        assert(superType == "table", "父类不为table类型")
--        cls.__super = cls.__super or super
--    end
--
--    cls.__index = cls
--    setmetatable(cls, { __index = cls.__super })
--
--    if not cls.ctor then
--        cls.ctor = function()
--        end
--    end
--
--    cls.new = function(...)
--        local instance = {}
--        local typ = type(instance)
--        local addr = tostring(instance)
--        instance.__cid = tonumber(string.sub(addr, #typ + 2), 16)
--        instance.__class = cls
--        setmetatableindex(instance, cls)
--
--        local create
--        create = function(c, ...)
--            if rawget(c, "__super") then
--                create(c.__super, ...)
--            end
--            if rawget(c, "ctor") then
--                c.ctor(instance, ...)
--            end
--        end
--        create(cls, ...)
--        return instance
--    end
--
--    cls.instance = setmetatable({}, {
--        __index = function(_, k)
--            if not cls.__instance then
--                cls.__instance = cls.new()
--            end
--            return cls.__instance[k]
--        end,
--
--        __newindex = function(_, k, v)
--            if not cls.__instance then
--                cls.__instance = cls.new()
--            end
--            cls.__instance[k] = v
--        end,
--
--        __call = function(...)
--            if not cls.__instance then
--                cls.__instance = cls.new()
--            end
--            return cls.__instance
--        end
--    })
--
--    cls.new = cls.new
--    cls.super = cls.__super
--    return cls
--end

function class(classname, super)
    local superType = type(super)
    local cls

    if superType ~= "function" and superType ~= "table" then
        superType = nil
        super = nil
    end

    if superType == "function" or (super and super.__ctype == 1) then
        -- inherited from native C++ Object
        cls = {}

        if superType == "table" then
            -- copy fields from super
            for k,v in pairs(super) do cls[k] = v end
            cls.__create = super.__create
            cls.super    = super
        else
            cls.__create = super
            cls.ctor = function() end
        end

        cls.__cname = classname
        cls.__ctype = 1

        function cls.new(...)
            local instance = cls.__create(...)
            -- copy fields from class to native object
            for k,v in pairs(cls) do instance[k] = v end
            instance.class = cls
            instance:ctor(...)
            return instance
        end

    else
        -- inherited from Lua Object
        if super then
            cls = {}
            setmetatable(cls, {__index = super})
            cls.super = super
        else
            cls = {ctor = function() end}
        end

        cls.__cname = classname
        cls.__ctype = 2 -- lua
        cls.__index = cls

        function cls.new(...)
            local instance = setmetatable({}, cls)
            instance.class = cls
            instance:ctor(...)
            return instance
        end



    end

    cls.instance = setmetatable({}, {
        __index = function(_, k)
            cls.__instance = cls.__instance and cls.__instance or cls.new()
            return cls.__instance[k]
        end,

        __newindex = function(_, k, v)
            cls.__instance = cls.__instance and cls.__instance or cls.new()
            cls.__instance[k] = v
        end,

        __call = function(_,...)
            cls.__instance = cls.__instance and cls.__instance or cls.new(...)
            return cls.__instance
        end
    })
    cls.New = cls.new
    return cls
end