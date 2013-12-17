require_relative '../../helpers/build_handler'
require_relative '../../config/definitions'
class DownloadFetcher
  include Sidekiq::Worker
  include BuildHandler

  def perform
    DownloadsManager.numbers = []
    DownloadsManager.files   = []
    DownloadsManager.names.each_with_index do |name, name_index|
      tmp_numbers = []
      tmp_files   = []
      get_downloads(name).each_with_index do |build, index|
        tmp_numbers << build['number']
        tmp_files << get_json(name, build['number'])['artifacts']
      end
      DownloadsManager.numbers << tmp_numbers
      DownloadsManager.files << tmp_files

      tmp_files.each_with_index do |file, index|
        file_info              = {}
        file_info[:version]    = get_version(file[0]['fileName'], @file_names[name_index])
        file_info[:mc_version] = get_mc_version(file[0]['fileName']).to_s.gsub('-', '')
        file_info[:types]      = get_download_types(file)
      end
    end
  end
end