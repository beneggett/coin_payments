module CoinPayments
  class Api
    URL_ENDPOINT = ENV.fetch("COIN_PAYMENTS_BASE_URL", "https://www.coinpayments.net/api.php")
    API_VERSION = ENV.fetch("COIN_PAYMENTS_API_VERSION", "1")

    include HTTParty

    def post(body)
      response = self.class.post(URL_ENDPOINT, body: modify_body(body), timeout: 30, headers: modify_headers(body))
      # api_type = options[:type] || options[:customer_vault]
      # handle_response(response, api_type)
    end



    private

    def modify_body(body)
      default_params = {
        version: API_VERSION,
        key:  ENV.fetch("COIN_PAYMENTS_PUBLIC_KEY", 'not-implemented')
      }
      default_params.merge body
    end

    def modify_headers(body)
      required_params = {
        version: API_VERSION,
        key: ENV.fetch("COIN_PAYMENTS_PUBLIC_KEY", 'not-implemented'),
      }.merge(body)
      headers =       {
        'Content-Type' => "application/x-www-form-urlencoded",
        'Content-transfer-encoding' => 'text',
      }
      headers["HMAC"] = hmac_encrypt(required_params)
      headers
    end

    def hmac_encrypt(required_params)
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha512'), ENV.fetch("COIN_PAYMENTS_PRIVATE_KEY", 'not-implemented'), HTTParty::HashConversions.to_params(required_params))
    end

  end
end
