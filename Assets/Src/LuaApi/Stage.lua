---@class Stage : Container
---@field public stageHeight Int32
---@field public stageWidth Int32
---@field public soundVolume Single
---@field public inst Stage
---@field public touchScreen bool
---@field public keyboardInput bool
---@field public isTouchOnUI bool
---@field public devicePixelRatio Single
---@field public onStageResized EventListener
---@field public touchTarget DisplayObject
---@field public focus DisplayObject
---@field public touchPosition Vector2
---@field public touchCount Int32
---@field public keyboard IKeyboard
---@field public activeCursor string
local Stage={ }
---@public
---@param value Action
---@return void
function Stage:add_beforeUpdate(value) end
---@public
---@param value Action
---@return void
function Stage:remove_beforeUpdate(value) end
---@public
---@param value Action
---@return void
function Stage:add_afterUpdate(value) end
---@public
---@param value Action
---@return void
function Stage:remove_afterUpdate(value) end
---@public
---@return void
function Stage.Instantiate() end
---@public
---@return void
function Stage:Dispose() end
---@public
---@param newFocus DisplayObject
---@param byKey bool
---@return void
function Stage:SetFous(newFocus, byKey) end
---@public
---@param backward bool
---@return void
function Stage:DoKeyNavigate(backward) end
---@public
---@param touchId Int32
---@return Vector2
function Stage:GetTouchPosition(touchId) end
---@public
---@param result Int32[]
---@return Int32[]
function Stage:GetAllTouch(result) end
---@public
---@return void
function Stage:ResetInputState() end
---@public
---@param touchId Int32
---@return void
function Stage:CancelClick(touchId) end
---@public
---@return void
function Stage:EnableSound() end
---@public
---@return void
function Stage:DisableSound() end
---@public
---@param clip AudioClip
---@param volumeScale Single
---@return void
function Stage:PlayOneShotSound(clip, volumeScale) end
---@public
---@param clip AudioClip
---@return void
function Stage:PlayOneShotSound(clip) end
---@public
---@param text string
---@param autocorrection bool
---@param multiline bool
---@param secure bool
---@param alert bool
---@param textPlaceholder string
---@param keyboardType Int32
---@param hideInput bool
---@return void
function Stage:OpenKeyboard(text, autocorrection, multiline, secure, alert, textPlaceholder, keyboardType, hideInput) end
---@public
---@return void
function Stage:CloseKeyboard() end
---@public
---@param value string
---@return void
function Stage:InputString(value) end
---@public
---@param screenPos Vector2
---@param buttonDown bool
---@return void
function Stage:SetCustomInput(screenPos, buttonDown) end
---@public
---@param screenPos Vector2
---@param buttonDown bool
---@param buttonUp bool
---@return void
function Stage:SetCustomInput(screenPos, buttonDown, buttonUp) end
---@public
---@param hit RaycastHit&
---@param buttonDown bool
---@return void
function Stage:SetCustomInput(hit, buttonDown) end
---@public
---@param hit RaycastHit&
---@param buttonDown bool
---@param buttonUp bool
---@return void
function Stage:SetCustomInput(hit, buttonDown, buttonUp) end
---@public
---@return void
function Stage:ForceUpdate() end
---@public
---@param target Container
---@return void
function Stage:ApplyPanelOrder(target) end
---@public
---@param panelSortingOrder Int32
---@return void
function Stage:SortWorldSpacePanelsByZOrder(panelSortingOrder) end
---@public
---@param texture NTexture
---@return void
function Stage:MonitorTexture(texture) end
---@public
---@param touchId Int32
---@param target EventDispatcher
---@return void
function Stage:AddTouchMonitor(touchId, target) end
---@public
---@param target EventDispatcher
---@return void
function Stage:RemoveTouchMonitor(target) end
---@public
---@param target EventDispatcher
---@return bool
function Stage:IsTouchMonitoring(target) end
---@public
---@param cursorName string
---@param texture Texture2D
---@param hotspot Vector2
---@return void
function Stage:RegisterCursor(cursorName, texture, hotspot) end
FairyGUI.Stage = Stage