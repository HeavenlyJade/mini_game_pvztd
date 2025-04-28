local camera = MS.WorkSpace.CurrentCamera

local CameraManager = {}

function CameraManager:Init()
    camera.CameraType = Enum.CameraType.Scriptable
    camera.FieldOfView = 30
    --camera.Position = Vector3.New(-1145.46, 2212.65, 2014.08)
    camera.Position = Vector3.New(-845.46, 3512.65, 1514.08)
    camera.Euler = Vector3.New(50.0865, 179.898, 0)
end

return CameraManager
