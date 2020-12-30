---@class String : Object
---@field public Empty string
---@field public Chars Char
---@field public Length Int32
local String={ }
---@public
---@param separator string
---@param value String[]
---@return string
function String.Join(separator, value) end
---@public
---@param separator string
---@param values Object[]
---@return string
function String.Join(separator, values) end
---@public
---@param separator string
---@param values IEnumerable`1
---@return string
function String.Join(separator, values) end
---@public
---@param separator string
---@param value String[]
---@param startIndex Int32
---@param count Int32
---@return string
function String.Join(separator, value, startIndex, count) end
---@public
---@param obj Object
---@return bool
function String:Equals(obj) end
---@public
---@param value string
---@return bool
function String:Equals(value) end
---@public
---@param value string
---@param comparisonType number
---@return bool
function String:Equals(value, comparisonType) end
---@public
---@param a string
---@param b string
---@return bool
function String.Equals(a, b) end
---@public
---@param a string
---@param b string
---@param comparisonType number
---@return bool
function String.Equals(a, b, comparisonType) end
---@public
---@param a string
---@param b string
---@return bool
function String.op_Equality(a, b) end
---@public
---@param a string
---@param b string
---@return bool
function String.op_Inequality(a, b) end
---@public
---@param sourceIndex Int32
---@param destination Char[]
---@param destinationIndex Int32
---@param count Int32
---@return void
function String:CopyTo(sourceIndex, destination, destinationIndex, count) end
---@public
---@return Char[]
function String:ToCharArray() end
---@public
---@param startIndex Int32
---@param length Int32
---@return Char[]
function String:ToCharArray(startIndex, length) end
---@public
---@param value string
---@return bool
function String.IsNullOrEmpty(value) end
---@public
---@param value string
---@return bool
function String.IsNullOrWhiteSpace(value) end
---@public
---@return Int32
function String:GetHashCode() end
---@public
---@param separator Char[]
---@return String[]
function String:Split(separator) end
---@public
---@param separator Char[]
---@param count Int32
---@return String[]
function String:Split(separator, count) end
---@public
---@param separator Char[]
---@param options number
---@return String[]
function String:Split(separator, options) end
---@public
---@param separator Char[]
---@param count Int32
---@param options number
---@return String[]
function String:Split(separator, count, options) end
---@public
---@param separator String[]
---@param options number
---@return String[]
function String:Split(separator, options) end
---@public
---@param separator String[]
---@param count Int32
---@param options number
---@return String[]
function String:Split(separator, count, options) end
---@public
---@param startIndex Int32
---@return string
function String:Substring(startIndex) end
---@public
---@param startIndex Int32
---@param length Int32
---@return string
function String:Substring(startIndex, length) end
---@public
---@param trimChars Char[]
---@return string
function String:Trim(trimChars) end
---@public
---@param trimChars Char[]
---@return string
function String:TrimStart(trimChars) end
---@public
---@param trimChars Char[]
---@return string
function String:TrimEnd(trimChars) end
---@public
---@return bool
function String:IsNormalized() end
---@public
---@param normalizationForm number
---@return bool
function String:IsNormalized(normalizationForm) end
---@public
---@return string
function String:Normalize() end
---@public
---@param normalizationForm number
---@return string
function String:Normalize(normalizationForm) end
---@public
---@param strA string
---@param strB string
---@return Int32
function String.Compare(strA, strB) end
---@public
---@param strA string
---@param strB string
---@param ignoreCase bool
---@return Int32
function String.Compare(strA, strB, ignoreCase) end
---@public
---@param strA string
---@param strB string
---@param comparisonType number
---@return Int32
function String.Compare(strA, strB, comparisonType) end
---@public
---@param strA string
---@param strB string
---@param culture CultureInfo
---@param options number
---@return Int32
function String.Compare(strA, strB, culture, options) end
---@public
---@param strA string
---@param strB string
---@param ignoreCase bool
---@param culture CultureInfo
---@return Int32
function String.Compare(strA, strB, ignoreCase, culture) end
---@public
---@param strA string
---@param indexA Int32
---@param strB string
---@param indexB Int32
---@param length Int32
---@return Int32
function String.Compare(strA, indexA, strB, indexB, length) end
---@public
---@param strA string
---@param indexA Int32
---@param strB string
---@param indexB Int32
---@param length Int32
---@param ignoreCase bool
---@return Int32
function String.Compare(strA, indexA, strB, indexB, length, ignoreCase) end
---@public
---@param strA string
---@param indexA Int32
---@param strB string
---@param indexB Int32
---@param length Int32
---@param ignoreCase bool
---@param culture CultureInfo
---@return Int32
function String.Compare(strA, indexA, strB, indexB, length, ignoreCase, culture) end
---@public
---@param strA string
---@param indexA Int32
---@param strB string
---@param indexB Int32
---@param length Int32
---@param culture CultureInfo
---@param options number
---@return Int32
function String.Compare(strA, indexA, strB, indexB, length, culture, options) end
---@public
---@param strA string
---@param indexA Int32
---@param strB string
---@param indexB Int32
---@param length Int32
---@param comparisonType number
---@return Int32
function String.Compare(strA, indexA, strB, indexB, length, comparisonType) end
---@public
---@param value Object
---@return Int32
function String:CompareTo(value) end
---@public
---@param strB string
---@return Int32
function String:CompareTo(strB) end
---@public
---@param strA string
---@param strB string
---@return Int32
function String.CompareOrdinal(strA, strB) end
---@public
---@param strA string
---@param indexA Int32
---@param strB string
---@param indexB Int32
---@param length Int32
---@return Int32
function String.CompareOrdinal(strA, indexA, strB, indexB, length) end
---@public
---@param value string
---@return bool
function String:Contains(value) end
---@public
---@param value string
---@return bool
function String:EndsWith(value) end
---@public
---@param value string
---@param comparisonType number
---@return bool
function String:EndsWith(value, comparisonType) end
---@public
---@param value string
---@param ignoreCase bool
---@param culture CultureInfo
---@return bool
function String:EndsWith(value, ignoreCase, culture) end
---@public
---@param value Char
---@return Int32
function String:IndexOf(value) end
---@public
---@param value Char
---@param startIndex Int32
---@return Int32
function String:IndexOf(value, startIndex) end
---@public
---@param anyOf Char[]
---@return Int32
function String:IndexOfAny(anyOf) end
---@public
---@param anyOf Char[]
---@param startIndex Int32
---@return Int32
function String:IndexOfAny(anyOf, startIndex) end
---@public
---@param value string
---@return Int32
function String:IndexOf(value) end
---@public
---@param value string
---@param startIndex Int32
---@return Int32
function String:IndexOf(value, startIndex) end
---@public
---@param value string
---@param startIndex Int32
---@param count Int32
---@return Int32
function String:IndexOf(value, startIndex, count) end
---@public
---@param value string
---@param comparisonType number
---@return Int32
function String:IndexOf(value, comparisonType) end
---@public
---@param value string
---@param startIndex Int32
---@param comparisonType number
---@return Int32
function String:IndexOf(value, startIndex, comparisonType) end
---@public
---@param value string
---@param startIndex Int32
---@param count Int32
---@param comparisonType number
---@return Int32
function String:IndexOf(value, startIndex, count, comparisonType) end
---@public
---@param value Char
---@return Int32
function String:LastIndexOf(value) end
---@public
---@param value Char
---@param startIndex Int32
---@return Int32
function String:LastIndexOf(value, startIndex) end
---@public
---@param anyOf Char[]
---@return Int32
function String:LastIndexOfAny(anyOf) end
---@public
---@param anyOf Char[]
---@param startIndex Int32
---@return Int32
function String:LastIndexOfAny(anyOf, startIndex) end
---@public
---@param value string
---@return Int32
function String:LastIndexOf(value) end
---@public
---@param value string
---@param startIndex Int32
---@return Int32
function String:LastIndexOf(value, startIndex) end
---@public
---@param value string
---@param startIndex Int32
---@param count Int32
---@return Int32
function String:LastIndexOf(value, startIndex, count) end
---@public
---@param value string
---@param comparisonType number
---@return Int32
function String:LastIndexOf(value, comparisonType) end
---@public
---@param value string
---@param startIndex Int32
---@param comparisonType number
---@return Int32
function String:LastIndexOf(value, startIndex, comparisonType) end
---@public
---@param value string
---@param startIndex Int32
---@param count Int32
---@param comparisonType number
---@return Int32
function String:LastIndexOf(value, startIndex, count, comparisonType) end
---@public
---@param totalWidth Int32
---@return string
function String:PadLeft(totalWidth) end
---@public
---@param totalWidth Int32
---@param paddingChar Char
---@return string
function String:PadLeft(totalWidth, paddingChar) end
---@public
---@param totalWidth Int32
---@return string
function String:PadRight(totalWidth) end
---@public
---@param totalWidth Int32
---@param paddingChar Char
---@return string
function String:PadRight(totalWidth, paddingChar) end
---@public
---@param value string
---@return bool
function String:StartsWith(value) end
---@public
---@param value string
---@param comparisonType number
---@return bool
function String:StartsWith(value, comparisonType) end
---@public
---@param value string
---@param ignoreCase bool
---@param culture CultureInfo
---@return bool
function String:StartsWith(value, ignoreCase, culture) end
---@public
---@return string
function String:ToLower() end
---@public
---@param culture CultureInfo
---@return string
function String:ToLower(culture) end
---@public
---@return string
function String:ToLowerInvariant() end
---@public
---@return string
function String:ToUpper() end
---@public
---@param culture CultureInfo
---@return string
function String:ToUpper(culture) end
---@public
---@return string
function String:ToUpperInvariant() end
---@public
---@return string
function String:ToString() end
---@public
---@param provider IFormatProvider
---@return string
function String:ToString(provider) end
---@public
---@return Object
function String:Clone() end
---@public
---@return string
function String:Trim() end
---@public
---@param startIndex Int32
---@param value string
---@return string
function String:Insert(startIndex, value) end
---@public
---@param oldChar Char
---@param newChar Char
---@return string
function String:Replace(oldChar, newChar) end
---@public
---@param oldValue string
---@param newValue string
---@return string
function String:Replace(oldValue, newValue) end
---@public
---@param startIndex Int32
---@param count Int32
---@return string
function String:Remove(startIndex, count) end
---@public
---@param startIndex Int32
---@return string
function String:Remove(startIndex) end
---@public
---@param format string
---@param arg0 Object
---@return string
function String.Format(format, arg0) end
---@public
---@param format string
---@param arg0 Object
---@param arg1 Object
---@return string
function String.Format(format, arg0, arg1) end
---@public
---@param format string
---@param arg0 Object
---@param arg1 Object
---@param arg2 Object
---@return string
function String.Format(format, arg0, arg1, arg2) end
---@public
---@param format string
---@param args Object[]
---@return string
function String.Format(format, args) end
---@public
---@param provider IFormatProvider
---@param format string
---@param arg0 Object
---@return string
function String.Format(provider, format, arg0) end
---@public
---@param provider IFormatProvider
---@param format string
---@param arg0 Object
---@param arg1 Object
---@return string
function String.Format(provider, format, arg0, arg1) end
---@public
---@param provider IFormatProvider
---@param format string
---@param arg0 Object
---@param arg1 Object
---@param arg2 Object
---@return string
function String.Format(provider, format, arg0, arg1, arg2) end
---@public
---@param provider IFormatProvider
---@param format string
---@param args Object[]
---@return string
function String.Format(provider, format, args) end
---@public
---@param str string
---@return string
function String.Copy(str) end
---@public
---@param arg0 Object
---@return string
function String.Concat(arg0) end
---@public
---@param arg0 Object
---@param arg1 Object
---@return string
function String.Concat(arg0, arg1) end
---@public
---@param arg0 Object
---@param arg1 Object
---@param arg2 Object
---@return string
function String.Concat(arg0, arg1, arg2) end
---@public
---@param arg0 Object
---@param arg1 Object
---@param arg2 Object
---@param arg3 Object
---@return string
function String.Concat(arg0, arg1, arg2, arg3) end
---@public
---@param args Object[]
---@return string
function String.Concat(args) end
---@public
---@param values IEnumerable`1
---@return string
function String.Concat(values) end
---@public
---@param str0 string
---@param str1 string
---@return string
function String.Concat(str0, str1) end
---@public
---@param str0 string
---@param str1 string
---@param str2 string
---@return string
function String.Concat(str0, str1, str2) end
---@public
---@param str0 string
---@param str1 string
---@param str2 string
---@param str3 string
---@return string
function String.Concat(str0, str1, str2, str3) end
---@public
---@param values String[]
---@return string
function String.Concat(values) end
---@public
---@param str string
---@return string
function String.Intern(str) end
---@public
---@param str string
---@return string
function String.IsInterned(str) end
---@public
---@return number
function String:GetTypeCode() end
---@public
---@return CharEnumerator
function String:GetEnumerator() end
---@public
---@param value Char
---@param startIndex Int32
---@param count Int32
---@return Int32
function String:IndexOf(value, startIndex, count) end
---@public
---@param anyOf Char[]
---@param startIndex Int32
---@param count Int32
---@return Int32
function String:IndexOfAny(anyOf, startIndex, count) end
---@public
---@param value Char
---@param startIndex Int32
---@param count Int32
---@return Int32
function String:LastIndexOf(value, startIndex, count) end
---@public
---@param anyOf Char[]
---@param startIndex Int32
---@param count Int32
---@return Int32
function String:LastIndexOfAny(anyOf, startIndex, count) end
System.String = String