--[[
    Need help with the script ? Go into the Discord support server  https://discord.gg/aKF3DX8yPx
]]

Config = {
    npcs = {
        --[[
            Template:
            {
                position = vector4(x, y, z, heading), -- NPC position X, Y, Z, Heading
                model = "modelName", -- NPC model (here is a list of all models https://wiki.rage.mp/index.php?title=Peds)
                animation = { -- Animation list : https://alexguirre.github.io/animations-list/ (dict in bold, animation name in regular)
                    enable = true, -- Activate the animation for the NPC
                    dict = "dictName", -- Dictionary associated to the animation
                    name = "animationName" -- Animation's name
                },
                props = {
                    enable = true, -- Activate the use of a prop for the NPC
                    list = {
                        {
                            model = "propName", -- Model of the prop
                            position = vec3(x, y, z), -- Position of the prop relative to the NPC
                            rotation = vec3(x, y, z) -- Rotation of the prop relative to the NPC
                        },
                    }
                }
            },
        ]]
        {
            position = vector4(461.288, -1691.799, 29.28, 225.0), -- NPC position X, Y, Z, Heading
            model = "csb_trafficwarden", -- NPC model (here is a list of all models https://wiki.rage.mp/index.php?title=Peds)
            animation = { -- Animation list : https://alexguirre.github.io/animations-list/ (dict in bold, animation name in regular)
                enable = true, -- Activate the animation for the NPC
                dict = "mp_player_intdrink", -- Dictionary associated to the animation
                name = "loop_bottle" -- Animation's name
            },
            props = {
                enable = true, -- Activate the use of a prop for the NPC
                list = {
                    {
                        model = "prop_ld_flow_bottle", -- Model of the prop
                        position = vec3(0.01, 0.01, 0.01), -- Position of the prop relative to the NPC
                        rotation = vec3(0.0, 0.0, -1.5) -- Rotation of the prop relative to the NPC
                    },
                }
            }
        },
        {
            position = vector4(459.71, -1691.42, 29.28, 319.87), -- NPC position X, Y, Z, Heading
            model = "ig_andreas", -- NPC model (here is a list of all models https://wiki.rage.mp/index.php?title=Peds)
            animation = { -- Animation list : https://alexguirre.github.io/animations-list/ (dict in bold, animation name in regular)
                enable = true, -- Activate the animation for the NPC
                dict = "amb@world_human_drinking@coffee@male@base", -- Dictionary associated to the animation
                name = "base" -- Animation's name
            },
            props = {
                enable = true, -- Activate the use of a prop for the NPC
                list = {
                    {
                        model = "p_amb_brolly_01", -- Model of the prop
                        bone = 57005, -- Bone associated to the prop
                        position = vec3(0.15, 0.005, 0.0), -- Position of the prop relative to the NPC
                        rotation = vec3(87.0, -20.0, 180.0) -- Rotation of the prop relative to the NPC
                    },
                }
            }
        },
        {
            position = vector4(458.3, -1690.5, 29.28, 343.25), -- NPC position X, Y, Z, Heading
            model = "s_m_y_airworker", -- NPC model (here is a list of all models https://wiki.rage.mp/index.php?title=Peds)
            animation = { -- Animation list : https://alexguirre.github.io/animations-list/ (dict in bold, animation name in regular)
                enable = true, -- Activate the animation for the NPC
                dict = "missheistdockssetup1clipboard@base", -- Dictionary associated to the animation
                name = "base" -- Animation's name
            },
            props = {
                enable = true, -- Activate the use of a prop for the NPC
                list = {
                    {
                        model = "prop_notepad_01", -- Model of the prop
                        bone = 18905, -- Bone associated to the prop
                        position = vec3(0.1, 0.02, 0.05), -- Position of the prop relative to the NPC
                        rotation = vec3(10.0, 0.0, 0.0) -- Rotation of the prop relative to the NPC
                    },
                    {
                        model = "prop_pencil_01", -- Model of the prop
                        bone = 58866, -- Bone associated to the prop
                        position = vec3(0.11, -0.02, 0.001), -- Position of the prop relative to the NPC
                        rotation = vec3(-120.0, 0.0, 0.0) -- Rotation of the prop relative to the NPC
                    },
                }
            }
        },
    }
}