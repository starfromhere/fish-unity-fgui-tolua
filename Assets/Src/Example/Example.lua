require("Class")

-- @eg:
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
local Animate = class("Animate")
function Animate:ctor(name, typ)
    self.varTest = "111"
    self.name = name
    self.typ = typ
    print("Animate construct function!!!", self.name)
    self.tp = 5
    self:test()
    
end

function Animate:showName()
    print("normal Animate")
end

function Animate:setTempValue()
    self.temp = 666
end

function Animate:test()
    print("Animate:test: ", self.varTest)
end

local Brid = class("Brid", Animate)
function Brid:ctor(name, typ)
    Brid.super.ctor(self)
    self.name = name
    self.type = typ
    print("Brid construct function!!!", self.name)
end

function Brid:showName()
    --super.showName()
    print("beautiful Brid!!!")
end

function Brid:test()
    Brid.super.test(self)
    print("Brid:test: ", self.varTest)
end

local HaiOu = class("HaiOu", Brid)
function HaiOu:ctor(name, typ)
    HaiOu.super.ctor(self)
    self.name = "HAHA"
    self.name = name or self.name
    self.type = typ
    print("HaiOu construct function!!!", tostring(self),self.name )
end

function HaiOu:showName(str)
    --super.showName()
    print("beautiful HaiOu!!!", self.name, str)
    self.varTest = "HaiOuTest"
end

--local ho = HaiOu.new("shuiHaiou")
--HaiOu.instance("tantantan")
--HaiOu.instance("shuiHaiou"):showName("hahaha")
--HaiOu.instance("shuiHaiou").name

--HaiOu.instance.name = "2222"
--ho.name = "tptpt"
--HaiOu.instance:showName()
--ho:showName()

--tt = {age = 12, func = function (...)
--    print(...)
--end}
--td = class("td", tt)
--function td:ctor(name, typ)
--    self.name = name
--    self.type = typ
--    print("td construct function!!!")
--end
--
--function td:showName()
--    print("beautiful td!!!")
--end
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
--bd = Brid.new("huahua", "maque")
--print(bd.tp, bd.temp)
--bd.tp = 10
--bd:setTempValue()
--print(bd.tp, bd.temp, bd.name, bd.type)
--bd:showName()
--
--bp = Brid.new("xiaohei", "wuya")
--print(bp.tp, bp.temp, bp.name, bp.type)
--print("tostring value --->>>", tostring(bd), tostring(bp))
