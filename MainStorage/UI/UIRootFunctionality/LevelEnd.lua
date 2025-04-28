local LevelEnd = MS.Class.new("LevelEnd", MS.UIRootFunctionality)

function LevelEnd:InitMainPanel(panel)
    local toLobbyUI = function()
    
        MS.SoundManager:PlaySound(MS.SoundManager.SoundId.Ui_Click) 
        MS.SoundManager:StopSound(MS.SoundManager.SoundId.Game_Background)
        MS.SoundManager:PlaySound(MS.SoundManager.SoundId.Hall_Background)  
        local localPlayer = MS.Players.LocalPlayer
        localPlayer.PlayerGui.LevelEnd.Visible = false

        local camera = MS.WorkSpace.CurrentCamera
        local goal = 
        {
            Position = Vector3.New(-845.46, 3512.65, 1314.08)
        }
    
        local tween = MS.Tween.CreateTween(camera, goal, 1)
        tween:Play()
        local localPlayer = MS.Players.LocalPlayer
        localPlayer.PlayerGui.PlantVsZombie.Visible = false
        wait(1)
        localPlayer.PlayerGui.Lobby.Visible = true
    end

    local restartLevel = function()
        local localPlayer = MS.Players.LocalPlayer
        -- 隐藏结算界面和大厅界面
        localPlayer.PlayerGui.LevelEnd.Visible = false
        localPlayer.PlayerGui.Lobby.Visible = false
        
    
        
        -- 等待清理完成
        wait(0.5)
        
        -- 使用相同的相机路线
        MS.CameraRun:Start("Route01", false, function()
            -- 重新显示游戏界面
            localPlayer.PlayerGui.PlantVsZombie.Visible = true
            
            -- 开始新的游戏
            MS.Bridge.SendMessageToServer(
                MS.Protocol.ClientMsgID.STARTGAME,
                {
                    level = 1  -- 当前关卡
                },
                false
            )
        end)
    end

    panel.MainPanel.Succeed.ReturnMainMenu.Click:Connect(
        function()
            print("Succeed ReturnMainMenu")
            -- 发送消息到服务器清理所有游戏元素
            MS.ActorManager:DestroyAllActors()
            MS.Bridge.SendMessageToServer(
            MS.Protocol.ClientMsgID.ENDGAME,
            {
                hp = 100  -- 重置生命值
            },
            false
        )
        
            toLobbyUI()
        end
    )

    panel.MainPanel.Succeed.NextLevel.Click:Connect(
        function()
            print("Succeed NextLevel")
            MS.ActorManager:DestroyAllActors()
            -- 发送消息到服务器清理所有游戏元素
            MS.Bridge.SendMessageToServer(
                MS.Protocol.ClientMsgID.ENDGAME,
                {
                    hp = 100  -- 重置生命值
                },
                false
            )
            -- 调用重新开始关卡的函数
            restartLevel()
        end
    )

    ----------------------
    panel.MainPanel.Failed.ReturnMainMenu.Click:Connect(
        function()
            print("Failed ReturnMainMenu")
            toLobbyUI()
        end
    )

    panel.MainPanel.Failed.NextLevel.Click:Connect(
        function()
            print("Restart Level")
            restartLevel()
        end
    )
end

function LevelEnd:Init()
    self:InitMainPanel(self.owner.bindingUI)
end

return LevelEnd