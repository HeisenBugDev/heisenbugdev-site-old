require "./helpers.rb"

module RecipeDefinitions
  include RecipesModule
  Recipes.new_recipe(:quantumOre, Smelting.new("cobblestone", "stone", 1))
  Recipes.new_recipe(:dirt, Crafting.new("stone", 1, ["stick", "stone", "","stick", "stone", "","stone", "stone", ""]))
end

module Localizations
  @@wiki_files = Dir["views/wiki/**/*.qc"]
  @@localized = {quantumOre: "Quantonium Ore", test: "Test", test1: "Test 1"}
end