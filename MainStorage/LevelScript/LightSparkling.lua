local Light = script.Parent

local Intensitys = {0.8, 1, 2}
local timer = SandboxNode.New("Timer")

while true do
    local randomIndex = math.random(1, 3)
    local Intensity = Intensitys[randomIndex]
    Light.Intensity = Intensity

    wait(0.8)
end