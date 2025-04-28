local Workspace = game:GetService("WorkSpace")
local WorldService = game:GetService("WorldService")

local camera = Workspace.CurrentCamera

local CharacterMovementModule = {}


--尝试得到鼠标点击的位置的地面位置
local function tryGetRaycastOnGround( positionX, positionY,depth )
    local viewportSize = camera.ViewportSize
    local ray= camera:ViewportPointToRay( positionX, viewportSize.y - positionY, depth )
    local ret_table = WorldService:RaycastClosest( ray.Origin, ray.Direction, depth, true, {0,1,2,3} )
    return ret_table
end

function CharacterMovementModule.CharacterMove(playerCharacter, mousePosition)
    local rayLength = 100000;
    local targetPosition = tryGetRaycastOnGround(mousePosition.X, mousePosition.Y, rayLength).position
    print(targetPosition)

	if targetPosition ~= nil then
		playerCharacter:NavigateTo(targetPosition)
	end
end

return CharacterMovementModule
