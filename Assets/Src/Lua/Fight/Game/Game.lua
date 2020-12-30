---@class Game
---@field public instance Game
Game = class("Game")
function Game:ctor()
    self.fsm = FSM.New(self)
    self.fishPool = nil
    self.effectPool = nil
    self.aniPool = nil
    self.fishery = nil
    self.firstEnterLogin = false
    self._IsFirstEntryGame = true

    ---网络信息
    self.connectUrl = nil

    --断网超时
    self.timeOut = 6000

    self.resetInfo = ResetInfo.New()

    self.lastReconnectTime = 0

    --重连次数
    self.reconnectTime = 0
    --最大重连次数
    self.maxReconnectTime = 5
    --上一次发送心跳的时间戳
    self.lastHeartBeatTs = 0
    --上一次收到协议的时间戳
    self.lastReceiveTs = 0


    --需要加载的资源
    self.loadingRes = nil
    --加载完成后进入的状态
    self.nextState = nil
    self.loadingResComplete = false

    self.version = "1.2"

    self.progressValue = 0;
    WebSocketManager.instance.handlers = {
        onReceiveHandler = self.onNetworkReceive,
        onErrorHandler = self.onNetworkError,
        onCloseHandler = self.onNetworkClose,
        onOpenHandler = self.onNetworkOpen,
        caller = self
    }
    GameTimer.frameLoop(1, self, self.update)
end

function Game:update()
    self:_checkWsTimeOut()
    self:_sendHeartBeat()

    self.fsm:update()
end

function Game:init()
    self.fsm:changeState(StateGameInit)
    self.camera = Stage.inst:GetRenderCamera()
    self.camera.farClipPlane = 100
    self.camera.allowHDR = true
    self.camera.allowMSAA = false
    self.fishPool = GObjectPool.New(Stage.inst.cachedTransform)
    self.effectPool = GObjectPool.New(Stage.inst.cachedTransform)
    self.aniPool = GObjectPool.New(Stage.inst.cachedTransform)
end

function Game:initFightContext()
    local cfgGlobal = cfg_global.instance(1)
    local cfgSkill = cfg_skill.instance(1)
    local ctx = FightContext.instance()
    ctx.designWidth = 1920
    ctx.designHeight = 1080
    ctx.is3D = false
    ctx.maxBulletNum = cfgGlobal.max_bullet_num
    ctx.shootSound = cfgGlobal.shoot_sound
    ctx.platform = 1
    ctx.haveValidMonthCard = false --TODO
    ctx.autoMode = 1
    ctx.lockMode = 1
    ctx.freezeLastTime = cfgSkill.lasttime
    --ctx.designScaleX = 1920 / designWidth
    --ctx.designScaleY = 1080 / designHeight

    ctx.drawCollisionRect = ENV.DrawCollisionRect
end

function Game:initManager()
    GameInit.instance()
    CmdGateIn.instance()

    SoundManager.PlayMusic("Music/bgmusic.mp3")
    UIFont.defaultFont = "FZY4JW.ttf";
end

function Game:loading(loadingRes, nextState)
    if loadingRes then

        self.loadingRes = loadingRes

        self.nextState = nextState
        self.fsm:changeState(StateGameLoading)
    else
        self.fsm:changeState(nextState)
    end
end

local UpdateProgress = Arthas.GameEntry.UpdateProgress
function Game:preLoad()
    local pathList = ResourceManifest.manifestGroups[LoadType.Preloading]
    Log.debug("ResourceManifest:Preloading", encode(pathList))
    for i, _ in ipairs(pathList) do
        local temp = pathList[i]
        UIPackageManager.instance:AddPackage(temp.path, temp.packageName)
        UpdateProgress(i / #pathList)
    end

end

function Game:loadPackageRes()
    if not self.loadingRes then
        return
    end
    local res = self.loadingRes
    local restload = #res
    return function()
        if restload <= 0 then
            return
        end
        local _, ret = next(res)
        table.remove(res, restload)
        restload = restload - 1
        return ret.path, ret.packageName
    end
end
