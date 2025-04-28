local CollisionComponent = MS.Class.new("CollisionComponent", MS.ActorComponent)

function CollisionComponent:ctor()
end

function CollisionComponent:Init(ConnectTouchedFunc, ConnectTouchEndedFunc)
    ConnectTouchedFunc(self)
    ConnectTouchEndedFunc(self)
end

return CollisionComponent
