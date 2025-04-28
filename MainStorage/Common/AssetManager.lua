local AssetManager = {}

-- AssetType : Model, Texture,Particle,LevelScene,Audio
function AssetManager.GetAssetByPath(...)
    local params = {...}
    local temp = {}
    for _, param in ipairs(params) do
        table.insert(temp, tostring(param))
    end

    local AssetNodePath = table.concat(temp, ".")
    return AssetNodePath
end

function AssetManager.GetActorPrefabByName(ActorClass, ActorName)
    -- For Model by now
    local ActorPrefab = nil
    if ActorClass == "Plant" then
        ActorPrefab = MS.MainStorage.Assets.Model.Plant:WaitForChild(ActorName)
    elseif ActorClass == "Zombie" then
        ActorPrefab = MS.MainStorage.Assets.Model.Zombie:WaitForChild(ActorName)
    elseif ActorClass == "Projectile" then
        ActorPrefab = MS.MainStorage.Assets.Model.Projectile:WaitForChild(ActorName)
	elseif ActorClass == "Drop" then
		ActorPrefab = MS.MainStorage.Assets.Model.Drop:WaitForChild(ActorName)
    elseif ActorClass == "Scene" then
		ActorPrefab = MS.MainStorage.Assets.Model.Scene:WaitForChild(ActorName)
    else
        print("Unsupported ActorClass: ".. ActorClass)
    end
    return ActorPrefab
end

return AssetManager
