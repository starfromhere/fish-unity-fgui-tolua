---@class UIRegisterPage :UIDialogBase
local UIRegisterPage = class("UIRegisterPage", UIDialogBase)

function UIRegisterPage:init()
    self.packageName = "Register"
    self.resName = "RegisterPage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.context = nil

    self.mlistManager = nil
    self.lastState = true;
end

-- @override 派生类可重写，只会在新建界面的时候调用一次。缓存的界面不会调用。可以用来初始化控件等
function UIRegisterPage:initComponent()
    self.contentView = self.view:GetChild("contentView")
    self.img = self.contentView:GetChild("img")
    self.mlist = self.contentView:GetChild("mlist")
    self.quitBtn = self.contentView:GetChild("quitBtn");
    self.receiveBtn = self.contentView:GetChild("receiveBtn");

    self.receiveBtn:onClick(self.onQuitClick, self);
    self.quitBtn:onClick(self.onQuitClick, self);
    self.bgMask.onClick:Set(self.onQuitClick, self);
    local data = RegiM:infoList()
    self.mlistManager = ListManager.creat(self.mlist, data, self.renderHandle, self)
end


--@override 注册事件监听
function UIRegisterPage:Register()
    self:AddRegister(tostring(20003), self, self.roleCreateRet);
    self:AddRegister(GameEvent.SignInUpdate, self, self.signUpdate)
end

function UIRegisterPage:StartGames(param)
    self:initView()
end

function UIRegisterPage.signUpdate(self, context)
    local data = RegiM:infoList()
    self.mlistManager:update(data)
    self:initView()
end

function UIRegisterPage:renderHandle(i, cell, config)
    cell.data = config
    local image = cell:GetChild("image")
    local txt = cell:GetChild("txt")
    local count = cell:GetChild("count")
    local rightBtn = cell:GetChild("rightBtn")
    local right = cell:GetChild("right")
    local imgSelected = cell:GetChild("imgSelected")
    image.icon = config.image.skin
    txt.text = config.text.text
    count.text = config.count.text
    rightBtn.visible = config.rightBtn.visible
    right.visible = config.rightBtn.visible
    imgSelected.visible = config.imgSelected.visible
    cell.onClick:Set(self.onQuitClick, self)
end

--function UIRegisterPage:clickBox(context)
--    local registerId = context.sender.data.registerId
--    local c2s = {}
--    if RoleInfoM.instance:getSignInStatus(registerId) == GameConst.sign_in_getting then
--        c2s.day = tonumber(registerId);
--        WebSocketManager.instance:Send(20002, encode(c2s));
--    end
--    --关于新手引导的内容，延后处理
--    --GameEventDispatch.instance.event(GameEvent.CloseRegisterPage);
--end

function UIRegisterPage:initView()
    local arr = RegiM:idArr();
    for i = 1, #arr do
        local registerId = arr[i]
        if RoleInfoM.instance:getSignInStatus(registerId) == GameConst.sign_in_getting then
            self.receiveBtn.icon = "ui://Register/btn_djqd"
            self.img.url = "ui://Register/img_bx"

            break
        else
            self.receiveBtn.icon = "ui://Register/btn_mrzl"
            self.img.url = "ui://Register/img_bx_opened"

        end
    end
    self.mlist:ScrollToView(self:getCurIndex())
end

function UIRegisterPage:getCurIndex()
    local data = RegiM:infoList()
    for i = 1, #data do
        if self.lastState and not data[i].rightBtn.visible then
            return i - 1
        end
        self.lastState = data[i].rightBtn.visible
    end
    return 0
end

function UIRegisterPage:clickPanel()
    local arr = RegiM:idArr();
    for i = 1, #arr do
        local registerId = arr[i]
        local c2s = {}
        if RoleInfoM.instance:getSignInStatus(registerId) == GameConst.sign_in_getting then
            c2s.day = tonumber(registerId);
            NetSender.GetSignInReward(encode(c2s));
        end
    end
    --关于新手引导的内容，延后处理
    --GameEventDispatch.instance.event(GameEvent.CloseRegisterPage);
end

function UIRegisterPage:roleCreateRet(data)
    if data.code == 0 then
        self.goodsId = { data.goods }
        self.count = { data.num }
        GameTimer.once(200, self, self.start);
    elseif data.code == 1 then
        --GameEventDispatch.instance.event(GameEvent.MsgTip, 29);
    elseif data.code == 2 then
        --GameEventDispatch.instance.event(GameEvent.MsgTip, 30);
    elseif data.code == 3 then
        --GameEventDispatch.instance.event(GameEvent.MsgTip, 31);
    end
end

function UIRegisterPage:start()
    if RegiM:isGet() then

    else
        self:onQuitClick()
        GameEventDispatch.instance:Event(GameEvent.Regic);
        GameEventDispatch.instance:Event(GameEvent.RewardTip, { self.goodsId, self.count });
    end
end

function UIRegisterPage:onQuitClick()
    if RegiM.instance:isGet() then
        self:clickPanel()
        RegiM:setFinishDays(0);
    else
        UIManager:ClosePanel("RegisterPage",nil, false)
    end

end

return UIRegisterPage