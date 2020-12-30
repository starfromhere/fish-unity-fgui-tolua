---@class Controller : EventDispatcher
---@field public name string
---@field public onChanged EventListener
---@field public selectedIndex Int32
---@field public selectedPage string
---@field public previsousIndex Int32
---@field public previousPage string
---@field public pageCount Int32
local Controller={ }
---@public
---@return void
function Controller:Dispose() end
---@public
---@param value Int32
---@return void
function Controller:SetSelectedIndex(value) end
---@public
---@param value string
---@return void
function Controller:SetSelectedPage(value) end
---@public
---@param index Int32
---@return string
function Controller:GetPageName(index) end
---@public
---@param index Int32
---@return string
function Controller:GetPageId(index) end
---@public
---@param aName string
---@return string
function Controller:GetPageIdByName(aName) end
---@public
---@param name string
---@return void
function Controller:AddPage(name) end
---@public
---@param name string
---@param index Int32
---@return void
function Controller:AddPageAt(name, index) end
---@public
---@param name string
---@return void
function Controller:RemovePage(name) end
---@public
---@param index Int32
---@return void
function Controller:RemovePageAt(index) end
---@public
---@return void
function Controller:ClearPages() end
---@public
---@param aName string
---@return bool
function Controller:HasPage(aName) end
---@public
---@return void
function Controller:RunActions() end
---@public
---@param buffer ByteBuffer
---@return void
function Controller:Setup(buffer) end
FairyGUI.Controller = Controller