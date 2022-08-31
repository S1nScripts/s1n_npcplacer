-- Create a NPC
-- @param {string} model - Model of the NPC
-- @param {vector4} position - Position of the NPC
local function createNpc(model, position)
    local model = GetHashKey(model)

    RequestModel(model)

    local timeoutCount = 0

    while not HasModelLoaded(model) and timeoutCount < 100 do
        timeoutCount = timeoutCount + 1

        Citizen.Wait(100)
    end

    local ped = CreatePed(4, model, position.x, position.y, position.z - 1, position.w, false, true)

    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    return ped
end

-- Attach a prop to an NPC
-- @param {Ped} ped - The ped to attach the prop to
-- @param {Vector3} position - The position of the NPC
-- @param {table} propData - The data of the prop to attach
local function attachPropToNpc(ped, position, propData)
    local propHash = GetHashKey(propData.model)

    RequestModel(propHash)

    local timeoutCount = 0

    while not HasModelLoaded(propHash) and timeoutCount < 100 do
        timeoutCount = timeoutCount + 1

        Citizen.Wait(100)
    end

    local object = CreateObject(propHash, position.x, position.y, position.z, true, true, true)
    AttachEntityToEntity(object, ped, GetPedBoneIndex(ped, propData.bone and propData.bone or 60309), propData.position.x, propData.position.y, propData.position.z, propData.rotation.x, propData.rotation.y, propData.rotation.z, true, true, false, true, 0, true)
end

-- Set an animation to the NPC
-- @param {Ped} ped - The ped to play the animation
-- @param {string} dict - The dictionary to play the animation
-- @param {string} name - The name of the animation
local function setNPCAnimation(ped, animationDict, animationName)
    RequestAnimDict(animationDict)

    while not HasAnimDictLoaded(animationDict) do
        Citizen.Wait(1000)
    end

    TaskPlayAnim(ped, animationDict, animationName, 1.0, 1.0, -1, 9, 1.0, 0, 0, 0)
end

-- Load a NPC with possibility to play an animation and attach a prop to it
-- @param {table} model - Model of the NPC
-- @param {table} position - Position of the NPC
-- @param {table} animation - Animation data of the NPC
-- @param {table} prop - Prop data to attach to the NPC
local function loadNpc(model, position, animData, propData)
    Citizen.CreateThread(function()
        local ped = createNpc(model, position)

        if propData.enable then
            for _, propData in pairs(propData.list) do
                attachPropToNpc(ped, position, propData)
            end
        end

        if animData.enable then
            setNPCAnimation(ped, animData.dict, animData.name)
        end
    end)
end

-- Load all npcs from the config file
for _, npcData in pairs(Config.npcs) do
    loadNpc(npcData.model, npcData.position, npcData.animation, npcData.props)
end