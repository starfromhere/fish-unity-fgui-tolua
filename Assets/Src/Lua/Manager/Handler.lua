
---@class Handler
Handler = class('Handler')

function Handler:ctor(callback, caller, ...)
    self._callback = callback
    self._caller = caller
    self._args = select("#",...) > 0 and {...} or {}
end

function Handler.Create(callback, caller, ...)
    return Handler.new(callback, caller, ...)
end

function Handler:Call()
    if self._caller then
        self._callback(self._caller, unpack(self._args))
    else
        self._callback(unpack(self._args))
    end
end