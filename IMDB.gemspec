# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'IMDB/version'

Gem::Specification.new do |spec|
  spec.name          = "IMDB"
  spec.version       = IMDB::VERSION
  spec.authors       = ["Tsvetan Hristov"]
  spec.email         = ["tsvetanhristov@yahoo.com"]
  spec.summary       = " IMDB: In-Memory SQL Database "
  spec.files         = Dir.glob("{lib}/**/*")
  spec.require_paths = ["lib"]
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 3.0"
end
