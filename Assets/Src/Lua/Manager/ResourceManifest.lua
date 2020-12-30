---@class ResourceManifest
---@field instance ResourceManifest
ResourceManifest = class("ResourceManifest")

ResourceManifest.manifestGroups = {

    [LoadType.Preloading] = {
        { path = "Assets/Res/UI/Fonts/Fonts", packageName = "Fonts" },
        { path = "Assets/Res/UI/IconRes/IconRes", packageName = "IconRes" },
        { path = "Assets/Res/UI/FishType/FishType", packageName = "FishType" },
        { path = "Assets/Res/UI/CommonComponent/CommonComponent", packageName = "CommonComponent" },
        { path = "Assets/Res/UI/Login/Login", packageName = "Login" },
        { path = "Assets/Res/UI/Load/Load", packageName = "Load" },
        { path = "Assets/Res/UI/Inside/Inside", packageName = "Inside" },
        { path = "Assets/Res/UI/Main/Main", packageName = "Main" },
    },

    [LoadType.SceneCommon] = {
        { path = "Assets/Res/UI/ChangeSkin/ChangeSkin", packageName = "ChangeSkin" },
        { path = "Assets/Res/UI/BulletsFrames/BulletsFrames", packageName = "BulletsFrames" },
        { path = "Assets/Res/UI/FishFrames/FishFrames", packageName = "FishFrames" },
        { path = "Assets/Res/UI/FishChangeScene/FishChangeScene", packageName = "FishChangeScene" },
        { path = "Assets/Res/UI/FishDeathAni/FishDeathAni", packageName = "FishDeathAni" },
    },


    ["scene_1"] = {
        { path = "Assets/Res/UI/FishScene1/FishScene1", packageName = "FishScene1" },
    },
    ["scene_2"] = {
        { path = "Assets/Res/UI/FishScene2/FishScene2", packageName = "FishScene2" },
        { path = "Assets/Res/UI/FishScene3/FishScene3", packageName = "FishScene3" },

    },
    ["scene_3"] = {
        { path = "Assets/Res/UI/FishScene2/FishScene2", packageName = "FishScene2" },
        { path = "Assets/Res/UI/FishScene3/FishScene3", packageName = "FishScene3" },
    },
    ["scene_4"] = {
        { path = "Assets/Res/UI/FishScene4/FishScene4", packageName = "FishScene4" },
    },
    ["scene_9"] = {
        { path = "Assets/Res/UI/FishScene1/FishScene1", packageName = "FishScene1" },
        { path = "Assets/Res/UI/FishScene2/FishScene2", packageName = "FishScene2" },
        { path = "Assets/Res/UI/FishScene3/FishScene3", packageName = "FishScene3" },
        { path = "Assets/Res/UI/FishScene4/FishScene4", packageName = "FishScene4" },
    },
}

function ResourceManifest:getSceneRes(sceneId)
    Log.debug("ResourceManifest:getSceneRes", sceneId)
    if sceneId <= 4 or sceneId == 9 then
        local scene_group_name = "scene_" .. sceneId
        local res = table.concatTable(ResourceManifest.manifestGroups[LoadType.SceneCommon], ResourceManifest.manifestGroups[scene_group_name])
        Log.debug("ResourceManifest:getSceneRes", encode(ResourceManifest.manifestGroups[LoadType.SceneCommon]), encode(ResourceManifest.manifestGroups[scene_group_name]))
        Log.debug("ResourceManifest:getSceneRes", encode(res))
        return res
    else
        return ResourceManifest:getSceneRes(1)
    end
end