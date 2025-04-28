MS = {}

-- Common Services
MS.RunService = game:GetService("RunService")
MS.Players = game:GetService("Players")
MS.TweenService = game:GetService('TweenService')
MS.WorkSpace = game:GetService("WorkSpace")
MS.Environment = MS.WorkSpace.Environment
MS.MainStorage = game:GetService("MainStorage")
MS.ContextActionService = game:GetService("ContextActionService")
MS.UserInputService = game:GetService("UserInputService")
MS.WorldService = game:GetService("WorldService")
MS.CloudService = game:GetService("CloudService") -- 云数据
MS.DeveloperStoreService = game:GetService("DeveloperStoreService") -- 迷你币商品服务
MS.CoreUi = game:GetService("CoreUi") -- 游戏核心界面信息
MS.PhysXService = game:GetService("PhysXService")
MS.FriendInviteService = game:GetService("FriendInviteService") -- 好友拉新
MS.StarterGui = game:GetService("StarterGui")
MS.TeleportService = game:GetService("TeleportService") -- 传送服务
MS.AnalyticsService = game:GetService("AnalyticsService") -- 数据埋点服务
MS.UtilService = game:GetService('UtilService')
MS.MouseService = game:GetService('MouseService') -- 鼠标服务
MS.CloudServerConfigService = game:GetService('CloudServerConfigService')
MS.SceneMgr = game:GetService("SceneMgr") -- 副本服务
MS.CustomConfigService = game:GetService("CustomConfigService")

-- Server Services

print("Service Ready")
MS.CameraRun = require(MS.MainStorage.Camera.CameraRun)
-- Common
MS.Utils = require(MS.MainStorage.Common.Utils)
MS.Math = require(MS.MainStorage.Common.Utils.Math)
MS.Logging = require(MS.MainStorage.Common.Utils.Logging)
MS.Config = require(MS.MainStorage.Common.Utils.Config)
MS.Const = require(MS.MainStorage.Common.Const)
MS.Bridge = require(MS.MainStorage.Common.Bridge)
MS.Protocol = require(MS.MainStorage.Common.Bridge.Protocol)
MS.Class = require(MS.MainStorage.Common.Utils.Class)
MS.UidGenerator = require(MS.MainStorage.Common.Utils.UidGenerator)
MS.Tween = require(MS.MainStorage.Common.Tween)
MS.Timer = require(MS.MainStorage.Common.Utils.Timer)
MS.Logging:Info("Common Ready")

-- Actor
MS.ActorComponent = require(MS.MainStorage.Actor.ActorComponent)
MS.ActorBase = require(MS.MainStorage.Actor.ActorBase)
MS.AIComponent = require(MS.MainStorage.Actor.ActorComponent.AIComponent)
MS.Logging:Info("Actor Ready")

-- Player
MS.PlayerActor = require(MS.MainStorage.Player.PlayerActor)
MS.PlayerState = require(MS.MainStorage.Player.PlayerState)
MS.PlayerController = require(MS.MainStorage.Player.PlayerController)
MS.Logging:Info("Player Ready")

-- UI
MS.UIRoot = require(MS.MainStorage.UI.UIRoot)
MS.UIRootPrefab = MS.MainStorage.UI.UIRootPrefab
MS.UIRootFunctionality = MS.MainStorage.UI.UIRootFunctionality
MS.Logging:Info("UI Ready")

-- Test
MS.Test = MS.MainStorage.Test
--MS.GameMode = require(MS.MainStorage.Level:WaitForChild("GameMode"))
MS.LevelManager = require(MS.MainStorage.Level:WaitForChild("LevelManager"))
MS.GameMode = require(MS.MainStorage.Level:WaitForChild("GameMode"))
MS.Logging:Info("LevelManager Ready")
-- Client Manager
if MS.RunService:IsClient() then
    MS.CameraManager = require(MS.MainStorage.Camera:WaitForChild("CameraManager"))
    MS.Logging:Info("CameraManager Ready")

    MS.UIManager = require(MS.MainStorage.UI:WaitForChild("UIManager"))
    MS.Logging:Info("UIManager Ready")
end

-- Common Manager
MS.ActorManager = require(MS.MainStorage.Actor.ActorManager)

MS.AssetManager = require(MS.MainStorage.Common:WaitForChild("AssetManager"))
MS.Logging:Info("AssetManager Ready")

MS.Logging:Info("All Manager Ready")

MS.SoundManager = require(MS.MainStorage.Sound:WaitForChild("SoundManager"))
MS.SoundManager:Init()

return MS

