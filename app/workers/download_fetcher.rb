require_relative '../../helpers/build_handler'
require_relative '../../config/definitions'
require 'json'
class DownloadFetcher
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  include BuildHandler

  class << self
    attr_accessor :files
    attr_accessor :numbers
    attr_accessor :file_info
  end

  recurrence { minutely }

  def perform
    puts "I am performing!"
    self.class.numbers = []
    self.class.files   = []
    file_info_builder  = []
    numbers_builder    = []
    files_builder      = []
    file_names         = DownloadsManager.file_names
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
    REDIS.set('file_info', file_info_builder.to_json)
    REDIS.set('numbers', numbers_builder.to_json)
    REDIS.set('files', files_builder.to_json)
    self.class.file_info = file_info_builder
    self.class.numbers   = numbers_builder
    self.class.files     = files_builder
  end
end

