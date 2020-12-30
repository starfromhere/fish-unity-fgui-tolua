---@class UIPackageManager
---@field public instance UIPackageManager
---@field private cachePackage table<string, boolean>    <packagename, count>
UIPackageManager = class("UIPackageManager")

function UIPackageManager:ctor()
    self.cachePackage = {}
end

---AddPackage
---@public
---@param path string               需要加载的包的全称
---@param packageName string        包名称
---@param packageType string        包类型，其实就是对应的文件夹
---@return void
function UIPackageManager:AddPackage(path, packageName, packageType)
    if self.cachePackage[packageName] then
        return
    end
    local AddpackageParm = path
    self.cachePackage[packageName] = true
    UIPackage.AddPackage(AddpackageParm, UIPackage.LoadFromResPath)
end

---没有实际对象，仅作为一个注解
---@class UIPackageManager.packgeInfo
---@field path string               需要加载的包的全称
---@field packageName string        包名称
---@field packageType string        包类型，其实就是对应的文件夹

---AddPackages  批量加载package包
---@public
---@param packageList UIPackageManager.packgeInfo[]
---@return void
function UIPackageManager:AddPackages(packageList)
    for _, v in ipairs(packageList) do
        if v.packageType then
            self:AddPackage(v.path, v.packageName, v.packageType)
        else
            self:AddPackage(v.path, v.packageName)
        end
    end
end

---RemovePackage 移除fgui的包，并清除缓存标记
---@public
---@param packageName string
---@return void
function UIPackageManager:RemovePackage(packageName)
    UIPackage.RemovePackage(packageName)
    self.cachePackage[packageName] = false;
end

