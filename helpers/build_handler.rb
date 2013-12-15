require 'json'
require 'net/http'

module BuildHandler
  JENKINS_URI = URI.parse('http://ci.theronsminecraft.com')

  def get_downloads(job)
    get_json(job)['builds']
  end

  def get_json(job, build=nil)
    begin
      http     = Net::HTTP.new(JENKINS_URI.host, JENKINS_URI.port)
      request  = Net::HTTP::Get.new("/job/#{job}/#{build}/api/json")
      response = http.request(request)
      JSON.parse(response.body)
    rescue SocketError, Errno::ENETUNREACH
      :error
    end
  end

  def get_version(file_name_rec, name_of_mod)
    file_name     = file_name_rec + ''
    mc_version    = get_mc_version(file_name).to_s
    wrapped_words = get_wrapped_words(file_name).to_s.reverse.sub!('-', '').reverse
    file_name.sub!(mc_version, '')
    file_name.sub!(wrapped_words, '')
    file_name.sub!(name_of_mod, '')
    file_name.sub!(name_of_mod.to_s.downcase,'')
    file_name.sub!('.jar', '')
  end

  def get_wrapped_words(file_name)
    /[-](.*?)[-]/.match(file_name)
  end

  def get_mc_version(file_name)
    /[-]((\d|\.)*?)[-]/.match(file_name)
  end

  def get_download_types(files)
    types = []
    files.each do |file|
      types << get_wrapped_words(file['fileName']).to_s.gsub('-', '')
    end
    types
  end

end