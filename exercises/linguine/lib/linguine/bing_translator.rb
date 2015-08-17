require 'faraday'
require 'json'
require 'nokogiri'

class BingTranslator

  TRANSLATOR_AUTH_PREFIX = 'Bearer '
  TRANSLATOR_URI = 'http://api.microsofttranslator.com/'

  ACCESS_TOKEN_URI = 'https://datamarket.accesscontrol.windows.net/'
  CLIENT_ID = 'linguine_1000'
  CLIENT_SECRET = 'vpgnTSjxeuGnxnr1MA0oJgkG0xzovPYoIzJnFXQoZzk='
  SCOPE = 'http://api.microsofttranslator.com'
  GRANT_TYPE = 'client_credentials'

  def translate(text, from, to)

    conn = Faraday.new(:url => TRANSLATOR_URI)

    response = conn.get do |req|
      req.url '/v2/Http.svc/Translate' # todo - use URL util to grab from one string
      req.params['text'] = text
      req.params['from'] = from
      req.params['to'] = to
      req.headers['Authorization'] = TRANSLATOR_AUTH_PREFIX + access_token[:token]
      req.headers['Content-Type'] = 'text/html'
    end

    doc = Nokogiri::XML(response.env[:body])
    doc.remove_namespaces!
    doc.at_xpath('//string').text
  end

  def access_token
    return @access_token if @access_token and Time.now < @access_token[:expires_in]

    conn = Faraday.new(:url => ACCESS_TOKEN_URI) do |faraday|
      faraday.request :url_encoded # form-encode POST params
      faraday.response :logger # log requests to STDOUT
      faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
    end

    response = conn.post 'v2/OAuth2-13', # todo - use URL util to grab from one string
              {:client_id => CLIENT_ID,
               :client_secret => CLIENT_SECRET,
               :scope => SCOPE,
               :grant_type => GRANT_TYPE}

    json_response = JSON.parse(response.env[:body])

    token_expiry = Time.now + json_response['expires_in'].to_i

    @access_token = {token: json_response['access_token'], expires_in: token_expiry}
  end
end
