require 'routes/twitter'

describe Twitter do

  include_context :sinatra_application

  let(:app_options) { {twitter_client: twitter_client_double}}
  let(:twitter_client_double) { double("TwitterClient")}

  describe 'get /timeline' do
    let(:timeline) do
      [{"created_at": "Mon Apr 20 20:49:20 +0000 2015",
        "id_str": "590255953431388160",
        "text": "RT @chris_coltrane: This is *heartbreaking*. List of reasons people had benefits sanctioned &amp; turned to foodbanks. http://t.co/8eYwaoVVKd h…"},
       {"created_at": "Sat Jun 01 07:50:34 +0000 2013",
        "id_str": "340737120081678336",
        "text": "@Jdwilliamson83 Yep really good cheers. Significant others are more than welcome so get Mrs Williamson over as well. Where you going in US?"}]
    end
    
    let(:favourites) do
      [{"created_at": "Fri Nov 22 21:01:13 +0000 2013",
        "id_str": "403991583390826500",
        "text": "Always loved this"},
       {"created_at": "Wed Mar 28 15:30:32 +0000 2012",
        "id_str": "185026093584089089",
        "text": "Come to Leeds thru a Lens Photowalk 12 May from 11:00 to 14:00"}]
    end

    let(:direct_messages) do
      [{"created_at": "Fri Nov 22 21:01:13 +0000 2013",
        "id_str": "403991583390826500",
        "text": "Always loved this"},
       {"created_at": "Wed Mar 28 15:30:32 +0000 2012",
        "id_str": "185026093584089089",
        "text": "Come to Leeds thru a Lens Photowalk 12 May from 11:00 to 14:00"}]
    end

    let(:mentions) do
      [{"created_at": "Fri Nov 22 21:01:13 +0000 2013",
        "id_str": "403991583390826500",
        "text": "Always loved this"},
       {"created_at": "Wed Mar 28 15:30:32 +0000 2012",
        "id_str": "185026093584089089",
        "text": "Come to Leeds thru a Lens Photowalk 12 May from 11:00 to 14:00"}]
    end

    before do
      allow(twitter_client_double).to receive(:home_timeline).and_return(timeline)
      allow(twitter_client_double).to receive(:favourites).and_return(favourites)
      allow(twitter_client_double).to receive(:direct_messages).and_return(direct_messages)
      allow(twitter_client_double).to receive(:mentions).and_return(mentions)
    end
    
    it 'renders the timeline and other tabs' do
      expect_any_instance_of(described_class).to receive(:slim)
        .with(:timeline, locals: {timeline: timeline, favourites: favourites, direct_messages: direct_messages, mentions: mentions})

      get '/timeline'
    end
  end

  describe '/retweet' do
    let(:id) {'10034534665'}

    it 'retweets the id via the twitter api' do
      expect(twitter_client_double).to receive(:retweet).with(id)

      get '/retweet', params = {id: id}
    end
  end
end