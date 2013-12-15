require_relative "renderers"

#noinspection RubyLiteralArrayInspection
module RecipeDefinitions
  include RecipesModule
  crystal   = 'crystal_quantonium'
  ingot_unb = 'ingot_unbioxenium'
  hyper_c   = 'hyper_conductor'
  q_plating = 'quantum_plating'
  Recipes.new_recipe(:crystal_quantonium, Smelting.new('raw_quantonium',
                                                       'crystal_quantonium', 1))
  Recipes.new_recipe(:quantum_plating, Crafting.new('quantum_plating',
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
  Recipes.new_recipe(:hyper_conductor, Crafting.new('hyper_conductor',
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
  Recipes.new_recipe(:q_fiber_wire, Crafting.new('q_fiber_wire',
                                                 6,
                                                 [q_plating,
                                                  q_plating,
                                                  q_plating,
                                                  hyper_c,
                                                  hyper_c,
                                                  hyper_c,
                                                  q_plating,
                                                  q_plating,
                                                  q_plating]))
  Recipes.new_recipe(:multi_tool, Crafting.new('multi_tool', 1, ['',
                                                                 ingot_unb,
                                                                 '',
                                                                 'dye',
                                                                 ingot_unb,
                                                                 ingot_unb,
                                                                 '',
                                                                 'dye',
                                                                 '']))
  Recipes.new_recipe(:upgrades, Crafting.new('blank_upgrade', 1, [q_plating,
                                                                  q_plating,
                                                                  q_plating,
                                                                  q_plating,
                                                                  hyper_c,
                                                                  q_plating,
                                                                  q_plating,
                                                                  q_plating,
                                                                  q_plating]))
  Recipes.new_recipe(:quantum_portable_capacitor,
                     Crafting.new('quantum_portable_capacitor',
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
  Recipes.new_recipe(:machine_casing, Crafting.new('machine_casing',
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
  Recipes.new_recipe(:QDE, Crafting.new('QDE', 1, [q_plating,
                                                   crystal,
                                                   q_plating,
                                                   hyper_c,
                                                   'machine_casing',
                                                   hyper_c,
                                                   q_plating,
                                                   q_plating,
                                                   q_plating]))
  Recipes.new_recipe(:QDM, Crafting.new('QDM', 1, [crystal,
                                                   hyper_c,
                                                   crystal,
                                                   'glass',
                                                   'ender_pearl',
                                                   'glass',
                                                   q_plating,
                                                   'machine_casing',
                                                   q_plating]))
  Recipes.new_recipe(:QEI, Crafting.new('QEI', 1, [crystal,
                                                   crystal,
                                                   crystal,
                                                   q_plating,
                                                   'machine_casing',
                                                   q_plating,
                                                   q_plating,
                                                   hyper_c,
                                                   q_plating]))
  Recipes.new_recipe(:QEI, Crafting.new('QEI', 1, ['QEE']))
  Recipes.new_recipe(:QEE, Crafting.new('QEE', 1, ['QEI']))
  # Recipes.new_recipe(:quantumOre, Smelting.new("cobblestone", "stone", 1))
  # Recipes.new_recipe(:QCP, Crafting.new("stone", 1, ["stick", "stone", "","stick", "stone", "","stone", "stone", ""]))
end

module Localizations
  @@wiki_files = Dir["views/wiki/**/*.qc"]
  @@localized  = {
      :a_meta                     => "Meta",
      :blocks                     => "Blocks",
      :items                      => "Items",
      :development                => "Development",
      :index                      => "Home",
      :machines                   => "Machines",
      :quantonium_ore             => "Quantonium Ore",
      :raw_quantonium             => "Raw Quantonium",
      :crystal_quantonium         => "Crystallized Quantonium",
      :quantum_tools              => "Quantum Tools",
      :quantum_portable_capacitor => "Quantum Portable Capacitor",
      :unbioxenium_ore            => "Unbioxenium Ore",
      :name_database              => "Name Database",
      :quantum_plating            => "Quantum Plating",
      :hyper_conductor            => "Hyper Conductor",
      :q_fiber_wire               => "Quantum Fiber Wire",
      :upgrades                   => "Upgrades",
      :machine_casing             => "Quantum Machine Casing",
      :QDE                        => "Quantum De-Energizer",
      :QEI                        => "Quantum Energy Injector",
      :QEE                        => "Quantum Energy Extractor",
      :QDM                        => "Quantum De-Materializer",
      :QDS                        => "Quantum Dislocator",
      :QDL                        => "Quantum De-Electrifier",
      :QEL                        => "Quantum Electrifier",
      :IOF                        => "ION Forge",
      :IOT                        => "ION Tunneler",
      :IOS                        => "ION Scanner",
      :IOH                        => "ION Harvester",
      :QCP                        => "Quantum Capacitor",
      :A_general                  => "General",
      :multi_tool                 => "Multi Tool",
      :guide                      => "Getting Started",
      :mc_forum_post              => "Minecraft Forum Post"
  }

  def self.localized
    @@localized
  end
end