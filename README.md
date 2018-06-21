<p align="center"><a href="https://www3.lenovo.com/us/en/data-center/software/systems-management/xclarity/" target="_blank" rel="noopener noreferrer"><img width="200" src="https://www3.lenovo.com/medias/lenovo-systems-software-management-xclarity-intro.png?context=bWFzdGVyfHJvb3R8NjY0OXxpbWFnZS9wbmd8aDI2L2hlMS85NDQ4OTkwODAxOTUwLnBuZ3xjZTdiOWJhNDViMTVhMjJjNTFiMWRmNzlhMDFkYzRmN2NkNGJjMzk1NTUxN2ZhYjExYWU1MDJlYmUyNGJkYjIw" alt="Lenovo Xclarity Logo"></a></p>

xclarity_client
===

[![Build Status](https://travis-ci.org/lenovo/xclarity_client.svg)](https://travis-ci.org/lenovo/xclarity_client)

Ruby gem to interact with Lenovo XClarity.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xclarity_client'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install xclarity_client

## Usage

To configure your appliance access:

```ruby
require 'xclarity_client'

conf = XClarityClient::Configuration.new(
  :host             => 'http://lxca_host.com'
  :username         => 'username',
  :password         => 'password',
  :port             => 'lxca_port',
  :auth_type        => 'auth_type',  # ('token', 'basic_auth')
  :verify_ssl       => 'verify_ssl', # ('PEER', 'NONE')
  :user_agent_label => 'user_agent'  # Api gem client identification
)

client = XClarityClient::Client.new(conf)
```

To access the appliance data:

```ruby
client.discover_aicc # get AICC informations

client.discover_cabinet # get Cabinets from LXCA appliance

# get the cabinets with the specifieds UUIDs,
# and retrive just `storageList` and `height` attributes.
client.fetch_cabinet(
  uuids = ['590b2546bbbc457f-bf801661018c408e', 'd27e57aa278c49a9b57e34a8e6c6e8ae'],
  include_attributes = ['storageList', 'height']
)

# get the cabinets with the specifieds UUIDs,
# and retrive all attributes except `height`.
client.fetch_cabinet(
  uuids = ['590b2546bbbc457f-bf801661018c408e', 'd27e57aa278c49a9b57e34a8e6c6e8ae'],
  exclude_attributes = ['height']
)
```
> To see how to interact with other LXCA resources, please take a look at `lib/xclarity_client/mixins` folder.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lenovo/xclarity_client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.
