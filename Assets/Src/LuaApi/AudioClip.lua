---@class AudioClip : Object
---@field public length Single
---@field public samples Int32
---@field public channels Int32
---@field public frequency Int32
---@field public isReadyToPlay bool
---@field public loadType number
---@field public preloadAudioData bool
---@field public ambisonic bool
---@field public loadInBackground bool
---@field public loadState number
local AudioClip={ }
---@public
---@return bool
function AudioClip:LoadAudioData() end
---@public
---@return bool
function AudioClip:UnloadAudioData() end
---@public
---@param data Single[]
---@param offsetSamples Int32
---@return bool
function AudioClip:GetData(data, offsetSamples) end
---@public
---@param data Single[]
---@param offsetSamples Int32
---@return bool
function AudioClip:SetData(data, offsetSamples) end
---@public
---@param name string
---@param lengthSamples Int32
---@param channels Int32
---@param frequency Int32
---@param _3D bool
---@param stream bool
---@return AudioClip
function AudioClip.Create(name, lengthSamples, channels, frequency, _3D, stream) end
---@public
---@param name string
---@param lengthSamples Int32
---@param channels Int32
---@param frequency Int32
---@param _3D bool
---@param stream bool
---@param pcmreadercallback PCMReaderCallback
---@return AudioClip
function AudioClip.Create(name, lengthSamples, channels, frequency, _3D, stream, pcmreadercallback) end
---@public
---@param name string
---@param lengthSamples Int32
---@param channels Int32
---@param frequency Int32
---@param _3D bool
---@param stream bool
---@param pcmreadercallback PCMReaderCallback
---@param pcmsetpositioncallback PCMSetPositionCallback
---@return AudioClip
function AudioClip.Create(name, lengthSamples, channels, frequency, _3D, stream, pcmreadercallback, pcmsetpositioncallback) end
---@public
---@param name string
---@param lengthSamples Int32
---@param channels Int32
---@param frequency Int32
---@param stream bool
---@return AudioClip
function AudioClip.Create(name, lengthSamples, channels, frequency, stream) end
---@public
---@param name string
---@param lengthSamples Int32
---@param channels Int32
---@param frequency Int32
---@param stream bool
---@param pcmreadercallback PCMReaderCallback
---@return AudioClip
function AudioClip.Create(name, lengthSamples, channels, frequency, stream, pcmreadercallback) end
---@public
---@param name string
---@param lengthSamples Int32
---@param channels Int32
---@param frequency Int32
---@param stream bool
---@param pcmreadercallback PCMReaderCallback
---@param pcmsetpositioncallback PCMSetPositionCallback
---@return AudioClip
function AudioClip.Create(name, lengthSamples, channels, frequency, stream, pcmreadercallback, pcmsetpositioncallback) end
UnityEngine.AudioClip = AudioClip