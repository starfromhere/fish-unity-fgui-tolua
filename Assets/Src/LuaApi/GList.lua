---@class GList : GComponent
---@field public defaultItem string
---@field public foldInvisibleItems bool
---@field public selectionMode number
---@field public itemRenderer ListItemRenderer
---@field public itemProvider ListItemProvider
---@field public scrollItemToViewOnClick bool
---@field public onClickItem EventListener
---@field public onRightClickItem EventListener
---@field public layout number
---@field public lineCount Int32
---@field public columnCount Int32
---@field public lineGap Int32
---@field public columnGap Int32
---@field public align number
---@field public verticalAlign number
---@field public autoResizeItem bool
---@field public defaultItemSize Vector2
---@field public itemPool GObjectPool
---@field public selectedIndex Int32
---@field public selectionController Controller
---@field public touchItem GObject
---@field public isVirtual bool
---@field public numItems Int32
local GList={ }
---@public
---@return void
function GList:Dispose() end
---@public
---@param url string
---@return GObject
function GList:GetFromPool(url) end
---@public
---@return GObject
function GList:AddItemFromPool() end
---@public
---@param url string
---@return GObject
function GList:AddItemFromPool(url) end
---@public
---@param child GObject
---@param index Int32
---@return GObject
function GList:AddChildAt(child, index) end
---@public
---@param index Int32
---@param dispose bool
---@return GObject
function GList:RemoveChildAt(index, dispose) end
---@public
---@param index Int32
---@return void
function GList:RemoveChildToPoolAt(index) end
---@public
---@param child GObject
---@return void
function GList:RemoveChildToPool(child) end
---@public
---@return void
function GList:RemoveChildrenToPool() end
---@public
---@param beginIndex Int32
---@param endIndex Int32
---@return void
function GList:RemoveChildrenToPool(beginIndex, endIndex) end
---@public
---@return List`1
function GList:GetSelection() end
---@public
---@param result List`1
---@return List`1
function GList:GetSelection(result) end
---@public
---@param index Int32
---@param scrollItToView bool
---@return void
function GList:AddSelection(index, scrollItToView) end
---@public
---@param index Int32
---@return void
function GList:RemoveSelection(index) end
---@public
---@return void
function GList:ClearSelection() end
---@public
---@return void
function GList:SelectAll() end
---@public
---@return void
function GList:SelectNone() end
---@public
---@return void
function GList:SelectReverse() end
---@public
---@param enabled bool
---@return void
function GList:EnableSelectionFocusEvents(enabled) end
---@public
---@param enabled bool
---@return void
function GList:EnableArrowKeyNavigation(enabled) end
---@public
---@param dir Int32
---@return Int32
function GList:HandleArrowKey(dir) end
---@public
---@return void
function GList:ResizeToFit() end
---@public
---@param itemCount Int32
---@return void
function GList:ResizeToFit(itemCount) end
---@public
---@param itemCount Int32
---@param minSize Int32
---@return void
function GList:ResizeToFit(itemCount, minSize) end
---@public
---@param c Controller
---@return void
function GList:HandleControllerChanged(c) end
---@public
---@param index Int32
---@return void
function GList:ScrollToView(index) end
---@public
---@param index Int32
---@param ani bool
---@return void
function GList:ScrollToView(index, ani) end
---@public
---@param index Int32
---@param ani bool
---@param setFirst bool
---@return void
function GList:ScrollToView(index, ani, setFirst) end
---@public
---@return Int32
function GList:GetFirstChildInView() end
---@public
---@param index Int32
---@return Int32
function GList:ChildIndexToItemIndex(index) end
---@public
---@param index Int32
---@return Int32
function GList:ItemIndexToChildIndex(index) end
---@public
---@return void
function GList:SetVirtual() end
---@public
---@return void
function GList:SetVirtualAndLoop() end
---@public
---@return void
function GList:RefreshVirtualList() end
---@public
---@param buffer ByteBuffer
---@param beginPos Int32
---@return void
function GList:Setup_BeforeAdd(buffer, beginPos) end
---@public
---@param buffer ByteBuffer
---@param beginPos Int32
---@return void
function GList:Setup_AfterAdd(buffer, beginPos) end
FairyGUI.GList = GList