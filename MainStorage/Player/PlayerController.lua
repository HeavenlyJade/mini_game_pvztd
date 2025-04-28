local CharacterMovementModule = require(MS.MainStorage.Character.CharacterMovement)

--local playerCharacter = MS.Players.LocalPlayer.Character

local PlayerController = {}

-- forward declarations

-- Need to unable all default Control first
-- For PC
function KeyMouseBinding()
    -- Binding

    -- MS.ContextActionService:BindContext("CharacterMove", function(actionName, inputState, inputObj)
    --     if inputState == Enum.UserInputState.InputBegin.Value then
    --         print("CharacterMove")
    --         print("MousePositionX: " .. inputObj.Position.x .. " MousePositionY: " .. inputObj.Position.y)
    --         CharacterMovementModule.CharacterMove(playerCharacter, inputObj.Position)
    --     end
    -- end, false, Enum.UserInputType.MouseButton2)

    -- MS.ContextActionService:BindContext("Select", function(actionName, inputState, inputObj)
    --     if inputState == Enum.UserInputState.InputBegin.Value then
    --         print("Select")
    --     end
    -- end, false, Enum.UserInputType.MouseButton1)

    -- MS.ContextActionService:BindContext("SwitchView", function(actionName, inputState, inputObj)
    --     if inputState == Enum.UserInputState.InputBegin.Value then
    --         print("SwitchView")
    --         MS.CameraManager:SwitchViewMode()
    --     end
    -- end, false, Enum.KeyCode.Q)

end

-- For Touch Device

function TouchDeviceBinding()
    -- MS.ContextActionService:BindContext("CharacterMove", function(actionName, inputState, inputObj)
    --     if inputState == Enum.UserInputState.InputBegin.Value then
    --         print("CharacterMove")
    --         print("MousePositionX: " .. inputObj.Position.x .. " MousePositionY: " .. inputObj.Position.y)
    --         CharacterMovementModule.CharacterMove(playerCharacter, inputObj.Position)
    --     end
    -- end, false, Enum.UserInputType.Touch)

    -- MS.ContextActionService:BindContext("Select", function(actionName, inputState, inputObj)
    --     if inputState == Enum.UserInputState.InputBegin.Value then
    --         print("Select")
    --     end
    -- end, false, Enum.UserInputType.Touch)
end

-- Binding depending on the Device
function PlayerController.Init()
    if MS.Environment:IsMobile() then
        MS.Logging:Info("Device is Mobile")
        TouchDeviceBinding()
    else
        MS.Logging:Info("Device is PC")
        KeyMouseBinding()
    end
    MS.CameraRun:Start("RouteLobby", true)
end


return PlayerController
