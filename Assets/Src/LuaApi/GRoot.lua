---@class GRoot : GComponent
---@field public contentScaleFactor Single
---@field public contentScaleLevel Int32
---@field public inst GRoot
---@field public modalLayer GGraph
---@field public hasModalWindow bool
---@field public modalWaiting bool
---@field public touchTarget GObject
---@field public hasAnyPopup bool
---@field public focus GObject
---@field public soundVolume Single
local GRoot={ }
---@public
---@return void
function GRoot:Dispose() end
---@public
---@param designResolutionX Int32
---@param designResolutionY Int32
---@return void
function GRoot:SetContentScaleFactor(designResolutionX, designResolutionY) end
---@public
---@param designResolutionX Int32
---@param designResolutionY Int32
---@param screenMatchMode number
---@return void
function GRoot:SetContentScaleFactor(designResolutionX, designResolutionY, screenMatchMode) end
---@public
---@param constantScaleFactor Single
---@return void
function GRoot:SetContentScaleFactor(constantScaleFactor) end
---@public
---@return void
function GRoot:ApplyContentScaleFactor() end
---@public
---@param win Window
---@return void
function GRoot:ShowWindow(win) end
---@public
---@param win Window
---@return void
function GRoot:HideWindow(win) end
---@public
---@param win Window
---@return void
function GRoot:HideWindowImmediately(win) end
---@public
---@param win Window
---@param dispose bool
---@return void
function GRoot:HideWindowImmediately(win, dispose) end
---@public
---@param win Window
---@return void
function GRoot:BringToFront(win) end
---@public
---@return void
function GRoot:ShowModalWait() end
---@public
---@return void
function GRoot:CloseModalWait() end
---@public
---@return void
function GRoot:CloseAllExceptModals() end
---@public
---@return void
function GRoot:CloseAllWindows() end
---@public
---@return Window
function GRoot:GetTopWindow() end
---@public
---@param obj DisplayObject
---@return GObject
function GRoot:DisplayObjectToGObject(obj) end
---@public
---@param popup GObject
---@return void
function GRoot:ShowPopup(popup) end
---@public
---@param popup GObject
---@param target GObject
---@return void
function GRoot:ShowPopup(popup, target) end
---@public
---@param popup GObject
---@param target GObject
---@param downward Object
---@return void
function GRoot:ShowPopup(popup, target, downward) end
---@public
---@param popup GObject
---@param target GObject
---@param dir number
---@return void
function GRoot:ShowPopup(popup, target, dir) end
---@public
---@param popup GObject
---@param target GObject
---@param dir number
---@param closeUntilUpEvent bool
---@return void
function GRoot:ShowPopup(popup, target, dir, closeUntilUpEvent) end
---@public
---@param popup GObject
---@param target GObject
---@param downward Object
---@return Vector2
function GRoot:GetPoupPosition(popup, target, downward) end
---@public
---@param popup GObject
---@param target GObject
---@param dir number
---@return Vector2
function GRoot:GetPoupPosition(popup, target, dir) end
---@public
---@param popup GObject
---@return void
function GRoot:TogglePopup(popup) end
---@public
---@param popup GObject
---@param target GObject
---@return void
function GRoot:TogglePopup(popup, target) end
---@public
---@param popup GObject
---@param target GObject
---@param downward Object
---@return void
function GRoot:TogglePopup(popup, target, downward) end
---@public
---@param popup GObject
---@param target GObject
---@param dir number
---@return void
function GRoot:TogglePopup(popup, target, dir) end
---@public
---@param popup GObject
---@param target GObject
---@param dir number
---@param closeUntilUpEvent bool
---@return void
function GRoot:TogglePopup(popup, target, dir, closeUntilUpEvent) end
---@public
---@return void
function GRoot:HidePopup() end
---@public
---@param popup GObject
---@return void
function GRoot:HidePopup(popup) end
---@public
---@param msg string
---@return void
function GRoot:ShowTooltips(msg) end
---@public
---@param msg string
---@param delay Single
---@return void
function GRoot:ShowTooltips(msg, delay) end
---@public
---@param tooltipWin GObject
---@return void
function GRoot:ShowTooltipsWin(tooltipWin) end
---@public
---@param tooltipWin GObject
---@param delay Single
---@return void
function GRoot:ShowTooltipsWin(tooltipWin, delay) end
---@public
---@return void
function GRoot:HideTooltips() end
---@public
---@return void
function GRoot:EnableSound() end
---@public
---@return void
function GRoot:DisableSound() end
---@public
---@param clip AudioClip
---@param volumeScale Single
---@return void
function GRoot:PlayOneShotSound(clip, volumeScale) end
---@public
---@param clip AudioClip
---@return void
function GRoot:PlayOneShotSound(clip) end
FairyGUI.GRoot = GRoot