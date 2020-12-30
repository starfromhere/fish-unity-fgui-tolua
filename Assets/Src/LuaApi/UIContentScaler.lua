---@class UIContentScaler : MonoBehaviour
---@field public scaleMode number
---@field public screenMatchMode number
---@field public designResolutionX Int32
---@field public designResolutionY Int32
---@field public fallbackScreenDPI Int32
---@field public defaultSpriteDPI Int32
---@field public constantScaleFactor Single
---@field public ignoreOrientation bool
---@field public scaleFactor Single
---@field public scaleLevel Int32
local UIContentScaler={ }
---@public
---@return void
function UIContentScaler:ApplyModifiedProperties() end
---@public
---@return void
function UIContentScaler:ApplyChange() end
FairyGUI.UIContentScaler = UIContentScaler