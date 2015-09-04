require 'routes/twitter'

Sinatra::Base.set :root, File.expand_path(File.dirname(__FILE__) + '/../')
Sinatra::Base.set :views, settings.root + '/views'