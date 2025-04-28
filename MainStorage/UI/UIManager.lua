local UIManager = MS.Class.new("UIManager")
local localPlayer = MS.Players.LocalPlayer

function UIManager:ctor()
    self.uiRoots = {}
end

function UIManager:CreateUIRoot(UIRootName, Parent)
    local RootPrefab = MS.UIRootPrefab:FindFirstChild(UIRootName)

    local uiRoot = nil
    if RootPrefab ~= nil then
        uiRoot = MS.UIRoot.new(RootPrefab)
        uiRoot.bindingUI.Parent = Parent
        uiRoot.bindingUI.Name = UIRootName
        self.uiRoots[UIRootName] = uiRoot
    end
    return uiRoot
end

function UIManager:SetUIRootVisible(UIRootName,isVisible)
    if self.uiRoots[UIRootName] ~= nil then
        self.uiRoots[UIRootName].bindingUI.Visible = isVisible
    end
end

function UIManager:DestroyUIRoot(UIRootName)
    if self.uiRoots[UIRootName] ~= nil then
        self.uiRoots[UIRootName]:Destroy()
        self.uiRoots[UIRootName] = nil
    end
end

return UIManager
