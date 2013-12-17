# Load before Sinatra
require 'compass'
require 'rack/cache'
# Sinatra!
require 'sinatra'

# Load after Sinatra
require 'haml'
require 'sidekiq'
require 'sidetiq'
require 'redis'
$redis = Redis.new
require_relative 'config/definitions'

require_relative 'helpers/file_reader'
require_relative 'helpers/renderers'
require_relative 'helpers/build_handler'
require_relative 'app/workers/download_fetcher'

use Rack::Cache
# Set Sinatra's variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, 'views'
set :haml, { :format => :html5 }
# Configure Compass
configure do
  Compass.add_project_configuration(File.join(Sinatra::Application.root,
                                              'config.rb'))
end
configure :production do
  require 'newrelic_rpm'
end

helpers do
  include RecipesModule
  include FileReader
  include Wiki
  include BuildHandler
end

before do
  expires 60, :public, :must_revalidate
end
DownloadFetcher.perform_async

# At a minimum the main sass file must reside within the views directory
# We create /views/stylesheets where all our sass files can safely reside
get '/stylesheets/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  scss(:"stylesheets/#{params[:name]}", Compass.sass_engine_options)
end

get '/downloads/?' do
  if get_json('QuantumCraft') == :error
    return haml 'Cannot get builds at this time.',
                :layout => :'layouts/application'
  end
  @names = DownloadsManager.names
  @file_names = DownloadsManager.file_names
  @repo_orgs = DownloadsManager.repo_orgs
  @descriptions = DownloadsManager.descriptions
  @files = DownloadsManager.files
  puts "files is #{DownloadsManager.files}"
  @numbers = DownloadsManager.numbers
  @file_info = DownloadsManager.file_info
  haml :downloads, :layout => :'layouts/application'
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
