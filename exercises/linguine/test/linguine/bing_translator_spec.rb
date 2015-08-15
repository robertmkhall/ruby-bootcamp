require_relative '../../lib/linguine/bing_translator'

describe BingTranslator do

  subject(:translator) {described_class.new}

  describe '#translate' do
    it 'will translate the web page' do
      expect(subject.translate('some text')).to eql('translated text')
    end
  end

  describe '#access_token' do

    let(:token) {'some random token'}
    let(:expires_in) {'600'}
    let(:response) {Faraday::Response.new}

    before do
      connection = Faraday::Connection.new

      env = {
        'body': "{\"access_token\": \"#{token}\", \"expires_in\": \"#{expires_in}\"}"
      }

      allow(response).to receive(:env).and_return(env)
      allow(Faraday).to receive(:new).and_return(connection)
      allow(connection).to receive(:post).and_return(response)
    end

    it 'will get a new access token' do
      access_token = {token: token, expires_in: expires_in}

      expect(subject.access_token).to eql(access_token)
    end
  end
end