$LOAD_PATH.unshift("#{__dir__}/../spec", "#{__dir__}/../lib")
require_relative 'rack_runner'
require 'routes/bill'

module Application
  class << self
    def start(args)
      @app = Rack::Runner.start "#{__dir__}/../config.ru", args
    end

    def stop
      @app.stop
    end

    def port
      @app.port
    end
  end
end

namespace :application do

  desc 'start application'
  task :start, [:rack_env] do |task, args|
    puts "rack_env: #{args[:rack_env]}"

    Application.start args
    at_exit do
      Application.stop
    end
  end
end