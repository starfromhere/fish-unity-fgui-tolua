---@class Uri : Object
---@field public UriSchemeFile string
---@field public UriSchemeFtp string
---@field public UriSchemeGopher string
---@field public UriSchemeHttp string
---@field public UriSchemeHttps string
---@field public UriSchemeMailto string
---@field public UriSchemeNews string
---@field public UriSchemeNntp string
---@field public UriSchemeNetTcp string
---@field public UriSchemeNetPipe string
---@field public SchemeDelimiter string
---@field public AbsolutePath string
---@field public AbsoluteUri string
---@field public LocalPath string
---@field public Authority string
---@field public HostNameType number
---@field public IsDefaultPort bool
---@field public IsFile bool
---@field public IsLoopback bool
---@field public PathAndQuery string
---@field public Segments String[]
---@field public IsUnc bool
---@field public Host string
---@field public Port Int32
---@field public Query string
---@field public Fragment string
---@field public Scheme string
---@field public OriginalString string
---@field public DnsSafeHost string
---@field public IdnHost string
---@field public IsAbsoluteUri bool
---@field public UserEscaped bool
---@field public UserInfo string
local Uri={ }
---@public
---@param name string
---@return number
function Uri.CheckHostName(name) end
---@public
---@param part number
---@return string
function Uri:GetLeftPart(part) end
---@public
---@param character Char
---@return string
function Uri.HexEscape(character) end
---@public
---@param pattern string
---@param index Int32&
---@return Char
function Uri.HexUnescape(pattern, index) end
---@public
---@param pattern string
---@param index Int32
---@return bool
function Uri.IsHexEncoding(pattern, index) end
---@public
---@param schemeName string
---@return bool
function Uri.CheckSchemeName(schemeName) end
---@public
---@param character Char
---@return bool
function Uri.IsHexDigit(character) end
---@public
---@param digit Char
---@return Int32
function Uri.FromHex(digit) end
---@public
---@return Int32
function Uri:GetHashCode() end
---@public
---@return string
function Uri:ToString() end
---@public
---@param uri1 Uri
---@param uri2 Uri
---@return bool
function Uri.op_Equality(uri1, uri2) end
---@public
---@param uri1 Uri
---@param uri2 Uri
---@return bool
function Uri.op_Inequality(uri1, uri2) end
---@public
---@param comparand Object
---@return bool
function Uri:Equals(comparand) end
---@public
---@param uri Uri
---@return Uri
function Uri:MakeRelativeUri(uri) end
---@public
---@param toUri Uri
---@return string
function Uri:MakeRelative(toUri) end
---@public
---@param uriString string
---@param uriKind number
---@param result Uri&
---@return bool
function Uri.TryCreate(uriString, uriKind, result) end
---@public
---@param baseUri Uri
---@param relativeUri string
---@param result Uri&
---@return bool
function Uri.TryCreate(baseUri, relativeUri, result) end
---@public
---@param baseUri Uri
---@param relativeUri Uri
---@param result Uri&
---@return bool
function Uri.TryCreate(baseUri, relativeUri, result) end
---@public
---@param components number
---@param format number
---@return string
function Uri:GetComponents(components, format) end
---@public
---@param uri1 Uri
---@param uri2 Uri
---@param partsToCompare number
---@param compareFormat number
---@param comparisonType number
---@return Int32
function Uri.Compare(uri1, uri2, partsToCompare, compareFormat, comparisonType) end
---@public
---@return bool
function Uri:IsWellFormedOriginalString() end
---@public
---@param uriString string
---@param uriKind number
---@return bool
function Uri.IsWellFormedUriString(uriString, uriKind) end
---@public
---@param stringToUnescape string
---@return string
function Uri.UnescapeDataString(stringToUnescape) end
---@public
---@param stringToEscape string
---@return string
function Uri.EscapeUriString(stringToEscape) end
---@public
---@param stringToEscape string
---@return string
function Uri.EscapeDataString(stringToEscape) end
---@public
---@param uri Uri
---@return bool
function Uri:IsBaseOf(uri) end
System.Uri = Uri