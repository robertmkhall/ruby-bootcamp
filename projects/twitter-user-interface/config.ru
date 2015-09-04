Bundler.require
$LOAD_PATH.unshift("#{__dir__}/lib")

require 'app'
require 'dotenv'

Dotenv.load

map '/twitter' do
  run Twitter
end


# The following properties need to be added to a .env file in the root of the project
#TWITTER_CONSUMER_KEY
#TWITTER_CONSUMER_SECRET
#TWITTER_ACCESS_TOKEN
#TWITTER_ACCESS_SECRET