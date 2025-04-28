local UIRoot = MS.Class.new("UIRoot")

function UIRoot:ctor(UIRootPrefab)
	local UIFunctionality = MS.UIRootFunctionality:FindFirstChild(UIRootPrefab.Name)

	self.name = UIRootPrefab.Name
    self.bindingUI = nil
	self.bindingFunctionality = nil

    self:SetBindingUI(UIRootPrefab)
	self:SetBindingFunc(UIFunctionality)
end

function UIRoot:SetBindingUI(UIRootPrefab)
    self.bindingUI = UIRootPrefab:Clone()
end

function UIRoot:SetBindingFunc(UIFunctionality)
	self.bindingFunctionality = require(UIFunctionality)
	self.bindingFunctionality.owner = self
    self.bindingFunctionality:Init()
end

function UIRoot:Destroy()
    if self.bindingUI ~= nil then
        self.bindingUI:Destroy()
        self.bindingUI = nil
    end
    if self.bindingFunctionality ~= nil then
        self.bindingFunctionality = nil
    end
end

return UIRoot