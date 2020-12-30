---@class DisplayObject : EventDispatcher
---@field public name string
---@field public gOwner GObject
---@field public id UInt32
---@field public parent Container
---@field public gameObject GameObject
---@field public cachedTransform Transform
---@field public graphics NGraphics
---@field public paintingGraphics NGraphics
---@field public onClick EventListener
---@field public onRightClick EventListener
---@field public onTouchBegin EventListener
---@field public onTouchMove EventListener
---@field public onTouchEnd EventListener
---@field public onRollOver EventListener
---@field public onRollOut EventListener
---@field public onMouseWheel EventListener
---@field public onAddedToStage EventListener
---@field public onRemovedFromStage EventListener
---@field public onKeyDown EventListener
---@field public onClickLink EventListener
---@field public onFocusIn EventListener
---@field public onFocusOut EventListener
---@field public alpha Single
---@field public grayed bool
---@field public visible bool
---@field public x Single
---@field public y Single
---@field public z Single
---@field public xy Vector2
---@field public position Vector3
---@field public pixelPerfect bool
---@field public width Single
---@field public height Single
---@field public size Vector2
---@field public scaleX Single
---@field public scaleY Single
---@field public scale Vector2
---@field public rotation Single
---@field public rotationX Single
---@field public rotationY Single
---@field public skew Vector2
---@field public perspective bool
---@field public focalLength Int32
---@field public pivot Vector2
---@field public location Vector3
---@field public material Material
---@field public shader string
---@field public renderingOrder Int32
---@field public layer Int32
---@field public focusable bool
---@field public tabStop bool
---@field public focused bool
---@field public cursor string
---@field public isDisposed bool
---@field public topmost Container
---@field public stage Stage
---@field public worldSpaceContainer Container
---@field public touchable bool
---@field public touchDisabled bool
---@field public paintingMode bool
---@field public cacheAsBitmap bool
---@field public filter IFilter
---@field public blendMode number
---@field public home Transform
local DisplayObject={ }
---@public
---@param value Action
---@return void
function DisplayObject:add_onPaint(value) end
---@public
---@param value Action
---@return void
function DisplayObject:remove_onPaint(value) end
---@public
---@param xv Single
---@param yv Single
---@return void
function DisplayObject:SetXY(xv, yv) end
---@public
---@param xv Single
---@param yv Single
---@param zv Single
---@return void
function DisplayObject:SetPosition(xv, yv, zv) end
---@public
---@param wv Single
---@param hv Single
---@return void
function DisplayObject:SetSize(wv, hv) end
---@public
---@return void
function DisplayObject:EnsureSizeCorrect() end
---@public
---@param xv Single
---@param yv Single
---@return void
function DisplayObject:SetScale(xv, yv) end
---@public
---@return void
function DisplayObject:EnterPaintingMode() end
---@public
---@param requestorId Int32
---@param extend Nullable`1
---@return void
function DisplayObject:EnterPaintingMode(requestorId, extend) end
---@public
---@param requestorId Int32
---@param extend Nullable`1
---@param scale Single
---@return void
function DisplayObject:EnterPaintingMode(requestorId, extend, scale) end
---@public
---@param requestorId Int32
---@return void
function DisplayObject:LeavePaintingMode(requestorId) end
---@public
---@param extend Nullable`1
---@param scale Single
---@return Texture2D
function DisplayObject:GetScreenShot(extend, scale) end
---@public
---@param mode Int32
---@return void
function DisplayObject:ChangeBlendMode(mode) end
---@public
---@param targetSpace DisplayObject
---@return Rect
function DisplayObject:GetBounds(targetSpace) end
---@public
---@param point Vector2
---@return Vector2
function DisplayObject:GlobalToLocal(point) end
---@public
---@param point Vector2
---@return Vector2
function DisplayObject:LocalToGlobal(point) end
---@public
---@param worldPoint Vector3
---@param direction Vector3
---@return Vector3
function DisplayObject:WorldToLocal(worldPoint, direction) end
---@public
---@param localPoint Vector3
---@return Vector3
function DisplayObject:LocalToWorld(localPoint) end
---@public
---@param point Vector2
---@param targetSpace DisplayObject
---@return Vector2
function DisplayObject:TransformPoint(point, targetSpace) end
---@public
---@param rect Rect
---@param targetSpace DisplayObject
---@return Rect
function DisplayObject:TransformRect(rect, targetSpace) end
---@public
---@return void
function DisplayObject:RemoveFromParent() end
---@public
---@return void
function DisplayObject:InvalidateBatchingState() end
---@public
---@param context UpdateContext
---@return void
function DisplayObject:Update(context) end
---@public
---@return void
function DisplayObject:Dispose() end
FairyGUI.DisplayObject = DisplayObject