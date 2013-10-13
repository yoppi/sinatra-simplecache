# Sinatra::Simplecache

Simple cache helpers for Sinatra.

## Installation

Add this line to your application's Gemfile:

    gem 'sinatra-simplecache'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra-simplecache

## Usage

Modular Application:

``` ruby
require 'sinatra/base'
require 'sinatra/simplecache'
require 'erubis'

class TestApp < Sinatra::Base
  helpers Sinatra::SimpleCache
  set :erb, escape_html: true

  get '/' do
    cache(key: "index", expire: 10) { erb :index, locals: { _time: Time.now }}
  end

  run! if app_file == $0
end
```

`sinatra-simplecache` provide `cache` helper method.
This helper method take two args,

* options
  - key: cache key
  - expire: set expire time(Time or Numeric)
* block
  - evaluate Template, RDB/KVS Query etc.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
