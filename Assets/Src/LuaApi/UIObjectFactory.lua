---@class UIObjectFactory : Object
local UIObjectFactory={ }
---@public
---@param url string
---@param type Type
---@return void
function UIObjectFactory.SetPackageItemExtension(url, type) end
---@public
---@param url string
---@param creator GComponentCreator
---@return void
function UIObjectFactory.SetPackageItemExtension(url, creator) end
---@public
---@param url string
---@param baseType Type
---@param extendFunction LuaFunction
---@return void
function UIObjectFactory.SetExtension(url, baseType, extendFunction) end
---@public
---@param type Type
---@return void
function UIObjectFactory.SetLoaderExtension(type) end
---@public
---@param creator GLoaderCreator
---@return void
function UIObjectFactory.SetLoaderExtension(creator) end
---@public
---@return void
function UIObjectFactory.Clear() end
---@public
---@param pi PackageItem
---@param userClass Type
---@return GObject
function UIObjectFactory.NewObject(pi, userClass) end
---@public
---@param type number
---@return GObject
function UIObjectFactory.NewObject(type) end
FairyGUI.UIObjectFactory = UIObjectFactory