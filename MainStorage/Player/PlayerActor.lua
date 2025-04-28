local PlayerActor = MS.Class.new("PlayerActor")
local localPlayer = MS.Players.LocalPlayer

function PlayerActor:ctor()
    self.uiManager = MS.UIManager.new()
end

function PlayerActor:Update(eventName, ...)
    if eventName == "OnEnterLobby" then
        self.uiManager:CreateUIRoot("Lobby", localPlayer.PlayerGui)
    elseif eventName == "OnLevelMenu" then
        self.uiManager:SetUIRootVisible("Lobby",false)
        if nil == localPlayer.PlayerGui.LevelMenu then        
            self.uiManager:CreateUIRoot("LevelMenu", localPlayer.PlayerGui)
        else
            localPlayer.PlayerGui.LevelMenu.Visible = true
        end
    elseif eventName == "OnEnterPVZGame" then
        if nil == localPlayer.PlayerGui.PlantVsZombie then
            self.uiManager:CreateUIRoot("PlantVsZombie", localPlayer.PlayerGui)
        else
            localPlayer.PlayerGui.PlantVsZombie.Visible = true
        end

        if nil == localPlayer.PlayerGui.LevelStart then
            self.uiManager:CreateUIRoot("LevelStart", localPlayer.PlayerGui)
        else
            localPlayer.PlayerGui.LevelStart.Visible = true
        end
        self.uiManager:SetUIRootVisible("Lobby",false)
        -- self.uiManager:DestroyUIRoot("PlayerCardLoadout")
    elseif eventName == "OnLevelStart" then
        self.uiManager.uiRoots.LevelStart.bindingFunctionality:ShowLevelStart()
    elseif eventName == "OnGameEnd" then
        self.uiManager:CreateUIRoot("LevelEnd", localPlayer.PlayerGui)
    end
    
end


return PlayerActor
