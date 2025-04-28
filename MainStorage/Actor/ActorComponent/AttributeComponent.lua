local AttributeComponent = MS.Class.new("AttributeComponent", MS.ActorComponent)

function AttributeComponent:ctor()
    self.Attributes = {}
end

function AttributeComponent:Init(Attributes)
    self.Attributes = MS.Utils.deepCopy(Attributes)
end

function AttributeComponent:SetAttribute(attributeName, attributeValue)
    self.Attributes[attributeName] = attributeValue
end

function AttributeComponent:GetAttribute(attributeName)
    return self.Attributes[attributeName]
end

-- AttributeChanged Event

function AttributeComponent:OnDead()
    if self.owner.actorClass == "Plant" then
        self.owner.bindActor.Parent:SetAttribute("HasPlanted", false)
    end
	local AIComponent = self.owner.actorComponents["AIComponent"]
    AIComponent:SwitchState(self.owner.actorComponents["AIComponent"].StateEnum.Die)
    AIComponent.AIBehaviors.Die(AIComponent)
end

function AttributeComponent:TakeDamage(damage)
    self.Attributes.health = self.Attributes.health - damage
    print("Health: " .. self.Attributes.health)
    if self.Attributes.health <= 0 then
        self:OnDead()
    end
end

return AttributeComponent
