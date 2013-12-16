require_relative '../../helpers/build_handler'
require_relative '../../config/definitions'
class DownloadFetcher
  include Sidekiq::Worker
  include BuildHandler
  include Downloads
  def perform(name, count)

  end
end