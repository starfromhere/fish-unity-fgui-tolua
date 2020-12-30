---@class GButton : GComponent
---@field public sound NAudioClip
---@field public soundVolumeScale Single
---@field public changeStateOnClick bool
---@field public linkedPopup GObject
---@field public UP string
---@field public DOWN string
---@field public OVER string
---@field public SELECTED_OVER string
---@field public DISABLED string
---@field public SELECTED_DISABLED string
---@field public onChanged EventListener
---@field public icon string
---@field public title string
---@field public text string
---@field public selectedIcon string
---@field public selectedTitle string
---@field public titleColor Color
---@field public color Color
---@field public titleFontSize Int32
---@field public selected bool
---@field public mode number
---@field public relatedController Controller
---@field public relatedPageId string
local GButton={ }
---@public
---@param downEffect bool
---@param clickCall bool
---@return void
function GButton:FireClick(downEffect, clickCall) end
---@public
---@return GTextField
function GButton:GetTextField() end
---@public
---@param c Controller
---@return void
function GButton:HandleControllerChanged(c) end
---@public
---@param buffer ByteBuffer
---@param beginPos Int32
---@return void
function GButton:Setup_AfterAdd(buffer, beginPos) end
FairyGUI.GButton = GButton