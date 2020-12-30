---@class HTTPResponse : Object
---@field public MinBufferSize Int32
---@field public VersionMajor Int32
---@field public VersionMinor Int32
---@field public StatusCode Int32
---@field public IsSuccess bool
---@field public Message string
---@field public IsStreamed bool
---@field public IsFromCache bool
---@field public CacheFileInfo HTTPCacheFileInfo
---@field public IsCacheOnly bool
---@field public Headers Dictionary`2
---@field public Data Byte[]
---@field public IsUpgraded bool
---@field public Cookies List`1
---@field public DataAsText string
---@field public DataAsTexture2D Texture2D
---@field public IsClosedManually bool
local HTTPResponse={ }
---@public
---@param forceReadRawContentLength Int32
---@param readPayloadData bool
---@param sendUpgradedEvent bool
---@return bool
function HTTPResponse:Receive(forceReadRawContentLength, readPayloadData, sendUpgradedEvent) end
---@public
---@param name string
---@param value string
---@return void
function HTTPResponse:AddHeader(name, value) end
---@public
---@param name string
---@return List`1
function HTTPResponse:GetHeaderValues(name) end
---@public
---@param name string
---@return string
function HTTPResponse:GetFirstHeaderValue(name) end
---@public
---@param headerName string
---@param value string
---@return bool
function HTTPResponse:HasHeaderWithValue(headerName, value) end
---@public
---@param headerName string
---@return bool
function HTTPResponse:HasHeader(headerName) end
---@public
---@return HTTPRange
function HTTPResponse:GetRange() end
---@public
---@return void
function HTTPResponse:Dispose() end
BestHTTP.HTTPResponse = HTTPResponse