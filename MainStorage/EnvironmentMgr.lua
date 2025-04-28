local Workspace = game:GetService("Workspace")

local M = {}

M.IsOpen = true
M.ActiveteIdx = 1

M.Alls = {
    [1] = {          -----------PVZ_3001_evening
         --SkyLight
        Position = {X = 0, Y = 0, Z = 0},
        Euler = {X = 0, Y = 0, Z = 0},
        LocalPosition = {X = 0, Y = 0, Z = 0},
        LocalEuler = {X = 0, Y = 0, Z = 0},
        LocalScale = {X = 1, Y = 1, Z = 1},
        CubeBorderEnable = false,
        CubeBorderColor ={R = 135, G = 206, B = 250, A = 255}, 

        SkyLightType = Enum.SkyLightType.Gradient , 
        SkyLightTexture="",--SandboxId://Map_Scenes/HDRI/FK_1010_Skylight.png
        SkyLightCubeAssetID="",--SandboxId://Map_Scenes/HDRI/FK_1010_Skylight.png
        Intensity= 1.3,
        Color = {R = 231, G = 171, B = 171, A = 255}, 
        --BlendAmount = 1,
        AmbientSkyColor = {R = 187, G = 207, B = 248, A = 255}, 
        AmbientEquatorColor = {R = 172, G = 191, B = 247, A = 255}, 
        AmbientGroundColor = {R = 137, G = 114, B = 159, A = 255}, 
        AmbientColor = {R = 130, G = 133, B = 140, A = 255}, 

        --Atmosphere
        FogType =  Enum.FogType.Linear,        
        FogColor = {R = 96, G = 138, B = 171, A = 255}, 
        FogStart = 1000.00, 
        FogEnd = 10000.00,
        FogOffset = 0.9,

        --skydome
        HazeColor = {R = 57, G = 59, B = 70, A = 255}, 
        HorizonColor = {R = 44, G = 45, B = 59, A = 255},
        ZenithColor = {R = 60, G = 61, B = 73, A = 255},
        SkyBoxType = Enum.SkyBoxType.Custom,
        CubeAssetID ="",

        CloudsEnable = true,
        ShadowColor = {R = 72, G = 74, B = 86, A = 255}, 
        ShadowDarkColor = {R = 87, G = 87, B = 96, A = 255},
        CloudsCoverage = 0.042,
        LightIntensity = 0.1,
        CloudsSpeed = 0.5,
        CloudsAlpha = 0.2,
        StarsAmount= 0,
            
        --SunLight
        SunLightIntensity=0.9,
        SunLightColor = {R = 134, G = 197, B = 225, A = 255},
        LockTimeDir = false,
        SunLightEuler = {X = 44, Y = 34, Z = -40},

        ShadowBias = 0.15,
        ShadowSlopeBias = 0.3,
        ShadowDistance = 4000,
        ShadowCascadeCount =Enum.ShadowCascadeCount.TWO,
        SunRaysActive = true,
        SunRaysScale = 2,
        SunRaysThreahold = 0.5,
        SunRaysColor = {R = 184, G = 202, B = 244, A = 255},
        
        UseCustomSunAndMoonTex = false,
        SunTex = "" ,
        SunScale = {X = 1, Y = 1},
        MoonTex = "" ,
        MoonScale = {X = 1, Y = 1},     
        
        ---PostProcessing
        BloomActive = true,
        BloomIntensity = 2,
        BloomThreshold = 1,
        BloomLuminanceScale=1,
        BloomIterator=4,
        
        DofActive = false,
        DofFocalRegion = 100,
        DofNearTransitionRegion = 9000,
        DofFarTransitionRegion = 50000,
        DofFocalDistance = 100,
        DofScale = 1,

        VignetteActive = true,
        VignetteIntensity=0.3,
        VignetteRounded=false,
        VignetteSmoothness=0.4,
        VignetteRoundness=1,
        VignetteMaskOpacity=1,
        VignetteCenter={X = 0.5, Y = 0.5},
        VignetteColor={R = 20, G = 20, B = 20, A = 255},
        VignetteMode=Enum.VignetteMode.Classic,
        
        AntialiasingEnable = true,
        --AntialiasingMethod = kAntialiasingMethodSMAA,
        --AntialiasingQuality = kAntialiasingQualityHigh,

        LUTsActive = true,
        --LUTsTemperatureType =WhilteBalance,
        LUTsWhiteTemp = 5500,
        LUTsWhiteTint = 0,
        LUTsColorCorrectionShadowsMax = 1,
        LUTsColorCorrectionHighlightsMin = 1,
        LUTsBlueCorrection = 0.59,
        LUTsExpandGamut = 1,
        LUTsToneCurveAmout = 0.6,
        LUTsFilmicToneMapSlope = 0.7,
        LUTsFilmicToneMapToe = 0.5,
        LUTsFilmicToneMapShoulder = 0,
        LUTsFilmicToneMapBlackClip = 0.02,
        LUTsFilmicToneMapWhiteClip = 1,

        LUTsBaseSaturation = {R = 229, G = 229, B = 229, A = 255},
        LUTsBaseContrast = {R = 255, G = 255, B = 255, A = 255},
        LUTsBaseGamma = {R = 213, G = 213, B = 213, A = 255},
        LUTsBaseGain = {R = 255, G = 255, B = 255, A = 255},
        LUTsBaseOffset = {R = 0, G = 0, B = 0, A = 0},
        LUTsShadowSaturation = {R = 255, G = 255, B = 255, A = 255},
        LUTsShadowContrast = {R = 255, G = 255, B = 255, A = 255},
        LUTsShadowGamma = {R = 225, G = 225, B = 225, A = 255},
        LUTsShadowGain = {R = 229, G = 229, B = 229, A = 255},
        LUTsShadowOffset = {R = 0, G = 0, B = 0, A = 0},
        LUTsMidtoneSaturation = {R = 255, G = 255, B = 255, A = 255},
        LUTsMidtoneContrast = {R = 255, G = 255, B = 255, A = 255},
        LUTsMidtoneGamma = {R = 255, G = 255, B = 255, A = 255},
        LUTsMidtoneGain = {R = 255, G = 255, B = 255, A = 255},
        LUTsMidtoneOffset = {R = 0, G = 0, B = 0, A = 0},
        LUTsHighlightSaturation = {R = 218, G = 218, B = 218 , A = 255},
        LUTsHighlightContrast = {R = 255, G = 255, B = 255, A = 255},
        LUTsHighlightGamma = {R = 255, G = 255, B = 255, A = 255},
        LUTsHighlightGain = {R = 255, G = 255, B = 255, A = 255},
        LUTsHighlightOffset = {R = 0, G = 0, B = 0, A = 0},
        LUTsColorGradingLUTPath = "",
        GTAOActive = false,
        GTAOThicknessblend = 0.75,
        GTAOFalloffStartRatio = 5,
        GTAOFalloffEnd = 70,
        GTAOFadeoutDistance = 7000,
        GTAOFadeoutRadius = 3000,
        GTAOIntensity = 0.5,
        GTAOPower = 3.5,
        ChromaticAberrationActive = false,
        ChromaticAberrationIntensity = 1,
        ChromaticAberrationStartOffset = 0,
        ChromaticAberrationlterationStep = 0.01,
        ChromaticAberrationlterationSamples = 1,
    },
	[2] = {          -----------PVZ_3001_noon
         --SkyLight
        Position = {X = 0, Y = 0, Z = 0},
        Euler = {X = 0, Y = 0, Z = 0},
        LocalPosition = {X = 0, Y = 0, Z = 0},
        LocalEuler = {X = 0, Y = 0, Z = 0},
        LocalScale = {X = 1, Y = 1, Z = 1},
        CubeBorderEnable = false,
        CubeBorderColor ={R = 135, G = 206, B = 250, A = 255}, 

        SkyLightType = Enum.SkyLightType.Gradient , 
        SkyLightTexture="",--SandboxId://Map_Scenes/HDRI/FK_1010_Skylight.png
        SkyLightCubeAssetID="",--SandboxId://Map_Scenes/HDRI/FK_1010_Skylight.png
        Intensity= 1.3,
        Color = {R = 231, G = 171, B = 171, A = 255}, 
        --BlendAmount = 1,
        AmbientSkyColor = {R = 225, G = 249, B = 255, A = 255}, 
        AmbientEquatorColor = {R = 189, G = 212, B = 255, A = 255}, 
        AmbientGroundColor = {R = 101, G = 116, B = 103, A = 255}, 
        AmbientColor = {R = 130, G = 133, B = 140, A = 255}, 

        --Atmosphere
        FogType =  Enum.FogType.Linear,        
        FogColor = {R = 189, G = 126, B = 55, A = 255}, 
        FogStart = 1000.00, 
        FogEnd = 10000.00,
        FogOffset = 0.9,

        --skydome
        HazeColor = {R = 57, G = 59, B = 70, A = 255}, 
        HorizonColor = {R = 44, G = 45, B = 59, A = 255},
        ZenithColor = {R = 60, G = 61, B = 73, A = 255},
        SkyBoxType = Enum.SkyBoxType.Custom,
        CubeAssetID ="",

        CloudsEnable = true,
        ShadowColor = {R = 72, G = 74, B = 86, A = 255}, 
        ShadowDarkColor = {R = 87, G = 87, B = 96, A = 255},
        CloudsCoverage = 0.042,
        LightIntensity = 0.1,
        CloudsSpeed = 0.5,
        CloudsAlpha = 0.2,
        StarsAmount= 0,
            
        --SunLight
        SunLightIntensity=1.3,
        SunLightColor = {R = 216, G = 247, B = 255, A = 255},
        LockTimeDir = false,
        SunLightEuler = {X = 41, Y = 14, Z = 0},

        ShadowBias = 0.1,
        ShadowSlopeBias = 1,
        ShadowDistance = 8000,
        ShadowCascadeCount =Enum.ShadowCascadeCount.TWO,
        SunRaysActive = true,
        SunRaysScale = 5,
        SunRaysThreahold = 0.5,
        SunRaysColor = {R = 184, G = 505, B = 244, A = 255},
        
        UseCustomSunAndMoonTex = false,
        SunTex = "" ,
        SunScale = {X = 1, Y = 1},
        MoonTex = "" ,
        MoonScale = {X = 1, Y = 1},     
        
        ---PostProcessing
        BloomActive = true,
        BloomIntensity = 2,
        BloomThreshold = 1,
        BloomLuminanceScale=1,
        BloomIterator=4,
        
        DofActive = false,
        DofFocalRegion = 100,
        DofNearTransitionRegion = 9000,
        DofFarTransitionRegion = 50000,
        DofFocalDistance = 100,
        DofScale = 1,

        VignetteActive = true,
        VignetteIntensity=0.3,
        VignetteRounded=false,
        VignetteSmoothness=0.4,
        VignetteRoundness=1,
        VignetteMaskOpacity=1,
        VignetteCenter={X = 0.5, Y = 0.5},
        VignetteColor={R = 20, G = 20, B = 20, A = 255},
        VignetteMode=Enum.VignetteMode.Classic,
        
        AntialiasingEnable = true,
        --AntialiasingMethod = kAntialiasingMethodSMAA,
        --AntialiasingQuality = kAntialiasingQualityHigh,

        LUTsActive = true,
        --LUTsTemperatureType =WhilteBalance,
        LUTsWhiteTemp = 5000,
        LUTsWhiteTint = 0.1,
        LUTsColorCorrectionShadowsMax = 0.5,
        LUTsColorCorrectionHighlightsMin = 0.7,
        LUTsBlueCorrection = 0.7,
        LUTsExpandGamut = 1,
        LUTsToneCurveAmout = 0.8,
        LUTsFilmicToneMapSlope = 0.8,
        LUTsFilmicToneMapToe = 0.45,
        LUTsFilmicToneMapShoulder = 0.45,
        LUTsFilmicToneMapBlackClip = 0.01,
        LUTsFilmicToneMapWhiteClip = 0.04,

        LUTsBaseSaturation = {R = 255, G = 255, B = 255, A = 255},
        LUTsBaseContrast = {R = 255, G = 255, B = 255, A = 255},
        LUTsBaseGamma = {R = 255, G = 255, B = 255, A = 255},
        LUTsBaseGain = {R = 255, G = 255, B = 255, A = 255},
        LUTsBaseOffset = {R = 0, G = 0, B = 0, A = 0},
        LUTsShadowSaturation = {R = 255, G = 255, B = 255, A = 255},
        LUTsShadowContrast = {R = 255, G = 255, B = 255, A = 255},
        LUTsShadowGamma = {R = 255, G = 255, B = 255, A = 255},
        LUTsShadowGain = {R = 255, G = 255, B = 255, A = 255},
        LUTsShadowOffset = {R = 0, G = 0, B = 0, A = 0},
        LUTsMidtoneSaturation = {R = 255, G = 255, B = 255, A = 255},
        LUTsMidtoneContrast = {R = 255, G = 255, B = 255, A = 255},
        LUTsMidtoneGamma = {R = 255, G = 255, B = 255, A = 255},
        LUTsMidtoneGain = {R = 255, G = 255, B = 255, A = 255},
        LUTsMidtoneOffset = {R = 0, G = 0, B = 0, A = 0},
        LUTsHighlightSaturation = {R = 255, G = 255, B = 255 , A = 255},
        LUTsHighlightContrast = {R = 255, G = 255, B = 255, A = 255},
        LUTsHighlightGamma = {R = 255, G = 255, B = 255, A = 255},
        LUTsHighlightGain = {R = 255, G = 255, B = 255, A = 255},
        LUTsHighlightOffset = {R = 0, G = 0, B = 0, A = 0},
        LUTsColorGradingLUTPath = "",
        GTAOActive = false,
        GTAOThicknessblend = 0.75,
        GTAOFalloffStartRatio = 5,
        GTAOFalloffEnd = 70,
        GTAOFadeoutDistance = 7000,
        GTAOFadeoutRadius = 3000,
        GTAOIntensity = 0.5,
        GTAOPower = 3.5,
        ChromaticAberrationActive = false,
        ChromaticAberrationIntensity = 1,
        ChromaticAberrationStartOffset = 0,
        ChromaticAberrationlterationStep = 0.01,
        ChromaticAberrationlterationSamples = 1,
    }
}

function M.RefreshConfig()
    local idx = M.ActiveteIdx
    local environment = Workspace:WaitForChild("Environment")
    if not environment then
        print("当前没有environment")
        return
    end
    if idx > #M.Alls then
        idx = 1
    end
    local EnvConfig = M.Alls[idx]
    if EnvConfig == nil then
        return
    end
    environment.OpenMiniCraftRender=false
    -- environment.LockTimeHour= true
    -- environment.TimeHour=16.799
    -- -- environment.SkyLight.Color =  ColorQuad.new(255,255,254,255)
    -- -- environment.SkyLight.AmbientColor=ColorQuad.new(255,255,254,255)
    -- work.Camera.FieldOfView=75
    -- work.Camera.ZFar=600000
    -- local snow=MS.MainStorage.Assets.VFX.VFX_2001_CamSnow
    -- if snow then
    --     if work.Camera.Snow ==nil then
    --         local clo=snow:Clone()
    --         clo.Parent= work:WaitForChild("Camera")
    --         clo.Name="Snow"
    --         clo.LocalPosition=Vector3.new(0,0,0)    
    --         print("添加雪特效")
    --     end
    -- end
    if environment:WaitForChild("SkyLight") then
        environment.SkyLight.SkyLightType=EnvConfig.SkyLightType 
        environment.SkyLight.SkyLightTexture=EnvConfig.SkyLightTexture 
        environment.SkyLight.Intensity = EnvConfig.Intensity
        environment.SkyLight.Color =  ColorQuad.new(EnvConfig.Color.R, EnvConfig.Color.G, EnvConfig.Color.B, EnvConfig.Color.A)
        environment.SkyLight.AmbientSkyColor=ColorQuad.new(EnvConfig.AmbientSkyColor.R, EnvConfig.AmbientSkyColor.G, EnvConfig.AmbientSkyColor.B, EnvConfig.AmbientSkyColor.A)
        environment.SkyLight.AmbientEquatorColor=ColorQuad.new(EnvConfig.AmbientEquatorColor.R, EnvConfig.AmbientEquatorColor.G, EnvConfig.AmbientEquatorColor.B, EnvConfig.AmbientEquatorColor.A)
        environment.SkyLight.AmbientGroundColor=ColorQuad.new(EnvConfig.AmbientGroundColor.R, EnvConfig.AmbientGroundColor.G, EnvConfig.AmbientGroundColor.B, EnvConfig.AmbientGroundColor.A)
        environment.SkyLight.AmbientColor=ColorQuad.new(EnvConfig.AmbientColor.R, EnvConfig.AmbientColor.G, EnvConfig.AmbientColor.B, EnvConfig.AmbientColor.A)
        environment.SkyLight.CubeAssetID=EnvConfig.SkyLightCubeAssetID
    else
        print("当前没有SkyLight")
    end

     if environment:WaitForChild("Atmosphere") then
        environment.Atmosphere.FogType=EnvConfig.FogType
        environment.Atmosphere.FogColor = ColorQuad.new(EnvConfig.FogColor.R, EnvConfig.FogColor.G, EnvConfig.FogColor.B, EnvConfig.FogColor.A)
        environment.Atmosphere.FogStart = EnvConfig.FogStart
        environment.Atmosphere.FogEnd = EnvConfig.FogEnd
    else
        print("当前没有Atmosphere")
    end
   
        ------------------------------SkyDome------------------------------

    if environment:WaitForChild("SkyDome") then
        environment.SkyDome.HazeColor = ColorQuad.new(EnvConfig.HazeColor.R, EnvConfig.HazeColor.G, EnvConfig.HazeColor.B, EnvConfig.HazeColor.A)
        environment.SkyDome.HorizonColor = ColorQuad.new(EnvConfig.HorizonColor.R, EnvConfig.HorizonColor.G, EnvConfig.HorizonColor.B, EnvConfig.HorizonColor.A)
        environment.SkyDome.ZenithColor = ColorQuad.new(EnvConfig.ZenithColor.R, EnvConfig.ZenithColor.G, EnvConfig.ZenithColor.B, EnvConfig.ZenithColor.A)
        environment.SkyDome.ShadowColor = ColorQuad.new(EnvConfig.ShadowColor.R, EnvConfig.ShadowColor.G, EnvConfig.ShadowColor.B, EnvConfig.ShadowColor.A)
        environment.SkyDome.ShadowDarkColor = ColorQuad.new(EnvConfig.ShadowDarkColor.R, EnvConfig.ShadowDarkColor.G, EnvConfig.ShadowDarkColor.B, EnvConfig.ShadowDarkColor.A)
        environment.SkyDome.CloudsCoverage = EnvConfig.CloudsCoverage
        environment.SkyDome.CloudsAlpha = EnvConfig.CloudsAlpha
        environment.SkyDome.CubeAssetID = EnvConfig.CubeAssetID
        environment.SkyDome.SkyBoxType=EnvConfig.SkyBoxType
    else
        print("当前没有SkyDome")
    end
        ------------------------------SunLight------------------------------

    if environment:WaitForChild("SunLight") then
        environment.SunLight.Intensity = EnvConfig.SunLightIntensity
        environment.SunLight.Color = ColorQuad.new(EnvConfig.SunLightColor.R, EnvConfig.SunLightColor.G, EnvConfig.SunLightColor.B, EnvConfig.SunLightColor.A)
        environment.SunLight.Euler = Vector3.new(EnvConfig.SunLightEuler.X, EnvConfig.SunLightEuler.Y, EnvConfig.SunLightEuler.Z)
        environment.SunLight.ShadowDistance=EnvConfig.ShadowDistance
        environment.SunLight.ShadowCascadeCount=EnvConfig.ShadowCascadeCount
        environment.SunLight.ShadowBias =  EnvConfig.ShadowBias
        environment.SunLight.ShadowSlopeBias =  EnvConfig.ShadowSlopeBias

        environment.SunLight.LockTimeDir =  EnvConfig.LockTimeDir
        environment.SunLight.SunRaysActive =  EnvConfig.SunRaysActive
        environment.SunLight.SunRaysScale =  EnvConfig.SunRaysScale
        environment.SunLight.SunRaysThreahold =  EnvConfig.SunRaysThreahold
        environment.SunLight.SunRaysColor = ColorQuad.new(EnvConfig.SunRaysColor.R, EnvConfig.SunRaysColor.G, EnvConfig.SunRaysColor.B, EnvConfig.SunRaysColor.A)
        
    else
        print("当前没有SunLight")
    end

        ----------------------------PostProcessing----------------------------
    if environment:WaitForChild("PostProcessing") then
        environment.PostProcessing.LUTsActive = EnvConfig.LUTsActive
        environment.PostProcessing.BloomActive = EnvConfig.BloomActive
        environment.PostProcessing.BloomIntensity = EnvConfig.BloomIntensity
        environment.PostProcessing.BloomThreshold = EnvConfig.BloomThreshold
        environment.PostProcessing.BloomLuminanceScale = EnvConfig.BloomLuminanceScale
        environment.PostProcessing.BloomIterator = EnvConfig.BloomIterator


        environment.PostProcessing.VignetteActive = EnvConfig.VignetteActive
        environment.PostProcessing.VignetteIntensity = EnvConfig.VignetteIntensity
        environment.PostProcessing.VignetteRounded = EnvConfig.VignetteRounded
        environment.PostProcessing.VignetteSmoothness = EnvConfig.VignetteSmoothness
        environment.PostProcessing.VignetteRoundness = EnvConfig.VignetteRoundness
        environment.PostProcessing.AntialiasingEnable = EnvConfig.AntialiasingEnable
        environment.PostProcessing.VignetteMaskOpacity = EnvConfig.VignetteMaskOpacity
        environment.PostProcessing.VignetteCenter =  Vector2.new(EnvConfig.VignetteCenter.X, EnvConfig.VignetteCenter.Y)
        environment.PostProcessing.VignetteColor = ColorQuad.new(EnvConfig.VignetteColor.R, EnvConfig.VignetteColor.G, EnvConfig.VignetteColor.B, EnvConfig.VignetteColor.A)
        environment.PostProcessing.VignetteMode = EnvConfig.VignetteMode


        environment.PostProcessing.LUTsWhiteTemp = EnvConfig.LUTsWhiteTemp
        environment.PostProcessing.LUTsFilmicToneMapToe = EnvConfig.LUTsFilmicToneMapToe
        environment.PostProcessing.LUTsFilmicToneMapShoulder = EnvConfig.LUTsFilmicToneMapShoulder
        environment.PostProcessing.LUTsBaseGain = ColorQuad.new(EnvConfig.LUTsBaseGain.R, EnvConfig.LUTsBaseGain.G, EnvConfig.LUTsBaseGain.B, EnvConfig.LUTsBaseGain.A)
        environment.PostProcessing.LUTsBaseSaturation = ColorQuad.new(EnvConfig.LUTsBaseSaturation.R, EnvConfig.LUTsBaseSaturation.G, EnvConfig.LUTsBaseSaturation.B, EnvConfig.LUTsBaseSaturation.A)
        environment.PostProcessing.LUTsBaseGamma = ColorQuad.new(EnvConfig.LUTsBaseGamma.R, EnvConfig.LUTsBaseGamma.G, EnvConfig.LUTsBaseGamma.B, EnvConfig.LUTsBaseGamma.A)
        environment.PostProcessing.LUTsBaseOffset = ColorQuad.new(EnvConfig.LUTsBaseOffset.R, EnvConfig.LUTsBaseOffset.G, EnvConfig.LUTsBaseOffset.B, EnvConfig.LUTsBaseOffset.A)
        environment.PostProcessing.LUTsShadowOffset = ColorQuad.new(EnvConfig.LUTsShadowOffset.R, EnvConfig.LUTsShadowOffset.G, EnvConfig.LUTsShadowOffset.B, EnvConfig.LUTsShadowOffset.A)
        environment.PostProcessing.LUTsMidtoneOffset = ColorQuad.new(EnvConfig.LUTsMidtoneOffset.R, EnvConfig.LUTsMidtoneOffset.G, EnvConfig.LUTsMidtoneOffset.B, EnvConfig.LUTsMidtoneOffset.A)
        environment.PostProcessing.LUTsHighlightOffset = ColorQuad.new(EnvConfig.LUTsHighlightOffset.R, EnvConfig.LUTsHighlightOffset.G, EnvConfig.LUTsHighlightOffset.B, EnvConfig.LUTsHighlightOffset.A)
    else
        print("当前没有PostProcessing")
    end
end

function M.RadialFlash(enable, params)
    local environment = Workspace:WaitForChild("Environment")
    if not environment then
        print("当前没有environment")
        return
    end
    local postProcessing = environment.PostProcessing
    if postProcessing == nil then
        return
    end
    postProcessing.RadialFlashActive = enable
    if not enable then
        return
    end
    postProcessing.RadialFlashLuminance = params.luminance or 0.65
    postProcessing.RadialFlashRadius = params.radius or 0.001
    postProcessing.RadialFlashContrast = params.contrast or 3
    postProcessing.RadialFlashThreshold = params.threshold or 0.06
    postProcessing.RadialFlashColor = ColorQuad.new(params.color[1] or 255, params.color[2] or 255, params.color[3] or 255, params.color[4] or 255)
    postProcessing.RadialFlashScale = Vector2.new(params.scale[1] or 1, params.scale[2] or 1)
    postProcessing.RadialFlashPivot = Vector2.new(params.pivot[1] or 0.5, params.pivot[2] or 0.5)
    postProcessing.RadialFlashSpeed = Vector2.new(params.speed[1] or 0, params.speed[2] or 0)
    postProcessing.RadialFlashNoiseTexturePath = params.texturePath
end

function M.Start()
    if M.IsOpen then
        M.RefreshConfig()
    end
end

return M
