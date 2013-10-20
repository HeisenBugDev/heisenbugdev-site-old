module RecipesModule

  class Recipe
    def initialize(name, input, output, quantity)
      @name = name
      @input = input
      @output = output
      @quantity = quantity
    end
  end

  class Smelting < Recipe
    def initialize(input, output, quantity)
      super("Smelting", input, output, quantity)
    end
  end

  class Crafting < Recipe
    def initialize  (output, quantity, input)
      super("Crafting", input, output, quantity)
    end
  end

  class Recipes
    # Create the recipes here. Once you do that put the image files in public/images/wiki/
    @@recipes = {}
    @@recipes[:cobblestone] = Smelting.new("cobblestone", "stone", 1)
    @@recipes[:dirt] = Crafting.new("stone", 1, ["stick", "stone", "","stick", "stone", "","stone", "stone", ""])

    def self.recipe(name)
      @@recipes[name]
    end
  end

  def render_stack(blockitem, size)
    if size < 2
      size = nil
    end
    html = ""
    html << "<a href=\"#\" class=\"stack-link\">"; # Not done, still need to change that for things
    html << "<div class=\"recipe-icon\" style=\"background: url(#{url("images/wiki/#{blockitem}.png")});\" title=\"{$name}\">#{size}</div>";
    html << "</a>";
  end

  def render_smelting(blockitem)
    html = "<div class=\"recipe smelt\" style=\"background: url(#{url("images/wiki/smelt.png")})\">"
    html << "<div class=\"slot\" style=\"top: 15px; left: 49px;\">"
    html << render_stack(Recipes.recipe(blockitem).instance_variable_get(:@input), 1)
    html << "</div>"
    html << "<div class=\"slot\" style=\"top: 50px; left: 169px;\">"
    html << render_stack(Recipes.recipe(blockitem).instance_variable_get(:@output), 
      Recipes.recipe(blockitem).instance_variable_get(:@quantity))
    html << "</div>"
    html << "</div>"
  end

  def render_crafting(blockitem)
    if Recipes.recipe(blockitem) == nil
      return "idiot! did not give a valid symbol"
    end
    html = "<div class=\"recipe craft\" style=\"background: url(#{url("images/wiki/craft.png")})\">"
    9.times do |i|
      x = 14 + (i % 3)*36
      y = 50 + (((i / 3)-0.2)-1).round * 36
      html << "<div class=\"slot\" style=\"top: #{y}px; left: #{x}px;\">"
      html << render_stack(Recipes.recipe(blockitem).instance_variable_get(:@input)[i],1)
      html << "</div>"
    end
    html << "<div class=\"slot\" style=\"top: 50px; left: 202px;\">"
    html << render_stack(Recipes.recipe(blockitem).instance_variable_get(:@output),Recipes.recipe(blockitem).instance_variable_get(:@quantity))
    html << "</div>"
    html << "</div>"
    #Recipes.recipe(:dirt)
  end
  
end