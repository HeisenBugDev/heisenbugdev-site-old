require './definitions.rb'
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
      file_path = file_path.reverse.sub!("/","").reverse
    end
    file_string = File.open("views/#{file_path}.qc".gsub!("//","/"), "r").read
    file_name = File.basename(file_path, File.extname(file_path))
    html = "<h1>"
    html << WikiFiles.localized[file_name.to_sym]
    html << "</h1>"
    html << "<p>"
    WikiFiles.localized.invert.each do |key, value|
      if key != WikiFiles.localized[file_name.to_sym]
        file_string.gsub! key, "<a href=\"#{value}\">#{key}</a>"
      end
    end
    html << file_string
    html << "</p>"
    unless render_smelting(file_name.to_sym) == "" && 
      render_crafting(file_name.to_sym) == ""
      html << "<br/><h2>Recipe</h2>"
    end
    html << render_smelting(file_name.to_sym)
    html << render_crafting(file_name.to_sym)
    haml html, :layout => :'layouts/application'
  end

  #file = File.open
end