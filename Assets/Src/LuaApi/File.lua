---@class File : Object
local File={ }
---@public
---@param path string
---@param contents string
---@return void
function File.AppendAllText(path, contents) end
---@public
---@param path string
---@param contents string
---@param encoding Encoding
---@return void
function File.AppendAllText(path, contents, encoding) end
---@public
---@param path string
---@return StreamWriter
function File.AppendText(path) end
---@public
---@param sourceFileName string
---@param destFileName string
---@return void
function File.Copy(sourceFileName, destFileName) end
---@public
---@param sourceFileName string
---@param destFileName string
---@param overwrite bool
---@return void
function File.Copy(sourceFileName, destFileName, overwrite) end
---@public
---@param path string
---@return FileStream
function File.Create(path) end
---@public
---@param path string
---@param bufferSize Int32
---@return FileStream
function File.Create(path, bufferSize) end
---@public
---@param path string
---@param bufferSize Int32
---@param options number
---@return FileStream
function File.Create(path, bufferSize, options) end
---@public
---@param path string
---@param bufferSize Int32
---@param options number
---@param fileSecurity FileSecurity
---@return FileStream
function File.Create(path, bufferSize, options, fileSecurity) end
---@public
---@param path string
---@return StreamWriter
function File.CreateText(path) end
---@public
---@param path string
---@return void
function File.Delete(path) end
---@public
---@param path string
---@return bool
function File.Exists(path) end
---@public
---@param path string
---@return FileSecurity
function File.GetAccessControl(path) end
---@public
---@param path string
---@param includeSections number
---@return FileSecurity
function File.GetAccessControl(path, includeSections) end
---@public
---@param path string
---@return number
function File.GetAttributes(path) end
---@public
---@param path string
---@return DateTime
function File.GetCreationTime(path) end
---@public
---@param path string
---@return DateTime
function File.GetCreationTimeUtc(path) end
---@public
---@param path string
---@return DateTime
function File.GetLastAccessTime(path) end
---@public
---@param path string
---@return DateTime
function File.GetLastAccessTimeUtc(path) end
---@public
---@param path string
---@return DateTime
function File.GetLastWriteTime(path) end
---@public
---@param path string
---@return DateTime
function File.GetLastWriteTimeUtc(path) end
---@public
---@param sourceFileName string
---@param destFileName string
---@return void
function File.Move(sourceFileName, destFileName) end
---@public
---@param path string
---@param mode number
---@return FileStream
function File.Open(path, mode) end
---@public
---@param path string
---@param mode number
---@param access number
---@return FileStream
function File.Open(path, mode, access) end
---@public
---@param path string
---@param mode number
---@param access number
---@param share number
---@return FileStream
function File.Open(path, mode, access, share) end
---@public
---@param path string
---@return FileStream
function File.OpenRead(path) end
---@public
---@param path string
---@return StreamReader
function File.OpenText(path) end
---@public
---@param path string
---@return FileStream
function File.OpenWrite(path) end
---@public
---@param sourceFileName string
---@param destinationFileName string
---@param destinationBackupFileName string
---@return void
function File.Replace(sourceFileName, destinationFileName, destinationBackupFileName) end
---@public
---@param sourceFileName string
---@param destinationFileName string
---@param destinationBackupFileName string
---@param ignoreMetadataErrors bool
---@return void
function File.Replace(sourceFileName, destinationFileName, destinationBackupFileName, ignoreMetadataErrors) end
---@public
---@param path string
---@param fileSecurity FileSecurity
---@return void
function File.SetAccessControl(path, fileSecurity) end
---@public
---@param path string
---@param fileAttributes number
---@return void
function File.SetAttributes(path, fileAttributes) end
---@public
---@param path string
---@param creationTime DateTime
---@return void
function File.SetCreationTime(path, creationTime) end
---@public
---@param path string
---@param creationTimeUtc DateTime
---@return void
function File.SetCreationTimeUtc(path, creationTimeUtc) end
---@public
---@param path string
---@param lastAccessTime DateTime
---@return void
function File.SetLastAccessTime(path, lastAccessTime) end
---@public
---@param path string
---@param lastAccessTimeUtc DateTime
---@return void
function File.SetLastAccessTimeUtc(path, lastAccessTimeUtc) end
---@public
---@param path string
---@param lastWriteTime DateTime
---@return void
function File.SetLastWriteTime(path, lastWriteTime) end
---@public
---@param path string
---@param lastWriteTimeUtc DateTime
---@return void
function File.SetLastWriteTimeUtc(path, lastWriteTimeUtc) end
---@public
---@param path string
---@return Byte[]
function File.ReadAllBytes(path) end
---@public
---@param path string
---@return String[]
function File.ReadAllLines(path) end
---@public
---@param path string
---@param encoding Encoding
---@return String[]
function File.ReadAllLines(path, encoding) end
---@public
---@param path string
---@return string
function File.ReadAllText(path) end
---@public
---@param path string
---@param encoding Encoding
---@return string
function File.ReadAllText(path, encoding) end
---@public
---@param path string
---@param bytes Byte[]
---@return void
function File.WriteAllBytes(path, bytes) end
---@public
---@param path string
---@param contents String[]
---@return void
function File.WriteAllLines(path, contents) end
---@public
---@param path string
---@param contents String[]
---@param encoding Encoding
---@return void
function File.WriteAllLines(path, contents, encoding) end
---@public
---@param path string
---@param contents string
---@return void
function File.WriteAllText(path, contents) end
---@public
---@param path string
---@param contents string
---@param encoding Encoding
---@return void
function File.WriteAllText(path, contents, encoding) end
---@public
---@param path string
---@return void
function File.Encrypt(path) end
---@public
---@param path string
---@return void
function File.Decrypt(path) end
---@public
---@param path string
---@return IEnumerable`1
function File.ReadLines(path) end
---@public
---@param path string
---@param encoding Encoding
---@return IEnumerable`1
function File.ReadLines(path, encoding) end
---@public
---@param path string
---@param contents IEnumerable`1
---@return void
function File.AppendAllLines(path, contents) end
---@public
---@param path string
---@param contents IEnumerable`1
---@param encoding Encoding
---@return void
function File.AppendAllLines(path, contents, encoding) end
---@public
---@param path string
---@param contents IEnumerable`1
---@return void
function File.WriteAllLines(path, contents) end
---@public
---@param path string
---@param contents IEnumerable`1
---@param encoding Encoding
---@return void
function File.WriteAllLines(path, contents, encoding) end
System.IO.File = File