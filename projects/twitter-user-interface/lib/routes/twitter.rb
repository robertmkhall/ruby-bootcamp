require 'twitter_client'

class Twitter < Sinatra::Base

  attr_reader :twitter_client

  enable :sessions

  def initialize(options = {twitter_client: TwitterClient.new})
    super

    @twitter_client = options[:twitter_client]
  end

  get '/timeline' do
    session[:timeline] ||= twitter_client.home_timeline
    session[:favourites] ||= twitter_client.favourites
    session[:direct_messages] ||= twitter_client.direct_messages
    session[:mentions] ||= twitter_client.mentions

    slim :timeline, locals:  {timeline: session[:timeline], favourites: session[:favourites],
                              direct_messages: session[:direct_messages], mentions: session[:mentions]}
  end

  get '/retweet' do
    twitter_client.retweet(params[:id])
  end
end