local GameState = {
    Validate = 1,
    LevelOver = false,
    SpawnSunshineTimer = nil,
    ZombieCount = 0,
    totalWaves = 3,
    --zombieTypes = {"Disguised", "BowlerHat", "ZombieNew"}
    zombieTypes = {"Disguised", "BowlerHat"}
    --zombieTypes = {}
}

local GameMode = {
    hp = 100,
}
local waveInfo = nil

--local SpawnZombieLocations = MS.WorkSpace:WaitForChild("ZombieSpawnGroup")
local SpawnZombieLocations = MS.WorkSpace.Level1:WaitForChild("ZombieSpawnGroup")
local function SpawnZombie(zombieType, index, offset)
    --local rand = math.random(1, 6)
    local SpawnZombieLocation = SpawnZombieLocations.Children[index]
    local localOffset = math.random(1, offset) - offset
    MS.LevelManager.SpawnActor("Zombie", zombieType, SpawnZombieLocation, Vector3.New(localOffset * 40, 0, 0), Vector3.New(0, -90, 0))
    GameState.ZombieCount = GameState.ZombieCount + 1
end

local function SpawnSunshine()
    
    GameState.SpawnSunshineTimer = MS.Timer.CreateTimer(
        7,
        10,
        true,
        function()
            if nil ~= GameState.SpawnSunshineTimer then
                local sunshineV3 = waveInfo.sunshineV3 
                local x = math.random(sunshineV3.x[1], sunshineV3.x[2])
                local z = math.random(sunshineV3.z[1], sunshineV3.z[2])
                local startY = sunshineV3.y[1]
                local endY = sunshineV3.y[2]

                local sunshine =
                    MS.LevelManager.SpawnActor(
                    "Drop",
                    "Sunshine",
                    MS.WorkSpace,
                    Vector3.New(x, startY, z),
                    Vector3.New(-40, 0, 0)
                )
                local sunshineBindActor = sunshine.bindActor
                local direction = Vector3.New(0, 0, -1)
                local goal = {
                    Position = Vector3.New(x, endY, z),
                }
                local tween = MS.Tween.CreateTween(sunshineBindActor, goal, 4)
                tween:Play()
            end
        end
    )
    GameState.SpawnSunshineTimer:Start()
end

local function SpawnLawnmower()
    local place1 = Vector3.New(-513.16, 111.45, 116.76)
    local place2 = Vector3.New(-513.16, 111.45, -11.593)
    local place3 = Vector3.New(-513.16, 111.45, -121.831)
    local place4 = Vector3.New(-513.16, 111.45, -249.86)
    local place5 = Vector3.New(-513.16, 111.45, -383.522)
    local place6 = Vector3.New(-513.16, 111.45, -503.241)

    local Lawnmower = MS.LevelManager.SpawnActor("Scene", "Lawnmower", MS.WorkSpace, place1, Vector3.New(0, 0, 0))
    local Lawnmower = MS.LevelManager.SpawnActor("Scene", "Lawnmower", MS.WorkSpace, place2, Vector3.New(0, 0, 0))
    local Lawnmower = MS.LevelManager.SpawnActor("Scene", "Lawnmower", MS.WorkSpace, place3, Vector3.New(0, 0, 0))
    local Lawnmower = MS.LevelManager.SpawnActor("Scene", "Lawnmower", MS.WorkSpace, place4, Vector3.New(0, 0, 0))
    local Lawnmower = MS.LevelManager.SpawnActor("Scene", "Lawnmower", MS.WorkSpace, place5, Vector3.New(0, 0, 0))
    local Lawnmower = MS.LevelManager.SpawnActor("Scene", "Lawnmower", MS.WorkSpace, place6, Vector3.New(0, 0, 0))
end

local function InitCollisionGroup()
    -- Set CollisionGroup
    -- 6 for drop,
    -- 5 for scene,
    -- 4 for projectile,
    -- 3 for zombie,
    -- 2 for plant,
    -- 1 for floor

    -- Zombie
    MS.PhysXService:SetCollideInfo(3, 1, false)
    MS.PhysXService:SetCollideInfo(3, 3, false)
    -- Plant
    MS.PhysXService:SetCollideInfo(2, 1, false)
    MS.PhysXService:SetCollideInfo(2, 4, false)
    MS.PhysXService:SetCollideInfo(2, 5, false)
end

-- 生成僵尸波次
local function StartWave()
    GameState.SpawnZombieTypesTimer = MS.Timer.CreateTimer(
        0,
        0,
        false,
        function()
            if #GameState.zombieTypes > 0 then
				local Validate = GameState.Validate
                GameState.LevelOver = false
                wait(5)
                for wave = 1, #waveInfo do
                    print("Starting wave " .. wave)
                    if Validate ~= GameState.Validate then
                        break
                    end

                    local zombies = {}
                    local zombiesTypeCount = #waveInfo[wave].zombies                    
                    for i = 1, zombiesTypeCount do
                        local zombie = waveInfo[wave].zombies[i]
                        local count = math.random(zombie.nMin, zombie.nMax)
                        for _ = 1, count do
                            local info = 
                            {
                                name = zombie.name,
                                spwanPos = zombie.spwanPos,
                                offset = zombie.offset
                            }               
                            if #zombies > 0 then
                                local index = math.random(1, #zombies)
                                table.insert(zombies, index, info)
                            else
                                table.insert(zombies, info)
                            end
                        end
                    end
                    
                    local zombiesCount = #zombies
                    local currentCount = 1
                    for _ = 1, zombiesCount do
                        local randomZombieCount = math.random(waveInfo[wave].count[1], waveInfo[wave].count[2])
                        local nCount = randomZombieCount
                        for _ = 1, nCount do
                            if currentCount <= #zombies then
                                local zombieType = zombies[currentCount].name -- GameState.zombieTypes[math.random(1, #GameState.zombieTypes)]
                                if Validate ~= GameState.Validate then
                                    break
                                end
                                SpawnZombie(zombieType, math.random(zombies[currentCount].spwanPos[1], zombies[1].spwanPos[2]), zombies[currentCount].offset)
                                print("currentCount: " .. currentCount)
                                currentCount = currentCount + 1  

                                wait(0.01 * math.random(1, 3))
                            else
                                break
                            end
                        end
                        if Validate ~= GameState.Validate then
                            break
                        end
                        if currentCount > zombiesCount then
                            break
                        else
                            wait(math.random(waveInfo[wave].rate[1], waveInfo[wave].rate[2]))
                        end
                        wait(math.random(waveInfo[wave].rate[1], waveInfo[wave].rate[2]))
                    end
                    if nil ~= waveInfo[wave+1] then
                        wait(waveInfo[wave].startTime) -- 每波僵尸之间的延迟
                    end
                end
                GameState.LevelOver = true
            end
            print("Wave end.....")
        end
    )
    GameState.SpawnZombieTypesTimer:Start() 
end

function GameMode.Init()
    InitCollisionGroup()
	MS.Bridge.RegisterClientMessageCallback(MS.Protocol.ClientMsgID.STARTGAME, GameMode.StartGame)
    MS.Bridge.RegisterClientMessageCallback(MS.Protocol.ClientMsgID.ENDGAME, GameMode.EndGame)
end

function GameMode.StartGame(MsgID, _, message)
    --SpawnLawnmower()
    --MS.SoundManager:PlaySound(MS.SoundManager.SoundId.Game_Begin)
    GameMode.hp = 100
    GameMode.LoadWaveConfig(message.level)
    waveInfo = GameMode.WaveConfig.GetWaveConfig(1)
    SpawnSunshine()
    GameMode.StartWave()
end


function GameMode.EndGame(PlayerID, MsgID, Message)
    if GameState.SpawnSunshineTimer ~= nil then
        print("Game Over")
        MS.ActorManager:DestroyAllActors()
        if GameState.SpawnSunshineTimer then
            GameState.SpawnSunshineTimer:Stop()
            GameState.SpawnSunshineTimer = nil
        end
        if GameState.SpawnZombieTypesTimer then
            GameState.SpawnZombieTypesTimer:Stop()
            GameState.SpawnZombieTypesTimer = nil
        end
        GameState.LevelOver = true
        GameMode.hp = Message.hp
        GameState.Validate = GameState.Validate + 1
        GameState.ZombieCount = 0
        MS.Bridge.BroadcastMessage(
            MS.Protocol.ServerMsgID.ENDGAME,
            {
                hp = GameMode.hp
            }
        )
    end
end

function GameMode.RemoveSpawnZombie(owner)
    GameState.ZombieCount = GameState.ZombieCount - 1
    MS.LevelManager.RemoveActor(owner)
    if 0 == GameState.ZombieCount then
        if true == GameState.LevelOver then
            GameState.SpawnSunshineTimer:Stop()
            GameState.SpawnSunshineTimer = nil
            GameState.SpawnZombieTypesTimer:Stop()
            GameState.SpawnZombieTypesTimer = nil
            print("level over----------------")
            MS.Bridge.BroadcastMessage(
                MS.Protocol.ServerMsgID.ENDGAME,
                {
                    hp = GameMode.hp
                }
            )
        end
    end
end

function GameMode.ModifyPlayerHp(value)
    GameMode.hp = GameMode.hp + value
    if GameMode.hp <= 0 then
        GameMode.EndGame(_, _, {hp = GameMode.hp})
    end
end

function GameMode.StartWave()
    --wait(2)
    MS.SoundManager:PlaySound(MS.SoundManager.SoundId.Zombie_Coming)
    StartWave()
end


function GameMode.LoadWaveConfig(level)
    GameMode.WaveConfig = require(MS.MainStorage.Level:WaitForChild("WaveConfig"))
end

-- 临时：退出时强制关服
game.Players.PlayerRemoving:Connect(function()
    game.CloudService:ShutdownServer("GameEnd")
end)

return GameMode
