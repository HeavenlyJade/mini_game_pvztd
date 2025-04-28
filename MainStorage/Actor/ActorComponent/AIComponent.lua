local AIComponent = MS.Class.new("AIComponent", MS.ActorComponent)

AIComponent.StateEnum = {
    Idle = 1,
    Move = 2,
    Attack = 3,
    Die = 4
}

function AIComponent:ctor()
    self.updateEnabled = true
    self.preState = nil
    self.currentState = nil
    self.AIBehaviors = {}

    self.otherActorUid = nil
end

function AIComponent:Update()
    if self.updateEnabled then
        if self.owner.actorClass == "Plant" then
            if self.owner.actorComponents["RaycastComponent"] ~= nil then
                local hitResult = self.owner.actorComponents["RaycastComponent"].HitResult
                if hitResult.isHit == true and hitResult.obj:GetAttribute("GameplayTag") == "Zombie" then
                    local SM_Spawn = MS.WorkSpace.Level1:WaitForChild("ZombieSpawnGroup"):WaitForChild("SM_Spawn1")
                    if hitResult.obj.Position.x > (SM_Spawn.Position.x+120) then
                        self.currentState = AIComponent.StateEnum.Attack
                    end
                else
                    self.currentState = AIComponent.StateEnum.Idle
                end
            else
                self.currentState = AIComponent.StateEnum.Attack
            end
        end
        self:Act()
    end
end

function AIComponent:Act()
    if self.currentState == AIComponent.StateEnum.Idle then
        self.AIBehaviors.Idle(self)
    elseif self.currentState == AIComponent.StateEnum.Move then
        self.AIBehaviors.Move(self)
    elseif self.currentState == AIComponent.StateEnum.Attack then
        self.AIBehaviors.Attack(self, self.otherActorUid)
    end
end

function AIComponent:SwitchState(state)
    if self.preState ~= state then
        self.preState = self.currentState
        self.currentState = state
    end
end

function AIComponent:InitBehavior(AIBehaviors)
    self.AIBehaviors = MS.Utils.deepCopy(AIBehaviors)
end

function AIComponent:Init(AIBehavior, UpdateRate)
    self:InitBehavior(AIBehavior)

    self.fixedUpdateRate = UpdateRate
    MS.Timer.CreateTimer(
        self.fixedUpdateRate,
        self.fixedUpdateRate,
        true,
        function()
            self:Update()
        end
    ):Start()

    if self.owner.actorClass == "Zombie" then
        local direction = Vector3.New(1, 0, 0)
        local goal = {
            Position = self.owner.bindActor.Position + direction * 3000
        }
        local movespeed = self.owner:GetComponent("AttributeComponent"):GetAttribute("moveSpeed")
        local tween = MS.Tween.CreateTween(self.owner.bindActor, goal, 3000 / movespeed)
        self.owner.bindTween = tween
        tween:Play()
    end

    if self.owner.actorClass == "Zombie" then
        self.preState = self.StateEnum.Move
        self.currentState = self.StateEnum.Move
    elseif self.owner.actorClass == "Plant" then
        self.preState = self.StateEnum.Idle
        self.currentState = self.StateEnum.Idle
    end
end

return AIComponent
