require_relative "helpers"

#noinspection RubyLiteralArrayInspection
module RecipeDefinitions
  include RecipesModule
  Recipes.new_recipe(:crystallizedQuantonium, Smelting.new("rawQuantonium",
                                                           "crystalQuantonium", 1))
  Recipes.new_recipe(:quantumPlating, Crafting.new('quantumPlating',
                                                   1,
                                                   ['ingotUnbioxenium',
                                                    'ingotUnbioxenium',
                                                    'ingotUnbioxenium',
                                                    'ingotUnbioxenium',
                                                    'crystalQuantonium',
                                                    'ingotUnbioxenium',
                                                    'ingotUnbioxenium',
                                                    'ingotUnbioxenium',
                                                    'ingotUnbioxenium']))
  # Recipes.new_recipe(:quantumOre, Smelting.new("cobblestone", "stone", 1))
  # Recipes.new_recipe(:QCP, Crafting.new("stone", 1, ["stick", "stone", "","stick", "stone", "","stone", "stone", ""]))
end

module Localizations
  @@wiki_files = Dir["views/wiki/**/*.qc"]
  @@localized  = {
      a_meta:                   "Meta",
      blocks:                   "Blocks",
      items:                    "Items",
      development:              "Development",
      index:                    "Home",
      machines:                 "Machines",
      quantoniumOre:            "Quantonium Ore",
      rawQuantonium:            "Raw Quantonium",
      crystalQuantonium:        "Crystallized Quantonium",
      quantumTools:             "Quantum Tools",
      quantumPortableCapicator: "Quantum Portable Capicator",
      unbioxeniumOre:           "Unbioxenium Ore",
      nameDatabase:             "Name Database",
      quantumPlating:           "Quantum Plating",
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
      A_general:                "General",
      multiTool:                "Multi Tool",
      guide:                    "Getting Started",
      mcForumPost:              "Minecraft Forum Post"
  }

  def self.localized
    @@localized
  end
end