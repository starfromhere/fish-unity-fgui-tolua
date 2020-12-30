---@class HTTPRequest : Object
---@field public EOL Byte[]
---@field public MethodNames String[]
---@field public UploadChunkSize Int32
---@field public OnUploadProgress OnUploadProgressDelegate
---@field public OnStreamingData OnStreamingDataDelegate
---@field public OnHeadersReceived Action`2
---@field public OnDownloadProgress OnDownloadProgressDelegate
---@field public OnUpgraded OnRequestFinishedDelegate
---@field public Uri Uri
---@field public MethodType number
---@field public RawData Byte[]
---@field public UploadStream Stream
---@field public DisposeUploadStream bool
---@field public UseUploadStreamLength bool
---@field public IsKeepAlive bool
---@field public DisableCache bool
---@field public CacheOnly bool
---@field public StreamFragmentSize Int32
---@field public StreamChunksImmediately bool
---@field public MaxFragmentQueueLength Int32
---@field public Callback OnRequestFinishedDelegate
---@field public ProcessingStarted DateTime
---@field public IsTimedOut bool
---@field public Retries Int32
---@field public MaxRetries Int32
---@field public IsCancellationRequested bool
---@field public IsRedirected bool
---@field public RedirectUri Uri
---@field public CurrentUri Uri
---@field public Response HTTPResponse
---@field public ProxyResponse HTTPResponse
---@field public Exception Exception
---@field public Tag Object
---@field public Credentials Credentials
---@field public HasProxy bool
---@field public Proxy Proxy
---@field public MaxRedirects Int32
---@field public UseAlternateSSL bool
---@field public IsCookiesEnabled bool
---@field public Cookies List`1
---@field public FormUsage number
---@field public State number
---@field public RedirectCount Int32
---@field public ConnectTimeout TimeSpan
---@field public Timeout TimeSpan
---@field public EnableTimoutForStreaming bool
---@field public EnableSafeReadOnUnknownContentLength bool
---@field public CustomCertificateVerifyer ICertificateVerifyer
---@field public CustomClientCredentialsProvider IClientCredentialsProvider
---@field public CustomTLSServerNameList List`1
---@field public ProtocolHandler number
---@field public Current Object
local HTTPRequest={ }
---@public
---@param value Func`4
---@return void
function HTTPRequest:add_CustomCertificationValidator(value) end
---@public
---@param value Func`4
---@return void
function HTTPRequest:remove_CustomCertificationValidator(value) end
---@public
---@param value OnBeforeRedirectionDelegate
---@return void
function HTTPRequest:add_OnBeforeRedirection(value) end
---@public
---@param value OnBeforeRedirectionDelegate
---@return void
function HTTPRequest:remove_OnBeforeRedirection(value) end
---@public
---@param value OnBeforeHeaderSendDelegate
---@return void
function HTTPRequest:add_OnBeforeHeaderSend(value) end
---@public
---@param value OnBeforeHeaderSendDelegate
---@return void
function HTTPRequest:remove_OnBeforeHeaderSend(value) end
---@public
---@param fieldName string
---@param value string
---@return void
function HTTPRequest:AddField(fieldName, value) end
---@public
---@param fieldName string
---@param value string
---@param e Encoding
---@return void
function HTTPRequest:AddField(fieldName, value, e) end
---@public
---@param fieldName string
---@param content Byte[]
---@return void
function HTTPRequest:AddBinaryData(fieldName, content) end
---@public
---@param fieldName string
---@param content Byte[]
---@param fileName string
---@return void
function HTTPRequest:AddBinaryData(fieldName, content, fileName) end
---@public
---@param fieldName string
---@param content Byte[]
---@param fileName string
---@param mimeType string
---@return void
function HTTPRequest:AddBinaryData(fieldName, content, fileName, mimeType) end
---@public
---@param form HTTPFormBase
---@return void
function HTTPRequest:SetForm(form) end
---@public
---@return List`1
function HTTPRequest:GetFormFields() end
---@public
---@return void
function HTTPRequest:ClearForm() end
---@public
---@param name string
---@param value string
---@return void
function HTTPRequest:AddHeader(name, value) end
---@public
---@param name string
---@param value string
---@return void
function HTTPRequest:SetHeader(name, value) end
---@public
---@param name string
---@return bool
function HTTPRequest:RemoveHeader(name) end
---@public
---@param name string
---@return bool
function HTTPRequest:HasHeader(name) end
---@public
---@param name string
---@return string
function HTTPRequest:GetFirstHeaderValue(name) end
---@public
---@param name string
---@return List`1
function HTTPRequest:GetHeaderValues(name) end
---@public
---@return void
function HTTPRequest:RemoveHeaders() end
---@public
---@param firstBytePos Int64
---@return void
function HTTPRequest:SetRangeHeader(firstBytePos) end
---@public
---@param firstBytePos Int64
---@param lastBytePos Int64
---@return void
function HTTPRequest:SetRangeHeader(firstBytePos, lastBytePos) end
---@public
---@param callback OnHeaderEnumerationDelegate
---@return void
function HTTPRequest:EnumerateHeaders(callback) end
---@public
---@param callback OnHeaderEnumerationDelegate
---@param callBeforeSendCallback bool
---@return void
function HTTPRequest:EnumerateHeaders(callback, callBeforeSendCallback) end
---@public
---@return string
function HTTPRequest:DumpHeaders() end
---@public
---@return Byte[]
function HTTPRequest:GetEntityBody() end
---@public
---@return HTTPRequest
function HTTPRequest:Send() end
---@public
---@return void
function HTTPRequest:Abort() end
---@public
---@return void
function HTTPRequest:Clear() end
---@public
---@return bool
function HTTPRequest:MoveNext() end
---@public
---@return void
function HTTPRequest:Reset() end
---@public
---@return void
function HTTPRequest:Dispose() end
BestHTTP.HTTPRequest = HTTPRequest