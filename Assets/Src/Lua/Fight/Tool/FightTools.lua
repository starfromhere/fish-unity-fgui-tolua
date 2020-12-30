FightTools = class("FightTools")

FightTools.TEMP_NUM1 = 0
FightTools.TEMP_NUM2 = 0
FightTools._acosAngleDic = {}
FightTools._sinAngleDic = {}
FightTools._cosAngleDic = {}

FightTools.TEMP_POINT1 = Vector2.New(0, 0)
FightTools.TEMP_POINT2 = Vector2.New(0, 0)
FightTools.TEMP_POINT3 = Vector2.New(0, 0)

FightTools.Vec3_1 = Vector3.New(0, 0, 0)
FightTools.Vec3_2 = Vector3.New(0, 0, 0)

---@param p1 Vector2
---@param p2 Vector2
function FightTools:distance1(p1, p2)
    FightTools.TEMP_NUM1 = (p1.x - p2.x)
    FightTools.TEMP_NUM2 = (p1.y - p2.y)
    return Mathf.Sqrt(FightTools.TEMP_NUM1 * FightTools.TEMP_NUM1 + FightTools.TEMP_NUM2 * FightTools.TEMP_NUM2)
end

function FightTools:distance2(x1, x2, y1, y2)
    FightTools.TEMP_NUM1 = (x1 - x2)
    FightTools.TEMP_NUM2 = (y1 - y2)
    return Mathf.Sqrt(FightTools.TEMP_NUM1 * FightTools.TEMP_NUM1 + FightTools.TEMP_NUM2 * FightTools.TEMP_NUM2)
end

--function FightTools.nowSecond()
--    return TimeTools.getCurSec()
--end
--
--function FightTools.CalRotatePos4(center, p1, p3, angle, radius)
--    p1.x = FightTools:CalCosBySheet(angle) * radius
--    p1.y = FightTools:CalSinBySheet(angle) * radius
--    p3.x = -p1.x
--    p3.y = -p1.y
--    p1.x = nil --[TODO]+= center.x
--    p1.y = nil --[TODO]+= center.y
--    p3.x = nil --[TODO]+= center.x
--    p3.y = nil --[TODO]+= center.y
--
--end
----[TODO]static
--function FightTools:CalRotatePos(angle, radius)
--    local out = FightTools._calRotatePosOut
--    out.x = FightTools:CalCosBySheet(angle) * radius
--    out.y = FightTools:CalSinBySheet(angle) * radius
--    return out
--
--end
----[TODO]static
function FightTools.CalSinBySheet(angle)
    if angle < 0 then
        angle = angle + 360
    elseif angle >= 360 then
        angle = angle - 360
    end

    angle = math.ceil(angle * 100)
    return FightTools._sinAngleDic[angle]
end
----[TODO]static
function FightTools.CalCosBySheet(angle)
    if angle < 0 then
        angle = angle + 360
    elseif angle >= 360 then
        angle = angle - 360
    end
    angle = math.ceil(angle * 100)
    return FightTools._cosAngleDic[angle]
end
----[TODO]static
--function FightTools:designPosYMapScreenPosY(y)
--    return FightTools._screenPosDivideDesignPosHeight * y
--
--end
----[TODO]static
--function FightTools:designPosXMapScreenPosX(x)
--    return FightTools._screenPosDivideDesignPosWidth * x
--
--end

function FightTools:CalLineAngle(startPos, endPos)
    local deltaX = endPos.x - startPos.x;
    local deltaY = endPos.y - startPos.y;
    if ((deltaY == 0) and (deltaX < 0)) then
        return 180;
    end

    local length = self:CalSqrtBySheet(deltaX, deltaY)
    if (length <= 0) then
        return 0;
    end
    local cos = deltaX / length;
    if (cos < -1) then

        cos = -1;
    elseif (cos > 1) then
        cos = 1;
    end
    local angle = self:CalAngleByAcos(cos);

    if (deltaY < 0) then

        angle = 360 - angle;
    end

    return angle;
end

----[TODO]static
--function FightTools:angleToRadian(angle)
--    return angle / 180 * Math.PI
--
--end
----[TODO]static
--function FightTools:downSkip(event)
--    event:stopPropagation()
--
--end


function FightTools.tan2ToAngle(y, x)
    local _angle = Mathf.Atan2(y, x) * 180 / Mathf.PI
    if y < 0 then
        _angle = _angle + 360
    end
    return _angle
end
----[TODO]static
--function FightTools:vecToAngle(vec)
--    return FightTools:tan2ToAngle(vec.y, vec.x)
--
--end
----[TODO]static
--function FightTools:screenResize()
--    FightTools._screenPosDivideDesignPosWidth = Laya.stage.width / 1920
--    FightTools._screenPosDivideDesignPosHeight = Laya.stage.height / 1080
--    FightTools._designPosDivideScreenPosWidth = 1920 / Laya.stage.width
--    FightTools._designPosDivideScreenPosHeight = 1080 / Laya.stage.height
--
--end
----[TODO]static
--function FightTools:clipTxt(fontClip, txt, color)
--    if color == "red" then
--        fontClip.skin = "font/word_red.png"
--        fontClip.sheet = "取出立即购买获得消确定继 续搜索同意拒绝复制升级解 锁游戏领前往充放置全部加 入房间重抽报名免费"
--
--
--    else
--        if color == "green" then
--            fontClip.skin = "font/word_green.png"
--            fontClip.sheet = "存入取消查看确定装备邀请 一键升级返回大厅反馈分享 礼包码炫耀下领奖励提交开 启使用完成布置规则询赠送 购买个观看广告订阅"
--
--        end
--    end
--    fontClip.align = "center"
--    fontClip.value = txt
--
--end
----[TODO]static
--function FightTools:getCurTs()
--    local now = nil--[TODO] new Date():getTime()
--    local now_time = Math:floor((now / 1000))
--    return now_time
--
--end
----[TODO]static
--function FightTools:copyToClipboard(text)
--
--end
----[TODO]static
--function FightTools:designPosMapScreenPos(pos)
--    pos.x = FightTools._screenPosDivideDesignPosWidth * pos.x
--    pos.y = FightTools._screenPosDivideDesignPosHeight * pos.y
--
--end
----[TODO]static
--function FightTools:screenPosXMapDesignPosX(x)
--    return FightTools._designPosDivideScreenPosWidth * x
--
--end
----[TODO]static
--function FightTools:screenPosYMapDesignPosY(y)
--    return FightTools._designPosDivideScreenPosHeight * y
--
--end
----[TODO]static
function FightTools:getRandomNumber(min, max)
    local ret = min + math.floor(math.random() * (max - min + 1))
    if ret > max then
        ret = max
    end
    return ret

end
----[TODO]static
function FightTools:CalSinCosSheet()
    for i = 0, 36000 - 1 do
        FightTools._sinAngleDic[i] = math.sin((i / 100) * math.pi / 180)
        FightTools._cosAngleDic[i] = math.cos((i / 100) * math.pi / 180)
    end

end
function FightTools:CalAcosSheet()
    for i = -10000, 10000 do
        FightTools._acosAngleDic[i + 10000] = math.acos(i / 10000) * (180 / math.pi)
    end
end

function FightTools:CalAngleByAcos(acos)
    local tmp = math.floor(acos * 10000 + 10000)
    return FightTools._acosAngleDic[tmp]

end

function FightTools:CalSqrtBySheet(deltaX, deltaY)
    return math.sqrt(deltaX * deltaX + deltaY * deltaY)
end
----[TODO]static
--function FightTools:CalLineAngleP4(startX, startY, endX, endY)
--    local deltaX = endX - startX
--    local deltaY = endY - startY
--    if (deltaY ===0) and (deltaX<0) then
--    return 180
--
--    end
--
--    local length = FightTools:CalSqrtBySheet(deltaX, deltaY)
--    if length<=0 then
--    return 0
--
--    end
--
--    local cos = deltaX/length
--    local angle =FightTools:CalAngleByAcos(cos)
--    if deltaY<0 then
--    angle = 360-angle
--
--    end
--    return angle
--
--end
----[TODO]static
--function FightTools:CalPointLenP4(startX, startY, endX, endY)
--    return FightTools:CalSqrtBySheet(endX - startX, endY - startY)
--
--end
----[TODO]static
--function FightTools:getCoinStr(coin)
--    local a = ""
--    if coin > 10000 then
--        a = coin / 10000 + "万"
--
--
--    else
--        if coin > 1000 then
--            a = coin / 1000 + "千"
--
--        end
--    end
--    return a
--
--end
----[TODO]static
--function FightTools:getRedTaskCoinStr(coin)
--    local a = ""
--    if coin > 10000 then
--        a = ((coin - coin % 10000) / 10000) + "万"
--
--
--    else
--        if coin > 1000 then
--            a = (coin / 1000):toFixed(0) + "千"
--
--        end
--    end
--    if coin == 0 then
--        a = "0"
--
--    end
--    return a
--
--end
----[TODO]static
--function FightTools:formatCurrency(amount)
--    return amount + ""
--
--end
--[TODO]static
function FightTools:formatNickName(nickname, str_len)
    if not str_len then
        str_len = 15
    end

    local dropping = string.byte(nickname, str_len + 1)
    if not dropping then
        return nickname
    end
    if dropping >= 128 and dropping < 192 then
        return self:formatNickName(nickname, str_len - 1)
    end
    return string.sub(nickname, 1, str_len).."..."
end
----[TODO]static
--function FightTools:getVisibleChildNumber(root)
--    local ret = 0
--    local index = 0
--    local child
--    while (1)child = root:getChildAt(index + +)
--        if ~child then
--        break
--
--        end
--
--
--        return ret
--
--end
----[TODO]static
--function FightTools:isCrossScreen()
--    return Browser.clientWidth > Browser.clientHeight
--
--end
----[TODO]static
--function FightTools:nameSkip(name)
--    return name:replace( /[&<>]/g, "")
--
--end
----[TODO]static
--function FightTools:adaptToDesignMap2DPoint(x, y, mirrorFlag)
--    fight.tool.FightTools.TEMP_POINT1.x = x
--    fight.tool.FightTools.TEMP_POINT1.y = y
--    Screen.instance:adaptToDesign(fight.tool.FightTools.TEMP_POINT1, fight.tool.FightTools.TEMP_POINT1)
--    MirrorMapper:map2DPoint(fight.tool.FightTools.TEMP_POINT1, fight.tool.FightTools.TEMP_POINT1, mirrorFlag)
--    return nil--[TODO] new Point(fight.tool.FightTools.TEMP_POINT1.x,fight.tool.FightTools.TEMP_POINT1.y)
--
--end
----[TODO]static
--function FightTools:getFloat(re)
--    re
--    local num = re / FightContext.instance.exchangeRate
--    return num:toFixed(2)
--
--end
--


--- 二次贝塞尔曲线
--- see: https://en.wikipedia.org/wiki/B%C3%A9zier_curve
--- @param p0 点p0
--- @param p1 点p1
--- @param p2 点p2
--- @param t 0 <= t <= 1
--- @return 值为t时二次贝塞尔曲线的值
function FightTools:calQuadraticBezier(p0, p1, p2, t)
    t = math.max(math.min(t, 1), 0);
    local m = 1 - t;
    return m * m * p0 + 2 * m * t * p1 + t * t * p2;
end

---@param src Vector2
---@param angle number
---@param out Vector2
function FightTools:rotateVec2(src, angle, out)
    local rd = angle / 180 * math.pi
    local sinVal = math.sin(rd);
    local cosVal = math.cos(rd);
    local rx = src.x * cosVal - src.y * sinVal;
    local ry = src.x * sinVal + src.y * cosVal;
    out:Set(rx, ry);
end

---@param a Vector2
---@param b Vector2
---@param out Vector2
function FightTools:subtractVec2(a, b, out)
    out.x = a.x - b.x
    out.y = a.y - b.y
end

---@param a Vector2
---@param b Vector2
---@param out Vector2
function FightTools:addVec2(a, b, out)
    out.x = a.x + b.x
    out.y = a.y + b.y
end
