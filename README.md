# Stripetease

Minimal client for the Stripe API

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     stripetease:
       github: grkek/stripetease
   ```

2. Run `shards install`

## Usage

```crystal
require "stripetease"


client = Stripetease::Client.new(base_url: "https://api.stripe.com", api_key: "sk_test_4eC39HqLyjWDarjtT1zdp7dc")

pp client.prices.list
```

## Contributing

1. Fork it (<https://github.com/grkek/stripetease/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Giorgi Kavrelishvili](https://github.com/grkek) - creator and maintainer
