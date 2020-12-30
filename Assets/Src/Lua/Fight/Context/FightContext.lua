---@class FightContext
---@field instance FightContext
FightContext = class("FightContext")

---@field public instance FightContext

function FightContext:ctor()
    self.designWidth = 1920
    self.designHeight = 1080
    self.designScaleX = 1
    self.designScaleY = 1
    self.is3D = true
    self.maxBulletNum = nil
    self.shootSound = nil
    self.platform = 0
    self.WxMiniGame = 1
    self.coinShootScene = true
    self.exchangeRate = 1000
    self.haveValidMonthCard = false
    self.freezeLastTime = 0
    self.upVector3D = Vector3.New()
    self.autoMode = 1
    self.lockMode = 1
    self.fish_stage_3d = 3


    --是否绘制碰撞体
    self.drawCollisionRect = false

    --是否在战斗中
    self.isInFight = false
    --当前战斗场景
    self.sceneId = nil
    --当前用户座位
    self.seatId = nil
    --FightTools:CalSinCosSheet()
    FightTools:CalAcosSheet()
    FightTools:CalSinCosSheet();
end

function FightContext:exchangeRate()
    return self.exchangeRate
end
