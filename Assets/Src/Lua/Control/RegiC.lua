---@class RegiC
---@field public instance RegiC
RegiC = class("RegiC")
function RegiC:ctor()
    self.on_off = 0
    GameEventDispatch.instance:On(GameEvent.SignInUpdate, self, self.signUpdate)
    GameEventDispatch.instance:On(GameEvent.Regic, self, self.startRegic)

end
function RegiC:startRegic()
    --if not LoginM.instance:isCompleteCertification() and self.on_off == 0 then
    --    if CertificationM.instance:isOpenCertification() then
    --        local certInfo = CertificationInfo.New();
    --        certInfo.openFrom = "login";
    --        CertificationM.instance:setInfo(certInfo);
    --        CertificationM.instance:OpenCertification()
    --    end
    --    self.on_off = self.on_off + 1
    --else
        if RegiM.instance:isRegic() then
            RegiM.instance:isToday(true)
            if RegiM.instance:isGet() then
                LoginM.instance:loginNew(true)
                UIManager:LoadView("RegisterPage")
            else

                --if LevelM.instance:isPopupRankPage() == 1 then
                --                --    UIManager:LoadView("Rank")
                --                --else
                --                --    if ActivityM.instance:loginNew() and ActivityM.instance:activityIsProceed('multi_at') then
                --                --        if not ActivityM.instance:loginShowActivityPannel() then
                --                --            ActivityM.instance:loginNew(false)
                --                --            ActivityM.instance:loginShowActivityPannel(true)
                --                --            UIManager:LoadView("UseTicket")
                --                --
                --                --        end
                --                --    end
                --                --end
            end
        end
    --end
end

function RegiC:signUpdate()
    RegiM.instance:isRegic(true)
    if RegiM.instance:isToday() then
        if RegiM.instance:isGet() then
            UIManager:LoadView("RegisterPage")
        end
    end

end
function RegiC:startSign()
    if RegiM.instance:isGet() then
        UIManager:LoadView("RegisterPage")
    end

end
        