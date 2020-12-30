---@class GameScreen
---@field public instance GameScreen
GameScreen = class("GameScreen")

function GameScreen:ctor()
    self.designWidth = nil
    self.designHeight = nil
    self.adaptWidth = nil
    self.adaptHeight = nil

    self.designDivideAdaptX = nil
    self.designDivideAdaptY = nil
    self.adaptDivideDesignX = nil
    self.adaptDivideDesignY = nil



    --设计比。H5设计为1280/720
    --传给服务器的坐标点，需要抓换成1280 * 720 的坐标
    self.designRatio = 1920 / 1280
    self.frameRatio = 60 / 30

    self.centerX = nil
    self.centerY = nil
end

function GameScreen:resetDesignWH()
    self.designWidth = FightContext.instance.designWidth
    self.designHeight = FightContext.instance.designHeight
end
function GameScreen:setAdaptWidthAndHeight(adaptWidth, adaptHeight)
    self:resetDesignWH()
    self.adaptWidth = adaptWidth
    self.adaptHeight = adaptHeight
    self.designDivideAdaptX = self.designWidth / self.adaptWidth
    self.designDivideAdaptY = self.designHeight / self.adaptHeight
    self.adaptDivideDesignX = 1 / self.designDivideAdaptX
    self.adaptDivideDesignY = 1 / self.designDivideAdaptY

    self.centerX = self.adaptWidth / 2
    self.centerY = self.adaptHeight / 2
    --GameEventDispatch.instance:event("ScreenResize")
end
function GameScreen:isInScreen(x, y)
    return self:isXInScreen(x) and self:isYInScreen(y)
end
function GameScreen:isXInScreen(x)
    return x <= self.adaptWidth and x >= 0

end
function GameScreen:isYInScreen(y)
    return y <= self.adaptHeight and y >= 0
end

function GameScreen:designToAdapt(p, out)
    out.x = p.x * self.adaptDivideDesignX
    out.y = p.y * self.adaptDivideDesignY
end

function GameScreen:adaptToDesign(p, out)
    out.x = p.x * self.designDivideAdaptX
    out.y = p.y * self.designDivideAdaptY
end

function GameScreen:screenScaleX()
    return GRoot.inst.width / GameConst.design_width
end
function GameScreen:screenScaleY()
    return GRoot.inst.height / GameConst.design_height
end

function GameScreen:getDesignWidth()
    return self.designWidth
end

function GameScreen:getDesignHeight()
    return self.designHeight
end

---@return GameScreen
--function GameScreen.instance
--    if not GameScreen.__instance then
--        GameScreen.__instance = GameScreen.New()
--    end
--    return GameScreen.__instance
--end

