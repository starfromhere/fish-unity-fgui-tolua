---@class GObject : EventDispatcher
---@field public name string
---@field public data Object
---@field public sourceWidth Int32
---@field public sourceHeight Int32
---@field public initWidth Int32
---@field public initHeight Int32
---@field public minWidth Int32
---@field public maxWidth Int32
---@field public minHeight Int32
---@field public maxHeight Int32
---@field public dragBounds Nullable`1
---@field public packageItem PackageItem
---@field public id string
---@field public relations Relations
---@field public parent GComponent
---@field public displayObject DisplayObject
---@field public draggingObject GObject
---@field public onClick EventListener
---@field public onRightClick EventListener
---@field public onTouchBegin EventListener
---@field public onTouchMove EventListener
---@field public onTouchEnd EventListener
---@field public onRollOver EventListener
---@field public onRollOut EventListener
---@field public onAddedToStage EventListener
---@field public onRemovedFromStage EventListener
---@field public onKeyDown EventListener
---@field public onClickLink EventListener
---@field public onPositionChanged EventListener
---@field public onSizeChanged EventListener
---@field public onDragStart EventListener
---@field public onDragMove EventListener
---@field public onDragEnd EventListener
---@field public onGearStop EventListener
---@field public onFocusIn EventListener
---@field public onFocusOut EventListener
---@field public x Single
---@field public y Single
---@field public z Single
---@field public xy Vector2
---@field public position Vector3
---@field public pixelSnapping bool
---@field public width Single
---@field public height Single
---@field public size Vector2
---@field public actualWidth Single
---@field public actualHeight Single
---@field public xMin Single
---@field public yMin Single
---@field public scaleX Single
---@field public scaleY Single
---@field public scale Vector2
---@field public skew Vector2
---@field public pivotX Single
---@field public pivotY Single
---@field public pivot Vector2
---@field public pivotAsAnchor bool
---@field public touchable bool
---@field public grayed bool
---@field public enabled bool
---@field public rotation Single
---@field public rotationX Single
---@field public rotationY Single
---@field public alpha Single
---@field public visible bool
---@field public sortingOrder Int32
---@field public focusable bool
---@field public tabStop bool
---@field public focused bool
---@field public tooltips string
---@field public cursor string
---@field public filter IFilter
---@field public blendMode number
---@field public gameObjectName string
---@field public inContainer bool
---@field public onStage bool
---@field public resourceURL string
---@field public gearXY GearXY
---@field public gearSize GearSize
---@field public gearLook GearLook
---@field public group GGroup
---@field public root GRoot
---@field public text string
---@field public icon string
---@field public draggable bool
---@field public dragging bool
---@field public isDisposed bool
---@field public asImage GImage
---@field public asCom GComponent
---@field public asButton GButton
---@field public asLabel GLabel
---@field public asProgress GProgressBar
---@field public asSlider GSlider
---@field public asComboBox GComboBox
---@field public asTextField GTextField
---@field public asRichTextField GRichTextField
---@field public asTextInput GTextInput
---@field public asLoader GLoader
---@field public asLoader3D GLoader3D
---@field public asList GList
---@field public asGraph GGraph
---@field public asGroup GGroup
---@field public asMovieClip GMovieClip
---@field public asTree GTree
---@field public treeNode GTreeNode
local GObject={ }
---@public
---@param xv Single
---@param yv Single
---@return void
function GObject:SetXY(xv, yv) end
---@public
---@param xv Single
---@param yv Single
---@param topLeftValue bool
---@return void
function GObject:SetXY(xv, yv, topLeftValue) end
---@public
---@param xv Single
---@param yv Single
---@param zv Single
---@return void
function GObject:SetPosition(xv, yv, zv) end
---@public
---@return void
function GObject:Center() end
---@public
---@param restraint bool
---@return void
function GObject:Center(restraint) end
---@public
---@return void
function GObject:MakeFullScreen() end
---@public
---@param wv Single
---@param hv Single
---@return void
function GObject:SetSize(wv, hv) end
---@public
---@param wv Single
---@param hv Single
---@param ignorePivot bool
---@return void
function GObject:SetSize(wv, hv, ignorePivot) end
---@public
---@param wv Single
---@param hv Single
---@return void
function GObject:SetScale(wv, hv) end
---@public
---@param xv Single
---@param yv Single
---@return void
function GObject:SetPivot(xv, yv) end
---@public
---@param xv Single
---@param yv Single
---@param asAnchor bool
---@return void
function GObject:SetPivot(xv, yv, asAnchor) end
---@public
---@return void
function GObject:RequestFocus() end
---@public
---@param byKey bool
---@return void
function GObject:RequestFocus(byKey) end
---@public
---@param mode Int32
---@return void
function GObject:ChangeBlendMode(mode) end
---@public
---@param obj GObject
---@return void
function GObject:SetHome(obj) end
---@public
---@param index Int32
---@return GearBase
function GObject:GetGear(index) end
---@public
---@return void
function GObject:InvalidateBatchingState() end
---@public
---@param c Controller
---@return void
function GObject:HandleControllerChanged(c) end
---@public
---@param target GObject
---@param relationType number
---@return void
function GObject:AddRelation(target, relationType) end
---@public
---@param target GObject
---@param relationType number
---@param usePercent bool
---@return void
function GObject:AddRelation(target, relationType, usePercent) end
---@public
---@param target GObject
---@param relationType number
---@return void
function GObject:RemoveRelation(target, relationType) end
---@public
---@return void
function GObject:RemoveFromParent() end
---@public
---@return void
function GObject:StartDrag() end
---@public
---@param touchId Int32
---@return void
function GObject:StartDrag(touchId) end
---@public
---@return void
function GObject:StopDrag() end
---@public
---@param pt Vector2
---@return Vector2
function GObject:LocalToGlobal(pt) end
---@public
---@param pt Vector2
---@return Vector2
function GObject:GlobalToLocal(pt) end
---@public
---@param rect Rect
---@return Rect
function GObject:LocalToGlobal(rect) end
---@public
---@param rect Rect
---@return Rect
function GObject:GlobalToLocal(rect) end
---@public
---@param pt Vector2
---@param r GRoot
---@return Vector2
function GObject:LocalToRoot(pt, r) end
---@public
---@param pt Vector2
---@param r GRoot
---@return Vector2
function GObject:RootToLocal(pt, r) end
---@public
---@param pt Vector3
---@return Vector2
function GObject:WorldToLocal(pt) end
---@public
---@param pt Vector3
---@param camera Camera
---@return Vector2
function GObject:WorldToLocal(pt, camera) end
---@public
---@param pt Vector2
---@param targetSpace GObject
---@return Vector2
function GObject:TransformPoint(pt, targetSpace) end
---@public
---@param rect Rect
---@param targetSpace GObject
---@return Rect
function GObject:TransformRect(rect, targetSpace) end
---@public
---@return void
function GObject:Dispose() end
---@public
---@return void
function GObject:ConstructFromResource() end
---@public
---@param buffer ByteBuffer
---@param beginPos Int32
---@return void
function GObject:Setup_BeforeAdd(buffer, beginPos) end
---@public
---@param buffer ByteBuffer
---@param beginPos Int32
---@return void
function GObject:Setup_AfterAdd(buffer, beginPos) end
---@public
---@param endValue Vector2
---@param duration Single
---@return GTweener
function GObject:TweenMove(endValue, duration) end
---@public
---@param endValue Single
---@param duration Single
---@return GTweener
function GObject:TweenMoveX(endValue, duration) end
---@public
---@param endValue Single
---@param duration Single
---@return GTweener
function GObject:TweenMoveY(endValue, duration) end
---@public
---@param endValue Vector2
---@param duration Single
---@return GTweener
function GObject:TweenScale(endValue, duration) end
---@public
---@param endValue Single
---@param duration Single
---@return GTweener
function GObject:TweenScaleX(endValue, duration) end
---@public
---@param endValue Single
---@param duration Single
---@return GTweener
function GObject:TweenScaleY(endValue, duration) end
---@public
---@param endValue Vector2
---@param duration Single
---@return GTweener
function GObject:TweenResize(endValue, duration) end
---@public
---@param endValue Single
---@param duration Single
---@return GTweener
function GObject:TweenFade(endValue, duration) end
---@public
---@param endValue Single
---@param duration Single
---@return GTweener
function GObject:TweenRotate(endValue, duration) end
FairyGUI.GObject = GObject