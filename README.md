# Remitano Ruby API Client

Feel free to fork, modify & redistribute under the MIT license.

## Installation

Add this line to your application's Gemfile:

    gem 'remitano'

## Create API Key

More info at: [https://remitano.com/article/api-key-implementation/](https://remitano.com/article/api-key-implementation/)

## Setup

```ruby
Remitano.setup do |config|
  config.key = YOUR_API_KEY
  config.secret = YOUR_API_SECRET
end
```

If you fail to set your `key` or `secret` a `MissingConfigException`
will be raised.

## Remitano ticker

The remitano ticker. Returns `last`, `high`, `low`, `volume`, `bid` and `ask`

```ruby
Remitano.ticker
```

## Fetch your open order

Returns an array with your open orders.

```ruby
Remitano.orders.all
```

## Create a sell order

Returns an `Order` object.

```ruby
Remitano.orders.sell(amount: 1.0, price: 111)
```

## Create a buy order

Returns an `Order` object.

```ruby
Remitano.orders.buy(amount: 1.0, price: 111)
```

## Fetch your transactions

Returns an `Array` of `UserTransaction`.

```ruby
Remitano.user_transactions.all
```

*To be continued!**

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
