local ActorBase = MS.Class.new("ActorBase")

function ActorBase:ctor(ActorObject, ActorClassName, Uid)
    self.uid = Uid -- 0 means uninitialized
    -- Property
    self.bindActor = nil
    self.bindTween = nil
    self.actorClass = ActorClassName

    self.actorComponents = {}

    self:SetBindActor(ActorObject)
end

function ActorBase:SetBindActor(ActorObject)
    self.bindActor = ActorObject
end

function ActorBase:GetBindObject()
    return self.bindActor
end

function ActorBase:GetComponent(componentType)
    return self.actorComponents[componentType]
end

return ActorBase
