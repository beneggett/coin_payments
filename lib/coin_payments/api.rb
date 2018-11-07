module CoinPayments
  class Api
    URL_ENDPOINT = ENV.fetch("COIN_PAYMENTS_BASE_URL", "https://www.coinpayments.net/api.php")
    API_VERSION = ENV.fetch("COIN_PAYMENTS_API_VERSION", "1")

    include HTTParty

    def post(body, openstruct: true)
      response = self.class.post(URL_ENDPOINT, body: modify_body(body), timeout: 30, headers: modify_headers(body))
      if response["error"] == "ok"
        if openstruct
          JSON::parse(response["result"].to_json, object_class: OpenStruct)
        else
          response
        end
      else
        OpenStruct.new response
      end
    end

    ### Informational Commands


    ## Get Basic Account Info
    # CoinPayments::Api.new.get_basic_account_info
    def get_basic_account_info
      body = {cmd: "get_basic_info"}
      post body
    end
    # Convert epoch time, fwiw: Time.at response.time_joined

    ## Get Exchange Rates / Supported Coins
    # CoinPayments::Api.new.get_exchange_rates
    # CoinPayments::Api.new.get_exchange_rates accepted: true
    # CoinPayments::Api.new.get_exchange_rates accepted: true, accepted_only: true
    def get_exchange_rates(options = {})
      body = {
        cmd: "rates"
      }
      body[:short] = 1 if options[:short]
      body[:accepted] = 1 if options[:accepted]
      response = post body, openstruct: false
      if options[:accepted_only]
        response.to_h.delete_if { |_k, v| v[:accepted] == 0 }
      else
        response.to_h
      end
    end

    ## Get Coin Balances
    # CoinPayments::Api.new.get_coin_balances
    # CoinPayments::Api.new.get_coin_balances all: true
    def get_coin_balances(options = {})
      body = {
        cmd: "balances"
      }
      body[:all] = 1 if options[:all]
      post body
    end

    ## Get Deposit Address
    # CoinPayments::Api.new.get_deposit_address
    def get_deposit_address(currency = "BTC")
      body = {
        cmd: "get_deposit_address",
        currency: currency
      }
      post body
    end



    ### Receiving Payments
    ## Create Transaction
    # CoinPayments::Api.new.create_transaction amount: 10, currency1: "USD", currency2: "BTC", buyer_email: "john@doe.com", buyer_name: "John Doe"
    def create_transaction(options = {})
      required_params = %i( amount currency1 currency2 buyer_email)
      required_params_present = required_params.all? { |e| options.keys.include?(e) }
      raise "Required Argument Error. Must include #{required_params.join(', ')}" unless required_params_present
      body = {
        cmd: "create_transaction",
        amount: options[:amount],
        currency1: options[:currency1],
        currency2: options[:currency2],
        buyer_email: options[:buyer_email],
      }
      body[:buyer_name] = options[:buyer_name] if options[:buyer_name]
      body[:item_name] = options[:item_name] if options[:item_name]
      body[:item_number] = options[:item_number] if options[:item_number]
      body[:invoice] = options[:invoice] if options[:invoice]
      body[:custom] = options[:custom] if options[:custom]
      body[:address] = options[:address] if options[:address]
      body[:ipn_url] = options[:ipn_url] if options[:ipn_url]
      post body
    end


    ## Callback Addresses
    # CoinPayments::Api.new.callback_addresses
    def callback_addresses(options = {})
      body = {
        cmd: "get_callback_address",
        currency: options.fetch(:currency, "BTC")
      }
      body[:ipn_url] = options[:ipn_url] if options[:ipn_url]
      post body
    end

    ## Get TX Info
    # CoinPayments::Api.new.get_tx_info "CPCK5DNHP28DYY3GMWBTWLOIZM"
    # CoinPayments::Api.new.get_tx_info "CPCK5DNHP28DYY3GMWBTWLOIZM", "CPCK5OLFDULWTYNDW7UQ0LYE2D" # Multiple lookup, don't recommend as it returns funny & they don't like more than 25
    def get_tx_info(*transaction_ids)
      cmd = if transaction_ids.size > 1
        "get_tx_info_multi"
      else
        "get_tx_info"
      end
      body = {
        cmd: cmd,
        txid: transaction_ids.join('|'),
        # full: 0 # I don't see any practical use for this
      }
      post body, openstruct: cmd != "get_tx_info_multi"
    end

    ## Get TX List
    # CoinPayments::Api.new.get_tx_list
    # CoinPayments::Api.new.get_tx_list limit: 5
    # CoinPayments::Api.new.get_tx_list limit: 5, start: 5
    # CoinPayments::Api.new.get_tx_list newer: (Time.now - 1800).to_i
    def get_tx_list(options = {})
      body = {
        cmd: "get_tx_ids"
      }
      body[:limit] = [options[:limit].to_i, 100].min if options[:limit] # limit The maximum number of transaction IDs to return from 1-100. (default: 25)
      body[:start] = options[:start] if options[:start] # start What transaction # to start from (for iteration/pagination.) (default: 0, starts with your newest transactions.)
      body[:newer] = options[:newer] if options[:newer] # newer Return transactions started at the given Unix timestamp or later. (default: 0)
      body[:all] = options[:all] if options[:all] # By default we return an array of TX IDs where you are the seller for use with get_tx_info_multi or get_tx_info. If all is set to 1 returns an array with TX IDs and whether you are the seller or buyer for the transaction.
      post body
    end


    ### Withdrawals/Transfers
    ## Create Transfer
    # CoinPayments::Api.new.create_transfer
    def create_transfer

    end

    ## Create Withdrawal / Mass Withdrawal
    # CoinPayments::Api.new.create_withdrawal
    def create_withdrawal

    end

    ## Convert Coins
    # CoinPayments::Api.new.convert_coins
    def convert_coins

    end

    ## Conversion Limits
    # CoinPayments::Api.new.conversion_limits
    def conversion_limits

    end

    ## Get Withdrawal History
    # CoinPayments::Api.new.get_withdrawal_history
    def get_withdrawal_history

    end

    ## Get Withdrawal Info
    # CoinPayments::Api.new.get_withdrawal_info
    def get_withdrawal_info

    end

    ## Get Conversion Info
    # CoinPayments::Api.new.get_conversion_info
    def get_conversion_info

    end


    ### PayByName
    ## Get Profile Information
    # CoinPayments::Api.new.get_profile_information
    def get_profile_information

    end

    ## Get Tag List
    # CoinPayments::Api.new.get_tag_list
    def get_tag_list

    end

    ## Update Tag Profile
    # CoinPayments::Api.new.update_tag_profile
    def update_tag_profile

    end

    ## Claim Tag
    # CoinPayments::Api.new.claim_tag
    def claim_tag

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
