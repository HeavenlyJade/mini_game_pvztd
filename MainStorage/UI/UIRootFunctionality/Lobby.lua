local Lobby = MS.Class.new("Lobby", MS.UIRootFunctionality)
local SoundManager = MS.SoundManager
function Lobby:InitAvatarPanel(avatarPanel)
    local localPlayer = MS.Players.LocalPlayer
    MS.Logging.dump(localPlayer)
    avatarPanel.Level.UITextLable.Title = "Lv.1"
    avatarPanel.Diamond.LabelNew.Title = "0"
end

--绑定LobbyUI
function Lobby:InitLobbyPanel(panel)

    self:InitAvatarPanel(panel.AvatarBg)
    
    panel.RightBottom.Bottom.Click:Connect(
        function()
            SoundManager:PlaySound(SoundManager.SoundId.Ui_Click)
            _G.PlayerActor:Update("OnLevelMenu")
            -- local camera = MS.WorkSpace.CurrentCamera
            -- local goal = 
            -- {
            --     Position = Vector3.New(-545.46, 3512.65, 1314.08)
            -- }
        
            -- local tween = MS.Tween.CreateTween(camera, goal, 1)
            -- tween:Play()
            -- MS.Bridge.SendMessageToServer(
            --     MS.Protocol.ClientMsgID.STARTGAME, -- Message
            --     {
            --         level = 1
            --     },
            --     false
            -- )
        end
    )

    -- 通行证
    panel.LeftBottom.PassPort.Click:connect(function()
        print("通行证=========")
        SoundManager:PlaySound(SoundManager.SoundId.Ui_Click)
    end)

    -- 商店
    panel.LeftBottom.Store.Click:connect(function()
        print("商店=========")
        SoundManager:PlaySound(SoundManager.SoundId.Ui_Click)
    end)

    -- 图鉴
    panel.LeftBottom.PlantIntro.Click:connect(function()
        print("图鉴=========")
        SoundManager:PlaySound(SoundManager.SoundId.Ui_Click)
    end)

    -- 任务
    panel.LeftBottom.Task.Click:connect(function()
        print("任务=========")
        SoundManager:PlaySound(SoundManager.SoundId.Ui_Click)
    end)

    -- 好友排行
    panel.LeftBottom.Rank.Click:connect(function()
        print("好友排行=========")
        SoundManager:PlaySound(SoundManager.SoundId.Ui_Click)
    end)

    panel.RightTop.Exit.Click:connect(function()
        print("send Tp Request")
        SoundManager:PlaySound(SoundManager.SoundId.Ui_Click)
        local playerId = MS.Players.LocalPlayer.UserId
        MS.Bridge.SendMessageToServer(MS.Protocol.ClientMsgID.TELEPORT_REQUEST, {playerId = playerId, mapId = 12839541415348})
        --SoundManager:StopSound(SoundManager.SoundId.Hall_Background)
    end)
end

-- Lobby
function Lobby:Init()
    self:InitLobbyPanel(self.owner.bindingUI)

    SoundManager:PlaySound(SoundManager.SoundId.Hall_Background)
end

-- Lobby.Init()

return Lobby
