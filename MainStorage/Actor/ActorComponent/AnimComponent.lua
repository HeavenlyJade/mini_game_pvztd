local AnimComponent = MS.Class.new("AnimComponent", MS.ActorComponent)

function AnimComponent:ctor()
    self.animator = nil
end

function AnimComponent:Init(animator, ConnectNotify)
    self.animator = animator
    ConnectNotify(self)
end

return AnimComponent
