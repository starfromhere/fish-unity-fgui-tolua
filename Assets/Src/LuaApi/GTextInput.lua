---@class GTextInput : GTextField
---@field public inputTextField InputTextField
---@field public onChanged EventListener
---@field public onSubmit EventListener
---@field public editable bool
---@field public hideInput bool
---@field public maxLength Int32
---@field public restrict string
---@field public displayAsPassword bool
---@field public caretPosition Int32
---@field public promptText string
---@field public keyboardInput bool
---@field public keyboardType Int32
---@field public disableIME bool
---@field public emojies Dictionary`2
---@field public border Int32
---@field public corner Int32
---@field public borderColor Color
---@field public backgroundColor Color
---@field public mouseWheelEnabled bool
local GTextInput={ }
---@public
---@param start Int32
---@param length Int32
---@return void
function GTextInput:SetSelection(start, length) end
---@public
---@param value string
---@return void
function GTextInput:ReplaceSelection(value) end
---@public
---@param buffer ByteBuffer
---@param beginPos Int32
---@return void
function GTextInput:Setup_BeforeAdd(buffer, beginPos) end
FairyGUI.GTextInput = GTextInput