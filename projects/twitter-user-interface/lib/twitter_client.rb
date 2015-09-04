require 'oauth'
require 'sinatra/base'
require 'json'
require 'hashie/mash'

class Tweet < Hashie::Mash
  def created_at
    DateTime.parse(self[:created_at]).strftime("%d %B %Y - %H:%M:%S")
  end
end

class TwitterClient

  TWITTER_API_URI = "https://api.twitter.com/"
  TWITTER_API_VERSION =  '1.1'

  ACCESS_TOKEN_URL = '/oauth/access_token?oauth_verifier=5758866'

  def consumer
    @consumer ||= OAuth::Consumer.new(ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET'],
                                      {site: TWITTER_API_URI, access_token_url: ACCESS_TOKEN_URL})
  end

  def request_token
    @request_token ||= consumer.get_request_token
  end

  def access_token
    # @access_token ||= request_token.get_access_token(oauth_verifier: 3527395)
    # @access_token ||= request_token.get_access_token

    @access_token ||= OAuth::AccessToken.from_hash(consumer, {oauth_token: ENV['TWITTER_ACCESS_TOKEN'],
                                                              oauth_token_secret: ENV['TWITTER_ACCESS_SECRET']})
  end

  def get(url)
    hash_array = JSON.parse(access_token.get( "/#{TWITTER_API_VERSION}#{url}?screen_name=robertohallio&count=20").body)
    hash_array.map { |item| Tweet.new(item) }
  end

  def post(url)
    access_token.post( "/#{TWITTER_API_VERSION}#{url}")
  end

  def home_timeline
    get '/statuses/home_timeline.json'
  end

  def favourites
    get '/favorites/list.json'
  end

  def direct_messages
    get '/direct_messages/sent.json'
  end

  def mentions
    get '/statuses/mentions_timeline.json'
  end

  def retweet(id)
    post ''
  end
end