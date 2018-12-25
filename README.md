# Remitano Ruby API Client

Feel free to fork, modify & redistribute under the MIT license.

## Installation

Add this line to your application's Gemfile:

    gem 'remitano'

## Create API Key

Visit [Settings](https://remitano.com/settings), Api section to create API key

## Setup

```ruby
Remitano::Client.default_key = YOUR_API_KEY
Remitano::Client.default_secret = YOUR_API_SECRET
Remitano::Client.default_authenticator_secret = YOUR_AUTHY_AUTHENTICATION_SECRET
Remitano::Client.default # => the default client
```
or
```ruby
client = new Remitano::Client(
  key: YOUR_API_KEY,
  secret: YOUR_API_SECRET,
  authenticator_secret: YOUR_AUTHY_AUTHENTICATION_SECRET,
)

```

## Fetch your live order

Returns an array with your open orders.

```ruby
client.orders.live
```

## Fetch your filled orders

Returns an array with your filled orders.

```ruby
client.orders.filled
```

## Create a buy order

```ruby
client.orders.create(pair: "btcusdt", side: "buy", amount: 1.0, price: 1000)

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b
my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
