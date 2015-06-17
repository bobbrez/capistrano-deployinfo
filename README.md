# Capistrano::Deployinfo

A Capistrano extension that writes information about the deploy to a JSON file in a public spot. This is intended to quickly answer the question "What's on production?"


## Installation

Add this line to your application's Gemfile:

    gem 'capistrano', '~> 3.1'
    gem 'capistrano-deployinfo', '~> 1.0'

And then execute:

    $ bundle install

## Usage

    # Capfile
    require 'capistrano/deployinfo'    


    # config/deploy.rb
    set :deployinfo_roles, :all # default value
    set :deployinfo_dir, 'public' # default value
    set :deployinfo_filename, 'deploy.json' # default value

## Configs

* `deployinfo_roles` which roles to generate the deploy info file
* `deployinfo_dir` the directory to place the deploy info file
* `deployinfo_filename` what to name the deploy info file

## Example deploy.json

```json
{
"app": "my-app",
"deployed_at": "2014-02-26 00:25:33 -0500",
"branch": "master",
"user": "bob",
"sha": "7cf044f",
"release": "20140226052444"
}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
