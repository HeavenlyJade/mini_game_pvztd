local Config = {}

function Config.GetCustomConfigNode(ConfigNodeID)
    if MS.CustomConfigService then
        local customNode = MS.CustomConfigService.ConfigGroup[ConfigNodeID]
        if customNode then
            return customNode
        else
            return nil
        end
    end
end

return Config
