local MAX_REFRESH_TIMECOUNT = 100

local NPC = {}
NPC.__index = NPC

-- This method creates a new NPC object with the given model and position. It requests the model and waits until it is loaded. It then creates a ped at the given position and sets it as invincible and frozen.
-- @param {model} : string, the model of the NPC
-- @param {position} : table, the position of the NPC
-- @returns : NPC object
function NPC:new(model, position)
    local object = {}
    setmetatable(object, NPC)

    object.model = GetHashKey(model)
    object.ped = nil
    object.position = position

    RequestModel(object.model)

    local timeoutCount = 0

    while not HasModelLoaded(object.model) and timeoutCount < MAX_REFRESH_TIMECOUNT do
        timeoutCount = timeoutCount + 1

        Citizen.Wait(100)
    end

    object.ped = CreatePed(4, object.model, position.x, position.y, position.z - 1, position.w, false, false)
    FreezeEntityPosition(object.ped, true)
    SetEntityInvincible(object.ped, true)
    SetBlockingOfNonTemporaryEvents(object.ped, true)

    return object
end

-- This method attaches a prop to the NPC. It first requests the model of the prop and waits until it is loaded. It then creates the object and attaches it to the NPC's ped using the AttachEntityToEntity function.
-- @param {propData} : table, data for the prop to be attached to the NPC
-- @returns : nil
function NPC:attachProp(propData)
    local propHash = GetHashKey(propData.model)

    RequestModel(propHash)

    local timeoutCount = 0

    while not HasModelLoaded(propHash) and timeoutCount < MAX_REFRESH_TIMECOUNT do
        timeoutCount = timeoutCount + 1

        Citizen.Wait(100)
    end

    local object = CreateObject(propHash, self.position.x, self.position.y, self.position.z, true, true, true)
    AttachEntityToEntity(object, self.ped, GetPedBoneIndex(self.ped, propData.bone and propData.bone or 60309), propData.position.x, propData.position.y, propData.position.z, propData.rotation.x, propData.rotation.y, propData.rotation.z, true, true, false, true, 0, true)
end

-- This method plays an animation for the NPC. It first requests the animation dictionary and waits until it is loaded. It then uses the TaskPlayAnim function to play the animation for the NPC's ped.
-- @param {animationDict} : string, the animation dictionary for the animation
-- @param {animationName} : string, the name of the animation
-- @returns : nil
function NPC:playAnimation(animationDict, animationName)
    RequestAnimDict(animationDict)

    while not HasAnimDictLoaded(animationDict) do
        Citizen.Wait(1000)
    end

    TaskPlayAnim(self.ped, animationDict, animationName, 1.0, 1.0, -1, 9, 1.0, 0, 0, 0)
end


-- This function loads an NPC by creating a new NPC object and attaching props and playing animations if specified in the npcData. It runs the code in a separate thread using Citizen.CreateThread.
-- @param {npcData} : table, data for the NPC to be loaded
-- @returns : nil
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
