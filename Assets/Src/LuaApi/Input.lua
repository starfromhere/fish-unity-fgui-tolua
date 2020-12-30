---@class Input : Object
---@field public simulateMouseWithTouches bool
---@field public anyKey bool
---@field public anyKeyDown bool
---@field public inputString string
---@field public mousePosition Vector3
---@field public mouseScrollDelta Vector2
---@field public imeCompositionMode number
---@field public compositionString string
---@field public imeIsSelected bool
---@field public compositionCursorPos Vector2
---@field public eatKeyPressOnTextFieldFocus bool
---@field public mousePresent bool
---@field public touchCount Int32
---@field public touchPressureSupported bool
---@field public stylusTouchSupported bool
---@field public touchSupported bool
---@field public multiTouchEnabled bool
---@field public isGyroAvailable bool
---@field public deviceOrientation number
---@field public acceleration Vector3
---@field public compensateSensors bool
---@field public accelerationEventCount Int32
---@field public backButtonLeavesApp bool
---@field public location LocationService
---@field public compass Compass
---@field public gyro Gyroscope
---@field public touches Touch[]
---@field public accelerationEvents AccelerationEvent[]
local Input={ }
---@public
---@param axisName string
---@return Single
function Input.GetAxis(axisName) end
---@public
---@param axisName string
---@return Single
function Input.GetAxisRaw(axisName) end
---@public
---@param buttonName string
---@return bool
function Input.GetButton(buttonName) end
---@public
---@param buttonName string
---@return bool
function Input.GetButtonDown(buttonName) end
---@public
---@param buttonName string
---@return bool
function Input.GetButtonUp(buttonName) end
---@public
---@param button Int32
---@return bool
function Input.GetMouseButton(button) end
---@public
---@param button Int32
---@return bool
function Input.GetMouseButtonDown(button) end
---@public
---@param button Int32
---@return bool
function Input.GetMouseButtonUp(button) end
---@public
---@return void
function Input.ResetInputAxes() end
---@public
---@param joystickName string
---@return bool
function Input.IsJoystickPreconfigured(joystickName) end
---@public
---@return String[]
function Input.GetJoystickNames() end
---@public
---@param index Int32
---@return Touch
function Input.GetTouch(index) end
---@public
---@param index Int32
---@return AccelerationEvent
function Input.GetAccelerationEvent(index) end
---@public
---@param key number
---@return bool
function Input.GetKey(key) end
---@public
---@param name string
---@return bool
function Input.GetKey(name) end
---@public
---@param key number
---@return bool
function Input.GetKeyUp(key) end
---@public
---@param name string
---@return bool
function Input.GetKeyUp(name) end
---@public
---@param key number
---@return bool
function Input.GetKeyDown(key) end
---@public
---@param name string
---@return bool
function Input.GetKeyDown(name) end
UnityEngine.Input = Input