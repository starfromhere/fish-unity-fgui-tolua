---@class CollisionRectangle
CollisionRectangle = class("CollisionRectangle")

--p1~p4 按照矩形顺时针或者逆时针
function CollisionRectangle:ctor(width, height)

    self.width = width
    self.height = height
    ---@type Vector2
    self.p1 = Vector2.New(0, 0)
    ---@type Vector2
    self.p2 = Vector2.New(0, 0)
    ---@type Vector2
    self.p3 = Vector2.New(0, 0)
    ---@type Vector2
    self.p4 = Vector2.New(0, 0)
end


--获取向量积
---@param p1 Vector2
---@param p2 Vector2
---@param p Vector2
function CollisionRectangle:getCrossProduct(p1, p2, p)
    return (p2.x - p1.x) * (p.y - p1.y) - (p.x - p1.x) * (p2.y - p1.y)
end

---@param p Vector2
function CollisionRectangle:contains(p)
    return (self:getCrossProduct(self.p1, self.p2, p) * self:getCrossProduct(self.p3, self.p4, p)) >= 0
            and (self:getCrossProduct(self.p2, self.p3, p) * self:getCrossProduct(self.p4, self.p1, p)) >= 0
end



--cos -sin
--sin cos



---@param centerPoint Vector2
---@param rotation number
function CollisionRectangle:reset(centerPoint, rotation)
    self.centerPoint = centerPoint
    self.rotation = rotation

    local sin = Mathf.Sin(rotation * Mathf.Deg2Rad)
    local cos = Mathf.Cos(rotation * Mathf.Deg2Rad)
    local offsetX = self.width / 2
    local offsetY = self.height / 2

    self.p1.x = centerPoint.x + (offsetX * cos + offsetY * sin)
    self.p1.y = centerPoint.y + (offsetX * -sin + offsetY * cos)

    self.p2.x = centerPoint.x + (offsetX * cos + -offsetY * sin)
    self.p2.y = centerPoint.y + (offsetX * -sin + -offsetY * cos)

    self.p3.x = centerPoint.x + (-offsetX * cos + -offsetY * sin)
    self.p3.y = centerPoint.y + (-offsetX * -sin + -offsetY * cos)

    self.p4.x = centerPoint.x + (-offsetX * cos + offsetY * sin)
    self.p4.y = centerPoint.y + (-offsetX * -sin + offsetY * cos)
end



