---@class AudioSource : AudioBehaviour
---@field public panLevel Single
---@field public pan Single
---@field public volume Single
---@field public pitch Single
---@field public time Single
---@field public timeSamples Int32
---@field public clip AudioClip
---@field public outputAudioMixerGroup AudioMixerGroup
---@field public isPlaying bool
---@field public isVirtual bool
---@field public loop bool
---@field public ignoreListenerVolume bool
---@field public playOnAwake bool
---@field public ignoreListenerPause bool
---@field public velocityUpdateMode number
---@field public panStereo Single
---@field public spatialBlend Single
---@field public spatialize bool
---@field public spatializePostEffects bool
---@field public reverbZoneMix Single
---@field public bypassEffects bool
---@field public bypassListenerEffects bool
---@field public bypassReverbZones bool
---@field public dopplerLevel Single
---@field public spread Single
---@field public priority Int32
---@field public mute bool
---@field public minDistance Single
---@field public maxDistance Single
---@field public rolloffMode number
---@field public minVolume Single
---@field public maxVolume Single
---@field public rolloffFactor Single
local AudioSource={ }
---@public
---@return void
function AudioSource:Play() end
---@public
---@param delay UInt64
---@return void
function AudioSource:Play(delay) end
---@public
---@param delay Single
---@return void
function AudioSource:PlayDelayed(delay) end
---@public
---@param time number
---@return void
function AudioSource:PlayScheduled(time) end
---@public
---@param clip AudioClip
---@return void
function AudioSource:PlayOneShot(clip) end
---@public
---@param clip AudioClip
---@param volumeScale Single
---@return void
function AudioSource:PlayOneShot(clip, volumeScale) end
---@public
---@param time number
---@return void
function AudioSource:SetScheduledStartTime(time) end
---@public
---@param time number
---@return void
function AudioSource:SetScheduledEndTime(time) end
---@public
---@return void
function AudioSource:Stop() end
---@public
---@return void
function AudioSource:Pause() end
---@public
---@return void
function AudioSource:UnPause() end
---@public
---@param clip AudioClip
---@param position Vector3
---@return void
function AudioSource.PlayClipAtPoint(clip, position) end
---@public
---@param clip AudioClip
---@param position Vector3
---@param volume Single
---@return void
function AudioSource.PlayClipAtPoint(clip, position, volume) end
---@public
---@param type number
---@param curve AnimationCurve
---@return void
function AudioSource:SetCustomCurve(type, curve) end
---@public
---@param type number
---@return AnimationCurve
function AudioSource:GetCustomCurve(type) end
---@public
---@param numSamples Int32
---@param channel Int32
---@return Single[]
function AudioSource:GetOutputData(numSamples, channel) end
---@public
---@param samples Single[]
---@param channel Int32
---@return void
function AudioSource:GetOutputData(samples, channel) end
---@public
---@param numSamples Int32
---@param channel Int32
---@param window number
---@return Single[]
function AudioSource:GetSpectrumData(numSamples, channel, window) end
---@public
---@param samples Single[]
---@param channel Int32
---@param window number
---@return void
function AudioSource:GetSpectrumData(samples, channel, window) end
---@public
---@param index Int32
---@param value Single
---@return bool
function AudioSource:SetSpatializerFloat(index, value) end
---@public
---@param index Int32
---@param value Single&
---@return bool
function AudioSource:GetSpatializerFloat(index, value) end
---@public
---@param index Int32
---@param value Single&
---@return bool
function AudioSource:GetAmbisonicDecoderFloat(index, value) end
---@public
---@param index Int32
---@param value Single
---@return bool
function AudioSource:SetAmbisonicDecoderFloat(index, value) end
UnityEngine.AudioSource = AudioSource