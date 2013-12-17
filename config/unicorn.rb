worker_processes 3
timeout 30
preload_app true

before_fork do |server, worker|
  @sidekiq_pid ||= spawn("bundle exec sidekiq -c 2 -r ./app.rb")
end