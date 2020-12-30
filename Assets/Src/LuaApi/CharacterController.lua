---@class CharacterController : Collider
---@field public velocity Vector3
---@field public isGrounded bool
---@field public collisionFlags number
---@field public radius Single
---@field public height Single
---@field public center Vector3
---@field public slopeLimit Single
---@field public stepOffset Single
---@field public skinWidth Single
---@field public minMoveDistance Single
---@field public detectCollisions bool
---@field public enableOverlapRecovery bool
local CharacterController={ }
---@public
---@param speed Vector3
---@return bool
function CharacterController:SimpleMove(speed) end
---@public
---@param motion Vector3
---@return number
function CharacterController:Move(motion) end
UnityEngine.CharacterController = CharacterController