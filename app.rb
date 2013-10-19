# Load before Sinatra
require 'compass'

# Sinatra!
require 'sinatra'

# Load after Sinatra
require 'haml' #MUST BE AFTER

# Set Sinatra's variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, 'views'
set :haml, {:format => :html5 }
  
# Configure Compass
configure do
  Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config.rb'))
end

# At a minimum the main sass file must reside within the views directory
# We create /views/stylesheets where all our sass files can safely reside
get '/stylesheets/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  scss(:"stylesheets/#{params[:name]}", Compass.sass_engine_options)
end

get '/:name' do
  haml params[:name].to_sym, :layout => :'layouts/application'
end