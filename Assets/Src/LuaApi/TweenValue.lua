---@class TweenValue : Object
---@field public x Single
---@field public y Single
---@field public z Single
---@field public w Single
---@field public d number
---@field public vec2 Vector2
---@field public vec3 Vector3
---@field public vec4 Vector4
---@field public color Color
---@field public Item Single
local TweenValue={ }
---@public
---@return void
function TweenValue:SetZero() end
FairyGUI.TweenValue = TweenValue