# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra/simplecache/version'

Gem::Specification.new do |spec|
  spec.name          = "sinatra-simplecache"
  spec.version       = Sinatra::SimpleCache::VERSION
  spec.authors       = ["yoppi"]
  spec.email         = ["y.hirokazu@gmail.com"]
  spec.description   = %q{Simple cache helper for Sinatra}
  spec.summary       = %q{Simple cache helper for Sinatra}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
