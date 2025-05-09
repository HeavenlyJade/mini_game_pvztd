local UidGenerator = {}

UidGenerator.currentId = 1

function UidGenerator:GenerateUid()
    self.currentId = self.currentId + 1
    return self.currentId
end

-- 唯一标识生成器
UidGenerator.Guid = function()
    local seed = {'e', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'}
    local tb = {}
    for i = 1, 32 do
        table.insert(tb, seed[math.random(1, 16)])
    end
    local sid = table.concat(tb)
    return string.format('%s-%s-%s-%s-%s', string.sub(sid, 1, 8), string.sub(sid, 9, 12), string.sub(sid, 13, 16),
        string.sub(sid, 17, 20), string.sub(sid, 21, 32))
end

return UidGenerator