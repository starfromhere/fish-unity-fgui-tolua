---@class Container : DisplayObject
---@field public renderMode number
---@field public renderCamera Camera
---@field public opaque bool
---@field public clipSoftness Nullable`1
---@field public hitArea IHitTest
---@field public touchChildren bool
---@field public reversedMask bool
---@field public numChildren Int32
---@field public clipRect Nullable`1
---@field public mask DisplayObject
---@field public fairyBatching bool
---@field public tabStopChildren bool
local Container={ }
---@public
---@param value Action
---@return void
function Container:add_onUpdate(value) end
---@public
---@param value Action
---@return void
function Container:remove_onUpdate(value) end
---@public
---@param child DisplayObject
---@return DisplayObject
function Container:AddChild(child) end
---@public
---@param child DisplayObject
---@param index Int32
---@return DisplayObject
function Container:AddChildAt(child, index) end
---@public
---@param child DisplayObject
---@return bool
function Container:Contains(child) end
---@public
---@param index Int32
---@return DisplayObject
function Container:GetChildAt(index) end
---@public
---@param name string
---@return DisplayObject
function Container:GetChild(name) end
---@public
---@return DisplayObject[]
function Container:GetChildren() end
---@public
---@param child DisplayObject
---@return Int32
function Container:GetChildIndex(child) end
---@public
---@param child DisplayObject
---@return DisplayObject
function Container:RemoveChild(child) end
---@public
---@param child DisplayObject
---@param dispose bool
---@return DisplayObject
function Container:RemoveChild(child, dispose) end
---@public
---@param index Int32
---@return DisplayObject
function Container:RemoveChildAt(index) end
---@public
---@param index Int32
---@param dispose bool
---@return DisplayObject
function Container:RemoveChildAt(index, dispose) end
---@public
---@return void
function Container:RemoveChildren() end
---@public
---@param beginIndex Int32
---@param endIndex Int32
---@param dispose bool
---@return void
function Container:RemoveChildren(beginIndex, endIndex, dispose) end
---@public
---@param child DisplayObject
---@param index Int32
---@return void
function Container:SetChildIndex(child, index) end
---@public
---@param child1 DisplayObject
---@param child2 DisplayObject
---@return void
function Container:SwapChildren(child1, child2) end
---@public
---@param index1 Int32
---@param index2 Int32
---@return void
function Container:SwapChildrenAt(index1, index2) end
---@public
---@param indice IList`1
---@param objs IList`1
---@return void
function Container:ChangeChildrenOrder(indice, objs) end
---@public
---@param backward bool
---@return IEnumerator`1
function Container:GetDescendants(backward) end
---@public
---@return void
function Container:CreateGraphics() end
---@public
---@param targetSpace DisplayObject
---@return Rect
function Container:GetBounds(targetSpace) end
---@public
---@return Camera
function Container:GetRenderCamera() end
---@public
---@param stagePoint Vector2
---@param forTouch bool
---@return DisplayObject
function Container:HitTest(stagePoint, forTouch) end
---@public
---@param obj DisplayObject
---@return bool
function Container:IsAncestorOf(obj) end
---@public
---@param childrenChanged bool
---@return void
function Container:InvalidateBatchingState(childrenChanged) end
---@public
---@param value Int32
---@return void
function Container:SetChildrenLayer(value) end
---@public
---@param context UpdateContext
---@return void
function Container:Update(context) end
---@public
---@return void
function Container:Dispose() end
FairyGUI.Container = Container