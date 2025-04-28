local MainStorage = game:GetService("MainStorage")
local WorkSpace = game:GetService("WorkSpace")

local function AddGroundGameplayTag(node)
    node:AddAttribute("GameplayTag",Enum.AttributeType.String)
    node:AddAttribute("HasPlanted",Enum.AttributeType.Bool)
	node:AddAttribute("CanPlant",Enum.AttributeType.Bool)
    node:SetAttribute("GameplayTag","PlantPlacePosition")
    node:SetAttribute("HasPlanted",false)
	node:SetAttribute("CanPlant",false)

	node.CollideGroupID = 1
	node.EffectObject.LocalScale = Vector3.New(1.5,1.5,1.5)

end

local function AddGroundTagRecursive(node)
    if #node.Children == 0 then
        AddGroundGameplayTag(node)
    else
        for _, child in ipairs(node.Children) do
            AddGroundTagRecursive(child)
        end
    end
end

plugin:addContextMenuButton("AddGameplayTag").Click:Connect(function()
    local LevelFolder = WorkSpace:WaitForChild("StoneBrickGroup")

    for _, node in ipairs(LevelFolder.Children) do
        AddGroundGameplayTag(node)
    end

end)
