---@class Tools : Object
---@field public timespace Int32
local Tools={ }
---@public
---@param bflag bool
---@return string
function Tools.GetTimeStamp(bflag) end
---@public
---@param bflag bool
---@return Int64
function Tools.GetTimeToday(bflag) end
---@public
---@return string
function Tools.GetTimeNow() end
---@public
---@return bool
function Tools.InEditor() end
---@public
---@return string
function Tools.GetPlatform() end
---@public
---@return string
function Tools.GetPrefix() end
---@public
---@param obj Object
---@return bool
function Tools.IsNull(obj) end
---@public
---@param assetPath string
---@return Object
function Tools.LoadAsset(assetPath) end
---@public
---@param r Int32
---@param g Int32
---@param b Int32
---@param a Int32
---@return ColorFilter
function Tools.GetColorFilter(r, g, b, a) end
---@public
---@return void
function Tools.shakePhone() end
---@public
---@param copyTxt string
---@return void
function Tools.CopyText(copyTxt) end
---@public
---@return string
function Tools.PasteText() end
---@public
---@param animator Animator
---@param clipName string
---@return Single
function Tools.GetClipLength(animator, clipName) end
---@public
---@param p ParticleSystem
---@return void
function Tools.PlayParticleEffect(p) end
Arthas.Tools = Tools