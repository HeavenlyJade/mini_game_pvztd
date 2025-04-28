local RaycastComponent = MS.Class.new("RaycastComponent", MS.ActorComponent)

function RaycastComponent:ctor()
    self.updateEnabled = true
    self.RaycastProps = {}
    self.HitResult = nil
end

function RaycastComponent:update()
end

function RaycastComponent:Raycast()
    -- print(self.origin, self.unitDir, self.distance, self.isIgnoreTrigger, self.filterGroup)
    local ret_table =
        MS.WorldService:RaycastClosest(
        self.owner.bindActor.Position + self.RaycastProps.originOffset,
        self.RaycastProps.unitDir,
        self.RaycastProps.distance,
        self.RaycastProps.isIgnoreTrigger,
        self.RaycastProps.filterGroup
    )

    return ret_table
end

function RaycastComponent:Init(RaycastProps, fixUpdateRate)
    self.fixedUpdateRate = fixUpdateRate
    self.RaycastProps = MS.Utils.deepCopy(RaycastProps)
    -- self:TraceRaycast()

    MS.Timer.CreateTimer(
        0,
        self.fixedUpdateRate,
        true,
        function()
            self.HitResult = self:Raycast()
        end
    ):Start()
end

-- Debug Function,using Trace Raycast to trace the line direction
function RaycastComponent:SpawnTestBall(location)
    -- figure out the position
    local testBall = MS.Test.TestSphere:Clone()
    testBall.Parent = MS.WorkSpace
    testBall.Position = location
    testBall.LocalScale = Vector3.new(0.1, 0.1, 0.1)
end

function RaycastComponent:TraceRaycast()
    local count = 0
    while count < 10 do
        self:SpawnTestBall(self.origin + count * self.unitDir * 10)
        count = count + 1
    end
end

-- Debug Function, print the hit result
function RaycastComponent:PrintHitResult(HitResult)
    print(
        "HitResult.isHit = ",
        HitResult.isHit,
        " HitResult.position = ",
        HitResult.position,
        " HitResult.normal = ",
        HitResult.normal,
        " HitResult.distance = ",
        HitResult.distance,
        " HitResult.obj = ",
        HitResult.obj
    )
end

return RaycastComponent
