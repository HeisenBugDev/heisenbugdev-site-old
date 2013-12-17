require_relative '../../helpers/build_handler'
require_relative '../../config/definitions'
class DownloadFetcher
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  include BuildHandler

  recurrence { minutely }

  def perform
    puts "I am performing!"
    DownloadsManager.numbers = []
    DownloadsManager.files   = []
    file_info_builder        = []
    numbers_builder          = []
    files_builder            = []
    file_names               = DownloadsManager.file_names
    DownloadsManager.names.each_with_index do |name, name_index|
      tmp_numbers = []
      tmp_files   = []
      get_downloads(name).each_with_index do |build, index|
        unless index > 1
          tmp_numbers << build['number']
          tmp_files << get_json(name, build['number'])['artifacts']
        end
      end
      numbers_builder << tmp_numbers
      files_builder << tmp_files

      files_info = []
      tmp_files.each_with_index do |file, index|
        file_info              = {}
        file_info[:version]    = get_version(file[0]['fileName'], file_names[name_index])
        file_info[:mc_version] = get_mc_version(file[0]['fileName']).to_s.gsub('-', '')
        file_info[:types]      = get_download_types(file)
        files_info << file_info
      end
      file_info_builder << files_info
    end
    DownloadsManager.file_info = file_info_builder
    DownloadsManager.numbers   = numbers_builder
    DownloadsManager.files= files_builder
    DownloadsManager.files = [1,2,3,4]
  end
end

