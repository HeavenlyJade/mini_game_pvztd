local LevelStart = MS.Class.new("LevelStart", MS.UIRootFunctionality)

function LevelStart:Init()
    self.mainPanel = self.owner.bindingUI.MainPanel
    self.countDown = self.mainPanel:FindFirstChild("CountDown")
end

function LevelStart:ShowLevelStart()
    _G.PlayerActor.uiManager:SetUIRootVisible("LevelStart",true)
    self.countDown.Scale = Vector2.New(2, 2)
    self.countDown.Icon = "sandboxId://PVZ_UI/PlayerHUD/Countdown/Img_CtD_5.png"
    --用tween实现icon从大变小
    local goal = {
        Scale = Vector2.New(1, 1)
    }
    print("5")
    local tween = MS.Tween.CreateTween(self.countDown, goal, 0.5)
    tween:Play()
    wait(1)
    tween:Destroy()
    print("4")
    self.countDown.Scale = Vector2.New(2, 2)
    self.countDown.Icon = "sandboxId://PVZ_UI/PlayerHUD/Countdown/Img_CtD_4.png"
    tween = MS.Tween.CreateTween(self.countDown, goal, 0.5)
    tween:Play()
    wait(1)
    tween:Destroy()
    print("3")
    self.countDown.Scale = Vector2.New(2, 2)
    self.countDown.Icon = "sandboxId://PVZ_UI/PlayerHUD/Countdown/Img_CtD_3.png"
    tween = MS.Tween.CreateTween(self.countDown, goal, 0.5)
    tween:Play()
    wait(0.4)
    MS.SoundManager:PlaySound(MS.SoundManager.SoundId.Game_Begin)
    wait(0.6)
    tween:Destroy()
    
    print("2")
    self.countDown.Scale = Vector2.New(2, 2)
    self.countDown.Icon = "sandboxId://PVZ_UI/PlayerHUD/Countdown/Img_CtD_2.png"
    tween = MS.Tween.CreateTween(self.countDown, goal, 0.5)
    tween:Play()
    wait(1)
    tween:Destroy()
    print("1")
    self.countDown.Scale = Vector2.New(2, 2)
    self.countDown.Icon = "sandboxId://PVZ_UI/PlayerHUD/Countdown/Img_CtD_1.png"
    tween = MS.Tween.CreateTween(self.countDown, goal, 0.5)
    tween:Play()
    wait(1)
    print("清理界面")
    _G.PlayerActor.uiManager:SetUIRootVisible("LevelStart",false)
    _G.PlayerActor.uiManager:DestroyUIRoot("LevelStart")
end

return LevelStart
