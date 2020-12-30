---@class UIChangeSkinPage :UIBase
---@field public listSkinManage ListManager
local UIChangeSkinPage = class("UIChangeSkinPage", UIBase)

function UIChangeSkinPage:init()
    self.packageName = "ChangeSkin"
    self.resName = "ChangeSkinPage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.listSkin = nil;
    self.listSkinManage = nil;
    self.listDate = nil;
end

function UIChangeSkinPage:StartGames(param)

    self.contentView = self.view:GetChild("contentView")
    self.contentView:GetChild("ReturnBtn"):onClick(self.onQuitClick, self)
    self.listSkin = self.contentView:GetChild("batteryList")
    self:initList()
end

function UIChangeSkinPage:initList()



     self.listDate = ConfigManager.filter("cfg_battery_skin", function(item)
        return item and item.isShowInList == 1
    end)
    table.sort(self.listDate,function (a,b)
        return a.id < b.id
    end)
    self.listSkinManage = ListManager.creat(self.listSkin, self.listDate, self.updateList, self)
end

function UIChangeSkinPage:updateList(i, cell, data)
    local seat = SeatRouter.instance.mySeat
    local batteryC;
    local power = 0
    if seat ~= nil then
        batteryC = seat:batteryContext();
    end

    if batteryC ~= nil then
        power = batteryC:consume();
    end
    --暂时不管炮倍大小
    --local tmp = cfg_battery_skin.instance(data.toskin)
    --if tmp ~= nil then
    --    data = tmp
    --end
    --if power >= data.more_change then
    --    local tmp = cfg_battery_skin.instance(data.toskin)
    --    if tmp ~= nil then
    --        data = tmp
    --    end
    --end

    local icon = cell:GetChild("icon")
    local title = cell:GetChild("title")
    local button = cell:GetChild("btn")
    local desc = cell:GetChild("desc")
    local equipped = cell:GetChild("equipped")
    local selectedBg = cell:GetChild("selectedBg")
    local holder = cell:GetChild("holder")

    local hasBatterySkin = RoleInfoM.instance:hasSkin(data.id)
    local isCurSkin = RoleInfoM.instance:isCurSkin(data.id)

    title.text = data.itemLabel;
    local dc = data.desc
    local sc = string.split(data.desc,"：")
    
    if  sc and #sc ==2 then
        dc = sc[1].."：[color=#fff725]"..sc[2].."[/color]"
    end
    desc.text = dc;
    equipped.visible = false;
    selectedBg.visible = false;

    --local action = cfg_battery_skin.instance(v.id).ani_stand_action
    --local batterySpine;
    --icon.icon = v.batteryImg;
    --
    --if action ~= "stand" then
    --    if not batterySpine then
    --        local position = Vector3.zero(0, 0, 0)
    --        batterySpine = SpineManager.create("Forts/allForts", position, 0.65, holder)
    --    end
    --
    --    batterySpine:play(action, true)
    --end

    icon.icon = data.batteryImg

    if isCurSkin then
        equipped.visible = true
        selectedBg.visible = true
        button.title = "已装备"
        button.icon = "ui://CommonComponent/btn_small_blue"
        button:onClick(nil)
    elseif hasBatterySkin then
        button.title = "装备"
        button.icon = "ui://CommonComponent/btn_small_yellow"
        button:onClick(self.ChangeSkin, data)
    else
        button.title = "获得"
        button.icon = "ui://CommonComponent/btn_small_green"
        button:onClick(self.BuySkin, data)
    end
end

function UIChangeSkinPage.ChangeSkin(v)
    if v.id == 0 then
        GameTip.showTip("暂无大力神炮spine")
    else
        local isCurSkin = RoleInfoM.instance:isCurSkin(v.id)
        if isCurSkin then
            return
        end
        local  curSkin=RoleInfoM.instance:getCurSkin()
        local cfgSkin = cfg_battery_skin.instance(curSkin)
        if cfgSkin.is_one_time==1 then
            GameTip.showTip("请先发射特殊炮")
            return
        end
        RoleInfoM.instance:setLastSkinID(v.id)
        GameEventDispatch.instance:event(GameEvent.ChangeSkin, v.id);
    end
end

function UIChangeSkinPage.BuySkin(data)
    local tipId = data.tip_id_down
    if tipId == 0 then
        GameTip.showTip("通过世界杯活动获得")
    else
        GameTip.showTipById(tipId)
    end
end

function UIChangeSkinPage:refreshList()
    self.listSkinManage:update(self.listDate)
end

function UIChangeSkinPage:onQuitClick(content)
    UIManager:ClosePanel("ChangeSkinPage")
end

function UIChangeSkinPage:Register()
    self:AddRegister(GameEvent.ChangeSkin, self, self.initList)
    self:AddRegister(GameEvent.FinishChangeSkin, self, self.refreshList)
end

return UIChangeSkinPage