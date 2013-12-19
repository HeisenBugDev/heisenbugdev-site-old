# Load before Sinatra
require 'compass'
require 'rack/cache'
# Sinatra!
require 'sinatra'
require 'sinatra/assetpack'

# Load after Sinatra
require 'haml'
require 'sidekiq'
require 'sidetiq'
require 'redis'
require 'json'
require_relative 'config/definitions'

require_relative 'helpers/file_reader'
require_relative 'helpers/renderers'
require_relative 'helpers/build_handler'
require_relative 'app/workers/download_fetcher'

use Rack::Cache
use Rack::Deflater

# Set Sinatra's variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, 'views'
set :haml, { :format => :html5 }

register Sinatra::AssetPack

assets {
  serve '/js',     from: 'app/js'        # Default
  serve '/css',    from: 'app/css'       # Default
  #serve '/images', from: 'app/images'    # Default

  # The second parameter defines where the compressed version will be served.
  # (Note: that parameter is optional, AssetPack will figure it out.)
  js :app, '/js/app.js', [
      '/js/**'
  ]

  css :application, '/css/application.css', [
      '/css/**'
  ]

  js_compression  :jsmin    # :jsmin | :yui | :closure | :uglify
  css_compression :simple   # :simple | :sass | :yui | :sqwish
}

# Configure Compass
configure do
  Compass.add_project_configuration(File.join(Sinatra::Application.root,
                                              'config.rb'))
  redis_uri = ENV["REDISTOGO_URL"] || 'redis://localhost:6379'
  uri = URI.parse(redis_uri)
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
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
  @files = JSON.parse(REDIS.get('files'))
  @numbers = JSON.parse(REDIS.get('numbers'))
  @file_info = JSON.parse(REDIS.get('file_info'))
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
