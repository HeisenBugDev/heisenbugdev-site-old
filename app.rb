# Load before Sinatra
require 'compass'

# Sinatra!
require 'sinatra'

# Load after Sinatra
require 'haml'
require_relative 'file_reader'
require_relative 'helpers'
require_relative 'build_fetcher'

# Set Sinatra's variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, 'views'
set :haml, { :format => :html5 }

# Configure Compass
configure do
  Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config.rb'))
end

helpers do
  include RecipesModule
  include FileReader
  include Wiki
  include BuildFetcher
end

# At a minimum the main sass file must reside within the views directory
# We create /views/stylesheets where all our sass files can safely reside
get '/stylesheets/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  scss(:"stylesheets/#{params[:name]}", Compass.sass_engine_options)
end

get '/updatedownloads/?' do
  get_downloads.each do |build|
    file = get_json(build['number'])['artifacts'][0]['fileName']
    unless File.exist?("./downloads/#{file}")
      download_build(build['number'], file)
    end
  end
  "Updating files"
end

get '/?' do
  haml :home, :layout => :'layouts/application'
end

get '/:name/?' do
  if params[:name] == 'wiki'
    file_path = request.path + "/a_meta/index"
    output(file_path)
  else
    haml params[:name].to_sym, :layout => :'layouts/application'
  end
end

get '/wiki/**:name/?' do
  file_path = request.path
  output(file_path)
end
