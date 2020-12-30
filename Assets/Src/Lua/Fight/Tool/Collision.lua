obb = class("obb")

function obb:ctor(pivot, size, rotation)
    self.pivot = pivot
    self.size = size
    self.rotation = math.rad(rotation)
end

function obb:updatePos(pivot, rotation)
    self.pivot = pivot
    self.rotation = math.rad(rotation)
end

function obb:local2World()
    local verts = {};
    verts[1] = Vector2.New(-self.size.x * 0.5, -self.size.y * 0.5);
    verts[2] =  Vector2.New( self.size.x * 0.5, -self.size.y * 0.5);
    verts[3] =  Vector2.New( self.size.x * 0.5,  self.size.y * 0.5);
    verts[4] =  Vector2.New(-self.size.x * 0.5,  self.size.y * 0.5);

    for i=1,#verts do
        local v = Vector2.New(verts[i].x, verts[i].y);
        verts[i].x = v.x * math.cos(self.rotation) - v.y * math.sin(self.rotation) + self.pivot.x;
        verts[i].y = v.x * math.sin(self.rotation) + v.y * math.cos(self.rotation) + self.pivot.y;
    end
    return verts;
end

collision = class("collision")

function collision:isOBBOverlap(o1, o2)
    
        local  axes = {}
        axes[1] = Vector2.New( math.cos(o1.rotation), math.sin(o1.rotation));
        axes[2] = Vector2.New(-math.sin(o1.rotation), math.cos(o1.rotation));
        axes[3] = Vector2.New( math.cos(o2.rotation), math.sin(o2.rotation));
        axes[4] = Vector2.New(-math.sin(o2.rotation), math.cos(o2.rotation));
    
        local verts1 = o1:local2World();
        local verts2 = o2:local2World();
    
        for i=1, #axes do
            -- // find max and min from o1
            
            local min1 = math.huge
            local max1 = -math.huge
            local ret1
            for j = 1, #verts1 do
            
                ret1 = Vector2.Dot(verts1[j], axes[i])
                -- verts1[j].dot(axes[i]);
                min1 = min1 > ret1 and ret1 or min1
                max1 = max1 < ret1 and ret1 or max1
            end
    
            -- // find max and min from o2
            local min2 = math.huge  
            local max2 = -math.huge
            local ret2;
            for j = 1, #verts2 do
                ret2 = Vector2.Dot(verts2[j], axes[i])
                -- verts2[j].dot(axes[i]);
                min2 = min2 > ret2 and ret2 or min2;
                max2 = max2 < ret2 and ret2 or max2;
            end
            -- // overlap check
            local r1 = max1 - min1;
            local r2 = max2 - min2;
            local r = (max1 > max2 and max1 or max2) - (min1 < min2 and min1 or min2)
            if (r1 + r2 <= r) then
                return false;
            end
        end
    
        return true;
    end