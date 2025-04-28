local LevelMenu = MS.Class.new("LevelMenu", MS.UIRootFunctionality) 
-- 关卡数据
local levelData = {
    {id = 1, stars = 3, unlocked = true},
    {id = 2, stars = 2, unlocked = false},
    {id = 3, stars = 0, unlocked = false},
    {id = 4, stars = 0, unlocked = false},
    {id = 5, stars = 0, unlocked = false}
} 
 
-- 当前选中的关卡
local selectedLevel = 1
 
-- 初始化关卡选择面板
function LevelMenu:InitLevelMenuPanel (panel)
    print("LevelMenu面板初始化开始")
    
    -- 检查LevelListBG和LevelList是否存在
    print(panel.MainPanel)
    for _, node in ipairs(panel.MainPanel.Children) do
        print(node)
    end

    if not panel.MainPanel.LevelListBG then
        print("错误: LevelListBG不存在")
        return
    end
    
    if not panel.MainPanel.LevelListBG.LevelList then
        print("错误: LevelListBG.LevelList不存在")
        return
    end


    
    panel.MainPanel.Exit.Click:connect(function()
        local localPlayer = MS.Players.LocalPlayer
        localPlayer.PlayerGui.LevelMenu.Visible = false
        --wait(1) 
        localPlayer.PlayerGui.Lobby.Visible = true

    end)
    local levelList = panel.MainPanel.LevelListBG.LevelList
    
    --local levelBarList = panel.MainPanel.LevelListBG.LevelBarList

    -- 绑定关卡按钮
    for i = 1, 5 do
        local levelButtonName = "Level" .. i
        print(levelButtonName) 
        if levelList[levelButtonName] then
            print(levelList[levelButtonName])  
            -- 设置关卡星级
            UpdateLevelStars(levelList[levelButtonName], levelData[i].stars, levelData[i].unlocked)

            --print(levelList[levelButtonName].Level.Lock)   
            --print(levelData[i].unlocked) 

            if levelData[i].stars >= 3 then 
           
                levelList[levelButtonName].CheckPoint.Icon = "sandboxId://PVZ_UI/LevelMenu/Icon_Level_Done.png"
                --levelBarList[levelButtonName].Icon = "sandboxId://PVZ_UI/LevelMenu/Bg_Level_bar_On.png"
                levelList[levelButtonName].CheckPoint.LevelSeq.Visible = false
                levelList[levelButtonName].LastHalf.Icon = "sandboxId://PVZ_UI/LevelMenu/Bg_Level_bar_On.png"
            else
                -- 暗淡的里程碑
                levelList[levelButtonName].CheckPoint.Icon = "sandboxId://PVZ_UI/LevelMenu/Icon_Level_Undo.png"     
                if levelData[i].stars <= 0 then            
                    levelList[levelButtonName].FirstHalf.Icon = "sandboxId://PVZ_UI/LevelMenu/Bg_Level_bar_Off.png"
                end
            
                --levelBarList[levelButtonName].Icon = "sandboxId://PVZ_UI/LevelMenu/Bg_Level_bar_Off.png"	
                -- 设置关卡序号（保留两位数字）
                -- 格式化为两位数字，例如：1 -> 01, 10 -> 10
                local formattedNumber = string.format("%02d", i)
                levelList[levelButtonName].CheckPoint.LevelSeq.Title = formattedNumber
            end
            
            -- 设置关卡状态（锁定/解锁）
            if levelList[levelButtonName].Level.Lock then
                print("关卡的锁显示，" .. levelButtonName) 
                print(not levelData[i].unlocked)  
                levelList[levelButtonName].Level.Lock.Visible = not levelData[i].unlocked
                print(levelList[levelButtonName].UILocked)
                levelList[levelButtonName].UILocked.Visible = not levelData[i].unlocked
            end
            
            levelList[levelButtonName].Level.Click:connect(function()
                print("游戏开始=========")
                MS.SoundManager:StopSound(MS.SoundManager.SoundId.Hall_Background)
                MS.SoundManager:PlaySound(MS.SoundManager.SoundId.Game_Background)    
                LoadLevel(i)
            end)
         
        else
            print("警告: LevelListBG.LevelList." .. levelButtonName .. "不存在")
        end
    end
    
    print("LevelMenu面板初始化完成")
end

-- 更新关卡星级显示
function UpdateLevelStars(levelButton, stars, unlocked)
    -- 检查并更新星星显示
    for i = 1, 3 do
        local starName = "Star" .. i
        
        if levelButton.Level.Stars[starName] then
            -- 所有星星都显示，但根据星级设置不同的图标
            levelButton.Level.Stars[starName].Visible = true
            
            if i <= stars then
                -- 点亮的星星
                levelButton.Level.Stars[starName].Icon = "sandboxId://PVZ_UI/LevelMenu/Icon_Level_Star_On.png"
            else
                -- 暗淡的星星
                levelButton.Level.Stars[starName].Icon = "sandboxId://PVZ_UI/LevelMenu/Icon_Level_Star_Off.png"
				print(levelButton.Level.Stars[starName]) 
            end
            
            --levelButton.Level.Stars[starName].Icon = "sandboxId://PVZ_UI/LevelMenu/Icon_Level_Star_Off.png"
        end
    end
    
    -- 如果有关卡编号显示，则更新为关卡编号
    if levelButton.LevelNumber then
        levelButton.LevelNumber.Text = tostring(levelButton.Name:sub(6))
    end
    
    -- 如果之前有关卡名称，现在不需要了，可以隐藏
    if levelButton.LevelName then
        levelButton.LevelName.Visible = false
    end
end

-- 加载关卡
function LoadLevel(levelIndex)
    if levelData[levelIndex].unlocked then
        _G.PlayerActor.uiManager:SetUIRootVisible("Lobby",false)
        _G.PlayerActor.uiManager:SetUIRootVisible("LevelMenu",false)
        -- local camera = MS.WorkSpace.CurrentCamera
        -- local goal = 
        -- {
        --     Position = Vector3.New(-509.46, 2299.65, 1026.08),
        --     Euler = Vector3.New(50.0865, 179.898, 0)
        -- }
        MS.CameraRun:Start("Route01", false, function()
            MS.Bridge.SendMessageToServer(
                MS.Protocol.ClientMsgID.STARTGAME, -- Message
                {
                    level = levelIndex
                },
                false
            )
            --wait(1.5)
            _G.PlayerActor:Update("OnEnterPVZGame")
            _G.PlayerActor:Update("OnLevelStart")
        end)
        -- local localPlayer = MS.Players.LocalPlayer
        -- MS.UIManager.CreateUIRoot("PlayerHUD", localPlayer.PlayerGui)
        -- localPlayer.PlayerGui.LevelMenu.Visible = false
        
        -- -- 设置摄像机位置
        -- local camera = MS.WorkSpace.CurrentCamera
        -- local goal = {
        --     Position = Vector3.New(-1145.46, 2212.65, 2014.08)
        -- }
        
        -- local tween = MS.Tween.CreateTween(camera, goal, 1)
        -- tween:Play()
        
        -- -- 发送开始游戏消息到服务器
        -- MS.Bridge.SendMessageToServer(
        --     MS.Protocol.ClientMsgID.STARTGAME,
        --     {
        --         level = levelIndex
        --     },
        --     false
        -- )
    end
end

-- 初始化LevelMenu
function LevelMenu:Init()
    self:InitLevelMenuPanel(self.owner.bindingUI)
end

--LevelMenu.Init()

return LevelMenu 