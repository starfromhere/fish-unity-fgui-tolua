--functions

--系统random

function loopChangeColor(a,b,c,offset)
    local movePos = 2
    return function()
        local op
        if movePos == 1 then
            if a == b then
                movePos = 2
            else
                op = a>b and -offset or offset
                a = a + op
                if op > 0 then
                    a = a<b and a or b
                else
                    a = a>b and a or b
                end
            end
        end

        if movePos == 2 then
            if b == c then
                movePos = 3
            else
                op = b>c and -offset or offset
                b = b + op
                if op > 0 then
                    b = b<c and b or c
                else
                    b = b>c and b or c
                end
            end
        end

        if movePos == 3 then
            if c == a then
                movePos = 1
            else
                op = c>a and -offset or offset
                c = c + op
                if op > 0 then
                    c = c<a and c or a
                else
                    c = c>a and c or a
                end
            end
        end
        return a,b,c
    end
end

local function getTraceback()
    local traceback = string.split(debug.traceback("", 3), "\n")
    local str = ""
    for k,v in pairs(traceback) do
        str = str .. v .. "\n"
    end
    return str
end

local function packArg( ... )
    local str = ""
    for _,v in pairs({...}) do
        v = v or "nil"
        str = str .. " " .. tostring(v)
    end
    return str
end
 --带traceback信息的print
function trace(...)
    -- body
    local str = packArg(...) .. "\n" .. getTraceback()
    print(str)
end

local function dump_value_(v)
    if type(v) == "string" then
        v = "\"" .. v .. "\""
    end
    return tostring(v)
end


function var_dump(describe,...)
    local tv = ""..describe..":\n"
    local xn = 0
    local function _foreach(v, func)
        for k1, v1 in pairs(v) do
            func(k1, v1)
        end
    end

    local function tvlinet(xn)
        -- body
        for i = 1, xn do
            tv = tv .. "\t"
        end
    end

    local function printTab(i, v)
        if type(v) == "table" then
            tvlinet(xn)
            xn = xn + 1
            tv = tv .. "" .. i .. ":Table{\n"
            _foreach(v, printTab)
            -- table.foreach(v, printTab)
            tvlinet(xn)
            tv = tv .. "}\n"
            xn = xn - 1
        elseif type(v) == nil then
            tvlinet(xn)
            tv = tv .. i .. ":nil\n"
        else
            tvlinet(xn)
            tv = tv .. i .. ":" .. tostring(v) .. "\n"
        end
    end
    local function dumpParam(tab)
        for i = 1, #tab do
            if tab[i] == nil then
                tv = tv .. "nil\t"
            elseif type(tab[i]) == "table" then
                xn = xn + 1
                tv = tv .. "\ntable{\n"
                _foreach(tab[i], printTab)
                -- table.foreach(tab[i], printTab)
                tv = tv .. "\t}\n"
            else
                tv = tv .. tostring(tab[i]) .. "\t"
            end
        end
    end
    local x = ...
    if type(x) == "table" then
        _foreach(x, printTab)
        -- table.foreach(x, printTab)
    else
        dumpParam( { ...})
        -- table.foreach({...},printTab)
    end
    LOG_DEBUG(tv)
end

function luadump(value, desciption, nesting)
    if type(nesting) ~= "number" then nesting = 3 end

    local lookupTable = {}
    local result = {}

    local traceback = string.split(debug.traceback("", 2), "\n")

    local function dump_(value, desciption, indent, nest, keylen)
        desciption = desciption or "<var>"
        local spc = ""
        if type(keylen) == "number" then
            spc = string.rep(" ", keylen - string.len(dump_value_(desciption)))
        end
        if type(value) ~= "table" then
            result[#result +1 ] = string.format("%s%s%s = %s", indent, dump_value_(desciption), spc, dump_value_(value))
        elseif lookupTable[tostring(value)] then
            result[#result +1 ] = string.format("%s%s%s = *REF*", indent, dump_value_(desciption), spc)
        else
            lookupTable[tostring(value)] = true
            if nest > nesting then
                result[#result +1 ] = string.format("%s%s = *MAX NESTING*", indent, dump_value_(desciption))
            else
                result[#result +1 ] = string.format("%s%s = {", indent, dump_value_(desciption))
                local indent2 = indent.."    "
                local keys = {}
                local keylen = 0
                local values = {}
                for k, v in pairs(value) do
                    keys[#keys + 1] = k
                    local vk = dump_value_(k)
                    local vkl = string.len(vk)
                    if vkl > keylen then keylen = vkl end
                    values[k] = v
                end
                table.sort(keys, function(a, b)
                    if type(a) == "number" and type(b) == "number" then
                        return a < b
                    else
                        return tostring(a) < tostring(b)
                    end
                end)
                for i, k in ipairs(keys) do
                    dump_(values[k], k, indent2, nest + 1, keylen)
                end
                result[#result +1] = string.format("%s}", indent)
            end
        end
    end
    dump_(value, desciption, "- ", 1)
    for i, line in ipairs(result) do    
        print(line)    
    end   
end

function printf(fmt, ...)
    print(string.format(tostring(fmt), ...))
end

-- function checknumber(value, base)
--     return tonumber(value, base) or 0
-- end

-- function checkint(value)
--     return math.round(checknumber(value))
-- end

-- function checkbool(value)
--     return (value ~= nil and value ~= false)
-- end

-- function checktable(value)
--     if type(value) ~= "table" then value = {} end
--     return value
-- end

-- function isset(hashtable, key)
--     local t = type(hashtable)
--     return (t == "table" or t == "userdata") and hashtable[key] ~= nil
-- end


-- function math.round(value)
--     value = checknumber(value)
--     return math.floor(value + 0.5)
-- end


-- function table.len(t)
--     local count = 0
--     for k, v in pairs(t) do
--         count = count + 1
--     end
--     return count
-- end

-- function table.keys(hashtable)
--     local keys = {}
--     for k, v in pairs(hashtable) do
--         keys[#keys + 1] = k
--     end
--     return keys
-- end

-- function table.values(hashtable)
--     local values = {}
--     for k, v in pairs(hashtable) do
--         values[#values + 1] = v
--     end
--     return values
-- end

-- function table.merge(dest, src)
--     for k, v in pairs(src) do
--         dest[k] = v
--     end
-- end

-- function table.mergeByAppend(dest, src)
--     for k, v in pairs(src) do
--         table.insert(dest, v)
--     end
-- end

-- function table.indexof(array, value, begin)
--     for i = begin or 1, #array do
--         if array[i] == value then return i end
--     end
--     return false
-- end

-- function table.keyof(hashtable, value)
--     for k, v in pairs(hashtable) do
--         if v == value then return k end
--     end
--     return nil
-- end

-- function table.removebyvalue(array, value, removeall)
--     local c, i, max = 0, 1, #array
--     while i <= max do
--         if array[i] == value then
--             table.remove(array, i)
--             c = c + 1
--             i = i - 1
--             max = max - 1
--             if not removeall then break end
--         end
--         i = i + 1
--     end
--     return c
-- end
-- --数组浅层拷贝,从index开始，拷贝len个长度，返回一个新的table，如果长度不够，则填充nil
-- function table.arraycopy(array, index, len)
--     local newtable = {}
--     len = len or 0
--     index = index or 1
--     if len == 0 then
--         len = #array - index + 1
--     end
--     for i = index,index + len - 1 do
--         newtable[i-index+1] = array[i]
--     end
--     return newtable;
-- end

-- function table.deepcopy(st)  
--     local tab = {}
--     for k, v in pairs(st or {}) do  
--         if type(v) ~= "table" then  
--             tab[k] = v  
--         else  
--             tab[k] = table.deepcopy(v)  
--         end  
--     end  
--     return tab
-- end

-- --将tarray的元素添加到array的末尾
-- function table.join(array, tarray)
--     -- body
--     for _,v in pairs(tarray) do
--         table.insert(array, v)
--     end
-- end

-- --将t清空
-- function table.clear(t)
--     if type(t) == "table" then
--         for k,v in pairs(t) do
--             t[k] = nil
--         end
--     end
-- end

-- function table.random(array)
--     local tmp,index
--     for i=1,#array-1 do
--         index = math.random(i, #array)
--         if i ~= index then
--             tmp = array[i]
--             array[i] = array[index]
--             array[index] = tmp
--         end
--     end
-- end

function string.starts(str, pattern)
    return string.sub(str,1,string.len(pattern))==pattern
end

function string.ends(str,pattern)
    return pattern=='' or string.sub(str,-string.len(pattern))==pattern
end

function string.split(input, delimiter)
    input = tostring(input)
    delimiter = tostring(delimiter)
    if (delimiter=='') then return false end
    local pos,arr = 0, {}
    -- for each divider found
    for st,sp in function() return string.find(input, delimiter, pos, true) end do
        table.insert(arr, string.sub(input, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
end

function string.ltrim(input)
    return string.gsub(input, "^[ \t\n\r]+", "")
end

function string.rtrim(input)
    return string.gsub(input, "[ \t\n\r]+$", "")
end

function string.trim(input)
    input = string.gsub(input, "^[ \t\n\r]+", "")
    return string.gsub(input, "[ \t\n\r]+$", "")
end

local function urlencodechar(char)
    return "%" .. string.format("%02X", string.byte(char))
end
function string.urlencode(input)
    -- convert line endings
    input = string.gsub(tostring(input), "\n", "\r\n")
    -- escape all characters but alphanumeric, '.' and '-'
    input = string.gsub(input, "([^%w%.%- ])", urlencodechar)
    -- convert spaces to "+" symbols
    return string.gsub(input, " ", "+")
end

function string.urldecode(input)
    input = string.gsub (input, "+", " ")
    input = string.gsub (input, "%%(%x%x)", function(h) return string.char(checknumber(h,16)) end)
    input = string.gsub (input, "\r\n", "\n")
    return input
end

function string.utf8len(input)
    local len  = string.len(input)
    local left = len
    local cnt  = 0
    local arr  = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}
    while left ~= 0 do
        local tmp = string.byte(input, -left)
        local i   = #arr
        while arr[i] do
            if tmp >= arr[i] then
                left = left - i
                break
            end
            i = i - 1
        end
        cnt = cnt + 1
    end
    return cnt
end

--luadump的另一种做法，不限制层级，打印结果更直观
function PRINT_T(t, t_name)  
    local d = string.split(string.trim(string.split(debug.traceback("", 2), "\n")[3]), ":")
    local dd = string.split(d[1], "/")

    local cut_line = string.rep("-", 30)
    t_name = t_name or ""
    cut_line = cut_line .. " PRINT_T " .. dd[#dd] .. ":".. d[2].. " "..t_name..string.rep("-", 30) 
    local line = cut_line.."\n{\n"
    
    local function is_str(s)
        if type(s) == "string" then
            return "\"" .. s .. "\""
        end
        return s
    end
    local function define_print(_tab,str)  
        str = str .. "    "  
        for k,v in pairs(_tab) do  
            if type(v) == "table" then 
                line = line .. str.. is_str(k) .." = {".."\n"
                define_print(v,str)  
                line = line .. str.."}" .."\n"
            else  
                line = line .. str .. tostring(is_str(k)) .. " = " .. tostring(is_str(v)) .. "\n"
            end  
        end  
    end  
    if type(t) == "table" then  
        define_print(t," ")  
    else  
        line = line ..  "  "..tostring(t).."\n"
    end  
    line = line .. "}\n"..string.rep("-", string.len(cut_line)).. "\n"
    print(line)
end

function getNodeByWeight(list)
    -- list = {{weight=xx,...},{weight=xx,...}}
    local total = 0
    for k,node in pairs(list) do
        total = total + node.weight
    end
    local i = math.random(total)
    for k,node in pairs(list) do
        total = total - node.weight
        if i > total then
            return node
        end
    end
end