---@class RewardBox :UIBase
local RewardBox = class("RewardBox")

function RewardBox:ctor()
    self._image = nil
    self._rewardView = nil
    self._label = nil
    self._spineRoot = nil
    self._spine = nil
    self._box = nil
    self._oneBox = nil
end

function RewardBox:creat(url, point, rewardView, count)
    if self._box == nil then
        self._box = UIPackage.CreateObjectFromURL("ui://RewardTip/RewardGroup")
    end
    if self._label == nil then
        self._label = self._box:GetChild("n4")
    end
    if self._image == nil then
        self._image = self._box:GetChild("n3")
    end
    --self._label:SetXY(point[1], point[2] + 75)
    self._label.text = count
    self._box:SetXY(point[1], point[2])
    self._image.icon = url;
    self._rewardView = rewardView
    --self._rewardView.AddChild

    --self._label:SetScale(1.5, 1.5)
    --self._image:SetScale(1.5, 1.5)
end

function RewardBox:start(delay)
    self.loopHandle = GameTimer.once(delay, self, function()
        --_rewardView.addChild(spineRoot);
        self._rewardView:AddChild(self._box);
        --spine.play(0, false, Handler.create(this, playComte));
        --Tween.to(spineRoot, { scaleX: 2, scaleY: 2 }, 150, null, Handler.create(this, playComplete));
        --Tween.to(skin, {
        --    scaleX:GameTools.getImageScale(skin, 2, true),
        --    scaleY:GameTools.getImageScale(skin, 2, true)
        --}, 150, null, Handler.create(this, playComplete));
        --Tween.to(clip, { scaleX: 2, scaleY: 2 }, 150, null, Handler.create(this, playComplete));
    end)
end

function RewardBox:playComplete()
    --Tween.to(spineRoot, { scaleX: 1.5, scaleY: 1.5 }, 150, null);
    --Tween.to(skin, { scaleX:GameTools.getImageScale(skin, 1.5, true), scaleY:GameTools.getImageScale(skin, 1.5, true) }, 150, null);
    --Tween.to(clip, { scaleX: 1.5, scaleY: 1.5 }, 150, null);
end

function RewardBox:stop()

    --Tween.to(spineRoot, { scaleX:0, scaleY:0 }, 150, null, Handler.create(this, stopComplete));
    --Tween.to(skin, { scaleX:0, scaleY:0 }, 150, null, Handler.create(this, stopComplete));
    --Tween.to(clip, { scaleX:0, scaleY:0 }, 150, null, Handler.create(this, stopComplete));
    --//_rewardView.removeChild(ani);
    --//_rewardView.removeChild(skin);
    --//_rewardView.removeChild(clip)
    self:stopComplete()
end

function RewardBox:stopComplete()
    GameEventDispatch.instance:Event(GameEvent.CloseRewadTip);
    --self._box.visible = false
    self._rewardView:RemoveChild(self._box);
end

return RewardBox