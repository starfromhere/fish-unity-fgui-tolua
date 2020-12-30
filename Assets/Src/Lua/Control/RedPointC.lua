---@class RedPointC
---@field public instance RedPointC
RedPointC = class("RedPointC")
function RedPointC:ctor()

end

RedPointC.red_point_name = "name_of_red_point_uid"
RedPointC.activity_point_name = "name_of_activity_point_uid"
RedPointC.spine_rank_point_name = "TiShi"

function RedPointC:addSpinePointToIcon(target, x, y, click_once)
    local spineGGraph = GGraph.New()
    local spine = SpineManager.create("Effects/TiShi", Vector3.New(0, 0, 1), 1, spineGGraph)
    spineGGraph.x = target.width * x
    spineGGraph.y = y
    spineGGraph.z = 1
    self:removeSpinePoint(target)
    target:AddChild(spineGGraph)
    target.data[RedPointC.spine_rank_point_name] = spine
    if not spine:isPlaying() then
        spine:play("animation", true)
    end
    --if click_once then
    --	target:once(Event.CLICK,target,self.removeRedPoint,{target})
    --
    --end
end

function RedPointC:removeSpinePoint(target)
    if not target.data or not target.data[RedPointC.spine_rank_point_name] then
        target.data = {}
        return
    end
    local spine = target.data[RedPointC.spine_rank_point_name]
    spine:destroy()
end

function RedPointC:addRedPointToIcon(target, x, y, skin, depth, click_once)
    if not depth then
        depth = 1
    end
    if not skin or #skin <= 0 then
        skin = "red_point"
    end
    local img = UIPackage.CreateObject("CommonComponent", skin).asImage
    local widthNum = target.width
    img.name = RedPointC.red_point_name
    img.z = depth
    img.x = widthNum * x
    img.y = y
    self:removeRedPoint(target)
    target:AddChild(img)
    --if click_once then
    --    target:once(Event.CLICK, target, self.removeRedPoint, { target })
    --
    --end
end

function RedPointC:removeRedPoint(target)
    local img = target:GetChild(RedPointC.red_point_name)
    if not img then
        return
    end
    img:RemoveFromParent()
    img:Dispose()
end

--function RedPointC:addActivityPointToIcon(target, x, y, click_once)
--    if ActivityM.instance.activityPictureConfig[4] then
--        local img = nil--[TODO] new Image()
--        img.name = RedPointC.activity_point_name
--        img.skin = ActivityM.instance.activityPictureConfig[4]
--        img.zOrder = 0
--        img.x = target.width * x
--        img.y = y
--        self:removeActivityPoint(target)
--        target:addChild(img)
--        if click_once then
--            target:once(Event.CLICK, target, self.removeRedPoint, { target })
--
--        end
--
--    end
--
--end
--function RedPointC:removeActivityPoint(target)
--    if ActivityM.instance.activityPictureConfig[4] then
--        target:removeChildByName(RedPointC.activity_point_name)
--
--    end
--
--end
--function RedPointC:addDoubleRewardPointToIcon(target, x, y, click_once)
--    local img = nil--[TODO] new Image()
--    img.name = RedPointC.activity_point_name
--    img.skin = "img_fanbei.png"
--    img.zOrder = 2
--    img.x = target.width * x
--    img.y = y
--    self:removeDoubleRewardPoint(target)
--    target:addChild(img)
--    if click_once then
--        target:once(Event.CLICK, target, self.removeRedPoint, { target })
--
--    end
--
--end
--function RedPointC:removeDoubleRewardPoint(target)
--    if target:getChildByName(RedPointC.activity_point_name) then
--        target:removeChildByName(RedPointC.activity_point_name)
--
--    end
--
--end
