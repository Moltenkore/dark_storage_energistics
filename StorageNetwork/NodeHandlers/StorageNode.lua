-- This file is part of Storage Energistics
-- Author: Nividica
-- Created: 10/29/2017
-- Description: Storage Node

return function(BaseHandler)
  local StorageNodeHandler = {
    HandlerName = SE.Constants.Names.NodeHandlers.Storage,
    Type = SE.Constants.NodeTypes.Storage
  }
  setmetatable(StorageNodeHandler, {__index = BaseHandler})

  -- ForceReadOnly( Node ) :: bool
  -- Returns true if read only should be forced, based on the entity
  local function ForceReadOnly(node)
    return node.Entity.name == SE.Constants.Names.Proto.RequesterChest.Entity
  end

  -- @See BaseNode:OnPlayerOpenedNode
  -- Show the gui
  function StorageNodeHandler:OnPlayerOpenedNode(player)
    if (not ForceReadOnly(self)) then
      return SE.GuiManager.Guis.StorageNode
    end
  end

  -- @See BaseNode:InsertItems
  function StorageNodeHandler:InsertItems(stack, simulate)
    if (self.ReadOnlyMode) then
      return 0
    end
    local inv = self.Entity.get_inventory(defines.inventory.chest)
    local inserted = inv.insert(stack)
    if (simulate and inserted > 0) then
      inv.remove({name = stack.name, count = inserted})
    end
    return inserted
  end

  -- @See BaseNode:ExtractItems
  function StorageNodeHandler:ExtractItems(stack, simulate)
    local inv = self.Entity.get_inventory(defines.inventory.chest)
    local removed = inv.remove(stack)
    if (simulate and removed > 0) then
      inv.insert({name = stack.name, count = removed})
    end
    return removed
  end

  -- @See BaseNode:GetItemCount
  function StorageNodeHandler:GetItemCount(itemName)
    local inv = self.Entity.get_inventory(defines.inventory.chest)
    return inv.get_item_count(itemName)
  end

  -- @See BaseNode:OnPasteSettings
  function StorageNodeHandler:GetContents(catalog)
    local inv = self.Entity.get_inventory(defines.inventory.chest)
    -- Get total slot count
    local totalSlots = #inv

    -- Add total to catalog
    catalog[SE.Constants.Strings.TotalSlots] = (catalog[SE.Constants.Strings.TotalSlots] or 0) + totalSlots

    -- Examine inventory
    local freeSlots = 0
    local item = nil
    for idx = 1, totalSlots do
      item = inv[idx]
      if (item.valid_for_read) then
        --SE.Logger.Trace("Index " .. tostring(idx) .. " has item " .. item.name .. " x" .. tostring(item.count))
        -- Add item to catalog
        catalog[item.name] = (catalog[item.name] or 0) + item.count
      else
        freeSlots = freeSlots + 1
      end
    end

    -- Add free to catalog
    catalog[SE.Constants.Strings.FreeSlots] = (catalog[SE.Constants.Strings.FreeSlots] or 0) + freeSlots
  end

  -- OnPasteSettings( Self,  LuaEntity, LuaPlayer ) :: void
  function StorageNodeHandler:OnPasteSettings(sourceEntity, player)
    -- Is this node forced read-only?
    if (ForceReadOnly(self)) then
      return
    end

    -- Other node is storage node?
    local node = SE.Networks.GetNodeForEntity(sourceEntity)
    if (node ~= nil) then
      local handler = SE.NodeHandlers.GetNodeHandler(node)
      if (handler ~= nil and handler.Type == SE.Constants.NodeTypes.Storage) then
        -- Copy read only setting
        self.ReadOnlyMode = node.ReadOnlyMode
      end
    end
  end

  -- @See BaseNode.NewNode
  function StorageNodeHandler.NewNode(entity)
    return StorageNodeHandler.EnsureStructure(BaseHandler.NewNode(entity))
  end

  -- @See BaseNode:EnsureStructure
  function StorageNodeHandler:EnsureStructure()
    BaseHandler.EnsureStructure(self)
    self.HandlerName = StorageNodeHandler.HandlerName
    if (ForceReadOnly(self)) then
      self.ReadOnlyMode = true
    end
    --self.ReadOnlyMode = nil
    return self
  end

  return StorageNodeHandler
end
