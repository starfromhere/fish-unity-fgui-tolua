---@class Relations : Object
---@field public handling GObject
---@field public isEmpty bool
local Relations={ }
---@public
---@param target GObject
---@param relationType number
---@return void
function Relations:Add(target, relationType) end
---@public
---@param target GObject
---@param relationType number
---@param usePercent bool
---@return void
function Relations:Add(target, relationType, usePercent) end
---@public
---@param target GObject
---@param relationType number
---@return void
function Relations:Remove(target, relationType) end
---@public
---@param target GObject
---@return bool
function Relations:Contains(target) end
---@public
---@param target GObject
---@return void
function Relations:ClearFor(target) end
---@public
---@return void
function Relations:ClearAll() end
---@public
---@param source Relations
---@return void
function Relations:CopyFrom(source) end
---@public
---@return void
function Relations:Dispose() end
---@public
---@param dWidth Single
---@param dHeight Single
---@param applyPivot bool
---@return void
function Relations:OnOwnerSizeChanged(dWidth, dHeight, applyPivot) end
---@public
---@param buffer ByteBuffer
---@param parentToChild bool
---@return void
function Relations:Setup(buffer, parentToChild) end
FairyGUI.Relations = Relations