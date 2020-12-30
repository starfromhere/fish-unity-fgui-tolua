---@class EaseTools
EaseTools = class("EaseTools")

---以较快速度开始运动，然后在执行时减慢运动速度，直至速率为零。
---@param t number 指定当前时间,介于 0 和持续时间之间（包括二者）.
---@param b number 指定动画属性的初始值。
---@param c number 指定动画属性的更改总计。
---@param d number 指定运动的持续时间。
---@return number 指定时间的插补属性的值。
function EaseTools:strongOut(t, b, c, d)
    t = t / d - 1
    return c * (t * t * t * t * t + 1) + b;
end

