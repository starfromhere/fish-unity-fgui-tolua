---@class Animator : Behaviour
---@field public isOptimizable bool
---@field public isHuman bool
---@field public hasRootMotion bool
---@field public humanScale Single
---@field public isInitialized bool
---@field public deltaPosition Vector3
---@field public deltaRotation Quaternion
---@field public velocity Vector3
---@field public angularVelocity Vector3
---@field public rootPosition Vector3
---@field public rootRotation Quaternion
---@field public applyRootMotion bool
---@field public linearVelocityBlending bool
---@field public animatePhysics bool
---@field public updateMode number
---@field public hasTransformHierarchy bool
---@field public gravityWeight Single
---@field public bodyPosition Vector3
---@field public bodyRotation Quaternion
---@field public stabilizeFeet bool
---@field public layerCount Int32
---@field public parameters AnimatorControllerParameter[]
---@field public parameterCount Int32
---@field public feetPivotActive Single
---@field public pivotWeight Single
---@field public pivotPosition Vector3
---@field public isMatchingTarget bool
---@field public speed Single
---@field public targetPosition Vector3
---@field public targetRotation Quaternion
---@field public cullingMode number
---@field public playbackTime Single
---@field public recorderStartTime Single
---@field public recorderStopTime Single
---@field public recorderMode number
---@field public runtimeAnimatorController RuntimeAnimatorController
---@field public hasBoundPlayables bool
---@field public avatar Avatar
---@field public playableGraph PlayableGraph
---@field public layersAffectMassCenter bool
---@field public leftFeetBottomHeight Single
---@field public rightFeetBottomHeight Single
---@field public logWarnings bool
---@field public fireEvents bool
---@field public keepAnimatorControllerStateOnDisable bool
local Animator={ }
---@public
---@param layerIndex Int32
---@return AnimationInfo[]
function Animator:GetCurrentAnimationClipState(layerIndex) end
---@public
---@param layerIndex Int32
---@return AnimationInfo[]
function Animator:GetNextAnimationClipState(layerIndex) end
---@public
---@return void
function Animator:Stop() end
---@public
---@param name string
---@return Single
function Animator:GetFloat(name) end
---@public
---@param id Int32
---@return Single
function Animator:GetFloat(id) end
---@public
---@param name string
---@param value Single
---@return void
function Animator:SetFloat(name, value) end
---@public
---@param name string
---@param value Single
---@param dampTime Single
---@param deltaTime Single
---@return void
function Animator:SetFloat(name, value, dampTime, deltaTime) end
---@public
---@param id Int32
---@param value Single
---@return void
function Animator:SetFloat(id, value) end
---@public
---@param id Int32
---@param value Single
---@param dampTime Single
---@param deltaTime Single
---@return void
function Animator:SetFloat(id, value, dampTime, deltaTime) end
---@public
---@param name string
---@return bool
function Animator:GetBool(name) end
---@public
---@param id Int32
---@return bool
function Animator:GetBool(id) end
---@public
---@param name string
---@param value bool
---@return void
function Animator:SetBool(name, value) end
---@public
---@param id Int32
---@param value bool
---@return void
function Animator:SetBool(id, value) end
---@public
---@param name string
---@return Int32
function Animator:GetInteger(name) end
---@public
---@param id Int32
---@return Int32
function Animator:GetInteger(id) end
---@public
---@param name string
---@param value Int32
---@return void
function Animator:SetInteger(name, value) end
---@public
---@param id Int32
---@param value Int32
---@return void
function Animator:SetInteger(id, value) end
---@public
---@param name string
---@return void
function Animator:SetTrigger(name) end
---@public
---@param id Int32
---@return void
function Animator:SetTrigger(id) end
---@public
---@param name string
---@return void
function Animator:ResetTrigger(name) end
---@public
---@param id Int32
---@return void
function Animator:ResetTrigger(id) end
---@public
---@param name string
---@return bool
function Animator:IsParameterControlledByCurve(name) end
---@public
---@param id Int32
---@return bool
function Animator:IsParameterControlledByCurve(id) end
---@public
---@param goal number
---@return Vector3
function Animator:GetIKPosition(goal) end
---@public
---@param goal number
---@param goalPosition Vector3
---@return void
function Animator:SetIKPosition(goal, goalPosition) end
---@public
---@param goal number
---@return Quaternion
function Animator:GetIKRotation(goal) end
---@public
---@param goal number
---@param goalRotation Quaternion
---@return void
function Animator:SetIKRotation(goal, goalRotation) end
---@public
---@param goal number
---@return Single
function Animator:GetIKPositionWeight(goal) end
---@public
---@param goal number
---@param value Single
---@return void
function Animator:SetIKPositionWeight(goal, value) end
---@public
---@param goal number
---@return Single
function Animator:GetIKRotationWeight(goal) end
---@public
---@param goal number
---@param value Single
---@return void
function Animator:SetIKRotationWeight(goal, value) end
---@public
---@param hint number
---@return Vector3
function Animator:GetIKHintPosition(hint) end
---@public
---@param hint number
---@param hintPosition Vector3
---@return void
function Animator:SetIKHintPosition(hint, hintPosition) end
---@public
---@param hint number
---@return Single
function Animator:GetIKHintPositionWeight(hint) end
---@public
---@param hint number
---@param value Single
---@return void
function Animator:SetIKHintPositionWeight(hint, value) end
---@public
---@param lookAtPosition Vector3
---@return void
function Animator:SetLookAtPosition(lookAtPosition) end
---@public
---@param weight Single
---@return void
function Animator:SetLookAtWeight(weight) end
---@public
---@param weight Single
---@param bodyWeight Single
---@return void
function Animator:SetLookAtWeight(weight, bodyWeight) end
---@public
---@param weight Single
---@param bodyWeight Single
---@param headWeight Single
---@return void
function Animator:SetLookAtWeight(weight, bodyWeight, headWeight) end
---@public
---@param weight Single
---@param bodyWeight Single
---@param headWeight Single
---@param eyesWeight Single
---@return void
function Animator:SetLookAtWeight(weight, bodyWeight, headWeight, eyesWeight) end
---@public
---@param weight Single
---@param bodyWeight Single
---@param headWeight Single
---@param eyesWeight Single
---@param clampWeight Single
---@return void
function Animator:SetLookAtWeight(weight, bodyWeight, headWeight, eyesWeight, clampWeight) end
---@public
---@param humanBoneId number
---@param rotation Quaternion
---@return void
function Animator:SetBoneLocalRotation(humanBoneId, rotation) end
---@public
---@param fullPathHash Int32
---@param layerIndex Int32
---@return StateMachineBehaviour[]
function Animator:GetBehaviours(fullPathHash, layerIndex) end
---@public
---@param layerIndex Int32
---@return string
function Animator:GetLayerName(layerIndex) end
---@public
---@param layerName string
---@return Int32
function Animator:GetLayerIndex(layerName) end
---@public
---@param layerIndex Int32
---@return Single
function Animator:GetLayerWeight(layerIndex) end
---@public
---@param layerIndex Int32
---@param weight Single
---@return void
function Animator:SetLayerWeight(layerIndex, weight) end
---@public
---@param layerIndex Int32
---@return AnimatorStateInfo
function Animator:GetCurrentAnimatorStateInfo(layerIndex) end
---@public
---@param layerIndex Int32
---@return AnimatorStateInfo
function Animator:GetNextAnimatorStateInfo(layerIndex) end
---@public
---@param layerIndex Int32
---@return AnimatorTransitionInfo
function Animator:GetAnimatorTransitionInfo(layerIndex) end
---@public
---@param layerIndex Int32
---@return Int32
function Animator:GetCurrentAnimatorClipInfoCount(layerIndex) end
---@public
---@param layerIndex Int32
---@return Int32
function Animator:GetNextAnimatorClipInfoCount(layerIndex) end
---@public
---@param layerIndex Int32
---@return AnimatorClipInfo[]
function Animator:GetCurrentAnimatorClipInfo(layerIndex) end
---@public
---@param layerIndex Int32
---@return AnimatorClipInfo[]
function Animator:GetNextAnimatorClipInfo(layerIndex) end
---@public
---@param layerIndex Int32
---@param clips List`1
---@return void
function Animator:GetCurrentAnimatorClipInfo(layerIndex, clips) end
---@public
---@param layerIndex Int32
---@param clips List`1
---@return void
function Animator:GetNextAnimatorClipInfo(layerIndex, clips) end
---@public
---@param layerIndex Int32
---@return bool
function Animator:IsInTransition(layerIndex) end
---@public
---@param index Int32
---@return AnimatorControllerParameter
function Animator:GetParameter(index) end
---@public
---@param matchPosition Vector3
---@param matchRotation Quaternion
---@param targetBodyPart number
---@param weightMask MatchTargetWeightMask
---@param startNormalizedTime Single
---@return void
function Animator:MatchTarget(matchPosition, matchRotation, targetBodyPart, weightMask, startNormalizedTime) end
---@public
---@param matchPosition Vector3
---@param matchRotation Quaternion
---@param targetBodyPart number
---@param weightMask MatchTargetWeightMask
---@param startNormalizedTime Single
---@param targetNormalizedTime Single
---@return void
function Animator:MatchTarget(matchPosition, matchRotation, targetBodyPart, weightMask, startNormalizedTime, targetNormalizedTime) end
---@public
---@return void
function Animator:InterruptMatchTarget() end
---@public
---@param completeMatch bool
---@return void
function Animator:InterruptMatchTarget(completeMatch) end
---@public
---@param normalizedTime Single
---@return void
function Animator:ForceStateNormalizedTime(normalizedTime) end
---@public
---@param stateName string
---@param fixedTransitionDuration Single
---@return void
function Animator:CrossFadeInFixedTime(stateName, fixedTransitionDuration) end
---@public
---@param stateName string
---@param fixedTransitionDuration Single
---@param layer Int32
---@return void
function Animator:CrossFadeInFixedTime(stateName, fixedTransitionDuration, layer) end
---@public
---@param stateName string
---@param fixedTransitionDuration Single
---@param layer Int32
---@param fixedTimeOffset Single
---@return void
function Animator:CrossFadeInFixedTime(stateName, fixedTransitionDuration, layer, fixedTimeOffset) end
---@public
---@param stateName string
---@param fixedTransitionDuration Single
---@param layer Int32
---@param fixedTimeOffset Single
---@param normalizedTransitionTime Single
---@return void
function Animator:CrossFadeInFixedTime(stateName, fixedTransitionDuration, layer, fixedTimeOffset, normalizedTransitionTime) end
---@public
---@param stateHashName Int32
---@param fixedTransitionDuration Single
---@param layer Int32
---@param fixedTimeOffset Single
---@return void
function Animator:CrossFadeInFixedTime(stateHashName, fixedTransitionDuration, layer, fixedTimeOffset) end
---@public
---@param stateHashName Int32
---@param fixedTransitionDuration Single
---@param layer Int32
---@return void
function Animator:CrossFadeInFixedTime(stateHashName, fixedTransitionDuration, layer) end
---@public
---@param stateHashName Int32
---@param fixedTransitionDuration Single
---@return void
function Animator:CrossFadeInFixedTime(stateHashName, fixedTransitionDuration) end
---@public
---@param stateHashName Int32
---@param fixedTransitionDuration Single
---@param layer Int32
---@param fixedTimeOffset Single
---@param normalizedTransitionTime Single
---@return void
function Animator:CrossFadeInFixedTime(stateHashName, fixedTransitionDuration, layer, fixedTimeOffset, normalizedTransitionTime) end
---@public
---@return void
function Animator:WriteDefaultValues() end
---@public
---@param stateName string
---@param normalizedTransitionDuration Single
---@param layer Int32
---@param normalizedTimeOffset Single
---@return void
function Animator:CrossFade(stateName, normalizedTransitionDuration, layer, normalizedTimeOffset) end
---@public
---@param stateName string
---@param normalizedTransitionDuration Single
---@param layer Int32
---@return void
function Animator:CrossFade(stateName, normalizedTransitionDuration, layer) end
---@public
---@param stateName string
---@param normalizedTransitionDuration Single
---@return void
function Animator:CrossFade(stateName, normalizedTransitionDuration) end
---@public
---@param stateName string
---@param normalizedTransitionDuration Single
---@param layer Int32
---@param normalizedTimeOffset Single
---@param normalizedTransitionTime Single
---@return void
function Animator:CrossFade(stateName, normalizedTransitionDuration, layer, normalizedTimeOffset, normalizedTransitionTime) end
---@public
---@param stateHashName Int32
---@param normalizedTransitionDuration Single
---@param layer Int32
---@param normalizedTimeOffset Single
---@param normalizedTransitionTime Single
---@return void
function Animator:CrossFade(stateHashName, normalizedTransitionDuration, layer, normalizedTimeOffset, normalizedTransitionTime) end
---@public
---@param stateHashName Int32
---@param normalizedTransitionDuration Single
---@param layer Int32
---@param normalizedTimeOffset Single
---@return void
function Animator:CrossFade(stateHashName, normalizedTransitionDuration, layer, normalizedTimeOffset) end
---@public
---@param stateHashName Int32
---@param normalizedTransitionDuration Single
---@param layer Int32
---@return void
function Animator:CrossFade(stateHashName, normalizedTransitionDuration, layer) end
---@public
---@param stateHashName Int32
---@param normalizedTransitionDuration Single
---@return void
function Animator:CrossFade(stateHashName, normalizedTransitionDuration) end
---@public
---@param stateName string
---@param layer Int32
---@return void
function Animator:PlayInFixedTime(stateName, layer) end
---@public
---@param stateName string
---@return void
function Animator:PlayInFixedTime(stateName) end
---@public
---@param stateName string
---@param layer Int32
---@param fixedTime Single
---@return void
function Animator:PlayInFixedTime(stateName, layer, fixedTime) end
---@public
---@param stateNameHash Int32
---@param layer Int32
---@param fixedTime Single
---@return void
function Animator:PlayInFixedTime(stateNameHash, layer, fixedTime) end
---@public
---@param stateNameHash Int32
---@param layer Int32
---@return void
function Animator:PlayInFixedTime(stateNameHash, layer) end
---@public
---@param stateNameHash Int32
---@return void
function Animator:PlayInFixedTime(stateNameHash) end
---@public
---@param stateName string
---@param layer Int32
---@return void
function Animator:Play(stateName, layer) end
---@public
---@param stateName string
---@return void
function Animator:Play(stateName) end
---@public
---@param stateName string
---@param layer Int32
---@param normalizedTime Single
---@return void
function Animator:Play(stateName, layer, normalizedTime) end
---@public
---@param stateNameHash Int32
---@param layer Int32
---@param normalizedTime Single
---@return void
function Animator:Play(stateNameHash, layer, normalizedTime) end
---@public
---@param stateNameHash Int32
---@param layer Int32
---@return void
function Animator:Play(stateNameHash, layer) end
---@public
---@param stateNameHash Int32
---@return void
function Animator:Play(stateNameHash) end
---@public
---@param targetIndex number
---@param targetNormalizedTime Single
---@return void
function Animator:SetTarget(targetIndex, targetNormalizedTime) end
---@public
---@param transform Transform
---@return bool
function Animator:IsControlled(transform) end
---@public
---@param humanBoneId number
---@return Transform
function Animator:GetBoneTransform(humanBoneId) end
---@public
---@return void
function Animator:StartPlayback() end
---@public
---@return void
function Animator:StopPlayback() end
---@public
---@param frameCount Int32
---@return void
function Animator:StartRecording(frameCount) end
---@public
---@return void
function Animator:StopRecording() end
---@public
---@param layerIndex Int32
---@param stateID Int32
---@return bool
function Animator:HasState(layerIndex, stateID) end
---@public
---@param name string
---@return Int32
function Animator.StringToHash(name) end
---@public
---@param deltaTime Single
---@return void
function Animator:Update(deltaTime) end
---@public
---@return void
function Animator:Rebind() end
---@public
---@return void
function Animator:ApplyBuiltinRootMotion() end
---@public
---@param name string
---@return Vector3
function Animator:GetVector(name) end
---@public
---@param id Int32
---@return Vector3
function Animator:GetVector(id) end
---@public
---@param name string
---@param value Vector3
---@return void
function Animator:SetVector(name, value) end
---@public
---@param id Int32
---@param value Vector3
---@return void
function Animator:SetVector(id, value) end
---@public
---@param name string
---@return Quaternion
function Animator:GetQuaternion(name) end
---@public
---@param id Int32
---@return Quaternion
function Animator:GetQuaternion(id) end
---@public
---@param name string
---@param value Quaternion
---@return void
function Animator:SetQuaternion(name, value) end
---@public
---@param id Int32
---@param value Quaternion
---@return void
function Animator:SetQuaternion(id, value) end
UnityEngine.Animator = Animator