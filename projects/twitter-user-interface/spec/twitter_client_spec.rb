require_relative 'spec_helper'
require 'twitter_client'
require 'support/twitter_client_interface_test'
require 'webmock/rspec'

describe TwitterClient do

  subject(:twitter) { described_class.new }

  let(:api_url) {TwitterClient::TWITTER_API_URI + TwitterClient::TWITTER_API_VERSION}

  let(:token) { 'ryG8JgAAAAAAhVRAAAABT4mB-Pg' }
  let(:secret) { '66JBuZ3GmdmWBHWg7q7EzPOeXaEW08ts' }
  let(:access_token_value) { 'ryG8JgsdfsdfshVRAAAABT4mB-Pg' }
  let(:access_token_secret) { 'ryG8Jgsdsdfsfsfsgsfghbjhewb323rkjsdjdjd' }

  include TwitterClientInterfaceTest

  it_behaves_like 'twitter_client_interface'

  before do
    token2 = 'ryG8Jsdfdsfe2222AAABT4mB-Pg'
    secret_2 = 'ryGq42342klerkffksdkdfgkfglkggl'

    stub_request(:post, TwitterClient::TWITTER_API_URI + 'oauth/request_token')
        .to_return(body: "oauth_token=#{token}&oauth_token_secret=#{secret}&oauth_callback_confirmed=true").then
        .to_return(body: "oauth_token=#{token2}&oauth_token_secret=#{secret_2}&oauth_callback_confirmed=true")

    access_token_2 = 'ryG8Jsdfdsf43543llllpppppp'
    access_secret_2 = 'rrrrrryyyyffffgggg2313123___lllggl'

    # stub_request(:post, TwitterClient::TWITTER_API_URI + 'oauth/access_token')
    #     .to_return(body: "oauth_token=#{access_token_value}&oauth_token_secret=#{access_token_secret}&oauth_callback_confirmed=true").then
    #     .to_return(body: "oauth_token=#{access_token_2}&oauth_token_secret=#{access_secret_2}&oauth_callback_confirmed=true")
  end

  describe '#request_token' do

    it 'gets authentication token from twitter' do
      request_token = twitter.request_token
      expect(request_token.token).to eq(token)
      expect(request_token.secret).to eq(secret)
    end

    it 'gets same authentication token on second request' do
      request_token = twitter.request_token
      request_token_2 = twitter.request_token

      expect(request_token_2.token).to eq(request_token.token)
      expect(request_token_2.secret).to eq(request_token.secret)
    end
  end

  describe '#access_token' do

    it 'gets access token using request token' do
      access_token = twitter.access_token
      expect(access_token.token).to eq(ENV['TWITTER_ACCESS_TOKEN'])
      expect(access_token.secret).to eq(ENV['TWITTER_ACCESS_SECRET'])
    end

    # it 'gets same access token on second request' do
    #   access_token = twitter.access_token
    #   access_token2 = twitter.access_token
    #
    #   expect(access_token.token).to eq(access_token2.token)
    #   expect(access_token.secret).to eq(access_token2.secret)
    # end
  end

  describe '#home_timeline' do
    let(:expected_response) do
      "[{\"created_at\": \"Mon Apr 20 20:49:20 +0000 2015\",
        \"id_str\": \"590255953431388160\",
        \"text\": \"RT @chris_coltrane: This is *heartbreaking*. List of reasons people had benefits sanctioned &amp; turned to foodbanks. http://t.co/8eYwaoVVKd h…\"},
       {\"created_at\": \"Sat Jun 01 07:50:34 +0000 2013\",
        \"id_str\": \"340737120081678336\",
        \"text\": \"@Jdwilliamson83 Yep really good cheers. Significant others are more than welcome so get Mrs Williamson over as well. Where you going in US?\"}]"
    end

    let(:expected_json) { JSON.parse(expected_response) }

    before do
      stub_request(:get, api_url + '/statuses/home_timeline.json?screen_name=robertohallio&count=20')
          .to_return(body: expected_response)
    end

    it 'gets timeline entries for user' do
      expect(twitter.home_timeline).to eq(expected_json)
    end
  end

  describe '#favourites' do
    let(:expected_response) do
      "[{\"created_at\": \"Fri Nov 22 21:01:13 +0000 2013\",
        \"id_str\": \"403991583390826500\",
        \"text\": \"Always loved this\"},
       {\"created_at\": \"Wed Mar 28 15:30:32 +0000 2012\",
        \"id_str\": \"185026093584089089\",
        \"text\": \"Come to Leeds thru a Lens Photowalk 12 May from 11:00 to 14:00\"}]"
    end

    let(:expected_json) { JSON.parse(expected_response) }

    before do
      stub_request(:get, api_url + '/favorites/list.json?screen_name=robertohallio&count=20')
          .to_return(body: expected_response)
    end

    it 'gets favourite entries for user' do
      expect(twitter.favourites).to eq(expected_json)
    end
  end

  describe '#direct_message' do
    let(:expected_response) do
      "[{\"created_at\": \"Fri Nov 22 21:01:13 +0000 2013\",
        \"id_str\": \"403991583390826500\",
        \"text\": \"Always loved this\"},
       {\"created_at\": \"Wed Mar 28 15:30:32 +0000 2012\",
        \"id_str\": \"185026093584089089\",
        \"text\": \"Come to Leeds thru a Lens Photowalk 12 May from 11:00 to 14:00\"}]"
    end

    let(:expected_json) { JSON.parse(expected_response) }

    before do
      stub_request(:get, api_url + '/direct_messages/sent.json?screen_name=robertohallio&count=20')
          .to_return(body: expected_response)
    end

    it 'gets favourite entries for user' do
      expect(twitter.direct_messages).to eq(expected_json)
    end
  end

  describe '#mentions' do
    let(:expected_response) do
      "[{\"created_at\": \"Fri Nov 22 21:01:13 +0000 2013\",
        \"id_str\": \"403991583390826500\",
        \"text\": \"Always loved this\"},
       {\"created_at\": \"Wed Mar 28 15:30:32 +0000 2012\",
        \"id_str\": \"185026093584089089\",
        \"text\": \"Come to Leeds thru a Lens Photowalk 12 May from 11:00 to 14:00\"}]"
    end

    let(:expected_json) { JSON.parse(expected_response) }

    before do
      stub_request(:get, api_url + '/statuses/mentions_timeline.json?screen_name=robertohallio&count=20')
          .to_return(body: expected_response)
    end

    it 'gets favourite entries for user' do
      expect(twitter.mentions).to eq(expected_json)
    end
  end
end