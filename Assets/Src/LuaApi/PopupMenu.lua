---@class PopupMenu : EventDispatcher
---@field public visibleItemCount Int32
---@field public hideOnClickItem bool
---@field public autoSize bool
---@field public onPopup EventListener
---@field public onClose EventListener
---@field public itemCount Int32
---@field public contentPane GComponent
---@field public list GList
local PopupMenu={ }
---@public
---@param caption string
---@param callback EventCallback0
---@return GButton
function PopupMenu:AddItem(caption, callback) end
---@public
---@param caption string
---@param callback EventCallback1
---@return GButton
function PopupMenu:AddItem(caption, callback) end
---@public
---@param caption string
---@param index Int32
---@param callback EventCallback1
---@return GButton
function PopupMenu:AddItemAt(caption, index, callback) end
---@public
---@param caption string
---@param index Int32
---@param callback EventCallback0
---@return GButton
function PopupMenu:AddItemAt(caption, index, callback) end
---@public
---@return void
function PopupMenu:AddSeperator() end
---@public
---@param index Int32
---@return void
function PopupMenu:AddSeperator(index) end
---@public
---@param index Int32
---@return string
function PopupMenu:GetItemName(index) end
---@public
---@param name string
---@param caption string
---@return void
function PopupMenu:SetItemText(name, caption) end
---@public
---@param name string
---@param visible bool
---@return void
function PopupMenu:SetItemVisible(name, visible) end
---@public
---@param name string
---@param grayed bool
---@return void
function PopupMenu:SetItemGrayed(name, grayed) end
---@public
---@param name string
---@param checkable bool
---@return void
function PopupMenu:SetItemCheckable(name, checkable) end
---@public
---@param name string
---@param check bool
---@return void
function PopupMenu:SetItemChecked(name, check) end
---@public
---@param name string
---@return bool
function PopupMenu:isItemChecked(name) end
---@public
---@param name string
---@return bool
function PopupMenu:IsItemChecked(name) end
---@public
---@param name string
---@return void
function PopupMenu:RemoveItem(name) end
---@public
---@return void
function PopupMenu:ClearItems() end
---@public
---@return void
function PopupMenu:Dispose() end
---@public
---@return void
function PopupMenu:Show() end
---@public
---@param target GObject
---@return void
function PopupMenu:Show(target) end
---@public
---@param target GObject
---@param downward Object
---@return void
function PopupMenu:Show(target, downward) end
---@public
---@param target GObject
---@param dir number
---@return void
function PopupMenu:Show(target, dir) end
---@public
---@param target GObject
---@param dir number
---@param parentMenu PopupMenu
---@return void
function PopupMenu:Show(target, dir, parentMenu) end
---@public
---@return void
function PopupMenu:Hide() end
FairyGUI.PopupMenu = PopupMenu