
local SoundManager = {}

SoundManager.SoundId = {
    Hall_Background = 1,--大厅背景音乐
    Game_Background = 2,--游戏背景音乐
    Pick_Plant = 3,--种植植物
    Ui_Click = 4,--点击按钮
    Game_Win = 5,--游戏胜利
    Game_Lose = 6,--游戏失败
    Frozen = 7,--冰冻
    Game_Begin = 8,--游戏开始
    Grow_Plant = 9,--放置植物
    Burn = 10,--燃烧
    Hit_Zombie = 11,--僵尸攻击
    Pick_Sunshine = 12,--收集阳光
    Wait_Zombie = 13,--僵尸等待
    Plant_Shoot = 14,--植物射击
    Zombie_Coming = 15,--僵尸来袭
    Zombie_Attack = 16,--僵尸攻击
    Zombie_Move_1 = 17,--僵尸移动1
    Zombie_Move_2 = 18,--僵尸移动2
    Click_Shovel = 19,--点击铲子
    Digup_Plant = 20,--挖出植物
    Synthetic_Plant = 21,--合成植物
    Click_Plant = 22,--点击植物
}

function SoundManager:Init()
    if self.isInit then
        return
    end
    self.isInit = true
    local rootNode = MS.MainStorage.Sound
    self.soundsMap = {
        [SoundManager.SoundId.Hall_Background] = {node = rootNode.hall_background, loop = true},
        [SoundManager.SoundId.Game_Background] = {node = rootNode.game_background, loop = true},
        [SoundManager.SoundId.Pick_Plant] = {node = rootNode.pick_plant, loop = false},
        [SoundManager.SoundId.Ui_Click] = {node = rootNode.ui_click, loop = false},
        [SoundManager.SoundId.Game_Win] = {node = rootNode.game_win, loop = false},
        [SoundManager.SoundId.Game_Lose] = {node = rootNode.game_lose, loop = false},
        [SoundManager.SoundId.Frozen] = {node = rootNode.frozen, loop = false},  
        [SoundManager.SoundId.Game_Begin] = {node = rootNode.game_begin, loop = false},
        [SoundManager.SoundId.Grow_Plant] = {node = rootNode.grow_plant, loop = false},
        [SoundManager.SoundId.Burn] = {node = rootNode.burn, loop = false},    
        [SoundManager.SoundId.Hit_Zombie] = {node = rootNode.hit_zombie, loop = false},
        [SoundManager.SoundId.Pick_Sunshine] = {node = rootNode.pick_sunshine, loop = false},
        [SoundManager.SoundId.Wait_Zombie] = rootNode.wait_zombie,
        [SoundManager.SoundId.Plant_Shoot] = {node = rootNode.plant_shoot, loop = false},
        [SoundManager.SoundId.Zombie_Coming] = {node = rootNode.zombie_coming, loop = false},
        [SoundManager.SoundId.Zombie_Attack] = {node = rootNode.zombie_attack, loop = false},
        [SoundManager.SoundId.Zombie_Move_1] = {node = rootNode.move_1, loop = false},
        [SoundManager.SoundId.Zombie_Move_2] = {node = rootNode.move_2, loop = false},
        [SoundManager.SoundId.Click_Shovel] = {node = rootNode.click_shovel, loop = false},
        [SoundManager.SoundId.Digup_Plant] = {node = rootNode.digup_plant, loop = false},
        [SoundManager.SoundId.Synthetic_Plant] = {node = rootNode.synthetic_plant, loop = false},
        [SoundManager.SoundId.Click_Plant] = {node = rootNode.pick_plant, loop = false},
    }

    self.soundCache = {}
    self.soundGroup = SandboxNode.new('SoundGroup')
    self.soundGroup.LocalSyncFlag = Enum.NodeSyncLocalFlag.DISABLE
    self.soundGroup.Name = 'SoundGroup'
    self.soundGroup.Parent = game.Workspace
end

function SoundManager:PlaySound(soundid)
    print("play sound:",soundid)
    local sound = self.soundCache[soundid]
    if sound then
        if sound.IsPlaying then
            sound:StopSound()
        end
        sound:PlaySound()
        return
    end
    local soundInfo = self.soundsMap[soundid]
    if not soundInfo or not soundInfo.node then
        print("soundNode not found:", soundid)
        return  
    end

    sound = soundInfo.node:Clone()
    sound.IsLoop = soundInfo.loop
    sound.Volume = 1.0
    sound.Parent = self.soundGroup
    self.soundCache[soundid] = sound

    sound:PlaySound()
end

function SoundManager:StopSound(soundid)
    local sound = self.soundCache[soundid]
    if sound then
        sound:StopSound()
    end
end 

function SoundManager:StopAllSound()
    for _, sound in pairs(self.soundCache) do
        sound:StopSound()
    end
end 




return SoundManager