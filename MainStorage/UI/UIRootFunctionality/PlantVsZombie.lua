local PlantVsZombie = MS.Class.new("PlantVsZombie", MS.UIRootFunctionality)

local startSunFlowerNum = 200
local sunshineSumUI = nil
local sunshineSum = startSunFlowerNum
local selectedPlantName = nil
local selectedPlantUI = nil

local plantingMode = false

local SelectedShovelUI = nil
local removingMode = false

local SelectedHammerUI = nil
local breakingMode = false

local SelectPlantType = nil
local PostPlant = nil
local PlantSelectedPlantType = nil

local InitMainPanel = nil


local RemovePlant = nil
local SelectShovel = nil
local PostRemove = nil

local SelectHammer = nil
local BreakFloor = nil
local PostBreak = nil

local SelectedActor = nil
local SelectActor = nil
local ModelRimLight = nil
local ChangePlantModel = nil


-- 选中植物类型
SelectPlantType = function(plantUI)
    -- if selectedPlantUI ~= plantUI then
    --     local localPlayer = MS.Players.LocalPlayer
    --     if plantUI.Name == "Sunflower" then
    --         --plantUI.Icon = "SandboxId://icon/UI/Plant_SunFlower_Selected.png"
    --     elseif plantUI.Name == "PeaShooter" then
    --         plantUI.Icon = "SandboxId://icon/UI/Plant_PeaShooter_Selected.png"
    --     elseif plantUI.Name == "SnowpeaShooter" then
    --         plantUI.Icon = "SandboxId://icon/UI/Plant_Snowpea_Selected.png"
    --     elseif plantUI.Name == "PeaShooterTwo" then
    --         local GameMode = MS.GameMode
    --         GameMode.StartWave()
    --     end
    --     plantingMode = true
    --     selectedPlantUI = plantUI
    --     selectedPlantName = selectedPlantUI.Name        
    -- end
    if selectedPlantUI ~= plantUI then
        plantingMode = true
        selectedPlantUI = plantUI
        selectedPlantName = selectedPlantUI.PlantName.Title        
        selectedPlantUI.Frame_Plant.Visible = true
    end
end

PostPlant = function()
    -- plantingMode = false
    -- selectedPlantName = nil
    -- if selectedPlantUI.Name == "Sunflower" then
    --     selectedPlantUI.Icon = "SandboxId://icon/UI/Plant_SunFlower.png"
    -- elseif selectedPlantUI.Name == "PeaShooter" then
    --     selectedPlantUI.Icon = "SandboxId://icon/UI/Plant_PeaShooter.png"
    -- elseif selectedPlantUI.Name == "SnowpeaShooter" then
    --     selectedPlantUI.Icon = "SandboxId://icon/UI/Plant_Snowpea.png"
    -- elseif selectedPlantUI.Name == "PeaShooterTwo" then
    --     selectedPlantUI.Icon = "SandboxId://icon/UI/Plant_PeaShooterTwo.png"
    -- end
    -- selectedPlantUI = nil
    selectedPlantUI.Frame_Plant.Visible = false
    plantingMode = false
    selectedPlantName = nil
    selectedPlantUI = nil
end

-- 种植选中的植物
PlantSelectedPlantType = function(raycastResult)
    if raycastResult then
        local raycastFirstObject = raycastResult.obj ~= nil and raycastResult.obj or nil
        print("raycastFirstObject: " .. tostring(raycastFirstObject))
        
        if raycastFirstObject ~= nil then
            if raycastFirstObject:GetAttribute("GameplayTag") == "PlantPlacePosition" and
               --raycastFirstObject:GetAttribute("CanPlant") == true and
               sunshineSum >= tonumber(selectedPlantUI.Img_Sun.Price.Title) then
                if raycastFirstObject:GetAttribute("HasPlanted") == false then   
                    sunshineSum = sunshineSum - tonumber(selectedPlantUI.Img_Sun.Price.Title)
                    sunshineSumUI.Text_Sun.Title = tostring(sunshineSum)
                    MS.SoundManager:PlaySound(MS.SoundManager.SoundId.Grow_Plant)
                    MS.Bridge.SendMessageToServer(
                        MS.Protocol.ClientMsgID.SPAWNACTOR, -- Message
                        {
                            ActorClass = "Plant",
                            ActorName = selectedPlantName,
                            Parent = raycastFirstObject,
                            LocalPosition = Vector3.New(0, 0, 0),
                            LocalEuler = Vector3.New(0, 90, 0)
                        },
                        false
                    )

                    MS.Bridge.SendMessageToServer(
                        MS.Protocol.ClientMsgID.SETATTRIBUTE,
                        {
                            Node = raycastFirstObject,
                            AttributeName = "HasPlanted",
                            AttributeValue = true
                        },
                        false
                    )
                else
                    local merge = function(plantName)
                        for _, v in ipairs(raycastFirstObject.Children) do
                            print("plantName ="..v.Name)
                            if plantName == v.Name then
                                v.synthesis.ModelId = ""
                                v.synthesis.ModelId = "sandboxId://PVZ_VFX_New/Scene/Prefab/FX_synthesis_huge.prefab"
                                MS.Timer.CreateTimer(
                                    1,
                                    0,
                                    false,
                                    function()
                                        MS.Bridge.SendMessageToServer(
                                            MS.Protocol.ClientMsgID.REMOVEACTOR, -- Message
                                            {
                                                bindActor = v
                                            },
                                            false
                                        )
                                    end
                                ):Start()
         
                                return true
                            end
                        end
                        return false
                    end
                    local bSucc = false
                    -- 检查是否有足够的阳光进行合成
                    if sunshineSum >= tonumber(selectedPlantUI.Img_Sun.Price.Title) then
                        if "PeaShooter" == selectedPlantName then
                            bSucc = merge("SnowpeaShooter")
                        elseif "SnowpeaShooter" == selectedPlantName then
                            bSucc = merge("PeaShooter")
                        end
                        if bSucc then 
                            -- 添加阳光消耗逻辑
                            sunshineSum = sunshineSum - tonumber(selectedPlantUI.Img_Sun.Price.Title)
                            sunshineSumUI.Text_Sun.Title = tostring(sunshineSum)
                            
                            MS.SoundManager:PlaySound(MS.SoundManager.SoundId.Synthetic_Plant)
                            MS.Timer.CreateTimer(
                                1,
                                0,--
                                false,
                                function()
                                    MS.Bridge.SendMessageToServer(
                                        MS.Protocol.ClientMsgID.SPAWNACTOR, -- Message
                                        {
                                            --selectedPlantName = "SnowpeaShooterEx",
                                            ActorClass = "Plant",
                                            ActorName = "SnowpeaShooterEx",
                                            Parent = raycastFirstObject,
                                            LocalPosition = Vector3.New(0, 0, 0),
                                            LocalEuler = Vector3.New(0, 90, 0)
                                        },
                                        false
                                    )
                                end
                            ):Start()
                            
          
                        end
                    end
                end
            end
        end
    end

    PostPlant()
end
-- 选中铲子
SelectShovel = function(ShovelUI)
    ShovelUI.FillColor = ColorQuad.New(251, 255, 169, 255)
    SelectedShovelUI = ShovelUI
    removingMode = true
end

PostRemove = function()
    SelectedShovelUI.FillColor = ColorQuad.New(255, 255, 255, 255)
    SelectedShovelUI = nil
    removingMode = false
end

-- 清除植物
RemovePlant = function(raycastResult)
    if raycastResult then
        local raycastFirstObject = raycastResult.obj ~= nil and raycastResult.obj or nil
        if raycastFirstObject ~= nil then
            if
                raycastFirstObject:GetAttribute("GameplayTag") == "Plant" and
                    raycastFirstObject.Parent:GetAttribute("HasPlanted") == true
             then
                print("raycastFirstObject get the Attribute")
                MS.SoundManager:PlaySound(MS.SoundManager.SoundId.Digup_Plant)

                MS.Bridge.SendMessageToServer(
                    MS.Protocol.ClientMsgID.SETATTRIBUTE,
                    {
                        Node = raycastFirstObject.Parent,
                        AttributeName = "HasPlanted",
                        AttributeValue = false
                    },
                    false
                )
                
                MS.Bridge.SendMessageToServer(
                    MS.Protocol.ClientMsgID.REMOVEACTOR, -- Message
                    {
                        bindActor = raycastFirstObject
                    },
                    false
                )
            end
        end
    end
    PostRemove()
end

SelectHammer = function(HammerUI)
    HammerUI.FillColor = ColorQuad.New(251, 255, 169, 255)
    SelectedHammerUI = HammerUI
    breakingMode = true
end

PostBreak = function()
    SelectedHammerUI.FillColor = ColorQuad.New(255, 255, 255, 255)
    SelectedHammerUI = nil
    breakingMode = false
end
-- 敲碎地板
BreakFloor = function(raycastResult)
    if raycastResult then
        local raycastFirstObject = raycastResult.obj ~= nil and raycastResult.obj or nil

        if raycastFirstObject ~= nil then
            if
                raycastFirstObject:GetAttribute("GameplayTag") == "PlantPlacePosition" and
                    raycastFirstObject:GetAttribute("CanPlant") == false
             then
                local ModelIds = {
                    "SandboxId://PVZ_LvArt/BrokenBricks/SM_BrokenBricks1.prefab",
                    "SandboxId://PVZ_LvArt/BrokenBricks/SM_BrokenBricks2.prefab",
                    "SandboxId://PVZ_LvArt/BrokenBricks/SM_BrokenBricks3.prefab",
                    "SandboxId://PVZ_LvArt/BrokenBricks/SM_BrokenBricks4.prefab",
                    "SandboxId://PVZ_LvArt/BrokenBricks/SM_BrokenBricks5.prefab",
                    "SandboxId://PVZ_LvArt/BrokenBricks/SM_BrokenBricks6.prefab",
                    "SandboxId://PVZ_LvArt/BrokenBricks/SM_BrokenBricks7.prefab",
                    "SandboxId://PVZ_LvArt/BrokenBricks/SM_BrokenBricks8.prefab"
                }

                local randomIndex = math.random(1, #ModelIds)
                local randomModelId = ModelIds[randomIndex]

                -- 随机改变植物模型
                MS.Bridge.SendMessageToServer(
                    MS.Protocol.ClientMsgID.SETPROPERTY, -- Message
                    {
                        Node = raycastFirstObject,
                        PropertyName = "ModelId",
                        PropertyValue = randomModelId
                    },
                    false
                )

                MS.Bridge.SendMessageToServer(
                    MS.Protocol.ClientMsgID.SETATTRIBUTE,
                    {
                        Node = raycastFirstObject,
                        AttributeName = "CanPlant",
                        AttributeValue = true
                    },
                    false
                )

                raycastFirstObject.EffectObject:Start()
            end
        end
    end
    PostBreak()
end

-- 选中场景中物体
SelectActor = function(raycastResult)
    local raycastFirstObject = raycastResult.obj ~= nil and raycastResult.obj or nil
    if raycastFirstObject ~= nil then
        if raycastFirstObject:GetAttribute("GameplayTag") == "Plant" then
            -- ModelRimLight(SelectedActor)
            SelectedActor = raycastFirstObject
        elseif raycastFirstObject:GetAttribute("GameplayTag") == "Drop" then
            SelectedActor = raycastFirstObject
            if SelectedActor.Name == "Sunshine" then
                MS.SoundManager:PlaySound(MS.SoundManager.SoundId.Pick_Sunshine)

                local goal = {
                    --Position = Vector3.New(sunshineSumUI.Position.x,sunshineSumUI.Position.y,sunshineSumUI.Position.z)
					Position = Vector3.New(-305.46, 2212.65, 1014.08)
                }
                local tween = MS.Tween.CreateTween(SelectedActor, goal, 1)
                tween:Play()

                sunshineSum = sunshineSum + 25
                sunshineSumUI.Text_Sun.Title = tostring(sunshineSum)
                SelectedActor.CollideGroupID = 6--31

                MS.Timer.CreateTimer(
                    1,
                    0,
                    false,
                    function()
                        MS.Bridge.SendMessageToServer(
                            MS.Protocol.ClientMsgID.REMOVEACTOR, -- Message
                            {
                                bindActor = SelectedActor
                            },
                            false
                        )
                    end
                ):Start()
            end
        else
            SelectedActor = nil
        end
    end
end

-- 选中植物边缘发光
ModelRimLight = function(BindActor)
end


-- 绑定UI点击事件
function PlantVsZombie:InitMainPanel(panelLayout)
    -- Init the sunshine sum
    sunshineSumUI = panelLayout.TopPanel.Panel_Sun

    sunshineSumUI.Text_Sun.Title = tostring(sunshineSum)
    panelLayout.TopPanel.Btn_Exit.Click:Connect(
        function()
            MS.SoundManager:PlaySound(MS.SoundManager.SoundId.Ui_Click)
            MS.Bridge.SendMessageToServer(
                MS.Protocol.ClientMsgID.ENDGAME, -- Message
                {
                    hp = 0
                },
                false
            )
            local camera = MS.WorkSpace.CurrentCamera
            local goal = 
            {
                Position = Vector3.New(-845.46, 3512.65, 1314.08)
            }
        
            local tween = MS.Tween.CreateTween(camera, goal, 1)
            tween:Play()
            local localPlayer = MS.Players.LocalPlayer
            localPlayer.PlayerGui.PlantVsZombie.Visible = false
            --wait(1)
            --localPlayer.PlayerGui.Lobby.Visible = true
        end
    )
    for _, plantUI in ipairs(panelLayout.TopPanel.PlantSelection.Children) do
        if plantUI:IsA("UIImage") then
            plantUI.Click:Connect(
                function()
                    MS.SoundManager:PlaySound(MS.SoundManager.SoundId.Click_Plant)
                    SelectPlantType(plantUI)
                end
            )
        end
    end

    for _, ToolUI in ipairs(panelLayout.TopPanel.ToolSelection.Children) do
        if ToolUI:IsA("UIImage") then
            if ToolUI.Name == "Btn_Shovel" then
                ToolUI.Click:Connect(
                    function()
                        MS.SoundManager:PlaySound(MS.SoundManager.SoundId.Click_Shovel)
                        SelectShovel(ToolUI)
                    end
                )
            elseif ToolUI.Name == "Btn_Hammer" then
                ToolUI.Click:Connect(
                    function()
                        MS.SoundManager:PlaySound(MS.SoundManager.SoundId.Ui_Click)
                        SelectHammer(ToolUI)
                    end
                )
            end
        end
    end

    -- 在3D空间中检测点击
    MS.UserInputService.InputBegan:Connect(
        function(inputObj, gameProcessed)
            if inputObj.UserInputType == Enum.UserInputType.Touch.Value or Enum.UserInputType.MouseButton1.Value then
                local rayLength = 1000000
                if plantingMode == true then
                    local raycastResult =
                        MS.Utils.TryGetRaycastOnGround(inputObj.Position.X, inputObj.Position.Y, rayLength, false, {1})
                    PlantSelectedPlantType(raycastResult)
                elseif removingMode == true then
                    local raycastResult =
                        MS.Utils.TryGetRaycastOnGround(inputObj.Position.X, inputObj.Position.Y, rayLength, false, {2})
                    RemovePlant(raycastResult)
                    
                elseif breakingMode == true then
                    local raycastResult =
                        MS.Utils.TryGetRaycastOnGround(inputObj.Position.X, inputObj.Position.Y, rayLength, false, {1})
                    BreakFloor(raycastResult)
                else
                    local raycastResult =
                        MS.Utils.TryGetRaycastOnGround(inputObj.Position.X, inputObj.Position.Y, rayLength, false, {6})
                    SelectActor(raycastResult)
                end
            end
        end
    )

    MS.UserInputService.InputChanged:Connect( function(inputObj)
        if nil ~= selectedPlantName then
            local localPlayer = MS.Players.LocalPlayer
            local uiImage = localPlayer.PlayerGui.SelectPlant.Plant
            if true == uiImage.Visible then
                uiImage.Position = Vector2.New(inputObj.Position.x, inputObj.Position.y)
            end
        end
    end)
end

function PlantVsZombie.EndGame(_, t)
    print("EndGame-----------------")
    if t.hp > 0 then
        MS.SoundManager:PlaySound(MS.SoundManager.SoundId.Game_Win)
    else
        MS.SoundManager:PlaySound(MS.SoundManager.SoundId.Game_Lose)
    end
    sunshineSum = startSunFlowerNum
    sunshineSumUI.Text_Sun.Title = tostring(sunshineSum)
    if nil == MS.Players.LocalPlayer.PlayerGui.LevelEnd then
        _G.PlayerActor:Update("OnGameEnd")
    end
    local localPlayer = MS.Players.LocalPlayer
    localPlayer.PlayerGui.LevelEnd.Visible = true
    if localPlayer.PlayerGui.PlantVsZombie then
        localPlayer.PlayerGui.PlantVsZombie.Visible = false
    end
    local gameEndUI = localPlayer.PlayerGui.LevelEnd.MainPanel
    if t.hp > 0 then
        gameEndUI.Succeed.Visible = true
        gameEndUI.Failed.Visible = false
    else
        gameEndUI.Succeed.Visible = false
        gameEndUI.Failed.Visible = true
    end
    local LevelFolder = MS.WorkSpace.Level1:WaitForChild("StoneBrickGroup")
    for _, node in ipairs(LevelFolder.Children) do
        MS.Bridge.SendMessageToServer(
            MS.Protocol.ClientMsgID.SETATTRIBUTE,
            {
                Node = node,
                AttributeName = "HasPlanted",
                AttributeValue = false, 
            },
            false
        )
    end
end

-- PlayerHUD
function PlantVsZombie:Init()
    MS.Bridge.RegisterServerMessageCallback(MS.Protocol.ServerMsgID.ENDGAME, PlantVsZombie.EndGame)
    self:InitMainPanel(self.owner.bindingUI)
end

-- PlantVsZombie.Init()

return PlantVsZombie
