---@class FSM
---@field New FSM
FSM = class("FSM")
function FSM:ctor(owner, currentState, prevState, globalState)
    self._owner = owner
    self._currentState = currentState
    self._prevState = prevState
    self._globalState = globalState
end
function FSM:update()
    if self._globalState then
        self._globalState:execute(self._owner)

    end
    if self._currentState then
        self._currentState:execute(self._owner)
    end
end
function FSM:changeState(newState, ...)
    if newState and newState ~= self._currentState then
        self._prevState = self._currentState
        self._currentState = newState
        if self._prevState then
            self._prevState:exit(self._owner)
        end
        newState:enter(self._owner, ...)
    end
end
function FSM:revertToPrevState()
    self:changeState(self._prevState)
end
function FSM:isInState(stateClazz)
    return self._currentState == stateClazz
end
function FSM:isInStates(clazzArr)
    for _, state in pairs(clazzArr) do
        if self:isInState(state) then
            return true
        end
    end
    return false
end
function FSM:isNotInStates(clazzArr)
    return not self:isInStates(clazzArr)
end

