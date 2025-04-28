local Light = script.Parent

local Intensitys = {0.1, 1, 2, 1.2, 3, 1, 0.5}
local timer = SandboxNode.New("Timer")

while true do
    local randomIndex = math.random(1, #Intensitys)
    local Intensity = Intensitys[randomIndex]
    Light.Intensity = Intensity

    wait(0.5)
end