

--- ITEM ---
local seProviderChestI = {}

seProviderChestI.type = "item"
seProviderChestI.name = Constants.Names.Proto.ProviderChest.Item
seProviderChestI.icon = Constants.DataPaths.EntityGFX .. "se-provider-chest.png"
seProviderChestI.icon_size = 32
seProviderChestI.subgroup = Constants.Strings.ItemGroups.StorageEnergistics.SubGroups.Buildings
seProviderChestI.order = Constants.Names.Proto.ProviderChest.Item
seProviderChestI.place_result = Constants.Names.Proto.ProviderChest.Entity
seProviderChestI.stack_size = 50

--- RECIPE ---
local seProviderChestR = {}

seProviderChestR.type = "recipe"
seProviderChestR.name = Constants.Names.Proto.ProviderChest.Recipe
seProviderChestR.enabled = false
seProviderChestR.energy_required = 3
seProviderChestR.ingredients = {
    {"logistic-chest-passive-provider", 1},
    { Constants.Names.Proto.PhaseCoil.Item, 1 }
}
seProviderChestR.result = Constants.Names.Proto.ProviderChest.Item

--- ENTITY ---
local seProviderChestE = {}

seProviderChestE.type = "logistic-container"
seProviderChestE.name = Constants.Names.Proto.ProviderChest.Entity
seProviderChestE.icon = Constants.DataPaths.EntityGFX .. "se-provider-chest.png"
seProviderChestE.icon_size = 32
seProviderChestE.flags = { "placeable-player", "player-creation" }
seProviderChestE.minable = { hardness = 0.2, mining_time = 0.5, result = Constants.Names.Proto.ProviderChest.Item }
seProviderChestE.max_health = 350
seProviderChestE.corpse = "small-remnants"
seProviderChestE.collision_box = { { -0.32, -0.32 }, { 0.32, 0.32 } }
seProviderChestE.selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } }
--collision_box = {{-2.7, -2.7}, {2.7, 2.7}},
--selection_box = {{-3.0, -3.0}, {3.0, 3.0}},
seProviderChestE.resistances = {
    {
        type = "fire",
        percent = 90
    },
    {
        type = "impact",
        percent = 60
    }
}
seProviderChestE.fast_replaceable_group = "container"
seProviderChestE.inventory_size = 64
seProviderChestE.logistic_mode = "passive-provider"
seProviderChestE.open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume = 0.65 }
seProviderChestE.close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.7 }
seProviderChestE.vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 }
seProviderChestE.picture = {
    filename = Constants.DataPaths.EntityGFX .. "se-provider-chest.png",
    priority = "extra-high",
    width = 32,
    height = 32,
    --width = 256,
    --height = 256,
    shift = { 0, 0 }
}
seProviderChestE.circuit_wire_connection_point = {
    shadow = {
        red = { 0.734375, 0.453125 },
        green = { 0.609375, 0.515625 }
    },
    wire = {
        red = { 0.44625, 0.21875 },
        green = { 0.38625, 0.375 }
    }
}
seProviderChestE.circuit_wire_max_distance = 9
seProviderChestE.circuit_connector_sprites = circuit_connector_definitions["chest"].sprites

--- IMPORT se-provider-chest ---
data:extend { seProviderChestI }
data:extend { seProviderChestR }
data:extend { seProviderChestE }