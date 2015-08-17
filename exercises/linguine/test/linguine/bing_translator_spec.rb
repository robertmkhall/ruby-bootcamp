require_relative '../../lib/linguine/bing_translator'
require 'webmock/rspec'
require 'timecop'

describe BingTranslator do

  subject(:translator) { described_class.new }

  let(:token) { 'some random token' }
  let(:expires_in) { '600' }
  let(:expected_time) { Time.now }

  before do
    Timecop.freeze(expected_time)

    stub_request(:post, BingTranslator::ACCESS_TOKEN_URI + 'v2/OAuth2-13') # todo - replace with one string
        .with(:body => {:client_id => BingTranslator::CLIENT_ID,
                        :client_secret => BingTranslator::CLIENT_SECRET,
                        :scope => BingTranslator::SCOPE,
                        :grant_type => BingTranslator::GRANT_TYPE})
        .to_return(:body => "{\"access_token\": \"#{token}\", \"expires_in\": \"#{expires_in}\"}")
  end

  describe '#translate' do
    let(:original_text) { 'text to be translated' }
    let(:translated_text) { 'some translated text' }
    let(:from_lang) { 'en' }
    let(:to_lang) { 'de' }

    it 'will translate the web page' do
      stub_request(:get, BingTranslator::TRANSLATOR_URI + 'v2/Http.svc/Translate')
          .with(:query => {text: original_text, from: from_lang, to: to_lang},
                :headers => {'Authorization' => BingTranslator::TRANSLATOR_AUTH_PREFIX + token})
          .to_return(:body => "<string>#{translated_text}</string>")

      expect(subject.translate(original_text, from_lang, to_lang)).to eql(translated_text)
    end
  end

  describe '#access_token' do

    let(:access_token) { {token: token, expires_in: expected_time + expires_in.to_i} }

    it 'will get a new access token' do
      expect(subject.access_token).to eql(access_token)
    end

    it 'will not get a new access token' do
      first_access_token = subject.access_token

      expect(subject.access_token).to eql(access_token)
      expect(subject.access_token).to eql(first_access_token)
    end

    context 'attempt to get token after expiry' do

      let(:expected_time_after_expiry) {Time.now + 1000}
      let(:access_token_after_expiry) { {token: token, expires_in: expected_time_after_expiry + expires_in.to_i} }

      it 'will get a new access token' do
        first_access_token = subject.access_token

        Timecop.freeze(expected_time_after_expiry)
        second_access_token = subject.access_token

        expect(first_access_token).to eql(access_token)
        expect(second_access_token).to eql(access_token_after_expiry)
      end
    end
  end
end