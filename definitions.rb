require "./helpers.rb"

module RecipeDefinitions
  include RecipesModule
  Recipes.new_recipe(:crystallizedQuantonium, Smelting.new("rawQuantonium",
   "crystallizedQuantonium", 1))
  # Recipes.new_recipe(:quantumOre, Smelting.new("cobblestone", "stone", 1))
  # Recipes.new_recipe(:dirt, Crafting.new("stone", 1, ["stick", "stone", "","stick", "stone", "","stone", "stone", ""]))
end

module Localizations
  @@wiki_files = Dir["views/wiki/**/*.qc"]
  @@localized = {
    a_meta: "Meta",
    blocks: "Blocks",
    items: "Items",
    index: "Home",
    quantoniumOre: "Quantonium Ore",
    rawQuantonium: "Raw Quantonium",
    crystallizedQuantonium: "Crystallized Quantonium"
  }
  def localized
    @@localized
  end
end