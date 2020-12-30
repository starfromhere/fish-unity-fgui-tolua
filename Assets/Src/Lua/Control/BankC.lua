---@class BankC
---@field public instance BankC
BankC = class("BankC")
function BankC:ctor()
    self.times = 0
    GameEventDispatch.instance:on(tostring(33003), self, self.end_deposit_in)
    GameEventDispatch.instance:on(tostring(33005), self, self.end_take_out)
    GameEventDispatch.instance:on(tostring(33006), self, self.syncBankInfo)
    GameEventDispatch.instance:on(tostring(33013), self, self.sync_bank_info)
    GameEventDispatch.instance:on(tostring(33015), self, self.receive_sms_code)
    GameEventDispatch.instance:on(tostring(33021), self, self.end_bind_tel)
    GameEventDispatch.instance:on(tostring(10028), self, self.synConfigOnOff)

    --身份认证
    GameEventDispatch.instance:on(tostring(60000), self, self.syncCertificationEnd)
    GameEventDispatch.instance:on(tostring(60002), self, self.syncCertificationSuccess)
    GameEventDispatch.instance:on(tostring(60006), self, self.syncNovicePlayer)

end
function BankC:synConfigOnOff(res)
    if res['bank_max_barbette'] then
        LoginInfoM.instance:setOpenBankBatteryLevel(res['bank_max_barbette'])
    end
    if res['certification_switch'] or tonumber(res['certification_switch']) == 0 then
        local certification = LoginM.instance:getIsCompleteCertification()
        LoginInfoM.instance:setOpenCertification(res['certification_switch'])
        self.times = self.times + 1
        if res['certification_switch'] == 1 and self.times > 1 and certification == 0 then
            if (CertificationM.instance:isOpenCertification()) then
                local certInfo = CertificationInfo.new()
                certInfo.openFrom = GameConst.from_login
                CertificationM.instance:setInfo(certInfo)
                CertificationM.instance:OpenCertification()
            end
        end
    end

    if res["name_filter"] then
        LoginInfoM.instance:setNameFilter(res["name_filter"])
        GameEventDispatch.instance:Event(GameEvent.UpdateProfile)
    end

    if (res["redpack_cfg"]) then
        if (res["redpack_cfg"]["wx"]) then
            ExchangeM.instance:setWx_wxExchangeOpen(res["redpack_cfg"]["wx"]["wx_open"])
            ExchangeM.instance:setWx_alipayExchangeOpen(res["redpack_cfg"]["wx"]["ali_open"])
        end
        if (res["redpack_cfg"]["h5"]) then
            ExchangeM.instance:setH5_wxExchangeOpen(res["redpack_cfg"]["h5"]["wx_open"])
            ExchangeM.instance:setH5_alipayExchangeOpen(res["redpack_cfg"]["h5"]["ali_open"])
        end
    end
end

function BankC:receive_sms_code(data)
    if 0 == data.code then
        GameTip.showTip("发送验证码成功")
    else
        GameTip.showTip("发送验证码失败")
    end
end

function BankC:sync_bank_info(data)
    if (data.code == 0) then
        RoleInfoM.instance.is_bind_tel = data['is_bind_bank'];
        if (data['is_bind_bank'] == 1) then
            RoleInfoM.instance.tel = data['tel'];
            RoleInfoM.instance.bank_gold = data['bank_gold'];
            RoleInfoM.instance.jjhNumber = data['jjhaccounts'];
            RoleInfoM.instance.jjhId = data['jjhuserid']
            GameEventDispatch.instance:Event(GameEvent.SyncBankCoin)
            if (CertificationM.instance:getInfo()) then
                UIManager:LoadView("CertificationPage")
            end
        else
            if (CertificationM.instance:getInfo()) then
                UIManager:LoadView("CertificationPage")
            end
        end
    elseif ("custom_err" == data.code) then
        GameTip.showTip(data.tips)
    else
        if (CertificationM.instance:getInfo() and CertificationM.instance:getInfo().openFrom == FightConst.from_login) then
            GameEventDispatch.instance:event(GameEvent.Regic)
        end
        GameTip.showTip("绑定信息获取失败")
    end
end

function BankC:end_bind_tel(data)
    if 0 == data.code then
        RoleInfoM.instance.is_bind_tel = 1
        RoleInfoM.instance.tel = data['tel']
        RoleInfoM.instance.bank_gold = data['bank_gold']
        RoleInfoM.instance.jjhNumber = data['account']
        GameEventDispatch.instance:Event(GameEvent.SyncBankCoin)
        GameEventDispatch.instance:Event(GameEvent.SynBankBindSuccess)
        GameTip.showTip("绑定成功")
    elseif 1 == data.code then
        GameTip.showTip("未知错误")
    elseif 2 == data.code then
        GameTip.showTip("此账号已被绑定")
    elseif 3 == data.code then
        GameTip.showTip("此账号或ID不存在")
    elseif 4 == data.code then
        GameTip.showTip("此帐号手机号不匹配")
    elseif 5 == data.code then
        GameTip.showTip("此帐号登录密码有误")
    elseif 6 == data.code then
        GameTip.showTip("对不起，此帐号已被禁用")
    elseif 7 == data.code then
        GameTip.showTip("验证码错误")
    elseif "custom_err" == data.code then
        GameTip.showTip(data.tips)
    else
        GameTools:dealCode(data.code)
    end
end

function BankC:end_deposit_in(data)
    if 0 == data.code then
        GameEventDispatch.instance:Event(GameEvent.EndBankDeposit)
        GameTip.showTip("存入成功")
    elseif 1 == data.code then
        GameTip.showTip("未绑定银行")
    elseif 3 == data.code then
        GameTip.showTip("存取失败")
    elseif 4 == data.code then
        GameTip.showTip("每次最少存入5万金币")
    elseif 5 == data.code then
        GameTip.showTip("当日存入金额已经超出上限，请降低金额或者明天再试")
    elseif 6 == data.code then
        GameTip.showTip("存取失败")
    elseif 10 == data.code then
        GameTip.showTip("请退出渔场再试")
    elseif 11 == data.code then
        GameTip.showTip("需要月卡才可使用")
    elseif "custom_err" == data.code then
        GameTip.showTip(data.tips)
    else
        GameTools:dealCode(data.code)
    end
end

function BankC:end_take_out(data)
    if 0 == data.code then
        GameEventDispatch.instance:Event(GameEvent.EndBankTake);
        GameTip.showTip("取出成功")
    elseif 1 == data.code then
        GameTip.showTip("未绑定银行")
    elseif 2 == data.code then
        GameTip.showTip("每次最少取出5万金币")
    elseif 3 == data.code then
        GameTip.showTip("当日取出金额已经超出上限，请降低金额或者明天再试")
    elseif 4 == data.code then
        GameTip.showTip("存取失败")
    elseif 5 == data.code then
        GameTip.showTip("存取失败")
    elseif 10 == data.code then
        GameTip.showTip("请退出渔场再试")
    elseif "custom_err" == data.code then
        GameTip.showTip(data.tips)
    else
        GameTools.dealCode(data.code)
    end
end

function BankC:syncBankInfo(data)
    RoleInfoM.instance:setCoin(data['gold'])
    RoleInfoM.instance.bank_gold = data['bank_gold']
    GameEventDispatch.instance:Event(GameEvent.BankUpdate);
    GameEventDispatch.instance:Event(GameEvent.UpdateProfile);

end

function BankC:syncCertificationEnd(res)
    if res then
        LoginM.instance:setPopupCertificationTimes(res.popup_times)
        LoginM.instance:setIsCompleteCertification(res.certification)
        if res['ageType'] then
            LoginInfoM.instance:setAgeType(res.ageType)
        end
        GameEventDispatch.instance:Event(GameEvent.SyncCertificationInfo)
    end
end

function BankC:syncCertificationSuccess(res)
    if res.code == 0 then
        GameTip.showTip("身份认证成功")
    elseif res.code == 1 then
        GameTip.showTip("真实姓名或身份证输入错误")
    elseif res.code == 2 then
        GameTip.showTip("重复认证")
    elseif res.code == 3 then
        GameTip.showTip("身份证号不符合规范")
    elseif res.code == 4 then
        GameTip.showTip("姓名不符合规范")
    elseif res.code == 5 then
        GameTip.showTip("系统错误，请重试")
    elseif res.code == 6 then
        GameTip.showTip("网络错误，请重试")
    else
        GameTools:dealCode(res.code)
    end
end