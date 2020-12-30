MeshSharing = class("MeshSharing")

function MeshSharing:ctor()
    self.meshArray = {}
    self.matArray = {}
    self.meshRenderArray = {}
    self.transformArray = {}
    self.parentTranArray = {}
    self.initFlag = false
    self.meshfish = {}
    self.meshfish = {"xiaochouyu_down_swim","xiaochouyu_down_death","qingtingyu_down_swim","jianzuiyu_down_swim","jianzuiyu_down_death","hetun_down_swim","hetun_down_death"}--,"xueyu_down_swim","shanhuyu_down_swim","moguiyu_down_swim"}
end

function MeshSharing:init()
    if self.initFlag then return end
    for _,v in pairs(self.meshfish) do
        local obj = GameTools.ResourcesLoad("Fish/"..v)
        MeshSharing.instance:initFish(obj.transform:GetChild(0).transform:Find("fishBody"),v)
    end
    self.initFlag = true
end

function MeshSharing:initFish(fish,name)
    if self.meshArray[name] then

    else
        local meshrender = fish.gameObject:GetComponent("SkinnedMeshRenderer")
        -- Log.error("材质是否支持 instancing " ..meshrender.sharedMaterial.enableInstancing .. "</color>");
		-- Log.error("<color=#FF0000>系统是否支持 instancing " .. UnityEngine.SystemInfo.supportsInstancing .. "</color>");
        self.meshRenderArray[name] = meshrender
        self.matArray[name] = meshrender.material
        self.meshArray[name] = UnityEngine.Mesh.New()
        self.transformArray[name] = fish.transform
        self.parentTranArray[name] = fish.parent.transform

    end
end

function MeshSharing:addFish(fish, name)
    -- local rotation =  self.transformArray[name].localRotation
    -- local rotationp =  self.parentTranArray[name].localRotation
    -- local scale = self.transformArray[name].localScale
    -- local scalep = self.parentTranArray[name].localScale
    -- fish.transform.localScale = scale
    -- Vector3.New(1/scale.x,1/scale.y,1/scale.z);
    -- fish.transform.localRotation = rotation
    -- fish.parent.transform.localRotation = rotationp
    -- fish.transform.localScale = scale
    -- fish.parent.transform.localScale = scalep
    -- fish.transform.localPosition = self.transformArray[name].localPosition:Clone()
    -- fish.parent.transform.localPosition = self.parentTranArray[name].localPosition:Clone()
    -- local scale =self.transformArray[name].lossyScale
    -- local localScale = Vector3.New(1 / scale.x, 1 / scale.y, 1 / scale.z)
    --     fish.transform.localScale = localScale
    local mf =  fish.gameObject:GetComponent("MeshFilter")
    if not mf then
        mf = fish.gameObject:AddComponent("MeshFilter")
    end
    mf.sharedMesh = self.meshArray[name]
    local mr = fish.gameObject:GetComponent("MeshRenderer")
    if not mr then
        mr = fish.gameObject:AddComponent("MeshRenderer")
        mr.receiveShadows = false
        mr.shadowCastingMode = 0;
    end
    mr.sharedMaterial = self.matArray[name]
end

function MeshSharing:changeStop()

end

function MeshSharing:changeDeath(fish,name)
    local mf =  fish.gameObject:GetComponent("MeshFilter")
    if not mf then
        mf = fish.gameObject:AddComponent("MeshFilter")
    end
    mf.sharedMesh = self.meshArray[name]
    local mr = fish.gameObject:GetComponent("MeshRenderer")
    if not mr then
        mr = fish.gameObject:AddComponent("MeshRenderer")
        mr.receiveShadows = false
        mr.shadowCastingMode = 0;
    end
    mr.sharedMaterial = self.matArray[name]
end

function MeshSharing:frameUpdate()
    
    for k,v in pairs(self.meshArray) do
        v:Clear()
        self.meshRenderArray[k]:BakeMesh(v)
    end
end

function MeshSharing:isMeshFish(name, wind)
    if wind then return 0 end
    -- luadump( table.indexOf(self.meshfish, name))
    if table.indexOf(self.meshfish, name) > -1 then
        if self.meshArray[name] then
            return 2
        else
            return 1
        end
    else
        return 0
    end
end
 