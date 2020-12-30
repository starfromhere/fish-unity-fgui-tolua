---@class MarshalByRefObject : Object
local MarshalByRefObject={ }
---@public
---@param requestedType Type
---@return ObjRef
function MarshalByRefObject:CreateObjRef(requestedType) end
---@public
---@return Object
function MarshalByRefObject:GetLifetimeService() end
---@public
---@return Object
function MarshalByRefObject:InitializeLifetimeService() end
System.MarshalByRefObject = MarshalByRefObject