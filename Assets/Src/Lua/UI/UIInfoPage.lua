---@class UIInfoPage :UIDialogBase
local UIInfoPage = class("UIInfoPage", UIDialogBase)

function UIInfoPage:init()
    self.packageName = "Info"
    self.resName = "InfoPage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.context = nil
    self.mlistManager = nil
    self.selectNum=0
    self.isHaveAvatar=false

end

function UIInfoPage:initComponent()
--获取对象
    self.contentView = self.view:GetChild("contentView")
    self.infoItem = self.contentView:GetChild("infoItem")
    self.user_id = self.infoItem:GetChild("user_id")
    self.quitBtn = self.infoItem:GetChild("quitBtn")
    self.infoBg =self.infoItem:GetChild("infoBg")
    self.playimg = self.infoItem:GetChild("playimg")
    self.nickname = self.infoItem:GetChild("nickname")
    self.levelCount =self.infoItem:GetChild("levelCount")
    self.editBtn =self.infoItem:GetChild("editBtn")
    self.copyBtn =self.infoItem:GetChild("copyBtn")
    self.nameInput=self.infoItem:GetChild("nameInput")
    self.infoBg=self.infoItem:GetChild("infoBg")
    self.changeBtn=self.infoItem:GetChild("changeBtn")
    self.expBar=self.infoItem:GetChild("expBar")
    self.avatarItem = self.contentView:GetChild("avatarItem")
    self.avatarBg = self.avatarItem:GetChild("bgImg")
    self.mlist = self.avatarItem:GetChild("mlist")
    self.quitAvatarBtn = self.avatarItem:GetChild("quitAvatarBtn")
--赋值
    local data = self:infoList()
    self.mlistManager = ListManager.creat(self.mlist, data, self.renderHandle, self)
--增加事件
    self.avatarBg.onClick:Set(self.onEditInfo, self)
    self.infoBg.onClick:Set(self.onEditInfo, self)
    self.quitBtn:onClick(self.onQuitClick, self)
    self.quitAvatarBtn:onClick(self.onCloseAvatar, self)
    self.copyBtn:onClick(self.onCopyClick, self)
    self.editBtn:onClick(self.onEditClick, self)
    self.changeBtn:onClick(self.onChangeClick, self)
    self.playimg.onClick:Add(self.onChangeClick, self)
    self.nameInput.onKeyDown:Add(self.onEditInfo, self)
end

function UIInfoPage:StartGames(param)
    self:initComponent()
    self:initView()
end

function UIInfoPage:initView()
    self.user_id.text=RoleInfoM.instance.jjhId;
    GameTools.loadHeadImage(self.playimg, RoleInfoM.instance:getAvatar())
    self.nickname.text=GameTools.filterName(FightTools:formatNickName(RoleInfoM.instance:getName()));
    self.levelCount.text = "Lv." .. tostring(RoleInfoM.instance:getLevel())
    --GameTip.showTip(RoleInfoM.instance:getExp());
    local cfg = cfg_level.instance(7)
    self.expBar.value = (RoleInfoM.instance:getExp()/cfg.exp)*100;
end

function UIInfoPage:onCloseAvatar()
    self:onEditInfo();
    self.avatarItem.visible=false;
    self:initView()
end

function UIInfoPage:onCopyClick()
    Arthas.Tools.CopyText(self.user_id.text)
    GameTip.showTip("复制成功");
end

function UIInfoPage:onEditInfo()
    local token = LoginInfoM:getUserToken();
    local nameStr= nil;
    local playIcon=nil
    if  string.len(self.nameInput:GetChild("input").text)==0  and self.selectNum==0 then
        return
    end
    if self.nameInput:GetChild("input").text~=nil and string.len(self.nameInput:GetChild("input").text)>0 then
        nameStr=self.nameInput:GetChild("input").text;
    else
        nameStr=GameTools.filterName(FightTools:formatNickName(RoleInfoM.instance:getName()));
    end
    if self.selectNum~=0 then
        playIcon=ConfigManager.getConfObject("cfg_avatar", self.selectNum).avatar
        RoleInfoM.instance:setAvatar(playIcon)
        self.avatarUpdate(self)
    else
        if type(RoleInfoM.instance:getAvatar()) == "string" and string.len(RoleInfoM.instance:getAvatar()) > 0 then
            playIcon=RoleInfoM.instance:getAvatar()
        else
            playIcon="ui://CommonComponent/nan"
        end
    end
    if (  string.len(nameStr)>0  and  string.len(playIcon)>0 ) then
        ApiManager.instance:SaveUserInfo(token, nameStr, playIcon ,nil, function(msg)
            if (msg["code"] == "success") then
                self.nickname.text=msg["data"]['nickname'];
                RoleInfoM.instance:setName(msg["data"]['nickname'])
                RoleInfoM.instance:setAvatar(msg["data"]['avatar'])
                GameTip.showTip("修改成功");
                self.nameInput:GetChild("input").text=nil
                self.selectNum=0
                self.isHaveAvatar=true;
            end
        end)
    end
    self.nickname.visible=true;
    self.nameInput.visible=false;
end

function UIInfoPage:onEditClick()
    if self.nameInput.visible == true then
        self:onEditInfo();
    else
        self.nickname.visible=false;
        self.nameInput.visible=true;
    end
end


function UIInfoPage:onQuitClick()
    UIManager:ClosePanel("InfoPage")
end

function UIInfoPage:onChangeClick()

    self.avatarItem.visible=true;

end

function UIInfoPage:renderHandle(i, cell, config)
    cell.data = config
    local playimg = cell:GetChild("playimg")
    local usedImg = cell:GetChild("usedImg")
    local suoBg = cell:GetChild("suoBg")
    local suoImg = cell:GetChild("suoImg")
    local selectImg = cell:GetChild("selectImg")
    selectImg.visible = config.selectImg.visible
    playimg.icon = config.playimg.skin
    usedImg.visible = config.usedImg.visible
    suoBg.visible = config.suoBg.visible
    suoImg.visible = config.suoImg.visible
    cell.onClick:Set(self.clickBox, self)
end

function UIInfoPage.avatarUpdate(self, context)
    local data = self:infoList()
    self.mlistManager:update(data)
end

function UIInfoPage:clickBox(cell)
    self.selectNum=cell.sender.data.avatarId;
    self.avatarUpdate(self)
    --local selectImg = cell.sender:GetChild("selectImg")
    --
    --selectImg.visible =  cell.sender.data.selectImg.visible
end

function UIInfoPage:infoList()
    local infoArr = {}
    local idAvatarData = self:idArr()
    for i = 1, #idAvatarData do
        local avatarId = idAvatarData[i]

        local avatarData = ConfigManager.getConfObject("cfg_avatar", avatarId)
        local data = {}
        if avatarData.avatar == RoleInfoM.instance:getAvatar() then
            --data.name = ConfigManager.getConfObject("cfg_goods", rewardData.rewardID).name
            --data.text = { text = rewardData.weekName, color = "#ffffff", strokeColor = "#104d86" }
            --data.image = { skin = self:imageUrl(rewardData.rewardID, idArrData[i]) }
            data.usedImg = { visible = true }

        else
            if self.isHaveAvatar==false and avatarId==1 then
                data.usedImg = { visible = false }
            else
                data.usedImg = { visible = false }
            end
        end
        if avatarId==self.selectNum then
            data.selectImg = { visible = true }
        else
            data.selectImg = { visible = false }
        end
        data.avatarId = avatarId

        data.playimg = { skin = avatarData.avatar }
        data.suoBg = { visible = false }
        data.suoImg = { visible = false };
        table.insert(infoArr, data)
    end
    return infoArr
end

function UIInfoPage:idArr()
    local arr = {}
    local items = ConfigManager.getLawItem("cfg_avatar")
    for i = 1, #items do
        local avatarId = items[i].id
        if avatarId == false then
            break ;
        end
        table.insert(arr, i);
    end
    return arr
end

return UIInfoPage