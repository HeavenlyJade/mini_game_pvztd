local actorAttributes = {
    {
        AttrName = "name",
        AttrType = "SubAttrs",
        DefaultValue = ""
    },
    {
        AttrName = "damage",
        AttrType = "double",
        DefaultValue = 0
    },
    {
        AttrName = "health",
        AttrType = "double",
        DefaultValue = 100
    },
    {
        AttrName = "attackSpeed",
        AttrType = "double",
        DefaultValue = 0.2
    },
    {
        AttrName = "spawnObjectName",
        AttrType = "string",
        DefaultValue = ""
    },
    {
        AttrName = "spawnSpeed",
        AttrType = "double",
        DefaultValue = 0
    },
    {
        AttrName = "lifetime",
        AttrType = "double",
        DefaultValue = 0
    },
	{
        AttrName = "price",
        AttrType = "double",
        DefaultValue = 0
	}
}

local configDesc = {
    -- Attribute
    {
        AttrName = "actorType",
        AttrType = "string",
        DefaultValue = ""
    },
    {
        AttrName = "Attributes",
        AttrType = "table",
        SubAttrs = actorAttributes,
        SubAttrsClass = "actorAttributes"
    }
}

return configDesc
