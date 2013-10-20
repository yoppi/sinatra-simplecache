require "sinatra/simplecache/version"
require "sinatra/base"

module Sinatra
  module SimpleCache
    # @example
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
    # @param [Hash] opts Must specified :key and :expire
    # @option opts [String] :key Cache key
    # @option opts [Numeric] :expire(Infinity) Expire time
    # @yield Evaluate template, RDB/KVS query etc
    # @return [String] Block evaluated value, or cached value.
    def cache(opts={}, &block)
      @@__entries__ ||= {}

      now = Time.now.to_f
      expire = opts[:expire] ? (opts[:expire] + now) : (@@inf ||= 1/0.0)
      key = opts[:key] || request.path

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
