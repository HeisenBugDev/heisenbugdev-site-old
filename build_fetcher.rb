require 'json'
require 'net/http'

module BuildFetcher
  JENKINS_URI = URI.parse('http://ci.theronsminecraft.com')

  def get_downloads
    get_JSON['builds']
  end

  def get_JSON(job=nil)
    if job
      job = "/#{job}"
    end
    http     = Net::HTTP.new(JENKINS_URI.host, JENKINS_URI.port)
    request  = Net::HTTP::Get.new("/job/QuantumCraft/#{job}/api/json")
    response = http.request(request)
    JSON.parse(response.body)
  end

  def download_build(build, file)
    Net::HTTP.start("ci.theronsminecraft.com") do |http|
      resp = http.get("/job/QuantumCraft/#{build}/dist/#{file}")
      Dir.chdir("public/downloads")
      open(file, "wb") do |file_down|
        file_down.write(resp.body)
      end
      Dir.chdir(File.dirname(__FILE__))
    end
  end
end