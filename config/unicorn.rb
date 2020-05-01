rails_root = File.expand_path('../../', __FILE__)
ENV['BUNDLE_GEMFILE'] = "#{rails_root}/Gemfile"

worker_processes 2
listen 3000, tcp_nopush: true
timeout 30
pid "#{rails_root}/tmp/pids/unicorn.pid"
preload_app true
check_client_connection false

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
