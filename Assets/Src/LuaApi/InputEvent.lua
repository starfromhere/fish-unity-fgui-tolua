---@class InputEvent : Object
---@field public x Single
---@field public y Single
---@field public keyCode number
---@field public character Char
---@field public modifiers number
---@field public mouseWheelDelta Single
---@field public touchId Int32
---@field public button Int32
---@field public clickCount Int32
---@field public holdTime Single
---@field public position Vector2
---@field public isDoubleClick bool
---@field public ctrlOrCmd bool
---@field public ctrl bool
---@field public shift bool
---@field public alt bool
---@field public command bool
local InputEvent={ }
FairyGUI.InputEvent = InputEvent