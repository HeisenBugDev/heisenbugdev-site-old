module RecipesModule
  class Recipe
    def initialize(name, input, output, quantity)
      @name     = name
      @input    = input
      @output   = output
      @quantity = quantity
    end
  end

  class Smelting < Recipe
    def initialize(input, output, quantity)
      super("Smelting", input, output, quantity)
    end
  end

  class Crafting < Recipe
    def initialize (output, quantity, input)
      super("Crafting", input, output, quantity)
    end
  end

  module Recipes
    # Create the recipes here. Once you do that put the image files in public/images/wiki/
    @@recipes = {}

    def self.new_recipe(name, recipe)
      if @@recipes[name.to_sym].nil?
        @@recipes[name.to_sym] = [recipe]
      else
        @@recipes[name.to_sym] << recipe
      end
    end

    def self.recipe(name)
      @@recipes[name.to_sym]
    end
  end

  def render_stack(blockitem, size)
    if size < 2
      size = nil
    end
    html = ""

    # html << "<a href=\"#{link}\" class=\"stack-link\">"; # Not done, still need to change that for things
    html << "<div class=\"recipe-icon\" style=\"background: url(#{url("images/wiki/#{blockitem}.png")});\" title=\"#{blockitem}\">#{size}</div>"
    # html << "</a>";
  end

  def render_smelting(blockitem)
    if Recipes.recipe(blockitem) == nil || Recipes.recipe(blockitem)[0].class == Crafting
      return ""
    end
    html = ''
    Recipes.recipe(blockitem).each do |block_item|
      html << "<div class=\"recipe smelt\" style=\"background: url(#{url("images/wiki/smelt.png")})\">"
      html << "<div class=\"slot\" style=\"top: 15px; left: 49px;\">"
      html << render_stack(block_item.instance_variable_get(:@input), 1)
      html << "</div>"
      html << "<div class=\"slot\" style=\"top: 50px; left: 169px;\">"
      html << render_stack(block_item.instance_variable_get(:@output),
                           block_item.instance_variable_get(:@quantity))
      html << "</div>"
      html << "</div>"
    end
    html
  end

  def render_crafting(blockitem)
    if Recipes.recipe(blockitem) == nil || Recipes.recipe(blockitem)[0].class == Smelting
      return ""
    end
    html = ''
    Recipes.recipe(blockitem).each do |block_item|
      html << "<div class=\"recipe craft\" style=\"background: url(#{url("images/wiki/craft.png")})\">"
      9.times do |i|
        x = 14 + (i % 3)*36
        y = 50 + (((i / 3)-0.2)-1).round * 36
        html << "<div class=\"slot\" style=\"top: #{y}px; left: #{x}px;\">"
        html << render_stack(block_item.instance_variable_get(:@input)[i], 1)
        html << "</div>"
      end
      html << "<div class=\"slot\" style=\"top: 50px; left: 202px;\">"
      html << render_stack(block_item.instance_variable_get(:@output), block_item.instance_variable_get(:@quantity))
      html << "</div>"
      html << "</div>"
    end
    html
  end

end

module Wiki
  require_relative '../config/definitions'

  def render_guis(file_name)
    if File.exist?("public/images/wiki/gui#{file_name}.png")
      html = ""
      html << "<img src=\"#{url("images/wiki/gui#{file_name}.png")}\"/>"
    else
      ""
    end
  end

  def render_nav
    files = Dir.glob("views/wiki/**/*").sort
    html  = ""
    files.each_with_index do |path, i|
      base_name = File.basename(path, File.extname(path))
      if File.directory?(path)
        html << "<li class=\"nav-header\"><h3>#{Localizations::localized[base_name.to_sym]}</h3></li>"
      elsif path.include? ".qc"
        html << "<li><a href = \"#{url(path.gsub("views/", "").gsub(".qc", ""))}\"><div class=\"menu-item\">#{Localizations::localized[base_name.to_sym]}"
        html << "<div class=\"menu-icon\" style=\"background: url(#{url("images/wiki/#{base_name}.png")});\"></div>"
        html << "</div>"
        html << "</a>"
      end
    end
    html
  end
end