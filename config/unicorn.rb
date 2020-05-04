# unicornのログのformatをjsonにする
# https://github.com/phusion/unicorn/blob/bafc04fe666bc5cb8fb7d0534568041964e1e0c2/FAQ#L31L42
require 'json'

Configurator::DEFAULTS[:logger].formatter = proc do |severity, timestamp, progname, msg|
  "#{JSON.dump(service: 'unicorn', severity: severity, timestamp: timestamp, progname: progname, msg: msg)}\n"
end

rails_root = File.expand_path('../../', __FILE__)
ENV['BUNDLE_GEMFILE'] = "#{rails_root}/Gemfile"

worker_processes 2
listen 3000, tcp_nopush: true
timeout 30
pid "#{rails_root}/tmp/pids/unicorn.pid"
preload_app true
check_client_connection false

before_fork do |server, worker|
  SemanticLogger.reopen
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  SemanticLogger.reopen
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
