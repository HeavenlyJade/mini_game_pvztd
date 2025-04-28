-- 客户端-服务器协议 (Callback)
local Protocol = {

    -- 客户端协议  区间[1000,2000)
    ClientMsgID = {
        TEST = 1001, --  测试用
        SETATTRIBUTE = 1002, --  设置自定义属性
        SPAWNACTOR = 1003, --  生成Actor
		REMOVEACTOR = 1004,-- 删除Actor
		SETPROPERTY = 1005,-- 设置本身自带属性
        TELEPORT_REQUEST = 1006, --  传送请求
		STARTGAME = 1100,   --游戏开始
		ENDGAME = 1101,   --游戏结束
    },

    -- 服务器协议  区间[2000,-]
    ServerMsgID = {
        TEST = 2001, --  测试用
        ENDGAME = 1101,   --游戏结束
    }
}

return Protocol
