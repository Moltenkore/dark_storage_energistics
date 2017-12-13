-- This file is part of Storage Energistics
-- Author: Nividica
-- Created: 10/20/2017
-- Description: Provides methods for locating entities on a circuit network
-- require "Utils/Entity"
-- -- Returns a table of all entities connected, either directly or indirectly, to the given entity via the specified wire color
-- -- rootEntity: Entity to start the search with
-- -- wireColor: red or green
-- -- IDSet(optional): Set of entity ID's to exclude
-- -- connectedEntities(optional): Indexed table of entities to append to
-- -- Returns connectedEntities if given, or a new indexed table of entities.
-- function GetEntitiesOnNetwork(rootEntity, wireColor, IDSet, connectedEntities)
--   if IDSet == nil then
--     IDSet = {}
--   end
--   if connectedEntities == nil then
--     connectedEntities = {}
--   end
--   -- Queue of circuit_connected_entities[wireColor]
--   local queue = nil
--   local swapQueue = {}
--   -- Add the rootEntity entity
--   IDSet[GenerateEntityID(rootEntity)] = true
--   swapQueue[#swapQueue + 1] = rootEntity.circuit_connected_entities[wireColor]
--   -- Searching for connected entities
--   while #swapQueue > 0 do
--     -- Begin new queue
--     queue = swapQueue
--     swapQueue = {}
--     -- For each connection in the queue
--     for ckey, connection in ipairs(queue) do
--       -- For each connected entity in the connection
--       for ekey, entity in pairs(connection) do
--         -- Generate an ID
--         local id = GenerateEntityID(entity)
--         -- Has not been seen before?
--         if IDSet[id] == nil then
--           -- Mark as seen
--           IDSet[id] = true
--           -- Add the entity
--           connectedEntities[#connectedEntities + 1] = entity
--           -- Add the entity's connections to the queue
--           swapQueue[#swapQueue + 1] = entity.circuit_connected_entities[wireColor]
--         end
--       end
--     end
--   end
--   return connectedEntities
-- end
-- -- Returns a table of all entities connected, either directly or indirectly, to the given entity
-- -- rootEntity: Entity to start the search with
-- function GetEntitiesOnNetworks(rootEntity)
--   -- Used as a hash set of entity id's to ensure no cycles
--   local IDSet = {}
--   -- All connected entities
--   local connectedEntities = {}
--   -- Search the red branches
--   GetEntitiesOnNetwork(rootEntity, "red", IDSet, connectedEntities)
--   -- Search the green branches
--   GetEntitiesOnNetwork(rootEntity, "green", IDSet, connectedEntities)
--   return connectedEntities
-- end
