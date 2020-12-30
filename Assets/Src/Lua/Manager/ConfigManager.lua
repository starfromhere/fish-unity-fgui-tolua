ConfigManager = class("ConfigManager")

local LogTools = require 'Util.Serpent'
--打印table使用
function ConfigManager.dump_table(t)
    if type(t) == "table" then
        Log.debug(LogTools.block(t))
    end
    --local print_r_cache = {}
    --local function sub_print_r(t, indent)
    --    if (print_r_cache[tostring(t)]) then
    --        print(indent .. "*" .. tostring(t))
    --    else
    --        print_r_cache[tostring(t)] = true
    --        if (type(t) == "table") then
    --            for pos, val in pairs(t) do
    --                if (type(val) == "table") then
    --                    print(indent .. "[" .. pos .. "] => " .. tostring(t) .. " {")
    --                    sub_print_r(val, indent .. string.rep(" ", string.len(pos) + 8))
    --                    print(indent .. string.rep(" ", string.len(pos) + 6) .. "}")
    --                elseif (type(val) == "string") then
    --                    print(indent .. "[" .. pos .. '] => "' .. val .. '"')
    --                else
    --                    print(indent .. "[" .. pos .. "] => " .. tostring(val))
    --                end
    --            end
    --        else
    --            print(indent .. tostring(t))
    --        end
    --    end
    --end
    --
    --if (type(t) == "table") then
    --    print(tostring(t) .. " {")
    --    sub_print_r(t, "  ")
    --    print("}")
    --else
    --    sub_print_r(t, "  ")
    --end
    --print()
end

function ConfigManager.getConfObject(sheetName, id)
    return _table_map[sheetName][id]
end

function ConfigManager.getConfValue(sheetName, id, name)
    return _table_map[sheetName][id][name]
end

function ConfigManager.items(cfg_name)
    return _table_map[cfg_name]
end

-- 表转为数组/并排序
function ConfigManager.getLawItem(cfg_name)
    local ret = {}
    for i, v in pairs(_table_map[cfg_name]) do
        if tonumber(i) ~= nil then
            table.insert(ret, v)
        end
    end
    table.sort(ret, function(a, b)
        return a.id < b.id
    end)
    return ret
end

function ConfigManager.filter(cfg_name, func, func_sort)
    local sheet = _table_map[cfg_name]
    if func == nil then
        return
    end
    local result = {}
    for k, v in pairs(sheet) do
        if type(v) ~= "function" then
            if func(v) then
                table.insert(result, v)
            end
        end
    end
    if func_sort == nil then
        return result
    end
    if func_sort then
        table.sort(result, func_sort)
    end
    return result
end

