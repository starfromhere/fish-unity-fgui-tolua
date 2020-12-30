
---@class UIEffectManager
UIEffectManager = class("UIEffectManager")

local EffectCall = {}
local ConstValue = {
    -- 可以添加的配表修改
    sv = 0.01,          -- 小数值 
    bv = 1.05,             -- 大数值
    dv = 1,             -- 默认数值
    mv = 0.5,           -- 中间数值
    b2s = 0.4,          -- 大变小类型缩放时间
    s2b = 0.4,          -- 小变大类型缩放时间
}

---CreateEffect 创建界面打开缓动动画效果
---@public
---@param view GComponent               缓动动画表现的根节点
---@param effectType UIEffectType       缓动动画类型
---@param handler Handler               缓动动画播放完成的回掉
---@return void
function UIEffectManager.Create(view, effectType, handler)
    if effectType == UIEffectType.NORMAL then
        EffectCall.normal(view, handler)
    elseif effectType == UIEffectType.SMALL_TO_BIG then
        EffectCall.smallToBig(view, handler)
    elseif effectType == UIEffectType.BIG_TO_SMALL then
        EffectCall.bigToSmall(view, handler)
    end
end

---@param view GComponent
---@param handler Handler
EffectCall.normal = function(view, handler)
    --view:SetPosition()
    if handler then
        handler:Call()
    end
end

---@param view GComponent
---@param handler Handler
EffectCall.smallToBig = function(view, handler)

    local x = Input.mousePosition.x;
    local y = Input.mousePosition.y;
    view:SetPivot(x/UnityEngine.Screen.width,(UnityEngine.Screen.height - y)/UnityEngine.Screen.height)
    view:SetScale(0,0)
    view:SetXY(0,0)

    view:TweenScale(Vector2.New(ConstValue.bv,ConstValue.bv), ConstValue.s2b)
        :OnComplete(function ()
        view:TweenScale(Vector2.New(ConstValue.dv,ConstValue.dv),0.1)
        if handler then
            handler:Call()
        end
    end)

end


---@param view GComponent
---@param handler Handler
EffectCall.bigToSmall = function (view, handler)
    view:TweenScale(Vector2.New(ConstValue.sv,ConstValue.sv), ConstValue.b2s)
        :OnComplete(function ()
            view.visible = false
            view:SetScale(ConstValue.dv, ConstValue.dv)
            if handler then
                handler:Call()
            end
            end)
end