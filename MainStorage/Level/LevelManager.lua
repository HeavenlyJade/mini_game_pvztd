local LevelManager = {}

-- 阳光生成队列管理
local sunshineQueue = {}
local isProcessingQueue = false
local SUNSHINE_SPAWN_INTERVAL = 0.5
-- 跟踪所有活跃的太阳花
local activeSunflowers = {}

-- 添加阳光生成请求到队列
local function AddSunshineToQueue(sunflowerActor)
    -- 检查太阳花是否还存在且有效
    if sunflowerActor and sunflowerActor.bindActor and not sunflowerActor.bindActor.IsDestroyed then
        table.insert(sunshineQueue, sunflowerActor)
        
        -- 如果队列没有在处理中，开始处理
        if not isProcessingQueue then
            ProcessSunshineQueue()
        end
    end
end

-- 处理阳光生成队列
function ProcessSunshineQueue()
    if #sunshineQueue == 0 then
        isProcessingQueue = false
        return
    end
    
    isProcessingQueue = true
    
    -- 取出队列中的第一个太阳花
    local sunflowerActor = table.remove(sunshineQueue, 1)
    
    -- 再次检查太阳花是否还存在且有效
    if sunflowerActor and sunflowerActor.bindActor and not sunflowerActor.bindActor.IsDestroyed then
        -- 生成阳光
        if sunflowerActor.actorComponents and sunflowerActor.actorComponents["SpawnComponent"] then
            sunflowerActor.actorComponents["SpawnComponent"]:Spawn()
        end
    end
    
    -- 设置定时器，延迟处理下一个阳光生成请求
    MS.Timer.CreateTimer(
        SUNSHINE_SPAWN_INTERVAL,
        0,
        false,
        function()
            ProcessSunshineQueue()
        end
    ):Start()
end

-- 注册太阳花
local function RegisterSunflower(actor)
    local uid = actor.uid
    activeSunflowers[uid] = actor
end

-- 注销太阳花
local function UnregisterSunflower(actor)
    local uid = actor.uid
    if activeSunflowers[uid] then
        activeSunflowers[uid] = nil
    end
end

-- public
function LevelManager.SpawnActorCallback(PlayerID, MsgID, SpawnMessage)
    MS.Logging.dump(SpawnMessage)
    return LevelManager.SpawnActor(
        SpawnMessage.ActorClass,
        SpawnMessage.ActorName,
        SpawnMessage.Parent,
        SpawnMessage.LocalPosition,
        SpawnMessage.LocalEuler
    )
end

function LevelManager.RemoveActorCallback(PlayerID, MsgID, RemoveMessage)
    MS.Logging.dump(RemoveMessage)
    if RemoveMessage.bindActor ~= nil then
        local Actor = MS.ActorManager:GetActorByUid(RemoveMessage.bindActor:GetAttribute("Uid"))
        if Actor ~= nil then
            LevelManager.RemoveActor(Actor)
        end
    end
end

function LevelManager.SetAttributeCallback(PlayerID, MsgID, AttributeMessage)
    MS.Logging.dump(AttributeMessage)
    return LevelManager.SetAttribute(
        AttributeMessage.Node,
        AttributeMessage.AttributeName,
        AttributeMessage.AttributeValue
    )
end

function LevelManager.SetPropertyCallback(PlayerID, MsgID, PropertyMessage)
    MS.Logging.dump(PropertyMessage)
    return LevelManager.SetProperty(PropertyMessage.Node, PropertyMessage.PropertyName, PropertyMessage.PropertyValue)
end

-- Function
function LevelManager.SpawnActor(ActorClass, ActorName, Parent, LocalPosition, LocalEuler)
    local configNode = MS.Config.GetCustomConfigNode(ActorName)

    local ActorObject = configNode.Model:Clone()
    ActorObject.Name = ActorName
    ActorObject.Parent = Parent
    ActorObject.LocalPosition = LocalPosition
    ActorObject.LocalEuler = LocalEuler

    -- UID
    local uid = MS.UidGenerator:GenerateUid()
    ActorObject:AddAttribute("Uid", Enum.AttributeType.Number)
    ActorObject:SetAttribute("Uid", uid)

    -- GameplayTag
    ActorObject:AddAttribute("GameplayTag", Enum.AttributeType.String)
    ActorObject:SetAttribute("GameplayTag", ActorClass)

    if ActorClass == "Drop" then
        ActorObject.CollideGroupID = 6
    elseif ActorClass == "Plant" then
        ActorObject.CollideGroupID = 2
    elseif ActorClass == "Zombie" then
        ActorObject.CollideGroupID = 3
    elseif ActorClass == "Projectile" then
        ActorObject.CollideGroupID = 4
    elseif ActorClass == "Scene" then
        ActorObject.CollideGroupID = 5
    end

    local Actor = MS.ActorManager:CreateActor(ActorObject, ActorClass, ActorName, uid)
    if ActorName == "Sunflower" then
        -- 注册到活跃太阳花列表
        RegisterSunflower(Actor)
    end
    return Actor
end

function LevelManager.SetAttribute(Node, AttributeName, AttributeValue)
    Node:SetAttribute(AttributeName, AttributeValue)
    return Node:GetAttribute(AttributeName)
end

function LevelManager.SetProperty(Node, PropertyName, PropertyValue)
    Node[PropertyName] = PropertyValue
end

function LevelManager.RemoveActor(Actor)
    -- 如果是太阳花，从活跃列表中移除
    if Actor.bindActor.Name == "Sunflower" then
        UnregisterSunflower(Actor)
    end
    
    local uid = Actor.bindActor:GetAttribute("Uid")
    MS.ActorManager:DestroyActorByUid(uid)
end

-- Register

local function RegisterCallbackToClient()
    MS.Bridge.RegisterClientMessageCallback(MS.Protocol.ClientMsgID.SPAWNACTOR, LevelManager.SpawnActorCallback)
    MS.Bridge.RegisterClientMessageCallback(MS.Protocol.ClientMsgID.REMOVEACTOR, LevelManager.RemoveActorCallback)
    MS.Bridge.RegisterClientMessageCallback(MS.Protocol.ClientMsgID.SETATTRIBUTE, LevelManager.SetAttributeCallback)
    MS.Bridge.RegisterClientMessageCallback(MS.Protocol.ClientMsgID.SETPROPERTY, LevelManager.SetPropertyCallback)
end

-- Init
function LevelManager.Init()
    RegisterCallbackToClient()
    MS.GameMode.Init()
end

-- 导出阳光队列管理函数，供其他模块使用
LevelManager.AddSunshineToQueue = AddSunshineToQueue

return LevelManager
