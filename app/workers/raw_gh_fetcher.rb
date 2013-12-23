require 'net/https'
class RawGHFetcher
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  GITHUB = URI.parse('https://raw.github.com')
  recurrence { minutely }

  def perform
    puts 'Fetching GitHub raw'
    http             = Net::HTTP.new(GITHUB.host, GITHUB.port)
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request          = Net::HTTP::Get.new('/HeisenBugDev/QuantumCraft/develop/README.md')
    REDIS.set('readme', http.request(request).body.gsub!('![Logo](http://i.imgur.com/h6cUsrb.png)', ''))
  end
end