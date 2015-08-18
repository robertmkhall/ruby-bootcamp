require 'faraday'
require 'json'
require 'nokogiri'
require 'uri'

class BingTranslator
  # Translator vars
  TRANSLATOR_AUTH_PREFIX = 'Bearer '
  TRANSLATOR_URI = 'http://api.microsofttranslator.com/v2/Http.svc/Translate'

  # Token vars
  ACCESS_TOKEN_URI = 'https://datamarket.accesscontrol.windows.net/v2/OAuth2-13'
  CLIENT_ID = 'linguine_1000'
  CLIENT_SECRET = 'vpgnTSjxeuGnxnr1MA0oJgkG0xzovPYoIzJnFXQoZzk='
  SCOPE = 'http://api.microsofttranslator.com'
  GRANT_TYPE = 'client_credentials'

  def translate(text, from, to)
    uri = URI.parse TRANSLATOR_URI
    conn = Faraday.new(:url => extract_host(uri))

    response = conn.get do |req|
      req.url uri.path
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

    uri = URI.parse ACCESS_TOKEN_URI

    conn = Faraday.new(:url => extract_host(uri)) do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end

    response = conn.post uri.path,
                         {:client_id => CLIENT_ID,
                          :client_secret => CLIENT_SECRET,
                          :scope => SCOPE,
                          :grant_type => GRANT_TYPE}

    json_response = JSON.parse(response.env[:body])
    token_expiry = Time.now + json_response['expires_in'].to_i

    @access_token = {token: json_response['access_token'], expires_in: token_expiry}
  end

  def extract_host(uri)
    "#{uri.scheme}://#{uri.host}"
  end
end
