# Remitano Ruby API Client

Feel free to fork, modify & redistribute under the MIT license.

## Installation

Add this line to your application's Gemfile:
```
gem 'remitano'
```
Then execute:
```
bundle install
```
Or install it yourself as:
```
gem install remitano
```

## Usage
### Create API Key

Visit https://remitano.com/settings/api_key to create API key.

### Get Authentiator secret

Visit https://remitano.com/settings/authenticator to get your authenticator secret.

Note: This is needed to perform actions which need 2FA authentication like withdrawals, otherwise, you won't need it.
### Setup Remitano client

```ruby
Remitano::Client.default_key = YOUR_API_KEY
Remitano::Client.default_secret = YOUR_API_SECRET
Remitano::Client.default_authenticator_secret = YOUR_AUTHENTICATOR_SECRET
Remitano::Client.default # => the default client
```
or
```ruby
client = Remitano::Client.new(
  key: YOUR_API_KEY,
  secret: YOUR_API_SECRET,
  authenticator_secret: YOUR_AUTHENTICATOR_SECRET,
)

```
### Payment gateway
Visit https://developers.remitano.com/api-explorer - Merchant section for more information.
#### Charges
##### Get
```ruby
client.merchant_charges.get(id)
```
##### Create
```ruby
client.merchant_charges.create(
  coin_currency: "usdt",
  coin_amount: 10.99,
  cancelled_or_completed_callback_url: "https://example.com/payments/callback?id=example",
  description: "Example charge"
)
```
Note: For now, we only support `usdt` as the price coin currency.

#### Withdrawals
##### Get
```ruby
client.merchant_withdrawals.get(id)
```
##### Create
1. Withdraw to external coin address
```ruby
client.merchant_withdrawals.create(
  merchant_withdrawal_ref: "akh9r1h29e1", # your withdrawal_ref, we won't process withdrawal if the same ref is submitted before
  coin_currency: "xrp",
  coin_amount: 10.99,
  receiver_pay_fee: true, # defines who will be charged for the withdrawal fee
  cancelled_or_completed_callback_url: "http://sample.com/123/callback",
  coin_address: "rLpumSZQNJ6Cve7hfQcdkG9rJbJhkSV8AD0",
  destination_tag: 1710676231 # include destination_tag if coin_currency is xrp, otherwise, leave it nil
)
```
2. Withdraw to other remitano account
```ruby
client.merchant_withdrawals.create(
  merchant_withdrawal_ref: "akh9r1h29e1", # your withdrawal_ref, we won't process withdrawal if the same ref is submitted before
  coin_currency: "xrp",
  coin_amount: 10.99,
  receiver_pay_fee: true,
  cancelled_or_completed_callback_url: "http://sample.com/123/callback",
  remitano_username: "receiver123",
  remitano_phone_number: "+234 1 123 4567"
)
```

#### Callbacks
When Charge or Withdrawal is changed to completed or cancelled in our system, we will send
a POST callback request to `object.cancelled_or_completed_callback_url` with following
request json body:
```ruby
{ "id" => object.id }
```
then you could call `client.merchant_charges.get(id)` or `client.merchant_withdrawals.get(id)`
to get the updated information and process accordingly.

### Errors
When receiving non 200-299 http code, a Remitano::Client::Request::RequestError will be raised.

### Sandbox testing
We have a Testnet at https://remidemo.com.

You could register an account there, then submit a request at [this google form](https://forms.gle/jvJyWPBNwTWfowSm9) with your Remidemo username, so we could help to setup your testing account as a merchant.

After that, you could start your sandbox testing by setting `ENV["REMITANO_SANDBOX"]` to `"true"`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b
my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
