---@class BulletInfoParser
BulletInfoParser = class("BulletInfoParser")
function BulletInfoParser:ctor()
    self.p = nil
end

--废弃不使用
function BulletInfoParser:getStartX()
    return self.p[1]
end
--废弃不使用
function BulletInfoParser:getStartY()
    return self.p[2]
end
function BulletInfoParser:getEndX()
    return self.p[3]

end
function BulletInfoParser:getEndY()
    return self.p[4]

end
function BulletInfoParser:getSk()
    return self.p[5]

end
function BulletInfoParser:getBt()
    return self.p[6]

end
function BulletInfoParser:getUniId()
    return self.p[7]

end
function BulletInfoParser:getSeatId()
    return self.p[8]

end
function BulletInfoParser:getCoin()
    return self.p[9]

end
function BulletInfoParser:getAgent()
    return self.p[10]

end
function BulletInfoParser:getSr()
    return self.p[11]

end

function BulletInfoParser:getFuid()
    return self.p[12]
end

function BulletInfoParser:getM()
    return self.p[13]

end
function BulletInfoParser:getHitCount()
    return self.p[14]

end
function BulletInfoParser:getTick()
    return self.p[15]
end

