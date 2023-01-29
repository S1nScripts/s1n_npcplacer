local MAX_TIMECOUNT = 100

local NPC = {}
NPC.__index = NPC

function NPC:new(model, position)
    local object = {}
    setmetatable(object, NPC)

    object.model = GetHashKey(model)
    object.ped = nil
    object.position = position

    RequestModel(object.model)

    local timeoutCount = 0

    while not HasModelLoaded(object.model) and timeoutCount < 100 do
        timeoutCount = timeoutCount + 1

        Citizen.Wait(100)
    end

    object.ped = CreatePed(4, object.model, position.x, position.y, position.z - 1, position.w, false, true)
    FreezeEntityPosition(object.ped, true)
    SetEntityInvincible(object.ped, true)
    SetBlockingOfNonTemporaryEvents(object.ped, true)

    return object
end

function NPC:attachProp(propData)
    local propHash = GetHashKey(propData.model)

    RequestModel(propHash)

    local timeoutCount = 0

    while not HasModelLoaded(propHash) and timeoutCount < MAX_TIMECOUNT do
        timeoutCount = timeoutCount + 1

        Citizen.Wait(100)
    end

    local object = CreateObject(propHash, self.position.x, self.position.y, self.position.z, true, true, true)
    AttachEntityToEntity(object, self.ped, GetPedBoneIndex(self.ped, propData.bone and propData.bone or 60309), propData.position.x, propData.position.y, propData.position.z, propData.rotation.x, propData.rotation.y, propData.rotation.z, true, true, false, true, 0, true)
end

function NPC:playAnimation(animationDict, animationName)
    RequestAnimDict(animationDict)

    while not HasAnimDictLoaded(animationDict) do
        Citizen.Wait(1000)
    end

    TaskPlayAnim(self.ped, animationDict, animationName, 1.0, 1.0, -1, 9, 1.0, 0, 0, 0)
end

-- Load a NPC with possibility to play an animation and attach a prop to it
-- @param {table} model - Model of the NPC
-- @param {table} position - Position of the NPC
-- @param {table} animation - Animation data of the NPC
-- @param {table} prop - Prop data to attach to the NPC
local function loadNpc(npcData)
    Citizen.CreateThread(function()
        local npc = NPC:new(npcData.model, npcData.position)

        if npcData.props.enable then
            for _, propData in pairs(npcData.props.list) do
                npc:attachProp(propData)
            end
        end

        if npcData.animation.enable then
            npc:playAnimation(npcData.animation.dict, npcData.animation.name)
        end
    end)
end

-- Load all npcs from the config file
for _, npcData in pairs(Config.npcs) do
    loadNpc(npcData)
end