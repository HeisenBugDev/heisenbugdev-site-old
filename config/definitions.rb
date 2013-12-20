require_relative '../helpers/renderers'

class DownloadsManager
  class << self
    attr_reader :names
    attr_reader :file_names
    attr_reader :repo_orgs
    attr_reader :descriptions
  end

  @names        = %w(QuantumCraft QuantumCraft-dev DebugHandler)
  @file_names   = %w(QuantumCraft QuantumCraft DebugHandler)
  @repo_orgs    = %w(HeisenBugDev HeisenBugDev HeisenBugDev)
  @descriptions = ['These are the most stable builds, you should start with t'\
                  'hese.', 'You\'re living on the edge, a tech guru, someone '\
                  'who will deal with bugs (and report them). These are highl'\
                  'y likely to break and cause problems. Use at your own risk',
                   'You need this to play QuantumCraft and any other mods that'\
                  ' are/will be here.']
end

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
  Recipes.new_recipe(:QEL, Crafting.new('QEL', 1, [crystal,
                                                   hyper_c,
                                                   crystal,
                                                   'wood_power_pipe',
                                                   'machine_casing',
                                                   'wood_power_pipe',
                                                   q_plating,
                                                   q_plating,
                                                   q_plating]))
  Recipes.new_recipe(:QEL, Crafting.new('QEL', 1, ['QDL']))
  Recipes.new_recipe(:QDL, Crafting.new('QDL', 1, ['QEL']))
  Recipes.new_recipe(:IOF, Crafting.new('IOF', 1, [ingot_unb,
                                                   ingot_unb,
                                                   ingot_unb,
                                                   hyper_c,
                                                   'furnace',
                                                   hyper_c,
                                                   ingot_unb,
                                                   ingot_unb,
                                                   ingot_unb]))
  Recipes.new_recipe(:IOT, Crafting.new('IOT', 1, ['diamond',
                                                   'dpick',
                                                   'diamond',
                                                   q_plating,
                                                   'machine_casing',
                                                   q_plating,
                                                   ingot_unb,
                                                   hyper_c,
                                                   ingot_unb]))
  Recipes.new_recipe(:IOS, Crafting.new('IOS', 1, [hyper_c,
                                                   ingot_unb,
                                                   hyper_c,
                                                   q_plating,
                                                   'machine_casing',
                                                   q_plating,
                                                   hyper_c,
                                                   ingot_unb,
                                                   hyper_c]))
  Recipes.new_recipe(:IOH, Crafting.new('IOH', 1, [ingot_unb,
                                                   ingot_unb,
                                                   ingot_unb,
                                                   q_plating,
                                                   'machine_casing',
                                                   q_plating,
                                                   hyper_c,
                                                   hyper_c,
                                                   hyper_c]))
  Recipes.new_recipe(:QCP, Crafting.new('Capacitor1', 1, [hyper_c,
                                                          q_plating,
                                                          hyper_c,
                                                          hyper_c,
                                                          'machine_casing',
                                                          hyper_c,
                                                          hyper_c,
                                                          q_plating,
                                                          hyper_c]))
  4.times do |capacitor|
    Recipes.new_recipe(:QCP, Crafting.new("Capacitor#{capacitor + 2}", 1, ["Capacitor#{capacitor + 1}",
                                                                           q_plating,
                                                                           "Capacitor#{capacitor + 1}",
                                                                           hyper_c,
                                                                           'machine_casing',
                                                                           hyper_c,
                                                                           "Capacitor#{capacitor + 1}",
                                                                           q_plating,
                                                                           "Capacitor#{capacitor + 1}"]))
  end
  # Recipes.new_recipe(:quantumOre, Smelting.new("cobblestone", "stone", 1))
  # Recipes.new_recipe(:QCP, Crafting.new("stone", 1, ["stick", "stone", "","stick", "stone", "","stone", "stone", ""]))
end

module Localizations
  @@wiki_files = Dir['views/wiki/**/*.qc']
  @@beta       = {
      :QDS => true
  }

  @@localized = {
      :a_meta                     => 'Meta',
      :blocks                     => 'Blocks',
      :items                      => 'Items',
      :development                => 'Development',
      :index                      => 'Home',
      :machines                   => 'Machines',
      :quantonium_ore             => 'Quantonium Ore',
      :raw_quantonium             => 'Raw Quantonium',
      :crystal_quantonium         => 'Crystallized Quantonium',
      :quantum_tools              => 'Quantum Tools',
      :quantum_portable_capacitor => 'Quantum Portable Capacitor',
      :unbioxenium_ore            => 'Unbioxenium Ore',
      :name_database              => 'Name Database',
      :quantum_plating            => 'Quantum Plating',
      :hyper_conductor            => 'Hyper Conductor',
      :q_fiber_wire               => 'Quantum Fiber Wire',
      :upgrades                   => 'Upgrades',
      :machine_casing             => 'Quantum Machine Casing',
      :QDE                        => 'Quantum De-Energizer',
      :QEI                        => 'Quantum Energy Injector',
      :QEE                        => 'Quantum Energy Extractor',
      :QDM                        => 'Quantum De-Materializer',
      :QDS                        => 'Quantum Dislocator',
      :QDL                        => 'Quantum De-Electrifier',
      :QEL                        => 'Quantum Electrifier',
      :IOF                        => 'ION Forge',
      :IOT                        => 'ION Tunneler',
      :IOS                        => 'ION Scanner',
      :IOH                        => 'ION Harvester',
      :QCP                        => 'Quantum Capacitor',
      :A_general                  => 'General',
      :multi_tool                 => 'Multi Tool',
      :guide                      => 'Getting Started',
      :mc_forum_post              => 'Minecraft Forum Post',
      :Capacitor1                 => 'Quantum Basic Capacitor',
      :Capacitor2                 => 'Quantum Advanced Capacitor',
      :Capacitor3                 => 'Quantum Super Capacitor',
      :Capacitor4                 => 'Quantum Ultra Capacitor',
      :Capacitor5                 => 'Quantum Insane Capacitor',
      :glass                      => 'Glass',
      :dye                        => 'Dye',
      :ingot_unbioxenium          => 'Ingot Unbioxenium',
      :blank_upgrade              => 'Blank Upgrade',
      :furnace                    => 'Furnace',
      :diamond                    => 'Diamond',
      :dpick                      => 'Diamond Pickaxe',
      :ender_pearl                => 'Ender Pearl',
      :wood_power_pipe            => 'Wooden Kinesis Pipe'
  }

  def self.localized
    @@localized
  end

  def self.beta
    @@beta
  end
end