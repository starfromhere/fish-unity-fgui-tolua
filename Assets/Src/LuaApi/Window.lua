---@class Window : GComponent
---@field public bringToFontOnClick bool
---@field public contentPane GComponent
---@field public frame GComponent
---@field public closeButton GObject
---@field public dragArea GObject
---@field public contentArea GObject
---@field public modalWaitingPane GObject
---@field public isShowing bool
---@field public isTop bool
---@field public modal bool
---@field public modalWaiting bool
local Window={ }
---@public
---@param source IUISource
---@return void
function Window:AddUISource(source) end
---@public
---@return void
function Window:Show() end
---@public
---@param r GRoot
---@return void
function Window:ShowOn(r) end
---@public
---@return void
function Window:Hide() end
---@public
---@return void
function Window:HideImmediately() end
---@public
---@param r GRoot
---@param restraint bool
---@return void
function Window:CenterOn(r, restraint) end
---@public
---@return void
function Window:ToggleStatus() end
---@public
---@return void
function Window:BringToFront() end
---@public
---@return void
function Window:ShowModalWait() end
---@public
---@param requestingCmd Int32
---@return void
function Window:ShowModalWait(requestingCmd) end
---@public
---@return bool
function Window:CloseModalWait() end
---@public
---@param requestingCmd Int32
---@return bool
function Window:CloseModalWait(requestingCmd) end
---@public
---@return void
function Window:Init() end
---@public
---@return void
function Window:Dispose() end
FairyGUI.Window = Window