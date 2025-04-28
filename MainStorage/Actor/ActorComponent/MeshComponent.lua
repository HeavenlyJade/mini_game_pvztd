local MeshComponent = MS.Class.new("MeshComponent", MS.ActorComponent)

function MeshComponent:ctor()
    self.mesh = nil
end

function MeshComponent:Init()
    self.mesh = self.owner.bindActor
end

function MeshComponent:Rim(duration, intensity, width, color)
    local ids = {0}
    local index = 0
    local skinMaterial = self.node:GetMaterialInstance(ids, index)
    local bodyMaterial = self.node:GetMaterialInstance(ids, index + 1)
    if skinMaterial and bodyMaterial then
        skinMaterial:SetKey("USE_RIM_COLOR", true)
        bodyMaterial:SetKey("USE_RIM_COLOR", true)
        color = color or {}
        intensity = intensity or 15
        MS.Tween:AlphaBy(
            function(progress)
                skinMaterial:SetR32("_RimIntensity", progress)
                bodyMaterial:SetR32("_RimIntensity", progress)
            end,
            0,
            intensity,
            duration,
            MS.Tween.Easing.EaseInQuad
        )

        skinMaterial:SetR32("_RimWidth", width or 1.40)
        skinMaterial:SetRGB32("g_RimColor", Vector3.new(color[1] or 1.00, color[2] or 1.00, color[3] or 1.00))

        bodyMaterial:SetR32("_RimWidth", width or 1.40)
        bodyMaterial:SetRGB32("g_RimColor", Vector3.new(color[1] or 1.00, color[2] or 1.00, color[3] or 1.00))

        -- 定时关闭
        if duration and duration > 0 then
            TimerManager:AddTimer(
                function()
                    skinMaterial:SetKey("USE_RIM_COLOR", false)
                    bodyMaterial:SetKey("USE_RIM_COLOR", false)
                end,
                duration,
                1
            )
        end
    end
end

return MeshComponent
