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

    ## INFORMATIONAL_COMMANDS

    # CoinPayments::Api.new.get_basic_account_info
    def get_basic_account_info
      response = post cmd: "get_basic_info"
    end

    # CoinPayments::Api.new.get_exchange_rates
    # CoinPayments::Api.new.get_exchange_rates accepted: true
    # CoinPayments::Api.new.get_exchange_rates accepted: true, accepted_only: true
    def get_exchange_rates(options = {})
      body = {
        cmd: "rates"
      }
      body[:short] = 1 if options[:short]
      body[:accepted] = 1 if options[:accepted]
      response = post body
      if options[:accepted_only]
        rates = response["result"]
        rates.delete_if { |_k, v| v["accepted"] == 0 }
      else
        response["result"]
      end
    end

    # CoinPayments::Api.new.get_coin_balances
    # CoinPayments::Api.new.get_coin_balances all: true
    def get_coin_balances(options = {})
      body = {
        cmd: "balances"
      }
      body[:all] = 1 if options[:all]
      response = post body
    end


    # CoinPayments::Api.new.get_deposit_address
    def get_deposit_address(currency = "BTC")
      body = {
        cmd: "get_deposit_address",
        currency: currency
      }
      response = post body
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
