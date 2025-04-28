local ActorManager = {}

ActorManager.ActorContainer = {}

ActorManager.ActorPrefabs = {
    -- Zombies
    MeleeZombie = {
        actorType = "MeleeZombie",
        -- Components,AI component must be the last component to Initialize
        ActorComponents = {"AttributeComponent", "CollisionComponent", "AnimComponent", "AIComponent"},
        -- AnimFrameEvent
        AnimFrameEvent = function(self)
            self.animator.ClipsEventNotify:Connect(
                function(key, value)
                    if key == "Die" then
                        self.owner.bindTween:Play()
                    end
                end
            )
        end,
        CollisionComponentBehavior = {
            -- self is the instigator of component collision
            ConnectTouchedFunc = function(thisComponent)
                thisComponent.owner.bindActor.Touched:Connect(
                    function(otherBindActor, pos, normal)
                        if otherBindActor ~= nil then
                            local otherActor = MS.ActorManager:GetActorByUid(otherBindActor:GetAttribute("Uid"))

                            if otherBindActor:GetAttribute("GameplayTag") == "Plant" then
                                local AIComponent = thisComponent.owner.actorComponents["AIComponent"]
                                AIComponent.otherActorUid = otherBindActor:GetAttribute("Uid")
                                AIComponent:SwitchState(AIComponent.StateEnum.Attack)
                            elseif otherBindActor:GetAttribute("GameplayTag") == "Scene" then
                                if otherBindActor.Name == "Lawnmower" then
                                    local direction = Vector3.New(-1, 0, 0)
                                    local goal = {
                                        Position = otherBindActor.Position + direction * 3000
                                    }
                                    local movespeed =
                                        otherActor:GetComponent("AttributeComponent"):GetAttribute("LawnmowerSpeed")
                                    local tween = MS.Tween.CreateTween(otherBindActor, goal, 3000 / movespeed)
                                    otherActor.bindTween = tween
                                    tween:Play()
                                end
                            end
                        end
                    end
                )
            end,
            ConnectTouchEndedFunc = function(thisComponent)
                thisComponent.owner.bindActor.TouchEnded:Connect(
                    function(otherBindActor, pos, normal)
                    end
                )
            end
        },
        -- AIComponentBehavior
        AIComponentBehavior = {
            Idle = function(self)
                if self.preState ~= self.StateEnum.Idle then
                    self:SwitchState(self.StateEnum.Idle)
                    self.owner.actorComponents["AnimComponent"].animator:Play("Idle", 0, 0)
                end
            end,
            Move = function(self)
                if self.preState ~= self.StateEnum.Move then
                    self:SwitchState(self.StateEnum.Move)
                    self.owner.bindTween:Play()
                end
                --print("self.owner.bindActor.LocalPosition.x = "..self.owner.bindActor.Position.x)
                if self.owner.bindActor.Position.x > 260 then
                    -- 僵尸越线，减少玩家生命值
                    self.owner.bindActor.Position = Vector3.New(0,0,0)
                    self.owner.bindTween:Cancel()
                    MS.GameMode.RemoveSpawnZombie(self.owner)
                    -- 减少玩家生命值，如果生命值小于等于0，会触发游戏结束
                    MS.GameMode.ModifyPlayerHp(-20)
                end
            end,
            Attack = function(self, otherActorUid)
                MS.SoundManager:PlaySound(MS.SoundManager.SoundId.Zombie_Attack)
                local otherActor = MS.ActorManager:GetActorByUid(otherActorUid)
	            if otherActor ~= nil then 
                    if otherActor.bindActor.Position.x - self.owner.bindActor.Position.x < 0 then
                        return
                    end
                end
                if otherActor ~= nil then
                    self.owner.bindTween:Pause()
                    if self.preState ~= self.StateEnum.Attack then
                        self:SwitchState(self.StateEnum.Attack)
                        MS.SoundManager:PlaySound(MS.SoundManager.SoundId.Zombie_Attack)
                        self.owner.actorComponents["AnimComponent"].animator:Play("AtkStart", 0, 0)
                    end
                    otherActor.actorComponents["AttributeComponent"]:TakeDamage(
                        self.owner.actorComponents["AttributeComponent"].Attributes.damage
                    )
                    if otherActor.bindActor.HitEffect ~= nil then
                        otherActor.bindActor.HitEffect:Start()
                    end
                else
                    self.owner.actorComponents["AnimComponent"].animator:Play("AtkEnd", 0, 0)
                    self.owner.actorComponents["AIComponent"]:SwitchState(
                        self.owner.actorComponents["AIComponent"].StateEnum.Move
                    )
                    self.owner.bindTween:Resume()
                end
            end,
            Die = function(self)
                self.owner.bindTween:Cancel()
                self.owner.bindActor.EnablePhysics = false

                local goal = {
                    Position = self.owner.bindActor.Position + Vector3.New(0, -40, 0)
                }
                self.owner.bindTween = MS.Tween.CreateTween(self.owner.bindActor, goal, 1)
                self.owner.actorComponents["AnimComponent"].animator:Play("Die", 0, 0)
                wait(2)
                MS.GameMode.RemoveSpawnZombie(self.owner)
            end
        }
    },
    -- Plants
    ShooterPlant = {
        actorType = "ShooterPlant",
        SpawnProps = {
            spawnObjectClass = "Bullet",
            spawnObjectName = "",
            spawnLocationOffset = Vector3.New(-20, 50, 0),
            spawnEulerOffset = Vector3.New(0, 0, 0),
            spawnDirection = Vector3.New(-1, 0, 0),
            spawnSpeed = 0
        },
        RaycastProps = {
            originOffset = Vector3.New(-10, 50, 0),
            unitDir = Vector3.New(-1, 0, 0),
            distance = 3000,
            isIgnoreTrigger = false,
            filterGroup = {3},
            fixedUpdateRate = 0.2
        },
        -- Components(Need to be Initialized)
        ActorComponents = {"AttributeComponent", "RaycastComponent", "SpawnComponent", "AnimComponent", "AIComponent"},
        -- AnimFrameEvent
        AnimFrameEvent = function(self)
            self.animator.ClipsEventNotify:Connect(
                function(key, value)
                    --if key == "SpawnProjectile" then
                        --self.owner.actorComponents["SpawnComponent"]:Spawn()
                    --end
                end
            )
        end,
        -- AIComponentBehavior
        AIComponentBehavior = {
            Idle = function(self)
            end,
            Move = function(self)
            end,
            Attack = function(self, otherActor)
                MS.SoundManager:PlaySound(MS.SoundManager.SoundId.Plant_Shoot)
                local plantName = self.owner.bindActor.Name
                if plantName == "PeaShooter" then
                    self.owner.actorComponents["AnimComponent"].animator:Play("BaseLayer.Atk", 0, 0)
                elseif plantName == "SnowpeaShooter" then
                    
                    self.owner.actorComponents["AnimComponent"].animator:Play("Base Layer.Atk", 0, 0)
                else
                    self.owner.actorComponents["AnimComponent"].animator:Play("Base Layer.ATK1", 0, 0)
                end
                
                MS.Timer.CreateTimer(
                    0.5,
                    0,
                    false,
                    function()
						if plantName  ~= "SnowpeaShooterEx" then
							self.owner.actorComponents["SpawnComponent"]:Spawn()
						else
							self.owner.actorComponents["SpawnComponent"]:Spawn()
							wait(0.1)
							self.owner.actorComponents["SpawnComponent"]:Spawn()
							wait(0.1)
							self.owner.actorComponents["SpawnComponent"]:Spawn()
						end
                    end
                ):Start()
            end,
            Die = function(self)
                self.owner.bindActor.EnablePhysics = false
                MS.LevelManager.RemoveActor(self.owner)
            end
        }
    },
    ProductivePlant = {
        actorType = "ProductivePlant",
        SpawnProps = {
            spawnObjectClass = "Drop",
            spawnObjectName = "",
            spawnLocationOffset = Vector3.New(0, 20, -10),
            spawnEulerOffset = Vector3.New(-40, -90, 0),
            spawnDirection = Vector3.New(-100, 0, 100),
            spawnSpeed = 10
        },
        -- Components(Need to be Initialized)
        ActorComponents = {"AttributeComponent", "AnimComponent", "SpawnComponent", "AIComponent"},
        -- AnimFrameEvent
        AnimFrameEvent = function(self)
            self.animator.ClipsEventNotify:Connect(
                function(key, value)
                    if key == "SpawnSunshine" then
                        self.owner.actorComponents["SpawnComponent"]:Spawn()
                    end
                end
            )
        end,
        -- AIComponentBehavior
        AIComponentBehavior = {
            Idle = function(self)
            end,
            Move = function(self)
            end,
            Attack = function(self, otherActor)
                self.owner.actorComponents["AnimComponent"].animator:Play("Atk", 0, 0)
            end,
            Die = function(self)
                self.owner.bindActor.EnablePhysics = false
                MS.LevelManager.RemoveActor(self.owner)
            end
        }
    },
    -- Bullet
    Bullet = {
        actorType = "Bullet",
        ActorComponents = {"AttributeComponent", "CollisionComponent"},
        -- CollisionComponentBehavior
        CollisionComponentBehavior = {
            -- self is the instigator of component collision
            ConnectTouchedFunc = function(thisComponent)
                thisComponent.owner.bindActor.Touched:Connect(
                    function(otherBindActor, pos, normal)
                        if otherBindActor:GetAttribute("GameplayTag") == "Zombie" then
                            MS.SoundManager:PlaySound(MS.SoundManager.SoundId.Hit_Zombie)
                            local otherActor = MS.ActorManager:GetActorByUid(otherBindActor:GetAttribute("Uid"))
                            otherActor.bindActor.HitEffect.AssetID =
                                thisComponent.owner.actorComponents["AttributeComponent"].Attributes.hitEffect
                            otherActor.bindActor.HitEffect:Start()
                            otherActor.actorComponents["AttributeComponent"]:TakeDamage(
                                thisComponent.owner.actorComponents["AttributeComponent"].Attributes.damage
                            )
                            MS.LevelManager.RemoveActor(thisComponent.owner)
							if math.random(1, 100) < 15 then
                                otherActor.bindTween:Pause()
                                otherActor.actorComponents["AIComponent"].updateEnabled = false
                                
                                otherActor.actorComponents["AnimComponent"].animator.Pause = true
                                if thisComponent.owner.bindActor.Name == "Snowpea" then
                                    wait(0.3)
                                elseif thisComponent.owner.bindActor.Name == "SnowpeaEx" then
                                    wait(0.7)
                                end
                                otherActor.bindTween:Resume()
                                otherActor.actorComponents["AIComponent"].updateEnabled = true
                                otherActor.actorComponents["AnimComponent"].animator.Pause = false
                            end
                        end
                    end
                )
            end,
            ConnectTouchEndedFunc = function(thisComponent)
                thisComponent.owner.bindActor.Touched:Connect(
                    function(otherBindActor, pos, normal)
                    end
                )
            end
        }
    },
    -- Drop
    Drop = {
        actorType = "Drop",
        Attributes = {
            lifetime = 15
        },
        ActorComponents = {"AttributeComponent"}
        -- Attributes(Need to be Initialized)
        -- CollisionComponentBehavior
    },
    -- Scene
    Scene = {
        actorType = "Scene",
        ActorComponents = {"AttributeComponent", "CollisionComponent"},
        CollisionComponentBehavior = {
            -- self is the instigator of component collision
            ConnectTouchedFunc = function(thisComponent)
                thisComponent.owner.bindActor.Touched:Connect(
                    function(otherBindActor, pos, normal)
                        if otherBindActor:GetAttribute("GameplayTag") == "Zombie" then
                            local otherActor = MS.ActorManager:GetActorByUid(otherBindActor:GetAttribute("Uid"))
                            otherActor.actorComponents["AttributeComponent"]:TakeDamage(9999)
                        end
                    end
                )
            end,
            ConnectTouchEndedFunc = function(thisComponent)
                thisComponent.owner.bindActor.Touched:Connect(
                    function(otherBindActor, pos, normal)
                    end
                )
            end
        }
        -- CollisionComponentBehavior
    },
    DefensePlant = {
        actorType = "DefensePlant",
        -- Components(Need to be Initialized)
        ActorComponents = {"AttributeComponent", "AnimComponent", "AIComponent"},
        -- AIComponentBehavior
        AIComponentBehavior = {
            Idle = function(self)
            end,
            Move = function(self)
            end,
            Attack = function(self, otherActor)
            end,
            Die = function(self)
                self.owner.bindActor.EnablePhysics = false
                MS.LevelManager.RemoveActor(self.owner)
            end
        }
    }
}

function ActorManager:CreateActor(bindObj, actorClass, actorPrefabName, uid)
    local configNode = MS.Config.GetCustomConfigNode(actorPrefabName)
    local configData = require(configNode.Data)
    for _, prefab in pairs(ActorManager.ActorPrefabs) do
        if prefab.actorType == configData.actorType then
            local actor = MS.ActorBase.new(bindObj, actorClass, uid)

            for _, componentName in ipairs(prefab.ActorComponents) do
                local componentClass = require(MS.MainStorage.Actor.ActorComponent:WaitForChild(componentName))
                local component = componentClass.new(actor)
                actor.actorComponents[componentName] = component
            end
            -- Init Components
            if actor.actorComponents["AttributeComponent"] ~= nil then
                local component = actor:GetComponent("AttributeComponent")
                local Attributes = configData.Attributes

                component:Init(Attributes)
            end

            if actor.actorComponents["CollisionComponent"] ~= nil then
                local component = actor:GetComponent("CollisionComponent")
                local ConnectTouchedFunc = prefab.CollisionComponentBehavior.ConnectTouchedFunc
                local ConnectTouchEndedFunc = prefab.CollisionComponentBehavior.ConnectTouchEndedFunc

                if ConnectTouchedFunc ~= nil and ConnectTouchEndedFunc ~= nil then
                    component:Init(ConnectTouchedFunc, ConnectTouchEndedFunc)
                end
            end

            if actor.actorComponents["SpawnComponent"] ~= nil then
                local component = actor:GetComponent("SpawnComponent")

                local attributeComponent = actor:GetComponent("AttributeComponent")
                prefab.SpawnProps.spawnObjectName = attributeComponent.Attributes.spawnObjectName
                prefab.SpawnProps.spawnSpeed = attributeComponent.Attributes.spawnSpeed

                component:Init(prefab.SpawnProps)
            end

            if actor.actorComponents["AnimComponent"] ~= nil then
                local component = actor:GetComponent("AnimComponent")
                local animator = actor.bindActor.Animator
                local AnimFrameEvent = prefab.AnimFrameEvent

                if animator ~= nil and AnimFrameEvent ~= nil then
                    component:Init(animator, AnimFrameEvent)
                end
            end

            if actor.actorComponents["RaycastComponent"] ~= nil then
                local component = actor:GetComponent("RaycastComponent")
                local RaycastProps = prefab.RaycastProps

                if RaycastProps ~= nil then
                    component:Init(RaycastProps, 0.2)
                end
            end

            if actor.actorComponents["AIComponent"] ~= nil then
                local component = actor:GetComponent("AIComponent")
                local AIComponentBehavior = prefab.AIComponentBehavior

                local attributeComponent = actor:GetComponent("AttributeComponent")
                local speed =
                    attributeComponent.Attributes.attackSpeed or attributeComponent.Attributes.productSpeed or nil

                if AIComponentBehavior ~= nil and speed ~= nil then
                    component:Init(AIComponentBehavior, speed)
                end
            end

            ActorManager.ActorContainer[actor.uid] = actor

            -- Auto Destroy
            ActorManager:CreateActorDestroyTimer(actor.uid)

            return actor
        end
    end
end

function ActorManager:CreateActorDestroyTimer(uid)
    local lifetime = 0

    local actor = ActorManager:GetActorByUid(uid)
    if actor:GetComponent("AttributeComponent") ~= nil then
        local component = actor:GetComponent("AttributeComponent")
        lifetime = component.Attributes.lifetime or 0
    end

    if lifetime ~= 0 then
        MS.Timer.CreateTimer(
            lifetime,
            lifetime,
            false,
            function()
                if ActorManager:GetActorByUid(uid) ~= nil then
                    ActorManager:DestroyActorByUid(uid)
                end
            end
        ):Start()
    end
end

function ActorManager:GetActorByUid(uid)
    return ActorManager.ActorContainer[uid]
end

function ActorManager:DestroyActorByUid(uid)
    local actor = ActorManager:GetActorByUid(uid)
    if actor ~= nil then
        if actor.actorComponents["AIComponent"] then
            actor.actorComponents["AIComponent"].updateEnabled = false
        end
        actor.bindActor:Destroy()
        ActorManager.ActorContainer[uid] = nil
    end
end

function ActorManager:DestroyAllActors()
    for uid, _ in pairs(ActorManager.ActorContainer) do
        self:DestroyActorByUid(uid)
    end
end

function ActorManager.Init()
end

-- helper function

return ActorManager
