function Seat:_onViolentLoop()
    Log.warning("Seat:onViolentLoop", self.violentTime)
    self.violentTime = self.violentTime - 1
    if self.violentTime <= 0 then
        self:_stopViolent()
    end
end

function Seat:reduceFireRate()
    if self.violentTime > 0 then
        return self.fireRate
    else
        return 1
    end
end

function Seat:_startViolentAni()
    if is_empty(self.violentPaoSheng) then
        local ani = self.paoMount:GetChild("violent")
        self.violentPaoSheng = AnimalManger.createByAni(ani)
    end

    if is_empty(self.violentPaoTai) then
        local ani = self.playerComponent:GetChild("violentPaoTai")
        self.violentPaoTai = AnimalManger.createByAni(ani)
    end
    self.violentPaoTai:resume(true)
    self.violentPaoSheng:resume(true)
    self.violentPaoTai:setVisible(true)
    self.violentPaoSheng:setVisible(true)

    self:_startViolentLoop()
end
function Seat:_startViolentLoop()
    self.violentTimer = GameTimer.loop(1000, self, self._onViolentLoop)
end

function Seat:setViolentInfo(time, skill_id)
    self.violentTime = time
    self.skillId = skill_id
    if self.violentTime > 0 then
        self:_startViolentAni()
    end
end

function Seat:_stopViolent()
    if self.violentPaoTai then
        self.violentPaoTai:pause()
        self.violentPaoTai:setVisible(false)
    end
    if self.violentPaoSheng then
        self.violentPaoSheng:pause()
        self.violentPaoSheng:setVisible(false)
    end
    if self.violentTimer then
        self.violentTimer:clear()
        self.violentTimer = nil
    end
end
