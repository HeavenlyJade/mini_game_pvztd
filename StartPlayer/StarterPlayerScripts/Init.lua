local MainStorage = game:GetService("MainStorage")
local MS = require(MainStorage.Common:WaitForChild("Global"))
_G.MS = MS

local playerController = require(MainStorage.Player:WaitForChild("PlayerController"))

local function Init()
    playerController:Init()
    MS.CameraManager:Init()
    _G.PlayerActor = MS.PlayerActor.new()
    _G.PlayerActor:Update("OnEnterLobby")
    local MainStorage = game:GetService("MainStorage")
    local Workspace = game:GetService("Workspace")
	
	if Workspace.Lobby then
		Workspace.Lobby:Destroy()
	end

    -- local EnvironmentMgrNode = MS.MainStorage:WaitForChild('EnvironmentMgr')
    -- local EnvironmentMgr = require(EnvironmentMgrNode)
    -- local WeatherManagerNode = MS.MainStorage:WaitForChild('WeatherManager')
    -- local WeatherManager = require(WeatherManagerNode)

    -- WeatherManager:Init()
    -- WeatherManager:Start()
	MS.LevelManager.Init()
end

Init()
