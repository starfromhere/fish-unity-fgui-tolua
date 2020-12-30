---@class Camera : Behaviour
---@field public onPreCull CameraCallback
---@field public onPreRender CameraCallback
---@field public onPostRender CameraCallback
---@field public nearClipPlane Single
---@field public farClipPlane Single
---@field public fieldOfView Single
---@field public renderingPath number
---@field public actualRenderingPath number
---@field public allowHDR bool
---@field public allowMSAA bool
---@field public allowDynamicResolution bool
---@field public forceIntoRenderTexture bool
---@field public orthographicSize Single
---@field public orthographic bool
---@field public opaqueSortMode number
---@field public transparencySortMode number
---@field public transparencySortAxis Vector3
---@field public depth Single
---@field public aspect Single
---@field public velocity Vector3
---@field public cullingMask Int32
---@field public eventMask Int32
---@field public layerCullSpherical bool
---@field public cameraType number
---@field public overrideSceneCullingMask UInt64
---@field public layerCullDistances Single[]
---@field public useOcclusionCulling bool
---@field public cullingMatrix Matrix4x4
---@field public backgroundColor Color
---@field public clearFlags number
---@field public depthTextureMode number
---@field public clearStencilAfterLightingPass bool
---@field public usePhysicalProperties bool
---@field public sensorSize Vector2
---@field public lensShift Vector2
---@field public focalLength Single
---@field public gateFit number
---@field public rect Rect
---@field public pixelRect Rect
---@field public pixelWidth Int32
---@field public pixelHeight Int32
---@field public scaledPixelWidth Int32
---@field public scaledPixelHeight Int32
---@field public targetTexture RenderTexture
---@field public activeTexture RenderTexture
---@field public targetDisplay Int32
---@field public cameraToWorldMatrix Matrix4x4
---@field public worldToCameraMatrix Matrix4x4
---@field public projectionMatrix Matrix4x4
---@field public nonJitteredProjectionMatrix Matrix4x4
---@field public useJitteredProjectionMatrixForTransparentRendering bool
---@field public previousViewProjectionMatrix Matrix4x4
---@field public main Camera
---@field public current Camera
---@field public scene Scene
---@field public stereoEnabled bool
---@field public stereoSeparation Single
---@field public stereoConvergence Single
---@field public areVRStereoViewMatricesWithinSingleCullTolerance bool
---@field public stereoTargetEye number
---@field public stereoActiveEye number
---@field public allCamerasCount Int32
---@field public allCameras Camera[]
---@field public commandBufferCount Int32
---@field public isOrthoGraphic bool
---@field public mainCamera Camera
---@field public near Single
---@field public far Single
---@field public fov Single
---@field public hdr bool
---@field public stereoMirrorMode bool
local Camera={ }
---@public
---@return void
function Camera:Reset() end
---@public
---@return void
function Camera:ResetTransparencySortSettings() end
---@public
---@return void
function Camera:ResetAspect() end
---@public
---@return void
function Camera:ResetCullingMatrix() end
---@public
---@param shader Shader
---@param replacementTag string
---@return void
function Camera:SetReplacementShader(shader, replacementTag) end
---@public
---@return void
function Camera:ResetReplacementShader() end
---@public
---@return Single
function Camera:GetGateFittedFieldOfView() end
---@public
---@return Vector2
function Camera:GetGateFittedLensShift() end
---@public
---@param colorBuffer RenderBuffer
---@param depthBuffer RenderBuffer
---@return void
function Camera:SetTargetBuffers(colorBuffer, depthBuffer) end
---@public
---@param colorBuffer RenderBuffer[]
---@param depthBuffer RenderBuffer
---@return void
function Camera:SetTargetBuffers(colorBuffer, depthBuffer) end
---@public
---@return void
function Camera:ResetWorldToCameraMatrix() end
---@public
---@return void
function Camera:ResetProjectionMatrix() end
---@public
---@param clipPlane Vector4
---@return Matrix4x4
function Camera:CalculateObliqueMatrix(clipPlane) end
---@public
---@param position Vector3
---@param eye number
---@return Vector3
function Camera:WorldToScreenPoint(position, eye) end
---@public
---@param position Vector3
---@param eye number
---@return Vector3
function Camera:WorldToViewportPoint(position, eye) end
---@public
---@param position Vector3
---@param eye number
---@return Vector3
function Camera:ViewportToWorldPoint(position, eye) end
---@public
---@param position Vector3
---@param eye number
---@return Vector3
function Camera:ScreenToWorldPoint(position, eye) end
---@public
---@param position Vector3
---@return Vector3
function Camera:WorldToScreenPoint(position) end
---@public
---@param position Vector3
---@return Vector3
function Camera:WorldToViewportPoint(position) end
---@public
---@param position Vector3
---@return Vector3
function Camera:ViewportToWorldPoint(position) end
---@public
---@param position Vector3
---@return Vector3
function Camera:ScreenToWorldPoint(position) end
---@public
---@param position Vector3
---@return Vector3
function Camera:ScreenToViewportPoint(position) end
---@public
---@param position Vector3
---@return Vector3
function Camera:ViewportToScreenPoint(position) end
---@public
---@param pos Vector3
---@param eye number
---@return Ray
function Camera:ViewportPointToRay(pos, eye) end
---@public
---@param pos Vector3
---@return Ray
function Camera:ViewportPointToRay(pos) end
---@public
---@param pos Vector3
---@param eye number
---@return Ray
function Camera:ScreenPointToRay(pos, eye) end
---@public
---@param pos Vector3
---@return Ray
function Camera:ScreenPointToRay(pos) end
---@public
---@param viewport Rect
---@param z Single
---@param eye number
---@param outCorners Vector3[]
---@return void
function Camera:CalculateFrustumCorners(viewport, z, eye, outCorners) end
---@public
---@param output Matrix4x4&
---@param focalLength Single
---@param sensorSize Vector2
---@param lensShift Vector2
---@param nearClip Single
---@param farClip Single
---@param gateFitParameters GateFitParameters
---@return void
function Camera.CalculateProjectionMatrixFromPhysicalProperties(output, focalLength, sensorSize, lensShift, nearClip, farClip, gateFitParameters) end
---@public
---@param focalLength Single
---@param sensorSize Single
---@return Single
function Camera.FocalLengthToFieldOfView(focalLength, sensorSize) end
---@public
---@param fieldOfView Single
---@param sensorSize Single
---@return Single
function Camera.FieldOfViewToFocalLength(fieldOfView, sensorSize) end
---@public
---@param horizontalFieldOfView Single
---@param aspectRatio Single
---@return Single
function Camera.HorizontalToVerticalFieldOfView(horizontalFieldOfView, aspectRatio) end
---@public
---@param verticalFieldOfView Single
---@param aspectRatio Single
---@return Single
function Camera.VerticalToHorizontalFieldOfView(verticalFieldOfView, aspectRatio) end
---@public
---@param eye number
---@return Matrix4x4
function Camera:GetStereoNonJitteredProjectionMatrix(eye) end
---@public
---@param eye number
---@return Matrix4x4
function Camera:GetStereoViewMatrix(eye) end
---@public
---@param eye number
---@return void
function Camera:CopyStereoDeviceProjectionMatrixToNonJittered(eye) end
---@public
---@param eye number
---@return Matrix4x4
function Camera:GetStereoProjectionMatrix(eye) end
---@public
---@param eye number
---@param matrix Matrix4x4
---@return void
function Camera:SetStereoProjectionMatrix(eye, matrix) end
---@public
---@return void
function Camera:ResetStereoProjectionMatrices() end
---@public
---@param eye number
---@param matrix Matrix4x4
---@return void
function Camera:SetStereoViewMatrix(eye, matrix) end
---@public
---@return void
function Camera:ResetStereoViewMatrices() end
---@public
---@param cameras Camera[]
---@return Int32
function Camera.GetAllCameras(cameras) end
---@public
---@param cubemap Cubemap
---@param faceMask Int32
---@return bool
function Camera:RenderToCubemap(cubemap, faceMask) end
---@public
---@param cubemap Cubemap
---@return bool
function Camera:RenderToCubemap(cubemap) end
---@public
---@param cubemap RenderTexture
---@param faceMask Int32
---@return bool
function Camera:RenderToCubemap(cubemap, faceMask) end
---@public
---@param cubemap RenderTexture
---@return bool
function Camera:RenderToCubemap(cubemap) end
---@public
---@param cubemap RenderTexture
---@param faceMask Int32
---@param stereoEye number
---@return bool
function Camera:RenderToCubemap(cubemap, faceMask, stereoEye) end
---@public
---@return void
function Camera:Render() end
---@public
---@param shader Shader
---@param replacementTag string
---@return void
function Camera:RenderWithShader(shader, replacementTag) end
---@public
---@return void
function Camera:RenderDontRestore() end
---@public
---@param cur Camera
---@return void
function Camera.SetupCurrent(cur) end
---@public
---@param other Camera
---@return void
function Camera:CopyFrom(other) end
---@public
---@param evt number
---@return void
function Camera:RemoveCommandBuffers(evt) end
---@public
---@return void
function Camera:RemoveAllCommandBuffers() end
---@public
---@param evt number
---@param buffer CommandBuffer
---@return void
function Camera:AddCommandBuffer(evt, buffer) end
---@public
---@param evt number
---@param buffer CommandBuffer
---@param queueType number
---@return void
function Camera:AddCommandBufferAsync(evt, buffer, queueType) end
---@public
---@param evt number
---@param buffer CommandBuffer
---@return void
function Camera:RemoveCommandBuffer(evt, buffer) end
---@public
---@param evt number
---@return CommandBuffer[]
function Camera:GetCommandBuffers(evt) end
---@public
---@param cullingParameters ScriptableCullingParameters&
---@return bool
function Camera:TryGetCullingParameters(cullingParameters) end
---@public
---@param stereoAware bool
---@param cullingParameters ScriptableCullingParameters&
---@return bool
function Camera:TryGetCullingParameters(stereoAware, cullingParameters) end
---@public
---@return Single
function Camera:GetScreenWidth() end
---@public
---@return Single
function Camera:GetScreenHeight() end
---@public
---@return void
function Camera:DoClear() end
---@public
---@return void
function Camera:ResetFieldOfView() end
---@public
---@param leftMatrix Matrix4x4
---@param rightMatrix Matrix4x4
---@return void
function Camera:SetStereoViewMatrices(leftMatrix, rightMatrix) end
---@public
---@param leftMatrix Matrix4x4
---@param rightMatrix Matrix4x4
---@return void
function Camera:SetStereoProjectionMatrices(leftMatrix, rightMatrix) end
---@public
---@return Matrix4x4[]
function Camera:GetStereoViewMatrices() end
---@public
---@return Matrix4x4[]
function Camera:GetStereoProjectionMatrices() end
UnityEngine.Camera = Camera