local Math = {}

Math.PI = 3.141592654

-- 获取随机数
function Math:GetRandomNumbers(maxCount, needCount)
    local numbers = {}
    if (maxCount < needCount) then
        maxCount = needCount
    end
    while #numbers < needCount do
        local n = math.random(1, maxCount)
        local found = false
        for i = 1, #numbers do
            if numbers[i] == n then
                found = true
                break
            end
        end
        if not found then
            table.insert(numbers, n)
        end
    end
    return numbers
end

-- 计算距离
function Math.Distance(a, b)
    return math.sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y) + (a.z - b.z) * (a.z - b.z))
end

function Math.toDegree(radian)
    return radian * 180 / Math.PI
end

-- type : Vector2 pos   Rect rect
-- 判断pos是否在rect内
function Math.isInsideRectangle(pos, rect)
    return pos.x >= rect.Left and pos.x <= rect.Right and pos.y >= rect.Top and pos.y <= rect.Bottom
end

function Math.SqrMagnitude(vector3)
    return vector3.x * vector3.x + vector3.y * vector3.y + vector3.z * vector3.z
end

-- 获取一个单位球内的随机点
function Math.insideUnitSphere()
    -- 在单位立方体内生成一个随机点
    local point = Vector3.new(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1))

    while Math:SqrMagnitude(point) > 1.0 do -- 检查点是否在单位球内
        point = Vector3.new(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1))
    end

    return point
end

-- 获取以指定点为圆心、指定半径的球体内的一个随机位置
function Math.GetRandomPointInUnitSphere(center, radius)
    -- 获取一个单位球内的随机点
    local randomDirection = Math:insideUnitSphere()
    -- 调整随机点的半径
    local randomPosition = center + randomDirection * radius
    return randomPosition
end

Math.toRadian = function(degree)
    return degree * Math.PI / 180
end

-- rot转换dir
Math.rot2dir = function(rot, t)
    if rot.x <= 0 then
        t.x = math.cos(-rot.x) * math.sin(rot.y)
        t.y = math.sin(-rot.x)
        t.z = math.cos(-rot.x) * math.cos(rot.y)
    else
        t.x = math.cos(rot.x) * math.sin(rot.y)
        t.y = -math.sin(rot.x)
        t.z = math.cos(rot.x) * math.cos(rot.y)
    end
end

Math.clamp = function(value, min, max)
    if value < min then
        return min
    elseif value > max then
        return max
    else
        return value
    end
end

-- const
Math.VECZERO       =   Vector3.new(0,0,0)    --默认
Math.VECONE        =   Vector3.new(1,1,1)    --默认
Math.VECUP         =   Vector3.new(0,1,0)    --默认
Math.VECDOWN       =   Vector3.new(0,-1,0)   --默认

return Math
