require 'faraday'
require 'json'

class BingTranslator

  TRANSLATOR_URI = 'http://api.microsofttranslator.com/'

  ACCESS_TOKEN_URI = 'https://datamarket.accesscontrol.windows.net/'
  CLIENT_ID = 'linguine_1000'
  CLIENT_SECRET = 'vpgnTSjxeuGnxnr1MA0oJgkG0xzovPYoIzJnFXQoZzk='
  SCOPE = 'http://api.microsofttranslator.com'
  GRANT_TYPE = 'client_credentials'

  def translate(text)

    conn = Faraday.new(:url => TRANSLATOR_URI) do |faraday|
      faraday.request :url_encoded
    end

    conn.get do |req|
      req.url '/v2/Http.svc/Translate'
      req.params['text'] = text
      req.params['from'] = 'en'
      req.params['to'] = 'de'
    end
  end

  def access_token
    return @access_token if @access_token and Time.now < @access_token[:expires_in]

    conn = Faraday.new(:url => ACCESS_TOKEN_URI) do |faraday|
      faraday.request :url_encoded # form-encode POST params
      faraday.response :logger # log requests to STDOUT
      faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
    end

    response = conn.post 'v2/OAuth2-13',
              {:client_id => CLIENT_ID,
               :client_secret => CLIENT_SECRET,
               :scope => SCOPE,
               :grant_type => GRANT_TYPE}

    json_response = JSON.parse(response.env[:body])

    @access_token = {token: json_response['access_token'], expires_in: json_response['expires_in']}
    @access_token
  end
end

translator = BingTranslator.new
translator.access_token
