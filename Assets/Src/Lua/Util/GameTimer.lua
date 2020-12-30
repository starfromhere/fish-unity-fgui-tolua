---@class GameTimer
GameTimer = class("GameTimer")

---@class GameHandler
GameHandler = class("GameHandler")
GameTimer._Handlers = {}
GameTimer._TargetHandlers = {}
GameTimer._TimestampHandlers = {}

function GameHandler:ctor(useFrame, loop, delay, caller, func, args, useTimestamp)
    self.useFrame = useFrame
    self.loop = loop
    self.delay = delay
    self.caller = caller
    self.func = func
    self.args = args or {}
    self.useTimestamp = useTimestamp or false
    if useTimestamp then
        self.calcDelay = delay + TimeTools.getCurMill()
    else
        self.calcDelay = delay
    end

    self.isStop = false
    table.insert(self.args, self)

    function GameHandler:clear()
        for i, v in ipairs(GameTimer._Handlers) do
            if v == self then
                self.isStop = true
                break
            end
        end
        for i, v in ipairs(GameTimer._TimestampHandlers) do
            if v == self then
                self.isStop = true
                break
            end
        end
    end
end

function GameTimer.frameUpdate(delta)
    local handler
    local i = 1

    while i <= #GameTimer._Handlers do
        handler = GameTimer._Handlers[i]
        if handler.isStop then
            table.remove(GameTimer._Handlers, i)
        else
            if handler.useFrame then
                handler.calcDelay = handler.calcDelay - 1
            else
                handler.calcDelay = handler.calcDelay - delta * 1000
            end
            if handler.calcDelay <= 0 then
                handler.func(handler.caller, unpack(handler.args))
                if handler.loop then
                    if handler.useFrame then
                        handler.calcDelay = handler.delay
                    else
                        handler.calcDelay = handler.delay + handler.calcDelay
                    end
                    i = i + 1
                else
                    table.remove(GameTimer._Handlers, i)
                end
            else
                i = i + 1
            end


            --if handler.calcDelay <= 0 then
            --    handler.func(handler.caller, unpack(handler.args))
            --    if handler.loop then
            --        handler.calcDelay = handler.delay
            --        handler.calcDelay = handler.calcDelay - 1
            --        i = i + 1
            --    else
            --        table.remove(GameTimer._Handlers, i)
            --    end
            --else
            --
            --    if handler.useFrame then
            --        handler.calcDelay = handler.calcDelay - 1
            --    else
            --        handler.calcDelay = handler.calcDelay - delta * 1000
            --    end
            --    i = i + 1
            --end

        end
    
    end

    i = 1
    while i <= #GameTimer._TimestampHandlers do
        handler = GameTimer._TimestampHandlers[i]
        if handler.isStop then
            table.remove(GameTimer._TimestampHandlers, i)
        else
            local curMill = TimeTools.getCurMill()
            if handler.useFrame then
                handler.calcDelay = handler.calcDelay - 1
            else
                if handler.calcDelay < curMill then
                    handler.calcDelay = 0
                end
            end
            if handler.calcDelay <= 0 then
                handler.func(handler.caller, unpack(handler.args))
                if handler.loop then
                    if handler.useFrame then
                        handler.calcDelay = handler.delay
                    else
                        handler.calcDelay = handler.delay + curMill
                    end
                    i = i + 1
                else
                    table.remove(GameTimer._TimestampHandlers, i)
                end
            else
                i = i + 1
            end

        end
    end
end

function GameTimer.insertHandlers(handler, caller)
    if not GameTimer._TargetHandlers[caller] then
        GameTimer._TargetHandlers[caller] = {}
    end
    table.insert(GameTimer._Handlers, handler)
    table.insert(GameTimer._TargetHandlers[caller], handler)
end

function GameTimer.insertTimestampHandlers(handler, caller)
    if not GameTimer._TargetHandlers[caller] then
        GameTimer._TargetHandlers[caller] = {}
    end
    table.insert(GameTimer._TimestampHandlers, handler)
    table.insert(GameTimer._TargetHandlers[caller], handler)
end

function GameTimer.clearTarget(caller)
    local handles = GameTimer._TargetHandlers[caller] or {}
    for _, handler in pairs(handles) do
        handler:clear()
    end
end
---@return GameHandler
function GameTimer.loop(delay, caller, method, args)

    local handler = GameHandler.New(false, true, delay, caller, method, args)
    GameTimer.insertHandlers(handler, caller)
    return handler
end
---@return GameHandler
function GameTimer.once(delay, caller, method, args)
    local handler = GameHandler.New(false, false, delay, caller, method, args)
    GameTimer.insertHandlers(handler, caller)
    return handler
end

---@return GameHandler
function GameTimer.frameLoop(delay, caller, method, args)
    local handler = GameHandler.New(true, true, delay, caller, method, args)
    GameTimer.insertHandlers(handler, caller)
    return handler
end

---@return GameHandler
function GameTimer.frameOnce(delay, caller, method, args)
    local handler = GameHandler.New(true, false, delay, caller, method, args)
    GameTimer.insertHandlers(handler, caller)
    return handler
end

---@return GameHandler
function GameTimer.TimeOnce(delay, caller, method, args)
    local handler = GameHandler.New(false, false, delay, caller, method, args, true)
    GameTimer.insertTimestampHandlers(handler, caller)
    return handler
end

local __timer = FrameTimer.New(function()
    GameTimer.frameUpdate(Time.deltaTime)
end, 1, -1)
__timer:Start()

