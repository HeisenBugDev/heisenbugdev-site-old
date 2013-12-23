require_relative '../config/definitions'
require 'github/markup'
module FileReader
  file_path = ""


  class WikiFiles
    include Localizations

    def self.localized
      @@localized
    end
  end

  def output(file_path)
    if file_path.reverse[0] == "/"
      file_path = file_path.reverse.sub!("/", "").reverse
    end
    file_name   = File.basename(file_path, File.extname(file_path))
    file_string = GitHub::Markup.render("#{file_name}.md", File.open("views/#{file_path}.qc".gsub!("//", "/"), "r").read)
    html        = "<div class=\"twelve wide right floated column\">"
    unless file_name == 'index'
      html << "<h1>"
      html << WikiFiles.localized[file_name.to_sym]
      if File.exist?("public/images/wiki/#{file_name}.png")
        html << "<img class=\"no-aa-image\" width=\"10%\" height=\"auto\" src=\"#{url("images/wiki/#{file_name}.png")}\"/>"
      end
    end
    html << "</h1>"
    #html << "<p>"
    WikiFiles.localized.invert.each do |key, value|
      if key != WikiFiles.localized[file_name.to_sym]
        files = Dir["views/wiki/**/*#{value}.*"]
        file  = url(files[0])
        file.sub!("views/", "")
        file.sub!(".qc", "")
        file_string.gsub! key, "<a href=\"#{file}\">#{key}</a>"
        #file_string.gsub! "\n", "<br/>"
      end
    end
    html << file_string
    if file_name == 'index'
      puts REDIS.get('readme')
      html << GitHub::Markup.render('readme.md', REDIS.get('readme'))
    end
    #html << "</p>"
    unless render_smelting(file_name.to_sym) == "" &&
        render_crafting(file_name.to_sym) == ""
      html << "<br/><h2>Recipe</h2>"
    end
    html << render_smelting(file_name.to_sym)
    html << render_crafting(file_name.to_sym)
    html << render_guis(file_name)
    html << "</div>"
    haml html, :layout => :'layouts/application'
  end

  #file = File.open
end