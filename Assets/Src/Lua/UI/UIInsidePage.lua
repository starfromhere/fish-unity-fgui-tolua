---@class UIInsidePage :UIDialogBase
local UIInsidePage = class("UIInsidePage",UIDialogBase)

function UIInsidePage:init()
    self.packageName = "Inside"
    self.resName = "InsidePage"
    self.uiType = UIType.UI_TYPE_DLG
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.context = nil
    self.sideType = nil
end


function UIInsidePage:StartGames(param)


    self.sideType = param or "inside"

    self:initComponent()

    self:initView()
end

function UIInsidePage:initComponent()
    self.contentView = self.view:GetChild("contentView")


    self.NoticeContext = self.contentView:GetChild("NoticeContext")
    self.title = self.NoticeContext:GetChild("title")
    self.content = self.NoticeContext:GetChild("content")
    self.insideBox = self.contentView:GetChild("insideBox")
    self.confirmBtn = self.contentView:GetChild("confirmBtn")
    self.confirmBtn:onClick(self.clickConfirm,self)
end


function UIInsidePage:initView()
    self.bgMask.visible = false
    self.insideBox.visible= false
    ApiManager.instance:GetAnnounce(self.sideType,nil,function (data)
        self:refreshView(data)
    end)
end

function UIInsidePage:refreshView(msg)
    local m = msg.data.notice
    LoginM.instance.provider_tel = msg.data.tel
    if m ~= nil then
        if table.len(m) ~= 0 then
            local con = m.content
            if con and string.len(con) ~= 0 then
                self.bgMask.visible = true
                self.insideBox.visible= true
                self.title.text = m.title
                self.content.text = con
            else
                self:clickConfirm();
            end
        end
    end
end

function UIInsidePage:clickConfirm()
    if self.sideType == "inside" then
        GameEventDispatch.instance:Event(GameEvent.Regic);
        UIManager:ClosePanel("InsidePage",nil, false)
    end
end


return UIInsidePage