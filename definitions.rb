require_relative "helpers"

#noinspection RubyLiteralArrayInspection
module RecipeDefinitions
  include RecipesModule
  crystal   = 'crystalQuantonium'
  ingot_unb = 'ingotUnbioxenium'
  hyper_c   = 'hyperConductor'
  q_plating = 'quantumPlating'
  Recipes.new_recipe(:crystalQuantonium, Smelting.new("rawQuantonium",
                                                      "crystalQuantonium", 1))
  Recipes.new_recipe(:quantumPlating, Crafting.new('quantumPlating',
                                                   4,
                                                   [ingot_unb,
                                                    ingot_unb,
                                                    ingot_unb,
                                                    ingot_unb,
                                                    crystal,
                                                    ingot_unb,
                                                    ingot_unb,
                                                    ingot_unb,
                                                    ingot_unb]))
  Recipes.new_recipe(:hyperConductor, Crafting.new('hyperConductor',
                                                   6,
                                                   ['glass',
                                                    'glass',
                                                    'glass',
                                                    crystal,
                                                    crystal,
                                                    crystal,
                                                    'glass',
                                                    'glass',
                                                    'glass']))
  Recipes.new_recipe(:QFiberWire, Crafting.new('QFiberWire', 6, [q_plating,
                                                                 q_plating,
                                                                 q_plating,
                                                                 hyper_c,
                                                                 hyper_c,
                                                                 hyper_c,
                                                                 q_plating,
                                                                 q_plating,
                                                                 q_plating]))
  Recipes.new_recipe(:multiTool, Crafting.new('multiTool', 1, ['',
                                                               ingot_unb,
                                                               '',
                                                               'dye',
                                                               ingot_unb,
                                                               ingot_unb,
                                                               '',
                                                               'dye',
                                                               '']))
  Recipes.new_recipe(:upgrades, Crafting.new('blankUpgrade', 1, [q_plating,
                                                                 q_plating,
                                                                 q_plating,
                                                                 q_plating,
                                                                 hyper_c,
                                                                 q_plating,
                                                                 q_plating,
                                                                 q_plating,
                                                                 q_plating]))
  Recipes.new_recipe(:quantumPortableCapacitor,
                     Crafting.new('quantumPortableCapacitor',
                                  1,
                                  [q_plating,
                                   crystal,
                                   q_plating,
                                   hyper_c,
                                   crystal,
                                   hyper_c,
                                   q_plating,
                                   crystal,
                                   q_plating]))
  Recipes.new_recipe(:machineCasing, Crafting.new('machineCasing',
                                                  1,
                                                  [q_plating,
                                                   q_plating,
                                                   q_plating,
                                                   q_plating,
                                                   '',
                                                   q_plating,
                                                   q_plating,
                                                   q_plating,
                                                   q_plating]))
  # Recipes.new_recipe(:quantumOre, Smelting.new("cobblestone", "stone", 1))
  # Recipes.new_recipe(:QCP, Crafting.new("stone", 1, ["stick", "stone", "","stick", "stone", "","stone", "stone", ""]))
end

module Localizations
  @@wiki_files = Dir["views/wiki/**/*.qc"]
  @@localized  = {
      :a_meta                   => "Meta",
      :blocks                   => "Blocks",
      :items                    => "Items",
      :development              => "Development",
      :index                    => "Home",
      :machines                 => "Machines",
      :quantonium_ore           => "Quantonium Ore",
      :raw_quantonium           => "Raw Quantonium",
      :crystal_quantonium       => "Crystallized Quantonium",
      :quantumTools             => "Quantum Tools",
      :quantumPortableCapacitor => "Quantum Portable Capacitor",
      :unbioxeniumOre           => "Unbioxenium Ore",
      :nameDatabase             => "Name Database",
      :quantumPlating           => "Quantum Plating",
      :hyperConductor           => "Hyper Conductor",
      :QFiberWire               => "Quantum Fiber Wire",
      :upgrades                 => "Upgrades",
      :machine_casing           => "Quantum Machine Casing",
      :QDE                      => "Quantum De-Energizer",
      :QEI                      => "Quantum Energy Injector",
      :QEE                      => "Quantum Energy Extractor",
      :QDM                      => "Quantum De-Materializer",
      :QDS                      => "Quantum Dislocator",
      :QDL                      => "Quantum De-Electrifier",
      :QEL                      => "Quantum Electrifier",
      :IOF                      => "ION Forge",
      :IOT                      => "ION Tunneler",
      :IOS                      => "ION Scanner",
      :IOH                      => "ION Harvester",
      :QCP                      => "Quantum Capacitor",
      :A_general                => "General",
      :multiTool                => "Multi Tool",
      :guide                    => "Getting Started",
      :mcForumPost              => "Minecraft Forum Post"
  }

  def self.localized
    @@localized
  end
end