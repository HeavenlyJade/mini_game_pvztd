--场景配置范例
local SceneConfig = {
    --切换方式
    weatherChangeType = "Sequence", --Random:随机切换,Sequence:顺序切换
    --天气切换时间段
    weatherChangeConfig = 
    {
        {
            duration =3,--分钟
            weather = "Weather_1",--天气
            fadeTime = 10,--秒
        },
        {
            duration = 3,--分钟
            weather = "Weather_2",--天气
            fadeTime = 10,--秒
        },
        -- {
        --     duration = 3,--分钟
        --     weather = "Weather_3001_Afternoon",--天气
        --     fadeTime = 10,--秒
        -- },
        -- {
        --     duration = 3,--分钟
        --     weather = "Weather_3001_Evening",--天气
        --     fadeTime = 10,--秒
        -- }
    }

}
return SceneConfig

