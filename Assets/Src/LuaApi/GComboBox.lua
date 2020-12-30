---@class GComboBox : GComponent
---@field public visibleItemCount Int32
---@field public dropdown GComponent
---@field public onChanged EventListener
---@field public icon string
---@field public title string
---@field public text string
---@field public titleColor Color
---@field public titleFontSize Int32
---@field public items String[]
---@field public icons String[]
---@field public values String[]
---@field public itemList List`1
---@field public valueList List`1
---@field public iconList List`1
---@field public selectedIndex Int32
---@field public selectionController Controller
---@field public value string
---@field public popupDirection number
local GComboBox={ }
---@public
---@return void
function GComboBox:ApplyListChange() end
---@public
---@return GTextField
function GComboBox:GetTextField() end
---@public
---@param c Controller
---@return void
function GComboBox:HandleControllerChanged(c) end
---@public
---@return void
function GComboBox:Dispose() end
---@public
---@param buffer ByteBuffer
---@param beginPos Int32
---@return void
function GComboBox:Setup_AfterAdd(buffer, beginPos) end
---@public
---@return void
function GComboBox:UpdateDropdownList() end
FairyGUI.GComboBox = GComboBox