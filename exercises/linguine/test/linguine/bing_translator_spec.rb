require_relative '../../lib/linguine/bing_translator'

describe BingTranslator do

  subject(:translator) { described_class.new }

  describe '#translate' do
    let(:original_text) { 'text to be translated' }
    let(:translated_text) { 'some translated text' }
    let(:from_lang) { 'en' }
    let(:to_lang) { 'de' }

    let(:connection) {connection = Faraday::Connection.new }

    before do
      connection_details = proc {
          |req|
        req.url '/v2/Http.svc/Translate'
        req.params['text'] = original_text
        req.params['from'] = from_lang
        req.params['to'] = to_lang
      }

      allow(Faraday).to receive(:new).with({url: BingTranslator::TRANSLATOR_URI}).and_return(connection)
      allow(connection).to receive(:get).and_return(translated_text)
    end

    it 'will translate the web page' do
      expect(subject.translate(original_text)).to eql(translated_text)
    end
  end

  describe '#access_token' do

    let(:token) { 'some random token' }
    let(:expires_in) { '600' }
    let(:response) { Faraday::Response.new }

    before do
      connection = Faraday::Connection.new

      env = {
          'body': "{\"access_token\": \"#{token}\", \"expires_in\": \"#{expires_in}\"}"
      }

      access_url = 'v2/OAuth2-13'

      connection_details = {:client_id => BingTranslator::CLIENT_ID,
                            :client_secret => BingTranslator::CLIENT_SECRET,
                            :scope => BingTranslator::SCOPE,
                            :grant_type => BingTranslator::GRANT_TYPE}

      allow(response).to receive(:env).and_return(env)
      allow(Faraday).to receive(:new).with(url: BingTranslator::ACCESS_TOKEN_URI).and_return(connection)
      allow(connection).to receive(:post).with(access_url, connection_details).and_return(response)
    end

    it 'will get a new access token' do
      access_token = {token: token, expires_in: expires_in}

      expect(subject.access_token).to eql(access_token)
    end
  end
end