---@class GameTools
---@field public instance GameTools
GameTools = class("GameTools")

local LogTools = require 'Util.Serpent'

--敏感词过滤，待做,
---@param name string
---@return string
function GameTools.filterName(name)
    return name
    --local tmp = name
    --for i = 1, #self._nameFilter do
    --    local nameFilterElement = self._nameFilter[i]
    --    tmp = string.gsub(tmp, nameFilterElement, "*")
    --end
    --return tmp
end

---将laya的url转换为fairygui的url
---eg  ui/fish/lock.png ==> ui://Fish/lock.png
function GameTools.transLayaUrl(url)
    return "ui://" .. string.gsub(url, ".png", ""):gsub("ui/", ""):gsub("^%l", string.upper)
end

function GameTools:isTelePhone(str)
    local p = "%d+"
    if #str ~= 11 or string.match(tostring(str), p) ~= tostring(str) then
        return false
    end
    return true
end

--返回 是否都为汉字,汉字个数
function GameTools:isChineseWord(str)
    local len = 0
    if #str > 0 and #str / 3 % 1 == 0 then
        --判断是否全部为中文
        for i = 1, #str, 3 do
            len = len + 1;
            local tmp = string.byte(str, i)
            print(" ----   ----", tmp)--230
            if tmp >= 240 or tmp < 224 then
                return false, len;
            end
        end
        --判断中文中是否有中文标点符号
        for i = 1, #str, 3 do
            local tmp1 = string.byte(str, i)
            local tmp2 = string.byte(str, i + 1)
            local tmp3 = string.byte(str, i + 2)
            print("mp1,mp2,mp3", tmp1, tmp2, tmp3)
            --228 184 128 -- 233 191 191
            if tmp1 < 228 or tmp1 > 233 then
                return false, len;
            elseif tmp1 == 228 then
                if tmp2 < 184 then
                    return false, len;
                elseif tmp2 == 184 then
                    if tmp3 < 128 then
                        return false, len;
                    end
                end
            elseif tmp1 == 233 then
                if tmp2 > 191 then
                    return false, len;
                elseif tmp2 == 191 then
                    if tmp3 > 191 then
                        return false, len;
                    end
                end
            end
        end
        return true, len;
    end
    return false, len;
end

---错误码处理
function GameTools.dealCode(code)
    local codeCfg = cfg_code.instance(code)
    if codeCfg then
        GameTip.showTip(codeCfg.txtContent)
    else
        if type(code) == "table" then
            code = LogTools.block(code)
        end
        Log.error("code:", code, "不明错误")
    end
end

function GameTools.booleanToNumber(boo)
    if boo then
        return 1
    else
        return 0
    end
end

function GameTools.createWrapper(prefabUrl, scale)
    local item = GameTools.ResourcesLoad(prefabUrl)

    ---@type Vector3
    local originScale = item.transform.localScale
    originScale:Mul(scale or 1)

    local animator = nil
    if item.transform.childCount > 0 then
        animator = item.transform:GetChild(0).gameObject:GetComponent("Animator")
    end
    local wrapper = GoWrapper.New(item)
    return wrapper, animator
end

---@param target GObject
function GameTools.buttonEffect(target, timesX, timesY)
    target:TweenScale(Vector2.New(timesX, timesY), 100)
          :OnComplete(function()
        GameTip.showTip("123456")
        target:TweenScale(Vector2.New(1, 1), 100)
    end)
end

---@param time number
function GameTools.timeUtils(time)
    local minute = math.floor(time / 60)
    local second = math.floor(time % 60)
    if (minute < 10) then
        minute = "0" .. tostring(minute)
    end

    if (second < 10) then
        second = "0" .. tostring(second)
    end
    local m = tostring(minute) .. ":" .. tostring(second)
    return m
end

---@param tableObj table
---@param startIndex number 包含开始index
---@param endIndex number 如果为空，则默认为table长度
---@return table 返回截取[startIndex,endIndex] table
function GameTools.tableSlice(tableObj, startIndex, endIndex)
    local data = {}
    if not endIndex then
        endIndex = #tableObj
    end
    for i, v in pairs(tableObj) do
        if i >= startIndex and i <= endIndex then
            table.insert(data, v)
        end
    end
    return data
end

function GameTools.getFloat(re)
    local temp = tonumber(re)
    --local num = tonumber(temp / FightContext.instance:exchangeRate())
    local num = tonumber(temp / 1000)
    return GameTools.GetPreciseDecimal(num, 2)
end

function GameTools.GetPreciseDecimal(nNum, n)
    if type(nNum) ~= "number" then
        return nNum;
    end
    n = n or 0;
    n = math.floor(n)
    if n < 0 then
        n = 0;
    end
    local nDecimal = 10 ^ n
    local nTemp = math.floor(nNum * nDecimal);
    local nRet = nTemp / nDecimal;
    return nRet;
end

--- TODO 临时接口， 所有UnityEngine.Resources.Load 都从这边走
function GameTools.ResourcesLoad(resUrl)
    return Resource:loadAssert(resUrl, ResourceType.prefab)
end

function GameTools.fullScreenShake(strength, time)
    local strength = strength or 10
    local time = time or 0.4
    UIFishPage.instance.douDongAni:SetValue("shake", strength, time)
    UIFishPage.instance.douDongAni:Play()
end

function GameTools.fullScreenAllUIShake(strength, time)
    local strength = strength or 10
    local time = time or 0.4
    UIFishPage.instance.douDongAllAni:SetValue("shake", strength, time)
    UIFishPage.instance.douDongAllAni:Play()
end
function GameTools.loadHeadImage(gLoader, resUrl)
    if type(resUrl) == "string" and string.len(resUrl) > 0 then
        if string.match(resUrl, 'http') then
            setNetworkImage(gLoader, resUrl)
        else
            gLoader.url = resUrl
        end
    else
        local url = "ui://CommonComponent/nan"
        gLoader.url = url
    end
end
function GameTools.playRandomMusic(prifix, suffix, min, max)
    local index = FightTools:getRandomNumber(min, max)
    local resUrl = prifix .. index
    SoundManager.PlayEffect("Music/" .. resUrl .. suffix)
end

---@param seatId number
function GameTools.getSeatFont(seatId)
    local pathUrl = "ui://Fonts/seatFont1"
    if SeatRouter.SEAT_INX_1 == seatId then
        pathUrl = "ui://Fonts/seatFont1"
    elseif SeatRouter.SEAT_INX_2 == seatId then
        pathUrl = "ui://Fonts/seatFont2"
    elseif SeatRouter.SEAT_INX_3 == seatId then
        pathUrl = "ui://Fonts/seatFont3"
    else
        pathUrl = "ui://Fonts/seatFont4"
    end
    return pathUrl
end

---@param txt GTextFiled
---@param num number
---@param seatId number
function GameTools.setTxtBySeatId(txt, num, seatId)
    local fontUrl = GameTools.getSeatFont(seatId)
    -- 新建一个TextFormat对象字体才会更新
    if fontUrl ~= txt.textFormat.font then
        -- TODO 使用对象池复用
        local textFormat = TextFormat.New()
        textFormat:CopyFrom(txt.textFormat)
        textFormat.font = fontUrl
        txt.textFormat = textFormat
        -- txt.textFormat.font = fontUrl
        -- txt:InvalidateBatchingState()
    end
    txt.text = num
end

function GameTools.bind(f, ...)
    local args = { ... }
    return function(...)
        local local_arg = { ... }
        local arg = {}
        for _, v in pairs(args) do
            table.insert(arg, v)
        end
        for _, v in pairs(local_arg) do
            table.insert(arg, v)
        end
        return f(unpack(arg))
    end
end

