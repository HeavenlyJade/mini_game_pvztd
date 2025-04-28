local PlayerState = MS.Class.new("PlayerState")

function PlayerState:ctor()
    self.sunshineSum = 5000
    self.maxPlantNumber = 5
    self.Plants = {}
end

function PlayerState:GetSunshineSum()
    return self.sunshineSum
end

function PlayerState:AddSunshine(sunshine)
    self.sunshineSum = self.sunshineSum + sunshine
end

function PlayerState:AddPlant(Plant)
    table.insert(self.Plants, Plant)
end

function PlayerState:RemovePlant(index)
    table.remove(self.Plants, index)
end

return PlayerState
