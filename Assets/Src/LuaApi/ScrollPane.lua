---@class ScrollPane : EventDispatcher
---@field public TWEEN_TIME_GO Single
---@field public TWEEN_TIME_DEFAULT Single
---@field public PULL_RATIO Single
---@field public draggingPane ScrollPane
---@field public onScroll EventListener
---@field public onScrollEnd EventListener
---@field public onPullDownRelease EventListener
---@field public onPullUpRelease EventListener
---@field public owner GComponent
---@field public hzScrollBar GScrollBar
---@field public vtScrollBar GScrollBar
---@field public header GComponent
---@field public footer GComponent
---@field public bouncebackEffect bool
---@field public touchEffect bool
---@field public inertiaDisabled bool
---@field public softnessOnTopOrLeftSide bool
---@field public scrollStep Single
---@field public snapToItem bool
---@field public pageMode bool
---@field public pageController Controller
---@field public mouseWheelEnabled bool
---@field public decelerationRate Single
---@field public isDragged bool
---@field public percX Single
---@field public percY Single
---@field public posX Single
---@field public posY Single
---@field public isBottomMost bool
---@field public isRightMost bool
---@field public currentPageX Int32
---@field public currentPageY Int32
---@field public scrollingPosX Single
---@field public scrollingPosY Single
---@field public contentWidth Single
---@field public contentHeight Single
---@field public viewWidth Single
---@field public viewHeight Single
local ScrollPane={ }
---@public
---@param buffer ByteBuffer
---@return void
function ScrollPane:Setup(buffer) end
---@public
---@return void
function ScrollPane:Dispose() end
---@public
---@param value Single
---@param ani bool
---@return void
function ScrollPane:SetPercX(value, ani) end
---@public
---@param value Single
---@param ani bool
---@return void
function ScrollPane:SetPercY(value, ani) end
---@public
---@param value Single
---@param ani bool
---@return void
function ScrollPane:SetPosX(value, ani) end
---@public
---@param value Single
---@param ani bool
---@return void
function ScrollPane:SetPosY(value, ani) end
---@public
---@param value Int32
---@param ani bool
---@return void
function ScrollPane:SetCurrentPageX(value, ani) end
---@public
---@param value Int32
---@param ani bool
---@return void
function ScrollPane:SetCurrentPageY(value, ani) end
---@public
---@return void
function ScrollPane:ScrollTop() end
---@public
---@param ani bool
---@return void
function ScrollPane:ScrollTop(ani) end
---@public
---@return void
function ScrollPane:ScrollBottom() end
---@public
---@param ani bool
---@return void
function ScrollPane:ScrollBottom(ani) end
---@public
---@return void
function ScrollPane:ScrollUp() end
---@public
---@param ratio Single
---@param ani bool
---@return void
function ScrollPane:ScrollUp(ratio, ani) end
---@public
---@return void
function ScrollPane:ScrollDown() end
---@public
---@param ratio Single
---@param ani bool
---@return void
function ScrollPane:ScrollDown(ratio, ani) end
---@public
---@return void
function ScrollPane:ScrollLeft() end
---@public
---@param ratio Single
---@param ani bool
---@return void
function ScrollPane:ScrollLeft(ratio, ani) end
---@public
---@return void
function ScrollPane:ScrollRight() end
---@public
---@param ratio Single
---@param ani bool
---@return void
function ScrollPane:ScrollRight(ratio, ani) end
---@public
---@param obj GObject
---@return void
function ScrollPane:ScrollToView(obj) end
---@public
---@param obj GObject
---@param ani bool
---@return void
function ScrollPane:ScrollToView(obj, ani) end
---@public
---@param obj GObject
---@param ani bool
---@param setFirst bool
---@return void
function ScrollPane:ScrollToView(obj, ani, setFirst) end
---@public
---@param rect Rect
---@param ani bool
---@param setFirst bool
---@return void
function ScrollPane:ScrollToView(rect, ani, setFirst) end
---@public
---@param obj GObject
---@return bool
function ScrollPane:IsChildInView(obj) end
---@public
---@return void
function ScrollPane:CancelDragging() end
---@public
---@param size Int32
---@return void
function ScrollPane:LockHeader(size) end
---@public
---@param size Int32
---@return void
function ScrollPane:LockFooter(size) end
---@public
---@return void
function ScrollPane:UpdateScrollBarVisible() end
FairyGUI.ScrollPane = ScrollPane