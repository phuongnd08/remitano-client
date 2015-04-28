# Remitano Ruby API Client

Feel free to fork, modify & redistribute under the MIT license.

## Installation

Add this line to your application's Gemfile:

    gem 'remitano'

## Create API Key

Visit [Settings](https://remitano.com/settings), Api section to create API key

## Setup

```ruby
Remitano.configure do |config|
  config.key = YOUR_API_KEY
  config.secret = YOUR_API_SECRET
end
```

## Remitano BTC exchange ticker

Returns `market_bid`, `market_ask`, `last_price`

```ruby
Remitano.ticker
```

## Fetch your live order

Returns an array with your open orders.

```ruby
Remitano.orders.live
```

## Fetch your live orders

Returns an array with your live orders.

```ruby
Remitano.orders.live
```

## Fetch your filled orders

Returns an array with your filled orders.

```ruby
Remitano.orders.filled
```

## Create a buy order

```ruby
Remitano.orders.create(side: "buy", order_type: "limit", amount: 1.0, price: 260)

```
## Get executions of an order

```ruby
Remitano.executions.all(order_id: 1)
```

# Tests

If you'd like to run the tests you need to set the following environment variables:

```
export REMITANO_KEY=xxx
export REMITANO_SECRET=yyy
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b
my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
