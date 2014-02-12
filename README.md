# Capistrano::Deployinfo

Writes a `deploy.json` file containing information about the latest
deployment to your `#{latest_release}/public` directory.

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-deployinfo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-deployinfo

## Usage

Add the hook to your Capistrano `deploy.rb` file

    after 'deploy:update_code', 'deploy:writeinfo'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
