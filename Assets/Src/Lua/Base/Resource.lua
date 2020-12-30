--- 资源加载缓存路径
---@class Resource
---@field private instance Resource
---@field private _prefabs      table<string, AssetRequest>
---@field private _materials    table<string, Material>
---@field private _others       table<string, AssetRequest>
---@field private _texture      table<string, AssetRequest>
---@field private _audios       table<string, AssetRequest>
local _M = class("Resource")

---@class ResourceType
local _suffix = {
    wav         =   ".wav",                 -- 音频
    mp3         =   ".mp3",                 
    prefab      =   ".prefab",              -- 预制体
    shader      =   ".shader",              -- shader
    scene       =   ".unity",               -- 场景
    mat         =   ".mat",                 -- 材质球
    controller  =   ".controller",          -- 动画控制器
    png         =   ".png",                 -- 贴图
    jpg         =   ".jpg",
    tga         =   ".tga"
}

ResourceType = _suffix

function _M:ctor()
    self._prefabs    = {}
    self._materials  = {}
    self._others     = {}
    self._texture    = {}
    self._audios     = {}
end

---loadAssert 同步加载资源
---@public
---@param path string 资源路径
---@param type ResourceType 资源
---@return Object
function _M:loadAssert(path, type)
    local tempPath = nil
    type, tempPath = type or self:getType(path)
    if not type then
        Log.error("not found Assets type")
        return
    end
    
    if type == ResourceType.prefab then
        path = tempPath or path
        return self:loadPrefabAsset(path)
    elseif type == ResourceType.png or type == ResourceType.jpg or type == ResourceType.tga then
        return self:loadTextureAsset(path)
    elseif type == ResourceType.mat or type == ResourceType.shader then
        return self:loadMatAsset(path, type)
    elseif type == ResourceType.mp3 or type == ResourceType.wav then
        return self:loadAudiosAsset(path)
    else
        Log.warning("please add new type to deal with")
    end
end

function _M:getType(path)
    for _, v in pairs(path) do
        if (string.ends(path, v)) then
            return v, string.sub(path,-string.len(v))
        end
    end
end

function _M:loadPrefabAsset(path)
    if not self._prefabs[path] then
        local prefabUrl = "Assets/Res/Prefabs/" .. path .. ".prefab"
        local libxAsset = libx.Assets.LoadAsset(prefabUrl, typeof(UnityEngine.Object))
        if libxAsset.error then
            Log.error("资源",prefabUrl ,"加载失败: ", libxAsset.error)
            return
        end
        self._prefabs[path] = libxAsset
    end
    return UnityEngine.Object.Instantiate(self._prefabs[path].asset)
end

function _M:loadTextureAsset(path)
    if not self._texture[path] then
        local libxAsset = libx.Assets.LoadAsset(path, typeof(UnityEngine.Texture))
        if libxAsset.error then
            Log.error("资源",path ,"加载失败: ", libxAsset.error)
            return
        end
        self._texture[path] = libxAsset
    end
    return self._texture[path].asset
end

function _M:loadMatAsset(path, type)
    if not self._materials[path] then
        local libxAsset = nil;
        if type == ResourceType.mat then
            libxAsset = libx.Assets.LoadAsset(path, typeof(UnityEngine.Material))
        elseif type == ResourceType.shader then
            libxAsset = libx.Assets.LoadAsset(path, typeof(UnityEngine.Shader))
        end
        
        if libxAsset.error then
            Log.error("资源",path ,"加载失败: ", libxAsset.error)
            return
        end
        local ret = type == ResourceType.shader and UnityEngine.Material(libxAsset.asset) or libxAsset.asset
        self._materials[path] = ret
    end
    return self._materials[path]
end

function _M:loadAudiosAsset(path)
end

Resource = Resource or {}
setmetatable(Resource, { __index = function(_, v)
    return _M.instance[v]
end })