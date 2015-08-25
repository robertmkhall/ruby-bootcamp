require 'sinatra/base'

module Sinatra
  module SessionAuth
    module Helpers
      def check_login(&block)
        if logged_in && block_given?
          yield block
        else
          redirect '/login'
        end
      end

      def logged_in
        session[:username]
      end

      def clear_session
        session[:username] = nil
      end
    end

    def self.registered(app)
      app.helpers SessionAuth::Helpers
      app.enable :sessions
    end
  end

  register SessionAuth
end