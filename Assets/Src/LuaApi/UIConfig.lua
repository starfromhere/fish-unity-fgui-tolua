---@class UIConfig : MonoBehaviour
---@field public defaultFont string
---@field public renderingTextBrighterOnDesktop bool
---@field public windowModalWaiting string
---@field public globalModalWaiting string
---@field public modalLayerColor Color
---@field public buttonSound NAudioClip
---@field public buttonSoundVolumeScale Single
---@field public horizontalScrollBar string
---@field public verticalScrollBar string
---@field public defaultScrollStep Single
---@field public defaultScrollDecelerationRate Single
---@field public defaultScrollBarDisplay number
---@field public defaultScrollTouchEffect bool
---@field public defaultScrollBounceEffect bool
---@field public popupMenu string
---@field public popupMenu_seperator string
---@field public loaderErrorSign string
---@field public tooltipsWin string
---@field public defaultComboBoxVisibleItemCount Int32
---@field public touchScrollSensitivity Int32
---@field public touchDragSensitivity Int32
---@field public clickDragSensitivity Int32
---@field public allowSoftnessOnTopOrLeftSide bool
---@field public bringWindowToFrontOnClick bool
---@field public inputCaretSize Single
---@field public inputHighlightColor Color
---@field public frameTimeForAsyncUIConstruction Single
---@field public depthSupportForPaintingMode bool
---@field public enhancedTextOutlineEffect bool
---@field public richTextRowVerticalAlign number
---@field public makePixelPerfect bool
---@field public Items List`1
---@field public PreloadPackages List`1
---@field public soundLoader SoundLoader
local UIConfig={ }
---@public
---@return void
function UIConfig:Load() end
---@public
---@param key number
---@param value ConfigValue
---@return void
function UIConfig.SetDefaultValue(key, value) end
---@public
---@return void
function UIConfig.ClearResourceRefs() end
---@public
---@return void
function UIConfig:ApplyModifiedProperties() end
FairyGUI.UIConfig = UIConfig