---@class GameEntry : LuaClient
---@field public Sound SoundCompoent
local GameEntry={ }
---@public
---@param pregress Single
---@return void
function GameEntry.UpdateProgress(pregress) end
---@public
---@return void
function GameEntry.PreLoadComplete() end
Arthas.GameEntry = GameEntry