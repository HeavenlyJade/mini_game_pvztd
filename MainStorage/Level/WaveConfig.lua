local WaveConfig = 
{
   --关卡1
   [1] = 
   {
        -- 太阳起始的X,Z轴坐标范围;太阳Y轴移动的起始坐标和终点坐标
        ["sunshineV3"] = {["x"] = {-1150,150},["y"] = {1600,810}, ["z"] = {-550,180}},
       --第一波
       [1] =
       {
	       rate = {3,5},      --僵尸的频率
           count = {1,3},      --僵尸的数量
           startTime = 8,          --第二波僵尸潮来的开始的时间, 单位是秒
           --多少种僵尸
           zombies = 
           {
                [1] = --僵尸id
                {
                    name = "Disguised",          --僵尸的名称
                    spwanPos = {1,6},      --僵尸产生的位置
                    nMin = 15,           --僵尸最少数量
                    nMax = 15,           --僵尸最多数量    
                    offset = 10,        --位置偏移范围
                },

                [2] = --僵尸id
                {
                    name = "BowlerHat", --僵尸的名称
                    spwanPos = {1,6},   --僵尸产生的位置
                    nMin = 15,           --僵尸最少数量
                    nMax = 15,           --僵尸最多数量    
                    offset = 10,        --位置偏移范围
                },               
           },
       },

       --第二波
       [2] =
       {
	   	   rate = {3,5},      --僵尸的频率
            count = {1,3},      --僵尸的数量
           startTime = 8,          --第三波僵尸潮来的开始的时间, 单位是秒
           --多少种僵尸
           zombies = 
           {
                [1] = --僵尸id
                {
                    name = "Disguised",          --僵尸的名称
                    spwanPos = {1,6},      --僵尸产生的位置
                    nMin = 25,           --僵尸最少数量
                    nMax = 25,           --僵尸最多数量    
                    offset = 10,        --位置偏移范围
                },

                [2] = --僵尸id
                {
                    name = "BowlerHat", --僵尸的名称
                    spwanPos = {1,6},   --僵尸产生的位置
                    nMin = 25,           --僵尸最少数量
                    nMax = 25,           --僵尸最多数量    
                    offset = 10,        --位置偏移范围
                },               
           },
       },
       
       --第三波
       [3] =
       {
	   	   rate = {3,5},      --僵尸的频率
              count = {1,3},      --僵尸的数量
           startTime = 8,          --第四波僵尸潮来的开始的时间, 单位是秒
           --多少种僵尸
           zombies = 
           {
                [1] = --僵尸id
                {
                    name = "Disguised",          --僵尸的名称
                    spwanPos = {1,6},      --僵尸产生的位置
                    nMin = 35,           --僵尸最少数量
                    nMax = 35,           --僵尸最多数量    
                    offset = 10,        --位置偏移范围
                },

                [2] = --僵尸id
                {
                    name = "BowlerHat", --僵尸的名称
                    spwanPos = {1,6},   --僵尸产生的位置
                    nMin = 35,           --僵尸最少数量
                    nMax = 35,           --僵尸最多数量    
                    offset = 10,        --位置偏移范围
                },               
           },
       },
       --第四波
       [4] =
       {
	   	   rate = {3,5},      --僵尸的频率
              count = {1,3},      --僵尸的数量
           startTime = 8,          --第五波僵尸潮来的开始的时间, 单位是秒
           --多少种僵尸
           zombies = 
           {
                [1] = --僵尸id
                {
                    name = "Disguised",          --僵尸的名称
                    spwanPos = {1,6},      --僵尸产生的位置
                    nMin = 40,           --僵尸最少数量
                    nMax = 40,           --僵尸最多数量    
                    offset = 10,        --位置偏移范围
                },

                [2] = --僵尸id
                {
                    name = "BowlerHat", --僵尸的名称
                    spwanPos = {1,6},   --僵尸产生的位置
                    nMin = 40,           --僵尸最少数量
                    nMax = 40,           --僵尸最多数量    
                    offset = 10,        --位置偏移范围
                },               
           },
       },
    }
}

function WaveConfig.GetWaveConfig(level)
    return WaveConfig[level]
end

function WaveConfig.Init()
    print("WaveConfig Init")
end
WaveConfig.Init()

return WaveConfig