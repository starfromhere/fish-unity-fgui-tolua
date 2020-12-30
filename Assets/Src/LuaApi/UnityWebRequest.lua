---@class UnityWebRequest : Object
---@field public kHttpVerbGET string
---@field public kHttpVerbHEAD string
---@field public kHttpVerbPOST string
---@field public kHttpVerbPUT string
---@field public kHttpVerbCREATE string
---@field public kHttpVerbDELETE string
---@field public disposeCertificateHandlerOnDispose bool
---@field public disposeDownloadHandlerOnDispose bool
---@field public disposeUploadHandlerOnDispose bool
---@field public method string
---@field public error string
---@field public useHttpContinue bool
---@field public url string
---@field public uri Uri
---@field public responseCode Int64
---@field public uploadProgress Single
---@field public isModifiable bool
---@field public isDone bool
---@field public isNetworkError bool
---@field public isHttpError bool
---@field public downloadProgress Single
---@field public uploadedBytes UInt64
---@field public downloadedBytes UInt64
---@field public redirectLimit Int32
---@field public chunkedTransfer bool
---@field public uploadHandler UploadHandler
---@field public downloadHandler DownloadHandler
---@field public certificateHandler CertificateHandler
---@field public timeout Int32
---@field public isError bool
local UnityWebRequest={ }
---@public
---@return void
function UnityWebRequest.ClearCookieCache() end
---@public
---@param uri Uri
---@return void
function UnityWebRequest.ClearCookieCache(uri) end
---@public
---@return void
function UnityWebRequest:Dispose() end
---@public
---@return AsyncOperation
function UnityWebRequest:Send() end
---@public
---@return UnityWebRequestAsyncOperation
function UnityWebRequest:SendWebRequest() end
---@public
---@return void
function UnityWebRequest:Abort() end
---@public
---@param name string
---@return string
function UnityWebRequest:GetRequestHeader(name) end
---@public
---@param name string
---@param value string
---@return void
function UnityWebRequest:SetRequestHeader(name, value) end
---@public
---@param name string
---@return string
function UnityWebRequest:GetResponseHeader(name) end
---@public
---@return Dictionary`2
function UnityWebRequest:GetResponseHeaders() end
---@public
---@param uri string
---@return UnityWebRequest
function UnityWebRequest.Get(uri) end
---@public
---@param uri Uri
---@return UnityWebRequest
function UnityWebRequest.Get(uri) end
---@public
---@param uri string
---@return UnityWebRequest
function UnityWebRequest.Delete(uri) end
---@public
---@param uri Uri
---@return UnityWebRequest
function UnityWebRequest.Delete(uri) end
---@public
---@param uri string
---@return UnityWebRequest
function UnityWebRequest.Head(uri) end
---@public
---@param uri Uri
---@return UnityWebRequest
function UnityWebRequest.Head(uri) end
---@public
---@param uri string
---@return UnityWebRequest
function UnityWebRequest.GetTexture(uri) end
---@public
---@param uri string
---@param nonReadable bool
---@return UnityWebRequest
function UnityWebRequest.GetTexture(uri, nonReadable) end
---@public
---@param uri string
---@param audioType number
---@return UnityWebRequest
function UnityWebRequest.GetAudioClip(uri, audioType) end
---@public
---@param uri string
---@return UnityWebRequest
function UnityWebRequest.GetAssetBundle(uri) end
---@public
---@param uri string
---@param crc UInt32
---@return UnityWebRequest
function UnityWebRequest.GetAssetBundle(uri, crc) end
---@public
---@param uri string
---@param version UInt32
---@param crc UInt32
---@return UnityWebRequest
function UnityWebRequest.GetAssetBundle(uri, version, crc) end
---@public
---@param uri string
---@param hash Hash128
---@param crc UInt32
---@return UnityWebRequest
function UnityWebRequest.GetAssetBundle(uri, hash, crc) end
---@public
---@param uri string
---@param cachedAssetBundle CachedAssetBundle
---@param crc UInt32
---@return UnityWebRequest
function UnityWebRequest.GetAssetBundle(uri, cachedAssetBundle, crc) end
---@public
---@param uri string
---@param bodyData Byte[]
---@return UnityWebRequest
function UnityWebRequest.Put(uri, bodyData) end
---@public
---@param uri Uri
---@param bodyData Byte[]
---@return UnityWebRequest
function UnityWebRequest.Put(uri, bodyData) end
---@public
---@param uri string
---@param bodyData string
---@return UnityWebRequest
function UnityWebRequest.Put(uri, bodyData) end
---@public
---@param uri Uri
---@param bodyData string
---@return UnityWebRequest
function UnityWebRequest.Put(uri, bodyData) end
---@public
---@param uri string
---@param postData string
---@return UnityWebRequest
function UnityWebRequest.Post(uri, postData) end
---@public
---@param uri Uri
---@param postData string
---@return UnityWebRequest
function UnityWebRequest.Post(uri, postData) end
---@public
---@param uri string
---@param formData WWWForm
---@return UnityWebRequest
function UnityWebRequest.Post(uri, formData) end
---@public
---@param uri Uri
---@param formData WWWForm
---@return UnityWebRequest
function UnityWebRequest.Post(uri, formData) end
---@public
---@param uri string
---@param multipartFormSections List`1
---@return UnityWebRequest
function UnityWebRequest.Post(uri, multipartFormSections) end
---@public
---@param uri Uri
---@param multipartFormSections List`1
---@return UnityWebRequest
function UnityWebRequest.Post(uri, multipartFormSections) end
---@public
---@param uri string
---@param multipartFormSections List`1
---@param boundary Byte[]
---@return UnityWebRequest
function UnityWebRequest.Post(uri, multipartFormSections, boundary) end
---@public
---@param uri Uri
---@param multipartFormSections List`1
---@param boundary Byte[]
---@return UnityWebRequest
function UnityWebRequest.Post(uri, multipartFormSections, boundary) end
---@public
---@param uri string
---@param formFields Dictionary`2
---@return UnityWebRequest
function UnityWebRequest.Post(uri, formFields) end
---@public
---@param uri Uri
---@param formFields Dictionary`2
---@return UnityWebRequest
function UnityWebRequest.Post(uri, formFields) end
---@public
---@param s string
---@return string
function UnityWebRequest.EscapeURL(s) end
---@public
---@param s string
---@param e Encoding
---@return string
function UnityWebRequest.EscapeURL(s, e) end
---@public
---@param s string
---@return string
function UnityWebRequest.UnEscapeURL(s) end
---@public
---@param s string
---@param e Encoding
---@return string
function UnityWebRequest.UnEscapeURL(s, e) end
---@public
---@param multipartFormSections List`1
---@param boundary Byte[]
---@return Byte[]
function UnityWebRequest.SerializeFormSections(multipartFormSections, boundary) end
---@public
---@return Byte[]
function UnityWebRequest.GenerateBoundary() end
---@public
---@param formFields Dictionary`2
---@return Byte[]
function UnityWebRequest.SerializeSimpleForm(formFields) end
UnityEngine.Networking.UnityWebRequest = UnityWebRequest