---@class UISettingPage :UIDialogBase
local UISettingPage = class("UISettingPage", UIDialogBase)
local File = System.IO.File
local StreamWriter = System.IO.StreamWriter
local Application = UnityEngine.Application

function UISettingPage:init()
    self.packageName = "Setting"
    self.resName = "SettingPage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.context = nil
    self.defaultValue = 50 --默认音量
    self.canbeCode = true
    self._code = nil
end

function UISettingPage:initComponent()
    self.contentView = self.view:GetChild("contentView")

    self.quitBtn = self.contentView:GetChild("quitBtn")
    self.bgmBar = self.contentView:GetChild("bgmBar").asSlider
    self.musicBar = self.contentView:GetChild("musicBar").asSlider

    self.exitGame = self.contentView:GetChild("exitGame")
    self.feedBtn = self.contentView:GetChild("feedBtn")
    self.giftcodeBtn = self.contentView:GetChild("giftcodeBtn")
    self.provider_tel = self.contentView:GetChild("provider_tel")
    self.writegiftInput = self.contentView:GetChild("writegiftInput")
    self.codeconfirmBtn = self.contentView:GetChild("codeconfirmBtn")
    self.feedInput = self.contentView:GetChild("feedInput")
    self.pushBtn = self.contentView:GetChild("pushBtn")

    self.openMusic = self.contentView:GetChild("openMusic")
    self.closeMusic = self.contentView:GetChild("closeMusic")
    self.pageControl = self.contentView:GetController("page")

    self.inputVersion = self.contentView:GetChild("n70")
    self.versionList = self.contentView:GetChild("n66")
    self.saveVersionBtn = self.contentView:GetChild("n67")
    self.changeVersionBtn = self.contentView:GetChild("changeVersionBtn")
    self.quitVersionBtn = self.contentView:GetChild("quitVersionBtn")

    self.openMusic:onClick(self.openAllMusic, self)
    self.closeMusic:onClick(self.closeAllMusic, self)
    self.bgmBar.onChanged:Add(self.onBgmChanged, self)
    self.musicBar.onChanged:Add(self.onEffChanged, self)

    self.quitBtn:onClick(self.onQuitClick, self)
    self.feedBtn:onClick(self.clickFeed, self)
    self.exitGame:onClick(self.onExitGame, self)
    self.giftcodeBtn:onClick(self.showWriteGiftCode, self)
    self.codeconfirmBtn:onClick(self.onCodeConfirmClick, self)
    self.pushBtn:onClick(self.onClickPush, self)
    if ENV.IN_EDITOR then
        self.changeVersionBtn.visible = false
    else
        if RoleInfoM.is_test_user == 1 then
            self.changeVersionBtn:onClick(self.onChangeVersionBtn, self)
            self.quitVersionBtn:onClick(self.onQuitVersionBtn, self)
            self.saveVersionBtn:onClick(self.onSaveVersionBtn, self)
            self.changeVersionBtn.visible = true

            if not LoginM._versionList or #LoginM._versionList < 0 then
                LoginM._versionList = {}
                local token = LoginInfoM:getUserToken();
                ApiManager.instance:GetVersionList(token, ENV.PLATFORM, nil, function(msg)
                    if (msg["code"] == "success") then
                        LoginM._versionList = msg['data'];
                        self.versionListManger = ListManager.creat(self.versionList, LoginM._versionList, self.versionRenderHandle, self)
                    end
                end)
            end
        end
    end
end

function UISettingPage:versionRenderHandle(i, cell, data)
    local envLabel = cell:GetChild("cdn")
    local versionLabel = cell:GetChild("version")
    local platformLabel = cell:GetChild("platform")
    local resourcesNameLabel = cell:GetChild("resourcesName")
    envLabel.text = data['env']
    platformLabel.text = data['platform']
    versionLabel.text = data['version']
    resourcesNameLabel.text = data['resources_uri']
end

function UISettingPage:StartGames(param)
    self.pageControl.selectedIndex = 0
    self.writegiftInput.text = ""
    self.provider_tel.text = LoginM.instance.provider_tel
    self:initView()
end

function UISettingPage:initView()
    self:allMusicState();
    self.openMusic.visible = not self.allMusicState()
    self.closeMusic.visible = self.allMusicState()
end

function UISettingPage:allMusicState()
    return SoundManager.GetMusicAudioState() or SoundManager.GetEffectAudioState()
end
--开的按钮 其实是关闭声音
function UISettingPage:openAllMusic()
    SoundManager.MusicMute(true)
    SoundManager.EffectMute(true)
    self.openMusic.visible = false
    self.closeMusic.visible = true
    self.bgmBar.value = 0
    self.musicBar.value = 0
    self:onBgmChanged()
    self:onEffChanged()
end
--关的按钮再次点击是开启声音
function UISettingPage:closeAllMusic()
    SoundManager.MusicMute(false)
    SoundManager.EffectMute(false)
    self.openMusic.visible = true
    self.closeMusic.visible = false
    self.bgmBar.value = self.defaultValue
    self.musicBar.value = self.defaultValue
    self:onBgmChanged()
    self:onEffChanged()
end

function UISettingPage:onBgmChanged()
    local bgmValue = string.format("%.1f", self.bgmBar.value / 100)
    SoundManager.SetMusicVolume(tonumber(bgmValue))
    self:checkMusicButton()
end

function UISettingPage:onEffChanged()
    local effValue = string.format("%.1f", self.musicBar.value / 100)
    SoundManager.SetEffectVolume(tonumber(effValue))
    self:checkMusicButton()
end

function UISettingPage:checkMusicButton()
    if (self.bgmBar.value == 0 and self.musicBar.value == 0) then
        self.openMusic.visible = false
        self.closeMusic.visible = true
        SoundManager.MusicMute(true)
        SoundManager.EffectMute(true)
    else
        self.openMusic.visible = true
        self.closeMusic.visible = false
        SoundManager.MusicMute(false)
        SoundManager.EffectMute(false)
    end
    if self.musicBar.value ~= 0 then
        GRoot.inst:EnableSound();
    else
        GRoot.inst:DisableSound();
    end
end

function UISettingPage:clickFeed()
    self.feedInput.text = ""
    self.pageControl.selectedIndex = 2
end

function UISettingPage:onExitGame(context)
    local info = ConfirmTipInfo.New();
    info.state = ConfirmTipInfo.LeftRight
    info.content = "是否退出游戏？";
    info.rightClick = function()
        if not ENV.IN_EDITOR then
            UnityEngine.Application.Quit();
        end
    end
    GameTip.showConfirmTip(info)
end

function UISettingPage:showWriteGiftCode()
    self.writegiftInput.text = ""
    self.pageControl.selectedIndex = 1
end

function UISettingPage:onCodeConfirmClick()
    self._code = self.writegiftInput.text;
    if (string.len(self._code) == 0) then
        GameTip.showTip("礼包码不能为空");
    elseif (string.len(self._code) > 0 and self.canbeCode) then
        self.canbeCode = false;
        NetSender.GiftCodeConfirm( { key = self._code });
        GameTimer.once(2000, self, function()
            self.canbeCode = true;
        end);
    end
end

function UISettingPage:onQuitClick()

    if self.pageControl.selectedIndex == 0 then
        UIManager:ClosePanel("SettingPage")
    else
        self.pageControl.selectedIndex = 0
    end
end

function UISettingPage:onClickPush()
    self._content = self.feedInput.text;
    if (string.len(self._content) == 0) then
        GameTip.showTip("反馈内容不能为空");
    else
        local token = LoginInfoM:getUserToken()
        ApiManager.instance:GetFeedBack(token, self._content, nil, function(msg)
            if (msg["code"] == "success") then
                self.pageControl.selectedIndex = 0
                GameTip.showTip("反馈成功");
            end
        end)
    end
end

function UISettingPage:onChangeVersionBtn()
    self.pageControl.selectedIndex = 3
end

function UISettingPage:onQuitVersionBtn()
    self.pageControl.selectedIndex = 0
end

function UISettingPage:onSaveVersionBtn()
    local txt = File.CreateText(Application.persistentDataPath .. "/recordingVersion.txt")
    if not is_empty(self.inputVersion.text) then
        txt:Write(self.inputVersion.text)
        txt:Close()
        GameTip.showTip("保存成功")
    end
end

return UISettingPage