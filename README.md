# FirstGiving

[![Code Climate](https://codeclimate.com/github/boosterllc/firstgiving_ruby.png)](https://codeclimate.com/github/boosterllc/firstgiving_ruby)
[![Gem Version](https://badge.fury.io/rb/firstgiving.svg)](http://badge.fury.io/rb/firstgiving)

FirstGiving Ruby Client Open Source.

EightBit Studios Fork to include the 'CARDONFILE' POST call

## Installation

Add this line to your application's Gemfile:

    gem 'firstgiving'

Or install it yourself as:

    $ gem install firstgiving

## Usage

    
    FirstGiving.configure do |config|
        config.application_key = APPLICATION_KEY
        config.security_token  = SECURITY_TOKEN
        config.options = OPTIONS
    end

# Lookup API

    FG.lookup.list(params)
    FG.lookup.detail(params)

# Donation API

    FG.donation.creditcard(params)
    FG.donation.verify(params)
    FG.donation.recurring_creditcard_profile(params)
    FG.donation.cardonfile(params)
    
# Search API
    
    FG.search.query(params)

    
    
## Test

    rake spec


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
