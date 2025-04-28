local SpawnComponent = MS.Class.new("SpawnComponent", MS.ActorComponent)

function SpawnComponent:ctor()
    self.SpawnProps = {}
end

function SpawnComponent:Init(spawnProps)
    self.SpawnProps = MS.Utils.deepCopy(spawnProps)
end

function SpawnComponent:CreateSpawnTween(spawnActor, spawnActorLifetime, spawnActorSpeed)
    local goal = nil
    local tween = nil 
    if self.SpawnProps.spawnObjectClass == "Drop" and self.SpawnProps.spawnObjectName == "Sunshine" then
        goal = {
            Position = spawnActor.bindActor.Position + self.SpawnProps.spawnDirection * spawnActorSpeed
        }
        tween = MS.Tween.CreateTween(spawnActor.bindActor, goal, spawnActorSpeed)
    else
        goal = {
            Position = spawnActor.bindActor.Position + self.SpawnProps.spawnDirection * spawnActorSpeed * spawnActorLifetime
        }
        tween = MS.Tween.CreateTween(spawnActor.bindActor, goal, spawnActorLifetime)
    end
    
    tween:Play()
end

function SpawnComponent:Spawn()
    local spawnActor =
        MS.LevelManager.SpawnActor(
        self.SpawnProps.spawnObjectClass,
        self.SpawnProps.spawnObjectName,
        MS.WorkSpace,
        self.owner.bindActor.Position + self.SpawnProps.spawnLocationOffset,
        self.owner.bindActor.Euler + self.SpawnProps.spawnEulerOffset
    )

    local spawnActorAttribute = spawnActor:GetComponent("AttributeComponent").Attributes
    local spawnActorLifetime = spawnActorAttribute.lifetime
    local spawnActorSpeed = self.SpawnProps.spawnSpeed

    -- 确保阳光有正确的生命周期
    if self.SpawnProps.spawnObjectClass == "Drop" and self.SpawnProps.spawnObjectName == "Sunshine" then
        -- 如果生命周期未设置，则设置为15秒（与自然生成的阳光一致）
        if spawnActorLifetime == 0 then
            spawnActorAttribute.lifetime = 15
            spawnActorLifetime = 15
        end
    end

    self:CreateSpawnTween(spawnActor, spawnActorLifetime, spawnActorSpeed)
end

return SpawnComponent
