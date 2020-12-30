---@class Rect : ValueType
---@field public zero Rect
---@field public x Single
---@field public y Single
---@field public position Vector2
---@field public center Vector2
---@field public min Vector2
---@field public max Vector2
---@field public width Single
---@field public height Single
---@field public size Vector2
---@field public xMin Single
---@field public yMin Single
---@field public xMax Single
---@field public yMax Single
---@field public left Single
---@field public right Single
---@field public top Single
---@field public bottom Single
local Rect={ }
---@public
---@param xmin Single
---@param ymin Single
---@param xmax Single
---@param ymax Single
---@return Rect
function Rect.MinMaxRect(xmin, ymin, xmax, ymax) end
---@public
---@param x Single
---@param y Single
---@param width Single
---@param height Single
---@return void
function Rect:Set(x, y, width, height) end
---@public
---@param point Vector2
---@return bool
function Rect:Contains(point) end
---@public
---@param point Vector3
---@return bool
function Rect:Contains(point) end
---@public
---@param point Vector3
---@param allowInverse bool
---@return bool
function Rect:Contains(point, allowInverse) end
---@public
---@param other Rect
---@return bool
function Rect:Overlaps(other) end
---@public
---@param other Rect
---@param allowInverse bool
---@return bool
function Rect:Overlaps(other, allowInverse) end
---@public
---@param rectangle Rect
---@param normalizedRectCoordinates Vector2
---@return Vector2
function Rect.NormalizedToPoint(rectangle, normalizedRectCoordinates) end
---@public
---@param rectangle Rect
---@param point Vector2
---@return Vector2
function Rect.PointToNormalized(rectangle, point) end
---@public
---@param lhs Rect
---@param rhs Rect
---@return bool
function Rect.op_Inequality(lhs, rhs) end
---@public
---@param lhs Rect
---@param rhs Rect
---@return bool
function Rect.op_Equality(lhs, rhs) end
---@public
---@return Int32
function Rect:GetHashCode() end
---@public
---@param other Object
---@return bool
function Rect:Equals(other) end
---@public
---@param other Rect
---@return bool
function Rect:Equals(other) end
---@public
---@return string
function Rect:ToString() end
---@public
---@param format string
---@return string
function Rect:ToString(format) end
UnityEngine.Rect = Rect