require "sinatra/simplecache/version"
require "sinatra/base"

module Sinatra
  module SimpleCache
    # Example.
    #
    #  For operation cache:
    #   @@users = MySQL.query("...").to_a
    #   //=> @@users = cache(key: "users", expire: 0.6) { MySQL.query("...").to_a }
    #
    #  For page cache:
    #   slim: index
    #   //=> cache(expire: 0.3) {slim: index}
    #
    #  For fragment cache:
    #    @@sidebar = cache(key: "sidebar", expire: 1) { slim: sidebar }
    #    slim :detail, :locales = { :sidebar => @@sidebar }
    #
    def cache(opts={}, &block)
      @@__entries__ ||= {}

      now = Time.now.to_f
      (expire = opts[:expire]) ? (expire + now) : (@@inf ||= 1/0.0)
      key = opts[:key] || (defined?(Sinatra) && request.path) || abort("set key")

      if (e = @@__entries__[key]) && (e[:expire] > now)
        return e[:value]
      end

      value = block.call
      @@__entries__[key] = {
        expire: expire,
        value: value
      }
      value
    end
  end

  helpers SimpleCache
end
