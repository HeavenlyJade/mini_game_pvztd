local Const = {}

function Const.readonly(table)
    local proxy = {}
    local mt = {
        __index = table,
        __newindex = function(_, key, value)
            error("Attempt to modify read-only table", 2)
        end,
        __metatable = false  -- 防止外部访问 metatable
    }
    setmetatable(proxy, mt)
    return proxy
end

return Const