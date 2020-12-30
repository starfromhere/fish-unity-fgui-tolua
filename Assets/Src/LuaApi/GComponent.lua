---@class GComponent : GObject
---@field public rootContainer Container
---@field public container Container
---@field public scrollPane ScrollPane
---@field public onDrop EventListener
---@field public fairyBatching bool
---@field public opaque bool
---@field public margin Margin
---@field public childrenRenderOrder number
---@field public apexIndex Int32
---@field public tabStopChildren bool
---@field public numChildren Int32
---@field public Controllers List`1
---@field public clipSoftness Vector2
---@field public mask DisplayObject
---@field public reversedMask bool
---@field public baseUserData string
---@field public viewWidth Single
---@field public viewHeight Single
local GComponent={ }
---@public
---@return void
function GComponent:Dispose() end
---@public
---@param childChanged bool
---@return void
function GComponent:InvalidateBatchingState(childChanged) end
---@public
---@param child GObject
---@return GObject
function GComponent:AddChild(child) end
---@public
---@param child GObject
---@param index Int32
---@return GObject
function GComponent:AddChildAt(child, index) end
---@public
---@param child GObject
---@return GObject
function GComponent:RemoveChild(child) end
---@public
---@param child GObject
---@param dispose bool
---@return GObject
function GComponent:RemoveChild(child, dispose) end
---@public
---@param index Int32
---@return GObject
function GComponent:RemoveChildAt(index) end
---@public
---@param index Int32
---@param dispose bool
---@return GObject
function GComponent:RemoveChildAt(index, dispose) end
---@public
---@return void
function GComponent:RemoveChildren() end
---@public
---@param beginIndex Int32
---@param endIndex Int32
---@param dispose bool
---@return void
function GComponent:RemoveChildren(beginIndex, endIndex, dispose) end
---@public
---@param index Int32
---@return GObject
function GComponent:GetChildAt(index) end
---@public
---@param name string
---@return GObject
function GComponent:GetChild(name) end
---@public
---@param path string
---@return GObject
function GComponent:GetChildByPath(path) end
---@public
---@param name string
---@return GObject
function GComponent:GetVisibleChild(name) end
---@public
---@param group GGroup
---@param name string
---@return GObject
function GComponent:GetChildInGroup(group, name) end
---@public
---@return GObject[]
function GComponent:GetChildren() end
---@public
---@param child GObject
---@return Int32
function GComponent:GetChildIndex(child) end
---@public
---@param child GObject
---@param index Int32
---@return void
function GComponent:SetChildIndex(child, index) end
---@public
---@param child GObject
---@param index Int32
---@return Int32
function GComponent:SetChildIndexBefore(child, index) end
---@public
---@param child1 GObject
---@param child2 GObject
---@return void
function GComponent:SwapChildren(child1, child2) end
---@public
---@param index1 Int32
---@param index2 Int32
---@return void
function GComponent:SwapChildrenAt(index1, index2) end
---@public
---@param obj GObject
---@return bool
function GComponent:IsAncestorOf(obj) end
---@public
---@param objs IList`1
---@return void
function GComponent:ChangeChildrenOrder(objs) end
---@public
---@param controller Controller
---@return void
function GComponent:AddController(controller) end
---@public
---@param index Int32
---@return Controller
function GComponent:GetControllerAt(index) end
---@public
---@param name string
---@return Controller
function GComponent:GetController(name) end
---@public
---@param c Controller
---@return void
function GComponent:RemoveController(c) end
---@public
---@param index Int32
---@return Transition
function GComponent:GetTransitionAt(index) end
---@public
---@param name string
---@return Transition
function GComponent:GetTransition(name) end
---@public
---@param child GObject
---@return bool
function GComponent:IsChildInView(child) end
---@public
---@return Int32
function GComponent:GetFirstChildInView() end
---@public
---@param c Controller
---@return void
function GComponent:HandleControllerChanged(c) end
---@public
---@return void
function GComponent:SetBoundsChangedFlag() end
---@public
---@return void
function GComponent:EnsureBoundsCorrect() end
---@public
---@return void
function GComponent:ConstructFromResource() end
---@public
---@param xml XML
---@return void
function GComponent:ConstructFromXML(xml) end
---@public
---@param buffer ByteBuffer
---@param beginPos Int32
---@return void
function GComponent:Setup_AfterAdd(buffer, beginPos) end
---@public
---@param peerTable LuaTable
---@return void
function GComponent:SetLuaPeer(peerTable) end
FairyGUI.GComponent = GComponent