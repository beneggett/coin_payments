# CoinPayments

Fully Implements the CoinPayments API in Ruby.

CoinPayments is an integrated payment gateway for cryptocurrencies such as Bitcoin and Litecoin. There are Over 1040 Supported Coins available. You can accept all 1040 supported coins or just one.

This gem will make it dead simple to work with CoinPayments API set & integrate it into any Ruby Project.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'coin_payments'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install coin_payments

## Usage

You'll first need to create a CoinPayments.net account to get started. If you don't have one, please consider creating one through my affiliate link: https://www.coinpayments.net/index.php?ref=1bf1c996fd6781bd4aabec78dda6250c

Or if you don't want to sign up through my link, feel free to sign up at https://www.coinpayments.net

There are many [tools for Merchants available](https://www.coinpayments.net/merchant-tools). We are going to focus on the API integrations.

There are two sides we'll need to concern ourselves:
1. Utilizing the API to manage payments & accounts
2. Creating a webhook or Instant Payment Notification (IPN)

### Utilizing the API

The only setup needed is to go to the [API Keys page and generate an API key](https://www.coinpayments.net/index.php?cmd=acct_api_keys). You will be given a private and public key used to authenticate your API calls. Make sure you don't share your private key with any 3rd parties!

Note: You must click 'Edit Permissions' to enable most commands

You will need to set the following environment variables in your app, and the rest will work automatically

```
COIN_PAYMENTS_PUBLIC_KEY: "your-public-api-key"
COIN_PAYMENTS_PRIVATE_KEY: "your-private-api-key"
```

Once those are set, you are now ready to utilize the API.
Available features have been implemented per the Features chart below


## Features

Implemented APIs from [CoinPayments API Docs](https://www.coinpayments.net/apidoc-intro)



| API |  Docs | Implemented? | Priority |
| --- | --- | --- | --- |
| **Informational Commands** |
| Get Basic Account Info | [📚](https://www.coinpayments.net/apidoc-get-basic-info) | ✅ | 👍 |
| Get Exchange Rates / Supported Coins | [📚](https://www.coinpayments.net/apidoc-rates) | ✅ | 👍 |
| Get Coin Balances | [📚](https://www.coinpayments.net/apidoc-balances) | ✅ | 👍 |
| Get Deposit Address | [📚](https://www.coinpayments.net/apidoc-get-deposit-address) | ✅ | 👍 |
| **Receiving Payments** |
| Create Transaction | [📚](https://www.coinpayments.net/apidoc-create-transaction) | ✅ | 👍 |
| Callback Addresses | [📚](https://www.coinpayments.net/apidoc-get-callback-address) | ✅ | 👍 |
| Get TX Info  | [📚](https://www.coinpayments.net/apidoc-get-tx-info) | ✅ | 👍 |
| Get TX List  | [📚](https://www.coinpayments.net/apidoc-get-tx-ids) | ✅ | 👍 |
| **Withdrawals/Transfers** |
| Create Transfer | [📚](https://www.coinpayments.net/apidoc-create-transfer) | ✅ | 👌 |
| Create Withdrawal / Mass Withdrawal | [📚](https://www.coinpayments.net/apidoc-create-withdrawal) | ❌ | 👌 |
| Convert Coins | [📚](https://www.coinpayments.net/apidoc-convert) | ❌ | 👌 |
| Conversion Limits | [📚](https://www.coinpayments.net/apidoc-convert-limits) | ❌ | 👌 |
| Get Withdrawal History | [📚](https://www.coinpayments.net/apidoc-get-withdrawal-history) | ❌ | 👌 |
| Get Withdrawal Info | [📚](https://www.coinpayments.net/apidoc-get-withdrawal-info) | ❌ | 👌 |
| Get Conversion Info | [📚](https://www.coinpayments.net/apidoc-get-conversion-info) | ❌ | 👌 |
| **$PayByName** |
| Get Profile Information | [📚](https://www.coinpayments.net/apidoc-get-pbn-info) | ❌ | 👎 |
| Get Tag List | [📚](https://www.coinpayments.net/apidoc-get-pbn-list) | ❌ | 👎 |
| Update Tag Profile | [📚](https://www.coinpayments.net/apidoc-update-pbn-tag) | ❌ | 👎 |
| Claim Tag | [📚](https://www.coinpayments.net/apidoc-claim-pbn-tag) | ❌ | 👎 |







## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/beneggett/coin_payments. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CoinPayments project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/beneggett/coin_payments/blob/master/CODE_OF_CONDUCT.md).
