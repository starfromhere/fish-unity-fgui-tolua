---@class PathContext
PathContext = class("PathContext")
function PathContext:ctor()
    self.pathId = nil
    self.pathType = nil
    self.pathData = nil

end
function PathContext:init(pathId, pathType, pathData)
    self.pathId = pathId
    self.pathType = pathType
    self.pathData = pathData
end

