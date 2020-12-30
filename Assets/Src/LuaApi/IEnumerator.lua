---@class IEnumerator
---@field public Current Object
local IEnumerator={ }
---@public
---@return bool
function IEnumerator:MoveNext() end
---@public
---@return void
function IEnumerator:Reset() end
System.Collections.IEnumerator = IEnumerator