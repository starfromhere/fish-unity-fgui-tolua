---@class Rigidbody : Component
---@field public velocity Vector3
---@field public angularVelocity Vector3
---@field public drag Single
---@field public angularDrag Single
---@field public mass Single
---@field public useGravity bool
---@field public maxDepenetrationVelocity Single
---@field public isKinematic bool
---@field public freezeRotation bool
---@field public constraints number
---@field public collisionDetectionMode number
---@field public centerOfMass Vector3
---@field public worldCenterOfMass Vector3
---@field public inertiaTensorRotation Quaternion
---@field public inertiaTensor Vector3
---@field public detectCollisions bool
---@field public position Vector3
---@field public rotation Quaternion
---@field public interpolation number
---@field public solverIterations Int32
---@field public sleepThreshold Single
---@field public maxAngularVelocity Single
---@field public solverVelocityIterations Int32
---@field public sleepVelocity Single
---@field public sleepAngularVelocity Single
---@field public useConeFriction bool
---@field public solverIterationCount Int32
---@field public solverVelocityIterationCount Int32
local Rigidbody={ }
---@public
---@param density Single
---@return void
function Rigidbody:SetDensity(density) end
---@public
---@param position Vector3
---@return void
function Rigidbody:MovePosition(position) end
---@public
---@param rot Quaternion
---@return void
function Rigidbody:MoveRotation(rot) end
---@public
---@return void
function Rigidbody:Sleep() end
---@public
---@return bool
function Rigidbody:IsSleeping() end
---@public
---@return void
function Rigidbody:WakeUp() end
---@public
---@return void
function Rigidbody:ResetCenterOfMass() end
---@public
---@return void
function Rigidbody:ResetInertiaTensor() end
---@public
---@param relativePoint Vector3
---@return Vector3
function Rigidbody:GetRelativePointVelocity(relativePoint) end
---@public
---@param worldPoint Vector3
---@return Vector3
function Rigidbody:GetPointVelocity(worldPoint) end
---@public
---@param a Single
---@return void
function Rigidbody:SetMaxAngularVelocity(a) end
---@public
---@param force Vector3
---@param mode number
---@return void
function Rigidbody:AddForce(force, mode) end
---@public
---@param force Vector3
---@return void
function Rigidbody:AddForce(force) end
---@public
---@param x Single
---@param y Single
---@param z Single
---@param mode number
---@return void
function Rigidbody:AddForce(x, y, z, mode) end
---@public
---@param x Single
---@param y Single
---@param z Single
---@return void
function Rigidbody:AddForce(x, y, z) end
---@public
---@param force Vector3
---@param mode number
---@return void
function Rigidbody:AddRelativeForce(force, mode) end
---@public
---@param force Vector3
---@return void
function Rigidbody:AddRelativeForce(force) end
---@public
---@param x Single
---@param y Single
---@param z Single
---@param mode number
---@return void
function Rigidbody:AddRelativeForce(x, y, z, mode) end
---@public
---@param x Single
---@param y Single
---@param z Single
---@return void
function Rigidbody:AddRelativeForce(x, y, z) end
---@public
---@param torque Vector3
---@param mode number
---@return void
function Rigidbody:AddTorque(torque, mode) end
---@public
---@param torque Vector3
---@return void
function Rigidbody:AddTorque(torque) end
---@public
---@param x Single
---@param y Single
---@param z Single
---@param mode number
---@return void
function Rigidbody:AddTorque(x, y, z, mode) end
---@public
---@param x Single
---@param y Single
---@param z Single
---@return void
function Rigidbody:AddTorque(x, y, z) end
---@public
---@param torque Vector3
---@param mode number
---@return void
function Rigidbody:AddRelativeTorque(torque, mode) end
---@public
---@param torque Vector3
---@return void
function Rigidbody:AddRelativeTorque(torque) end
---@public
---@param x Single
---@param y Single
---@param z Single
---@param mode number
---@return void
function Rigidbody:AddRelativeTorque(x, y, z, mode) end
---@public
---@param x Single
---@param y Single
---@param z Single
---@return void
function Rigidbody:AddRelativeTorque(x, y, z) end
---@public
---@param force Vector3
---@param position Vector3
---@param mode number
---@return void
function Rigidbody:AddForceAtPosition(force, position, mode) end
---@public
---@param force Vector3
---@param position Vector3
---@return void
function Rigidbody:AddForceAtPosition(force, position) end
---@public
---@param explosionForce Single
---@param explosionPosition Vector3
---@param explosionRadius Single
---@param upwardsModifier Single
---@param mode number
---@return void
function Rigidbody:AddExplosionForce(explosionForce, explosionPosition, explosionRadius, upwardsModifier, mode) end
---@public
---@param explosionForce Single
---@param explosionPosition Vector3
---@param explosionRadius Single
---@param upwardsModifier Single
---@return void
function Rigidbody:AddExplosionForce(explosionForce, explosionPosition, explosionRadius, upwardsModifier) end
---@public
---@param explosionForce Single
---@param explosionPosition Vector3
---@param explosionRadius Single
---@return void
function Rigidbody:AddExplosionForce(explosionForce, explosionPosition, explosionRadius) end
---@public
---@param position Vector3
---@return Vector3
function Rigidbody:ClosestPointOnBounds(position) end
---@public
---@param direction Vector3
---@param hitInfo RaycastHit&
---@param maxDistance Single
---@param queryTriggerInteraction number
---@return bool
function Rigidbody:SweepTest(direction, hitInfo, maxDistance, queryTriggerInteraction) end
---@public
---@param direction Vector3
---@param hitInfo RaycastHit&
---@param maxDistance Single
---@return bool
function Rigidbody:SweepTest(direction, hitInfo, maxDistance) end
---@public
---@param direction Vector3
---@param hitInfo RaycastHit&
---@return bool
function Rigidbody:SweepTest(direction, hitInfo) end
---@public
---@param direction Vector3
---@param maxDistance Single
---@param queryTriggerInteraction number
---@return RaycastHit[]
function Rigidbody:SweepTestAll(direction, maxDistance, queryTriggerInteraction) end
---@public
---@param direction Vector3
---@param maxDistance Single
---@return RaycastHit[]
function Rigidbody:SweepTestAll(direction, maxDistance) end
---@public
---@param direction Vector3
---@return RaycastHit[]
function Rigidbody:SweepTestAll(direction) end
UnityEngine.Rigidbody = Rigidbody