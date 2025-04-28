local Tween = {}

function Tween.CreateTween(node, goal, duration)
    local tweenInfo = TweenInfo.New(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, 0, false)
    local tween = MS.TweenService:Create(node, tweenInfo, goal)
    return tween
end

return Tween
